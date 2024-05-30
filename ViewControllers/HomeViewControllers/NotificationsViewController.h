//
//  NotificationsViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 10/11/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NotificationsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *customTableView;

@property (weak, nonatomic) IBOutlet UIView *emptyTableViewView;
@property (weak, nonatomic) IBOutlet UIImageView *emptyTableViewImage;
@property (weak, nonatomic) IBOutlet UILabel *emptyTableViewTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *emptyTableViewBodyLabel;

@property (strong, nonatomic) NSMutableArray *homeMembersArray;
@property (strong, nonatomic) NSMutableDictionary *homeMembersDict;
@property (strong, nonatomic) NSMutableDictionary *notificationSettingsDict;
@property (strong, nonatomic) NSMutableDictionary *topicDict;
@property (strong, nonatomic) NSMutableDictionary *folderDict;
@property (strong, nonatomic) NSMutableDictionary *taskListDict;
@property (strong, nonatomic) NSMutableDictionary *sectionDict;
@property (strong, nonatomic) NSMutableDictionary *templateDict;
@property (strong, nonatomic) NSMutableDictionary *draftDict;
@property (strong, nonatomic) NSMutableArray * _Nullable itemNamesAlreadyUsed;
@property (strong, nonatomic) NSMutableArray * _Nullable allItemAssignedToArrays;
@property (strong, nonatomic) NSMutableArray * _Nullable allItemTagsArrays;
@property (strong, nonatomic) NSMutableArray * _Nullable allItemIDsArrays;

@end

NS_ASSUME_NONNULL_END
