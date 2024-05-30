//
//  HomeFeaturesViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 5/21/23.
//

#import "HomeFeaturesViewController.h"

#import "MainCell.h"

#import "GeneralObject.h"
#import "SetDataObject.h"
#import "PushObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

#import <MRProgress/MRProgress.h>

@interface HomeFeaturesViewController () {
    
    MRProgressOverlayView *progressView;
    
    NSMutableArray *featuresArray;
    NSMutableArray *selectedFeaturesArray;
    
}

@end

@implementation HomeFeaturesViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self InitMethod];
    
}

-(void)viewDidLayoutSubviews {

    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
    
    _customTableView.frame = CGRectMake(0, height*0.5 - ((self.view.frame.size.height*0.11694153 > 78?(78):self.view.frame.size.height*0.11694153)*[featuresArray count])*0.5, width, 78*4);
    
    _titleLabel.frame = CGRectMake(width*0.5 -((width*0.5821256)*0.5), (height - (height - _customTableView.frame.origin.y))*0.5 - (height*0.05298913)*0.5, width*0.5821256, height*0.05298913);
    _subTitleLabel.frame = CGRectMake(width*0.5 - ((width*0.75)*0.5), _titleLabel.frame.origin.y + _titleLabel.frame.size.height + (height*0.01630435), width*0.75, height*0.05027174);
    
    _titleLabel.font = [UIFont systemFontOfSize:(_titleLabel.frame.size.height*0.425 > 17?(17):_titleLabel.frame.size.height*0.425) weight:UIFontWeightSemibold];
    _subTitleLabel.font = [UIFont systemFontOfSize:(_subTitleLabel.frame.size.height*0.4 > 15?(15):_subTitleLabel.frame.size.height*0.4) weight:UIFontWeightMedium];
    
    _enableNotificationsButton.frame = CGRectMake(width*0.5 - (width*0.90)*0.5, height - (self.view.frame.size.height*0.03532609 > 26?(26):self.view.frame.size.height*0.03532609) - (self.view.frame.size.height*0.03532609 > 26?(26):self.view.frame.size.height*0.03532609) - (height*0.02717391) - bottomPadding, width*0.90, (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934));
    _enableNotificationsButton.titleLabel.font = [UIFont systemFontOfSize:_enableNotificationsButton.frame.size.height*0.32 weight:UIFontWeightSemibold];
    _enableNotificationsButton.layer.cornerRadius = 7;
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary]};
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.customTableView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.titleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        
        [self preferredStatusBarStyle];
        
    }
    
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpAnalytics];
    
    [self SetUpArrays];

    [self SetUpTableView];

    [self SetUpButton];
    
}

#pragma mark - SetUp Methods

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"HomeFeaturesViewController" completionHandler:^(BOOL finished) {
        
    }];
    
    [[[GeneralObject alloc] init] TrackInMixPanel:@"HomeFeaturesViewController"];
    
}

-(void)SetUpArrays {
    
    featuresArray = [@[@"🧹 Chores", @"💵 Expenses", @"📝 Lists", @"💬 Group Chats"] mutableCopy];
    
    selectedFeaturesArray =
    ![[NSUserDefaults standardUserDefaults] objectForKey:@"VisibleTabBarOptions"] ||
    [(NSArray *)[[NSUserDefaults standardUserDefaults] objectForKey:@"VisibleTabBarOptions"] count] == 0 ?
    [@[@"🧹 Chores", @"💵 Expenses", @"📝 Lists", @"💬 Group Chats"] mutableCopy] :
    [[[NSUserDefaults standardUserDefaults] objectForKey:@"VisibleTabBarOptions"] mutableCopy];
    
}

-(void)SetUpTableView {
    
    _customTableView.delegate = self;
    _customTableView.dataSource = self;
    [_customTableView setScrollEnabled:NO];
    
}

-(void)SetUpButton {
    
    if (_comingFromSettings) {
        [_enableNotificationsButton setTitle:@"I'm Finished 😀" forState:UIControlStateNormal];
    }
    
}

#pragma mark - UI Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

#pragma mark - IBAction Methods

