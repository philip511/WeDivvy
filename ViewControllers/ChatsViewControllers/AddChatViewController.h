//
//  AddChatViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 10/3/21.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddChatViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (assign, nonatomic) BOOL featureForum;

@property (strong, nonatomic) NSMutableDictionary * itemToEditDict;
@property (strong, nonatomic) NSMutableArray *homeMembersArray;
@property (strong, nonatomic) NSMutableDictionary *homeMembersDict;
@property (strong, nonatomic) NSMutableDictionary *notificationSettingsDict;
@property (strong, nonatomic) NSMutableDictionary *topicDict;

@property (weak, nonatomic) IBOutlet UIView *itemNameView;
@property (weak, nonatomic) IBOutlet UIView *itemAssignedToView;

@property (weak, nonatomic) IBOutlet UITextField *itemNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *itemAssignedToTextField;

@property (weak, nonatomic) IBOutlet UIImageView *itemAssignedToImage;

@property (weak, nonatomic) IBOutlet UILabel *itemAssignedToLabel;

@property (weak, nonatomic) IBOutlet UIImageView *rightArrowImage1;

@property (weak, nonatomic) IBOutlet UIView *addImageView;
@property (weak, nonatomic) IBOutlet UIImageView *addImageImage;

@property (weak, nonatomic) IBOutlet UIButton *itemAddImageLabel;

@end

NS_ASSUME_NONNULL_END
