//
//  NotificationSettingsViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 8/3/22.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NotificationSettingsViewController : UIViewController <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPickerViewDelegate, SKProductsRequestDelegate>

@property (assign, nonatomic) BOOL ViewingChores;
@property (assign, nonatomic) BOOL ViewingExpenses;
@property (assign, nonatomic) BOOL ViewingLists;
@property (assign, nonatomic) BOOL ViewingGroupChats;
@property (assign, nonatomic) BOOL ViewingHomeMembers;
@property (assign, nonatomic) BOOL ViewingForum;
@property (assign, nonatomic) BOOL ViewingScheduledSummary;
@property (assign, nonatomic) BOOL ViewingScheduledSummaryTaskTypes;

@property (strong, nonatomic) NSMutableArray *allItemAssignedToArrays;
@property (strong, nonatomic) NSMutableDictionary *notificationSettings;

@property (weak, nonatomic) IBOutlet UIScrollView *customScrollView;

@property (weak, nonatomic) IBOutlet UITableView *scheduledSummaryTableView;
@property (weak, nonatomic) IBOutlet UITableView *taskTypesTableView;
@property (weak, nonatomic) IBOutlet UITableView *dueDatesTableView;
@property (weak, nonatomic) IBOutlet UITableView *priorityTableView;
@property (weak, nonatomic) IBOutlet UITableView *colorTableView;
@property (weak, nonatomic) IBOutlet UITableView *tagsTableView;
@property (weak, nonatomic) IBOutlet UITableView *assignedToTableView;

@end

NS_ASSUME_NONNULL_END
