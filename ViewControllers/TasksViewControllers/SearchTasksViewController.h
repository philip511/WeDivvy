//
//  SearchTasksViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 11/6/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchTasksViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) NSMutableDictionary *itemDict;
@property (strong, nonatomic) NSMutableDictionary *itemDictNo2;
@property (strong, nonatomic) NSMutableDictionary *itemDictNo3;

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

@property (weak, nonatomic) IBOutlet UIScrollView *customScrollView;

@property (weak, nonatomic) IBOutlet UITableView *customTableView;

@property (weak, nonatomic) IBOutlet UIView *searchBarView;
@property (weak, nonatomic) IBOutlet UITextField *searchBar;
@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;

@end

NS_ASSUME_NONNULL_END
