//
//  ViewAssignedToViewController.h
//  RoommateApp
//
//  Created by Philip Nagel on 5/21/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewAssignedToViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (assign, nonatomic) BOOL viewingItemDetails;
@property (assign, nonatomic) BOOL viewingExpense;
@property (assign, nonatomic) BOOL viewingChatMembers;
@property (assign, nonatomic) BOOL viewingWeDivvyPremiumAddingAccounts;
@property (assign, nonatomic) BOOL viewingWeDivvyPremiumEditingAccounts;

@property (strong, nonatomic) NSString *itemAssignedToAnybody;
@property (strong, nonatomic) NSString *itemAssignedToNewHomeMembers;
@property (strong, nonatomic) NSString *itemUniqueID;

@property (strong, nonatomic) NSMutableDictionary *homeMembersDict;
@property (strong, nonatomic) NSMutableDictionary *notificationSettingsDict;
@property (strong, nonatomic) NSMutableDictionary *topicDict;
@property (strong, nonatomic) NSMutableDictionary *homeMembersUnclaimedDict;
@property (strong, nonatomic) NSMutableDictionary *homeKeysDict;
@property (strong, nonatomic) NSMutableArray *homeKeysArray;
@property (strong, nonatomic) NSMutableArray *homeMembersArray;
@property (strong, nonatomic) NSMutableArray *selectedArray;

@property (weak, nonatomic) IBOutlet UITableView *customTableView;
@property (weak, nonatomic) IBOutlet UIButton *addHomeMemberButton;
@property (weak, nonatomic) IBOutlet UIButton *hasAndroidButton;

@property (weak, nonatomic) IBOutlet UIView *assignedToAnybodyView;
@property (weak, nonatomic) IBOutlet UILabel *assignedToAnybodyLabel;
@property (weak, nonatomic) IBOutlet UISwitch *assignedToAnybodySwitch;
@property (weak, nonatomic) IBOutlet UIImageView *assignedToAnybodyInfoImage;

@property (weak, nonatomic) IBOutlet UIView *assignNewHomeMembersView;
@property (weak, nonatomic) IBOutlet UILabel *assignNewHomeMembersLabel;
@property (weak, nonatomic) IBOutlet UISwitch *assignNewHomeMembersSwitch;
@property (weak, nonatomic) IBOutlet UIImageView *assignNewHomeMembersInfoImage;

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
