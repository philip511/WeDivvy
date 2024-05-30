//
//  ViewTaskListsViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 6/3/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewTaskListsViewController : UIViewController

@property (strong, nonatomic) NSMutableDictionary * _Nullable itemToEditDict;
@property (strong, nonatomic) NSMutableDictionary *foldersDict;
@property (strong, nonatomic) NSMutableDictionary *taskListDict;
@property (strong, nonatomic) NSString *itemUniqueID;

@property (assign, nonatomic) BOOL comingFromTasksViewController;
@property (assign, nonatomic) BOOL comingFromViewTaskViewController;

@property (weak, nonatomic) IBOutlet UIView *itemListNameView;
@property (weak, nonatomic) IBOutlet UIView *itemFolderView;

@property (weak, nonatomic) IBOutlet UITextField *itemListNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *itemFolderTextField;

@property (weak, nonatomic) IBOutlet UILabel *itemFolderLabel;

@property (weak, nonatomic) IBOutlet UIImageView *itemFolderImage;
@property (weak, nonatomic) IBOutlet UIImageView *itemFolderRightArrow;

@end

NS_ASSUME_NONNULL_END
