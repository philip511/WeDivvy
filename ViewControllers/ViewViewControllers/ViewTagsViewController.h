//
//  ViewTagsViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 5/12/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewTagsViewController : UIViewController <UITextFieldDelegate>

@property (assign, nonatomic) BOOL viewingItemDetails;
@property (assign, nonatomic) BOOL comingFromAddTaskViewController;
@property (assign, nonatomic) BOOL comingFromViewTaskViewController;

@property (strong, nonatomic) NSMutableArray *itemsAlreadyChosenArray;
@property (strong, nonatomic) NSMutableArray * _Nullable allItemTagsArrays;

@property (weak, nonatomic) IBOutlet UIView *tagsView;
@property (weak, nonatomic) IBOutlet UIView *addTagView;

@property (weak, nonatomic) IBOutlet UITextField *addTagTextField;

@end

NS_ASSUME_NONNULL_END
