//
//  CreateHomeViewController.h
//  RoommateApp
//
//  Created by Philip Nagel on 5/23/21.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import <StoreKit/StoreKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CreateHomeViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, SKProductsRequestDelegate, SKProductsRequestDelegate, UITextFieldDelegate>

@property (strong, nonatomic) NSMutableArray *arrayOfHomeIDsYouAreAPartOf;
@property (assign, nonatomic) BOOL comingFromSignUp;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (weak, nonatomic) IBOutlet UIButton *createHomeButton;
@property (weak, nonatomic) IBOutlet UIButton *findHomeButton;
@property (weak, nonatomic) IBOutlet UIButton *createHomeButtonCover;
@property (weak, nonatomic) IBOutlet UIButton *findHomeButtonCover;

@property (weak, nonatomic) IBOutlet UIImageView *homeImage;
@property (weak, nonatomic) IBOutlet UIImageView *keyImage;
@property (weak, nonatomic) IBOutlet UIImageView *codeKeyImage;

@property (weak, nonatomic) IBOutlet UITextField *homeNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *keyTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeKeyTextField;

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *homeView;
@property (weak, nonatomic) IBOutlet UIView *keyView;
@property (weak, nonatomic) IBOutlet UIView *codeKeyView;
@property (weak, nonatomic) IBOutlet UIView *slidingBar;
@property (weak, nonatomic) IBOutlet UIView *viewOne;
@property (weak, nonatomic) IBOutlet UIView *viewTwo;
@property (weak, nonatomic) IBOutlet UIView *separatorView;

@end

NS_ASSUME_NONNULL_END
