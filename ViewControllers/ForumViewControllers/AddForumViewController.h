//
//  AddForumViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 8/11/21.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddForumViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (assign, nonatomic) BOOL viewingFeatureForum;
@property (assign, nonatomic) BOOL editingSpecificForumPost;
@property (assign, nonatomic) BOOL viewingSpecificForumPost;

@property (strong, nonatomic) NSMutableDictionary *itemToEditDict;

@property (weak, nonatomic) IBOutlet UIView *itemNameView;
@property (weak, nonatomic) IBOutlet UITextField *itemNameTextField;

@property (weak, nonatomic) IBOutlet UIView *itemNotesView;
@property (weak, nonatomic) IBOutlet UITextView *itemNotesTextField;

@property (weak, nonatomic) IBOutlet UIView *addImageView;
@property (weak, nonatomic) IBOutlet UIImageView *addImageImage;

@property (weak, nonatomic) IBOutlet UIButton *itemAddImageLabel;

@end

NS_ASSUME_NONNULL_END
