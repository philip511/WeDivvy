//
//  ViewTaskViewController.h
//  RoommateApp
//
//  Created by Philip Nagel on 5/21/21.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/SDWebImage.h>
#import <Mixpanel/Mixpanel.h>
#import <MRProgressOverlayView.h>
#import <Photos/Photos.h>
#import <StoreKit/StoreKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewTaskViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPickerViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, SKProductsRequestDelegate>

@property (assign, nonatomic) BOOL viewingViewExpenseViewController;
@property (assign, nonatomic) BOOL viewingViewListViewController;
@property (assign, nonatomic) BOOL viewingOccurrence;

@property (strong, nonatomic) NSString *itemID;
@property (strong, nonatomic) NSString * _Nullable itemOccurrenceID;

@property (strong, nonatomic) NSMutableDictionary *itemDictFromPreviousPage;
@property (strong, nonatomic) NSMutableDictionary *itemOccurrencesDict;

@property (strong, nonatomic) NSMutableArray *homeMembersArray;
@property (strong, nonatomic) NSMutableDictionary *homeMembersDict;
@property (strong, nonatomic) NSMutableDictionary *notificationSettingsDict;
@property (strong, nonatomic) NSMutableDictionary *topicDict;
@property (strong, nonatomic) NSMutableDictionary * _Nullable collectionDict;
@property (strong, nonatomic) NSMutableDictionary * _Nullable folderDict;
@property (strong, nonatomic) NSMutableDictionary * _Nullable taskListDict;
@property (strong, nonatomic) NSMutableDictionary * _Nullable sectionDict;
@property (strong, nonatomic) NSMutableDictionary * _Nullable templateDict;
@property (strong, nonatomic) NSMutableDictionary * _Nullable draftDict;
@property (strong, nonatomic) NSMutableArray * _Nullable itemNamesAlreadyUsed;
@property (strong, nonatomic) NSMutableArray * _Nullable allItemAssignedToArrays;
@property (strong, nonatomic) NSMutableArray * _Nullable allItemTagsArrays;
@property (strong, nonatomic) NSMutableArray * _Nullable allItemIDsArrays;
@property (weak, nonatomic) IBOutlet UIScrollView *customScrollView;

@property (weak, nonatomic) IBOutlet UITableView *customTableView;
@property (weak, nonatomic) IBOutlet UITableView *subTasksTableView;

@property (weak, nonatomic) IBOutlet UIView *notificationReminderView;
@property (weak, nonatomic) IBOutlet UILabel *notificationitemReminderLabel;
@property (weak, nonatomic) IBOutlet UIView *notificationReminderSeparator;

@property (weak, nonatomic) IBOutlet UIImageView *viewItemImageView;
@property (weak, nonatomic) IBOutlet UIView *viewItemView;
@property (weak, nonatomic) IBOutlet UIButton *viewItemViewOverlay;
@property (weak, nonatomic) IBOutlet UILabel *viewItemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewItemitemDueDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewItemNotesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *viewItemEllipsisImage;
@property (weak, nonatomic) IBOutlet UIImageView *viewItemItemPriorityImage;
@property (weak, nonatomic) IBOutlet UIView *viewItemItemColor;
@property (weak, nonatomic) IBOutlet UIImageView *viewItemItemMutedImage;
@property (weak, nonatomic) IBOutlet UIImageView *viewItemItemPrivateImage;
@property (weak, nonatomic) IBOutlet UIImageView *viewItemItemReminderImage;

@property (weak, nonatomic) IBOutlet UIView *viewPaymentMethodView;
@property (weak, nonatomic) IBOutlet UIButton *viewPaymentMethodViewOverlay;
@property (weak, nonatomic) IBOutlet UILabel *viewPaymentMethodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewPaymentMethodDataLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewPaymentMethodNotesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *viewPaymentMethodEllipsisImage;

@property (weak, nonatomic) IBOutlet UIView *viewRewardView;
@property (weak, nonatomic) IBOutlet UIButton *viewRewardViewOverlay;
@property (weak, nonatomic) IBOutlet UILabel *viewRewardNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewRewardDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewRewardNotesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *viewRewardImage;
@property (weak, nonatomic) IBOutlet UIImageView *viewRewardEllipsisImage;

@property (weak, nonatomic) IBOutlet UIView *progressBarOne;
@property (weak, nonatomic) IBOutlet UIView *progressBarTwo;
@property (weak, nonatomic) IBOutlet UILabel *percentageLabel;

@property (weak, nonatomic) IBOutlet UIView *writeTaskContainerView;
@property (weak, nonatomic) IBOutlet UIView *writeTaskView;
@property (weak, nonatomic) IBOutlet UIView *writeTaskBackgroundView;
@property (weak, nonatomic) IBOutlet UITextField *writeTaskTextField;
@property (weak, nonatomic) IBOutlet UITextField *writeAssignedToTaskTextField;

@property (weak, nonatomic) IBOutlet UIView *lastCommentView;
@property (weak, nonatomic) IBOutlet UIView *lastCommentViewTextView;
@property (weak, nonatomic) IBOutlet UILabel *lastCommentViewTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *lastCommentViewProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *lastCommentViewNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastCommentViewTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *lastCommentPremiumImage;

@property (weak, nonatomic) IBOutlet UILabel *lastCommentNoCommentLabel;
@property (weak, nonatomic) IBOutlet UIView *lastCommentNoCommentView;

@end

NS_ASSUME_NONNULL_END
