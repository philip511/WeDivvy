//
//  ViewItemSummaryViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 7/12/21.
//

#import "ViewItemSummaryViewController.h"
#import "CustomCell.h"
#import "AppDelegate.h"

#import <MRProgress/MRProgressOverlayView.h>
#import <CoreText/CoreText.h>
#import <CFNetwork/CFNetwork.h>

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"

@interface ViewItemSummaryViewController () {
    
    MRProgressOverlayView *progressView;
    UIActivityIndicatorView *activityControl;
    
    NSArray *keyArray;
    NSMutableDictionary *occurrencesDict;
    
}

@end

@implementation ViewItemSummaryViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self InitMethod];

    [self BarButtonItems];
    
    [[[GetDataObject alloc] init] GetDataItemOccurrences:_collection itemID:_itemID keyArray:keyArray completionHandler:^(BOOL finished, NSMutableDictionary *occurrencesDict) {
  
        self->occurrencesDict = [occurrencesDict mutableCopy];
        
        [self MainImageHiddenStatus];
        [self ReverseItemOccurrences];
        
        [self->activityControl stopAnimating];
        [self.customTableView reloadData];
        
    }];
    
}

-(void)viewWillLayoutSubviews {
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];

    _customTableView.frame = CGRectMake(0, navigationBarHeight, width, height - navigationBarHeight - bottomPadding);
    activityControl.frame = CGRectMake((self.customTableView.frame.size.width*0.5)-(12.5), (self.customTableView.frame.size.height*0.5) - (12.5) + _customTableView.frame.origin.y, 25, 25);

    self->_hiddenLabel.frame = CGRectMake(width*0.5 - ((width*0.75)*0.5), ((height*0.5) - (70*0.5)), width*0.75, 70);
  
}

#pragma mark - Init Method

-(void)InitMethod {

    [self SetUpAnalytics];
    
    [self SetUpTitle];
    
    [self SetUpKeyArray];
    
    [self SetUpActivityControl];
    
    [self SetUpTableView];
    
    [self SetUpHiddenLabel];

}

-(void)BarButtonItems {

    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(NavigationBackButtonAction:)];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
}

#pragma mark - Setup Methods

-(void)SetUpAnalytics {
 
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:self.restorationIdentifier completionHandler:^(BOOL finished) {
        
    }];
    
}

-(void)SetUpTitle {
    
    self.title = @"History";
    
}

-(void)SetUpKeyArray {
    
    keyArray = [[[GeneralObject alloc] init] GetAppropriateKeyArray:NO Expense:NO];
    
}

-(void)SetUpActivityControl {
    
    activityControl = [[UIActivityIndicatorView alloc] init];
    activityControl.color = [UIColor lightGrayColor];
    [activityControl setHidden:NO];
    [activityControl startAnimating];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [activityControl startAnimating];
        
    });
    
    [self.view addSubview:activityControl];
    
}

-(void)SetUpTableView {
    
    _customTableView.delegate = self;
    _customTableView.dataSource = self;
    _customTableView.estimatedRowHeight = 40;
    _customTableView.rowHeight = UITableViewAutomaticDimension;
    
}

-(void)SetUpHiddenLabel {
    
    _hiddenLabel.hidden = YES;
    
}

#pragma mark - IBAction Methods

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"BackButton - %@", self.restorationIdentifier] completionHandler:^(BOOL finished) {
        
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - Custom Methods

-(void)ReverseItemOccurrences {
 
    for (NSString *key in keyArray) {
        
        NSMutableArray *arr = self->occurrencesDict[key];
        NSMutableArray *reverseArr = [NSMutableArray array];
        
        for (int i=(int)arr.count-1;i>-1;i--) {
            [reverseArr addObject:arr[i]];
        }
        
        [self->occurrencesDict setObject:reverseArr forKey:key];
        
    }
    
}

-(void)MainImageHiddenStatus {
    
    if ([self->occurrencesDict[@"SummaryID"] count] == 0) {
        
        self->_hiddenLabel.hidden = NO;
        self->_customTableView.hidden = YES;
        
    } else {
        
        self->_hiddenLabel.hidden = YES;
        self->_customTableView.hidden = NO;
        
    }
    
}

#pragma mark - Table View Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell"];

    cell.descriptionLabel.text = occurrencesDict[@"ItemNotes"][indexPath.row];
    cell.timeLabel.text = [[[GeneralObject alloc] init] GetDaysFromDate:occurrencesDict[@"ItemDueDate"][indexPath.row]];
    cell.itemNameLabel.text = occurrencesDict[@"ItemName"][indexPath.row];
        
    return cell;
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [occurrencesDict[@"ItemID"] count];

}

