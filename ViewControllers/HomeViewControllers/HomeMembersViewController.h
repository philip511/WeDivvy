//
//  HomeMembersViewController.h
//  RoommateApp
//
//  Created by Philip Nagel on 5/27/21.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <AddressBookUI/AddressBookUI.h>
#import <Contacts/Contacts.h>
#import <StoreKit/StoreKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeMembersViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, UITextFieldDelegate, SKProductsRequestDelegate>

@property (assign, nonatomic) BOOL viewingHomeMembersFromHomesViewController;

@property (strong, nonatomic) NSString *homeID;
@property (strong, nonatomic) NSString *homeName;
@property (strong, nonatomic) NSMutableDictionary *notificationSettingsDict;
@property (strong, nonatomic) NSMutableDictionary *topicDict;

@property (weak, nonatomic) IBOutlet UIImageView *homeKeyImage;
@property (weak, nonatomic) IBOutlet UIImageView *moveOutImage;
@property (weak, nonatomic) IBOutlet UIImageView *multipleHomesImage;

@property (weak, nonatomic) IBOutlet UITableView *customTableView;

@property (weak, nonatomic) IBOutlet UIButton *addHomeMemberButton;

@property (weak, nonatomic) IBOutlet UIButton *hasAndroidButton;
@property (weak, nonatomic) IBOutlet UIButton *tellAFriendButton;

@property (weak, nonatomic) IBOutlet UIView *inviteReminderBackDropView;
@property (weak, nonatomic) IBOutlet UIView *inviteReminderAlertView;
@property (weak, nonatomic) IBOutlet UILabel *inviteReminderAlertViewTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *inviteReminderAlertViewSubTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *inviteReminderAlertViewXIcon;
@property (weak, nonatomic) IBOutlet UIView *inviteReminderAlertViewXIconCover;
@property (weak, nonatomic) IBOutlet UIButton *inviteReminderAlertViewSubmitButton;

@property (weak, nonatomic) IBOutlet UIView *inviteHomeMemberBackDropView;
@property (weak, nonatomic) IBOutlet UIView *inviteHomeMemberAlertView;
@property (weak, nonatomic) IBOutlet UILabel *inviteHomeMemberAlertViewTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *inviteHomeMemberAlertViewSubTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *inviteHomeMemberAlertViewXIcon;
@property (weak, nonatomic) IBOutlet UIView *inviteHomeMemberAlertViewXIconCover;
@property (weak, nonatomic) IBOutlet UIButton *inviteHomeMemberAlertViewSubmitButton;
@property (weak, nonatomic) IBOutlet UIButton *inviteHomeMemberAlertViewLaterButton;

@end

NS_ASSUME_NONNULL_END
