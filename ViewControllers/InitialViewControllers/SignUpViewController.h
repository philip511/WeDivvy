//
//  SignUpViewController.h
//  RoommateApp
//
//  Created by Philip Nagel on 5/17/21.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface SignUpViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UITextViewDelegate>

@property (assign, nonatomic) BOOL ThirdPartySignup;

@property (weak, nonatomic) IBOutlet UIButton *createAccountButton;
@property (weak, nonatomic) IBOutlet UIButton *hearAboutUsButton;
@property (weak, nonatomic) IBOutlet UIButton *whoIsThisForButton;

@property (weak, nonatomic) IBOutlet UIImageView *middleImage;

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *hearAboutUsLabel;
@property (weak, nonatomic) IBOutlet UILabel *whoIsThisForLabel;
@property (weak, nonatomic) IBOutlet UILabel *receiveEmailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *receiveEmailsSubLabel;

@property (weak, nonatomic) IBOutlet UITextView *TOSandPPTextView;

@property (weak, nonatomic) IBOutlet UITextField *UsernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *EmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *HearAboutUsTextField;
@property (weak, nonatomic) IBOutlet UITextField *whoIsThisForTextField;

@property (weak, nonatomic) IBOutlet UIView *usernameView;
@property (weak, nonatomic) IBOutlet UIView *emailView;
@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UIView *hearAboutUsView;
@property (weak, nonatomic) IBOutlet UIView *whoIsThisForView;
@property (weak, nonatomic) IBOutlet UIView *receiveEmailsView;

@property (weak, nonatomic) IBOutlet UISwitch *receiveEmailsSwitch;

@end

NS_ASSUME_NONNULL_END