- (void)tableView:(UITableView *)tableView
willDisplayCell:(CustomCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {

    cell.descriptionLabel.adjustsFontSizeToFitWidth = NO;
    cell.timeLabel.adjustsFontSizeToFitWidth = NO;
    cell.itemNameLabel.adjustsFontSizeToFitWidth = NO;

    [self TableViewWillDisplayCellColor:occurrencesDict cell:cell indexPath:indexPath];
    [self TableViewWillDisplayEllipsis:occurrencesDict cell:cell indexPath:indexPath];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    CGFloat height = CGRectGetHeight(self.view.bounds);
    return (height*0.15625 > 130?(130):height*0.15625);

}

#pragma mark - Internal Methods

-(void)TableViewWillDisplayCellColor:(NSMutableDictionary *)dictToUse cell:(CustomCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    NSString *userIDToCheck = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"];
    
    BOOL YouAreAssignedToThisTask = [dictToUse[@"ItemAssignedTo"][indexPath.row] containsObject:userIDToCheck];

    UIColor *cellColor;
    
    if (YouAreAssignedToThisTask == NO) {
        
        cellColor = [UIColor colorWithRed:167.0f/255.0f green:176.0f/255.0f blue:185.0f/255.0f alpha:1.0f];
        
    } else {
        
        BOOL CompletedDisplayed = [dictToUse[@"ItemCompleted"] count] == [dictToUse[@"ItemAssignedTo"] count];
        BOOL PastDueDisplayed = [dictToUse[@"ItemCompleted"] count] != [dictToUse[@"ItemAssignedTo"] count];
        
        if (CompletedDisplayed == YES) {
            cellColor = [UIColor colorWithRed:56.0f/255.0f green:196.0f/255.0f blue:92.0f/255.0f alpha:1.0f];
        } else if (PastDueDisplayed == YES) {
            cellColor = [UIColor systemRedColor];
        }

    }
    
    cell.colorView.backgroundColor = cellColor;
    
}

-(void)TableViewWillDisplayEllipsis:(NSMutableDictionary *)dictToUse cell:(CustomCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    BOOL TaskWasCreatedByMe = [dictToUse[@"ItemCreatedBy"][indexPath.row] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    BOOL TaskWasAssignedToMe = [dictToUse[@"ItemAssignedTo"][indexPath.row] containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    BOOL TaskIsTakingTurns = [dictToUse[@"ItemTakeTurns"][indexPath.row] isEqualToString:@"Yes"] && [dictToUse[@"ItemTime"][indexPath.row] length] > 0 && [dictToUse[@"ItemFrequency"][indexPath.row] length] > 0;
    BOOL TaskHasExistingCreatedMember = [[[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeMembers"] containsObject:dictToUse[@"ItemCreatedBy"][indexPath.row]];
    
    if ((TaskWasCreatedByMe == NO && TaskHasExistingCreatedMember == YES) && (TaskWasAssignedToMe == NO || TaskIsTakingTurns == YES)) {
        
        cell.rightArrowImage.hidden = YES;
        cell.rightArrowCover.hidden = YES;
        
        cell.rightArrowImage.userInteractionEnabled = NO;
        cell.rightArrowCover.userInteractionEnabled = NO;
        
    } else {
        
        cell.rightArrowImage.hidden = NO;
        cell.rightArrowCover.hidden = NO;
        
        cell.rightArrowImage.userInteractionEnabled = YES;
        cell.rightArrowCover.userInteractionEnabled = YES;
        
    }

    
}
@end
