//
//  EditProfileViewController.h
//  RoommateApp
//
//  Created by Philip Nagel on 5/22/21.
//

#import <UIKit/UIKit.h>
#import <MRProgressOverlayView.h>


NS_ASSUME_NONNULL_BEGIN

@interface EditProfileViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (assign, nonatomic) BOOL editingHome;
@property (strong, nonatomic) NSString *homeID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *imageURL;

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIImageView *cameraImage;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UIView *greyView;
@property (weak, nonatomic) IBOutlet UIView *usernameView;

@end

NS_ASSUME_NONNULL_END
