//
//  InviteMembersViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 11/13/21.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <AddressBookUI/AddressBookUI.h>
#import <Contacts/Contacts.h>

NS_ASSUME_NONNULL_BEGIN

@interface InviteMembersViewController : UIViewController <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *whoWasInvitedLabel;
@property (weak, nonatomic) IBOutlet UIButton *inviteFriendsButton;
@property (weak, nonatomic) IBOutlet UIButton *maybeLabelButton;

@end

NS_ASSUME_NONNULL_END
