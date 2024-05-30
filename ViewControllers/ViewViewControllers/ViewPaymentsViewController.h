//
//  ViewPaymentsViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 2/2/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewPaymentsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableDictionary *itemDict;
@property (strong, nonatomic) NSMutableDictionary *dataDisplayDict;

@property (strong, nonatomic) NSMutableArray *homeMembersArray;
@property (strong, nonatomic) NSMutableDictionary *homeMembersDict;
@property (strong, nonatomic) NSMutableDictionary *notificationSettingsDict;
@property (strong, nonatomic) NSMutableDictionary *topicDict;
@property (strong, nonatomic) NSMutableDictionary *folderDict;
@property (strong, nonatomic) NSMutableDictionary *taskListDict;
@property (strong, nonatomic) NSMutableDictionary *templateDict;
@property (strong, nonatomic) NSMutableDictionary *draftDict;
@property (strong, nonatomic) NSMutableArray * _Nullable itemNamesAlreadyUsed;
@property (strong, nonatomic) NSMutableArray * _Nullable allItemAssignedToArrays;
@property (strong, nonatomic) NSMutableArray * _Nullable allItemTagsArrays;
@property (strong, nonatomic) NSMutableArray * _Nullable allItemIDsArrays;

@property (assign, nonatomic) BOOL viewingOwed;
@property (assign, nonatomic) BOOL viewingEarned;
@property (strong, nonatomic) NSString *viewingUserIDWhoOwesMoney;
@property (strong, nonatomic) NSString *viewingUserIDWhoIsOwedMoney;

@property (weak, nonatomic) IBOutlet UISegmentedControl *customSegmentControl;

@property (weak, nonatomic) IBOutlet UITableView *paymentsTableView;
@property (weak, nonatomic) IBOutlet UITableView *owedTableView;

@property (weak, nonatomic) IBOutlet UIView *emptyTableViewView;
@property (weak, nonatomic) IBOutlet UIImageView *emptyTableViewImage;
@property (weak, nonatomic) IBOutlet UILabel *emptyTableViewTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *emptyTableViewBodyLabel;

@end

NS_ASSUME_NONNULL_END
