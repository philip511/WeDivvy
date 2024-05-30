//
//  AddTaskViewController.h
//  RoommateApp
//
//  Created by Philip Nagel on 5/17/21.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddTaskViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIScrollViewDelegate, SKProductsRequestDelegate>

@property (assign, nonatomic) BOOL viewingAddExpenseViewController;
@property (assign, nonatomic) BOOL viewingAddListViewController;

@property (assign, nonatomic) BOOL partiallyAddedTask;
@property (assign, nonatomic) BOOL addingTask;
@property (assign, nonatomic) BOOL addingMultipleTasks;
@property (assign, nonatomic) BOOL addingSuggestedTask;
@property (assign, nonatomic) BOOL editingTask;
@property (assign, nonatomic) BOOL viewingTask;
@property (assign, nonatomic) BOOL viewingMoreOptions;
@property (assign, nonatomic) BOOL duplicatingTask;

@property (assign, nonatomic) BOOL editingTemplate;
@property (assign, nonatomic) BOOL viewingTemplate;

@property (assign, nonatomic) BOOL editingDraft;
@property (assign, nonatomic) BOOL viewingDraft;

@property (strong, nonatomic) NSString *homeID;
@property (strong, nonatomic) NSMutableArray *homeMembersArray;
@property (strong, nonatomic) NSMutableDictionary *homeMembersDict;
@property (strong, nonatomic) NSMutableDictionary *notificationSettingsDict;
@property (strong, nonatomic) NSMutableDictionary *topicDict;
@property (strong, nonatomic) NSMutableDictionary *partiallyAddedDict;
@property (strong, nonatomic) NSMutableDictionary *itemToEditDict;
@property (strong, nonatomic) NSMutableDictionary *suggestedItemToAddDict;
@property (strong, nonatomic) NSMutableDictionary *templateToEditDict;
@property (strong, nonatomic) NSMutableDictionary *draftToEditDict;
@property (strong, nonatomic) NSMutableDictionary *moreOptionsDict;
@property (strong, nonatomic) NSMutableDictionary *multiAddDict;
@property (strong, nonatomic) NSMutableDictionary *itemOccurrencesDict;
@property (strong, nonatomic) NSMutableDictionary *folderDict;
@property (strong, nonatomic) NSMutableDictionary *taskListDict;
@property (strong, nonatomic) NSMutableDictionary *templateDict;
@property (strong, nonatomic) NSMutableDictionary *draftDict;
@property (strong, nonatomic) NSMutableArray * _Nullable allItemAssignedToArrays;
@property (strong, nonatomic) NSMutableArray * _Nullable allItemTagsArrays;
@property (strong, nonatomic) NSMutableArray * _Nullable allItemIDsArrays;
@property (strong, nonatomic) NSString * _Nullable defaultTaskListName;

@property (weak, nonatomic) IBOutlet UIScrollView *customScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *customToolbarScrollView;

@property (weak, nonatomic) IBOutlet UIView *toolbarView;

@end

NS_ASSUME_NONNULL_END