-(IBAction)AddHomeFeatures:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Lets Get Started Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"];
    NSString *homeOwnerUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeOwnerUserID"];
    NSString *myUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"];
  
    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewDidLoadShouldStart"];
    
    if ([homeOwnerUserID isEqualToString:myUserID]) {
       
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[[SetDataObject alloc] init] UpdateDataHome:homeID homeDict:@{@"HomeFeatures" : self->selectedFeaturesArray} completionHandler:^(BOOL finished) {
               
                [[NSUserDefaults standardUserDefaults] setObject:self->selectedFeaturesArray forKey:@"VisibleTabBarOptions"];
                
                [[[PushObject alloc] init] PushToTasksNavigationController:YES Expenses:NO Lists:NO Animated:YES currentViewController:self];
               
            }];
            
        });
        
    } else {
        
        [[NSUserDefaults standardUserDefaults] setObject:selectedFeaturesArray forKey:@"VisibleTabBarOptions"];
     
        [[[PushObject alloc] init] PushToTasksNavigationController:YES Expenses:NO Lists:NO Animated:YES currentViewController:self];
        
    }
    
}

#pragma mark - Table View Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    MainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];

    cell.titleLabel.text = featuresArray[indexPath.row];
   
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return featuresArray.count;
    
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(MainCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = CGRectGetWidth(cell.contentView.bounds);
    CGFloat height = CGRectGetHeight(cell.contentView.bounds);
    
    cell.mainView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), height*0.5 - ((height*0.7037037)*0.5), width*0.90338164, height*0.7037037);
    cell.contentView.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeSecondary] : [UIColor clearColor];
    
    height = CGRectGetHeight(cell.mainView.bounds);
    width = CGRectGetWidth(cell.mainView.bounds);
 
    cell.titleLabel.textColor =  [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] LightModeTextPrimary];
    cell.titleLabel.alpha = 1;
    
    cell.titleLabel.frame = CGRectMake(width*0.075, height*0.5 - (height*0.350878)*0.5, width*0.772727, height*0.350878);
    cell.subLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, height - cell.titleLabel.frame.size.height - height*0.14035, cell.titleLabel.frame.size.width, cell.titleLabel.frame.size.height);
    
    cell.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
    cell.subLabel.font = [UIFont systemFontOfSize:cell.subLabel.frame.size.height*0.65 weight:UIFontWeightSemibold];
   
    cell.checkmarkView.hidden = YES;
    cell.subLabel.hidden = YES;
    
    cell.selectedSuggestedView.frame = CGRectMake(width - height*0.43859 - width*0.04278075, height*0.5 - ((height*0.43859)*0.5), height*0.43859, height*0.43859);
    cell.selectedSuggestedView.layer.cornerRadius = cell.selectedSuggestedView.frame.size.height/2;
    cell.selectedSuggestedViewImage.frame = CGRectMake(cell.selectedSuggestedView.frame.size.width*0.5 - ((cell.selectedSuggestedView.frame.size.width*0.5 > 20?20:(cell.selectedSuggestedView.frame.size.width*0.5))*0.5),
                                                       cell.selectedSuggestedView.frame.size.height*0.5 - ((cell.selectedSuggestedView.frame.size.height*0.5 > 20?20:(cell.selectedSuggestedView.frame.size.height*0.5))*0.5),
                                                       (cell.selectedSuggestedView.frame.size.height*0.5 > 20?20:(cell.selectedSuggestedView.frame.size.height*0.5)),
                                                       (cell.selectedSuggestedView.frame.size.height*0.5 > 20?20:(cell.selectedSuggestedView.frame.size.height*0.5)));
    cell.selectedSuggestedViewButton.frame = CGRectMake(cell.selectedSuggestedView.frame.origin.x - 10, 0, cell.selectedSuggestedView.frame.size.width + 20, height);
    
    BOOL TaskHasBeenSelected = [selectedFeaturesArray containsObject:featuresArray[indexPath.row]];
    
    if (TaskHasBeenSelected) {
        
        cell.selectedSuggestedView.backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
        cell.selectedSuggestedViewImage.image = [UIImage imageNamed:@"MultiAddCellIcons.SelectedCheckmark"];
        
    } else {
        
        cell.selectedSuggestedView.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeSecondary] : [UIColor colorWithRed:238.0f/255.0f green:240.0f/255.0f blue:243.0f/255.0f alpha:1.0f];
        cell.selectedSuggestedViewImage.image = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [UIImage imageNamed:@"MultiAddCellIcons.SelectedCheckmark"] : [UIImage imageNamed:@"MultiAddCellIcons.UnselectedPlus.png"];
        
    }
    
    cell.selectedSuggestedView.userInteractionEnabled = NO;
    cell.selectedSuggestedViewImage.userInteractionEnabled = NO;
    cell.selectedSuggestedViewButton.userInteractionEnabled = NO;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"DidSelect %@", featuresArray[indexPath.row]] completionHandler:^(BOOL finished) {
        
    }];
    
    NSArray *mandatoryFeatures = @[@"🧹 Chores", @"💵 Expenses", @"📝 Lists"];
    
    int mandatoryFeaturesSelected = 0;
    
    for (NSString *feature in selectedFeaturesArray) {
        if ([mandatoryFeatures containsObject:feature]) {
            mandatoryFeaturesSelected += 1;
        }
    }
    
    selectedFeaturesArray = [[[GeneralObject alloc] init] RemoveDupliatesFromArray:selectedFeaturesArray];
    
    NSString *selectedFeature = featuresArray[indexPath.row];
    
    if ([selectedFeaturesArray containsObject:selectedFeature] == NO) {
      
        if ([selectedFeature containsString:@"🧹 Chores"]) {
            
            if ([selectedFeaturesArray count] == 0) {
                [selectedFeaturesArray addObject:selectedFeature];
            } else {
                [selectedFeaturesArray insertObject:selectedFeature atIndex:0];
            }
            
        } else if ([selectedFeature containsString:@"💵 Expenses"]) {
            
            if ([selectedFeaturesArray containsObject:@"🧹 Chores"]) {
                [selectedFeaturesArray insertObject:selectedFeature atIndex:1];
            } else {
                [selectedFeaturesArray insertObject:selectedFeature atIndex:0];
            }
            
        } else if ([selectedFeature containsString:@"📝 Lists"]) {
            
            if ([selectedFeaturesArray containsObject:@"🧹 Chores"] && [selectedFeaturesArray containsObject:@"💵 Expenses"]) {
                [selectedFeaturesArray insertObject:selectedFeature atIndex:2];
            } else if ([selectedFeaturesArray containsObject:@"🧹 Chores"] && [selectedFeaturesArray containsObject:@"💵 Expenses"] == NO) {
                [selectedFeaturesArray insertObject:selectedFeature atIndex:1];
            } else {
                [selectedFeaturesArray insertObject:selectedFeature atIndex:0];
            }
            
        } else if ([selectedFeature containsString:@"💬 Group Chats"]) {
            
            [selectedFeaturesArray addObject:selectedFeature];
            
        }
      
        
    } else if ([selectedFeaturesArray containsObject:selectedFeature] && selectedFeaturesArray.count >= 2 && (mandatoryFeaturesSelected >= 2 || (mandatoryFeaturesSelected == 1 && [mandatoryFeatures containsObject:selectedFeature] == NO))) {
        [selectedFeaturesArray removeObject:selectedFeature];
        
    } else if (mandatoryFeaturesSelected == 1 && [mandatoryFeatures containsObject:selectedFeature] == YES) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"You need to have at least one of the following, \"Chores\", \"Expenses\", or \"Lists\"." currentViewController:self];
   
    } else if ([selectedFeaturesArray containsObject:selectedFeature] && selectedFeaturesArray.count == 1) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"You can't have zero features in your home." currentViewController:self];
    }
    
    selectedFeaturesArray = [[[GeneralObject alloc] init] RemoveDupliatesFromArray:selectedFeaturesArray];
    
    [self.customTableView beginUpdates];
    [self.customTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.customTableView endUpdates];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return (self.view.frame.size.height*0.11694153 > 78?(78):self.view.frame.size.height*0.11694153);
}

#pragma mark

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger )section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger )section {
    
    return 0;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return @"";
}


@end
