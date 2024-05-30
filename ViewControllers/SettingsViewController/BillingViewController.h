//
//  BillingViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 3/11/22.
//

#import <UIKit/UIKit.h>
#import <MRProgressOverlayView.h>
#import <MessageUI/MessageUI.h>

NS_ASSUME_NONNULL_BEGIN

@interface BillingViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UILabel *subscriptionStartDateTopLabel;
@property (weak, nonatomic) IBOutlet UIView *subscriptionStartDateView;
@property (weak, nonatomic) IBOutlet UILabel *subscriptionStartDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *subscriptionTypeTopLabel;
@property (weak, nonatomic) IBOutlet UIView *subscriptionTypeView;
@property (weak, nonatomic) IBOutlet UILabel *subscriptionTypeLabel;

@property (weak, nonatomic) IBOutlet UIButton *cancelSubscriptionButton;

@end

NS_ASSUME_NONNULL_END
