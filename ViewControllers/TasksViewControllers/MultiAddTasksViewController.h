//
//  MultiAddTasksViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 9/7/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MultiAddTasksViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIScrollViewDelegate>

@property (assign, nonatomic) BOOL viewingAddedTasks;
@property (strong, nonatomic) NSMutableDictionary *itemDictFromPreviousPage;
@property (strong, nonatomic) NSMutableDictionary *itemDictKeysFromPreviousPage;
@property (strong, nonatomic) NSMutableDictionary *itemSelectedDict;

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
@property (strong, nonatomic) NSString * _Nullable defaultTaskListName;

@property (weak, nonatomic) IBOutlet UIScrollView *customScrollView;

@property (weak, nonatomic) IBOutlet UITableView *customTableView;

@property (weak, nonatomic) IBOutlet UIView *searchBarView;
@property (weak, nonatomic) IBOutlet UITextField *searchBar;
@property (weak, nonatomic) IBOutlet UIView *clearSearchBarView;
@property (weak, nonatomic) IBOutlet UIImageView *clearSearchBarImageView;

@end

NS_ASSUME_NONNULL_END
