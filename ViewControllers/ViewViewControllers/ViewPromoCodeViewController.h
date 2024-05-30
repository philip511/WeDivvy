//
//  ViewPromoCodeViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 4/20/23.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <AddressBookUI/AddressBookUI.h>
#import <Contacts/Contacts.h>
#import <StoreKit/StoreKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewPromoCodeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, UITextFieldDelegate, SKProductsRequestDelegate>

@property (weak, nonatomic) IBOutlet UITableView *customTableView;

@property (weak, nonatomic) IBOutlet UIButton *sharePromoCodeButton;

@property (weak, nonatomic) IBOutlet UIView *inviteReminderBackDropView;
@property (weak, nonatomic) IBOutlet UIView *inviteReminderAlertView;
@property (weak, nonatomic) IBOutlet UILabel *inviteReminderAlertViewTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *inviteReminderAlertViewSubTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *inviteReminderAlertViewAlertLabel;
@property (weak, nonatomic) IBOutlet UIImageView *inviteReminderAlertViewAlertImage;
@property (weak, nonatomic) IBOutlet UIImageView *inviteReminderAlertViewXIcon;
@property (weak, nonatomic) IBOutlet UIView *inviteReminderAlertViewXIconCover;
@property (weak, nonatomic) IBOutlet UIButton *inviteReminderAlertViewSubmitButton;

@end

NS_ASSUME_NONNULL_END
