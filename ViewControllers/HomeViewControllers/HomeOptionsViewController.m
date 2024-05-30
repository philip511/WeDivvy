//
//  HomeOptionsViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 6/9/23.
//

#import "HomeOptionsViewController.h"

#import "HomeOptionsCell.h"

#import "GeneralObject.h"
#import "SetDataObject.h"
#import "PushObject.h"
#import "NotificationsObject.h"
#import "HomesViewControllerObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

#import <MRProgress/MRProgress.h>

@interface HomeOptionsViewController () {
    
    MRProgressOverlayView *progressView;
    NSMutableDictionary *selectedOptions;
    NSArray *optionsArray;
    
}

@end

@implementation HomeOptionsViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self InitMethod];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        return UIStatusBarStyleLightContent;
        
    } else {
        
        return UIStatusBarStyleDefault;
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    _nextButton.backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    
}

-(void)viewWillLayoutSubviews {
    
    CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    _titleLabel.frame = CGRectMake(width*0.5 -((width*0.5821256)*0.5), height*0.16, width*0.5821256, height*0.05298913);
    _subTitleLabel.frame = CGRectMake(width*0.5 - ((width*0.69565217)*0.5), _titleLabel.frame.origin.y + _titleLabel.frame.size.height + (height*0.01630435), width*0.69565217, height*0.05027174);
    
    _mainImage.frame = CGRectMake(0, _subTitleLabel.frame.origin.y + _subTitleLabel.frame.size.height + 50, width, height*0.20380435);
    
    _customTableView.frame = CGRectMake(0, _mainImage.frame.origin.y + _mainImage.frame.size.height + 100, width, 132);
    
    _titleLabel.font = [UIFont systemFontOfSize:(_titleLabel.frame.size.height*0.4 > 16?(16):_titleLabel.frame.size.height*0.4) weight:UIFontWeightSemibold];
    _subTitleLabel.font = [UIFont systemFontOfSize:(_subTitleLabel.frame.size.height*0.4 > 15?(15):_subTitleLabel.frame.size.height*0.4) weight:UIFontWeightMedium];
    
    _nextButton.frame = CGRectMake(width*0.5 - (width*0.90)*0.5, height - (self.view.frame.size.height*0.03532609 > 26?(26):self.view.frame.size.height*0.03532609) - (height*0.02717391) - bottomPadding, width*0.90, (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934));
    _nextButton.titleLabel.font = [UIFont systemFontOfSize:_nextButton.frame.size.height*0.32 weight:UIFontWeightSemibold];
    _nextButton.layer.cornerRadius = 7;
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.titleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.subTitleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextSecondary];
        self.maybeLabelButton.titleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextSecondary];
        
        [self preferredStatusBarStyle];
        
    }
    
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpAnalytics];

    [self SetUpDicts];
 
    [self SetUpTableView];
    
}

#pragma mark - SetUp Methods

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"EnableNotificationsViewController" completionHandler:^(BOOL finished) {
        
    }];
    
}

-(void)SetUpDicts {
    
    optionsArray = @[@"Onboarding Assistant", @"Morning Overview", @"Evening Overview"];
    
    selectedOptions = [NSMutableDictionary dictionary];
    [selectedOptions setObject:@"Yes" forKey:@"0"];
    [selectedOptions setObject:@"Yes" forKey:@"1"];
    [selectedOptions setObject:@"No" forKey:@"2"];
    
//    folderDict = [NSMutableDictionary dictionary];
//    taskListDict = [NSMutableDictionary dictionary];
//    sectionDict = [NSMutableDictionary dictionary];
//    templateDict = [NSMutableDictionary dictionary];
    
}

-(void)SetUpTableView {
    
    _customTableView.delegate = self;
    _customTableView.dataSource = self;
    
    [_customTableView reloadData];
    
}

#pragma mark - UI Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

#pragma mark - IBAction Methods

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)NextButton:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Next Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    if ([selectedOptions[@"0"] isEqualToString:@"Yes"]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewTutorial"];
        
    }
    
    if ([selectedOptions[@"1"] isEqualToString:@"No"] || [selectedOptions[@"2"] isEqualToString:@"Yes"]) {
        
        [self StartProgressView];
        
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
        
        BOOL addMorningOverView = [selectedOptions[@"1"] isEqualToString:@"Yes"];
        BOOL addEveningOverView = [selectedOptions[@"2"] isEqualToString:@"Yes"];
        
        NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateDefaultNotificationSettingsDict:userID addMorningOverView:addMorningOverView addEveningOverView:addEveningOverView];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID == %@", userID];
        [[[SetDataObject alloc] init] SetDataEditCoreData:@"NotificationSettings" predicate:predicate setDataObject:dataDict];
        
        [[[SetDataObject alloc] init] UpdateDataNotificationSettings:userID dataDict:dataDict completionHandler:^(BOOL finished, NSError * _Nonnull error) {
            
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"NotificationSettings" userInfo:@{@"NotificationSettings" : dataDict} locations:@[@"Settings", @"NotificationSettings"]];
            
            [self->progressView setHidden:YES];
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        
    }
    
}

-(IBAction)CustomSwitchAction:(id)sender {
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self->_customTableView];
    NSIndexPath *indexPath = [self->_customTableView indexPathForRowAtPoint:buttonPosition];
    
    HomeOptionsCell *cell = [_customTableView cellForRowAtIndexPath:indexPath];
    
    [selectedOptions setObject:[cell.customSwitch isOn] ? @"Yes" : @"No" forKey:[NSString stringWithFormat:@"%lu", indexPath.row]];
    
}

#pragma mark - IAP Methods

- (BOOL)CanMakePurchases {
    
    return [SKPaymentQueue canMakePayments];
    
}

#pragma mark - TableView Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
  
    HomeOptionsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeOptionsCell"];
    
    cell.titleLabel.text = optionsArray[indexPath.row];
    [cell.customSwitch setOn:YES];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [optionsArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    return (height*0.05978261 > 44?(44):height*0.05978261);
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(HomeOptionsCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
 
    CGFloat width = CGRectGetWidth(cell.contentView.bounds);
    CGFloat height = CGRectGetHeight(cell.contentView.bounds);
    
    cell.titleLabel.font = [UIFont systemFontOfSize:_titleLabel.font.pointSize weight:UIFontWeightMedium];
    
    CGFloat switchTransform = height*0.55/27;
    
    cell.customSwitch.transform = CGAffineTransformMakeScale(switchTransform, switchTransform);
    cell.customSwitch.frame = CGRectMake(width*1 - cell.customSwitch.frame.size.width - width*0.04830918 + (height*0.55/31), height*0.5 - cell.customSwitch.frame.size.height*0.5 + (height*0.55/31), cell.customSwitch.frame.size.width, cell.customSwitch.frame.size.height);
    
    cell.customSwitch.onTintColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    
}

@end
