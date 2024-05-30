//
//  ViewPaymentMethodViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 4/15/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewPaymentMethodViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) NSMutableDictionary *itemPaymentMethodDict;

@property (assign, nonatomic) BOOL comingFromAddTaskViewController;
@property (assign, nonatomic) BOOL viewingReward;
@property (assign, nonatomic) BOOL viewingPaymentMethod;

@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UIView *usernameView;
@property (weak, nonatomic) IBOutlet UIView *notesView;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextView *notesTextField;

@end

NS_ASSUME_NONNULL_END
