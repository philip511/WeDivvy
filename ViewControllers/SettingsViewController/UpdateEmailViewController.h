//
//  UpdateEmailViewController.h
//  RoommateApp
//
//  Created by Philip Nagel on 5/22/21.
//

#import <UIKit/UIKit.h>
#import <MRProgressOverlayView.h>


NS_ASSUME_NONNULL_BEGIN

@interface UpdateEmailViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *clickWhenVerifiedButton;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIView *emailView;
@property (weak, nonatomic) IBOutlet UIView *currentEmailView;
@property (weak, nonatomic) IBOutlet UILabel *currentEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstTopLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondTopLabel;

@end

NS_ASSUME_NONNULL_END
