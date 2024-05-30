//
//  TasksViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 10/15/23.
//

#import <UIKit/UIKit.h>
#import "AnalyticsViewController.h"
#import <MRProgressOverlayView.h>
#import <SDWebImage/SDWebImage.h>
#import <Mixpanel/Mixpanel.h>
#import <StoreKit/StoreKit.h>

#import <Vision/Vision.h>
#import <VisionKit/VisionKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TasksViewController : AnalyticsViewController <UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate, UITextViewDelegate, UIScrollViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate, SKProductsRequestDelegate, VNDocumentCameraViewControllerDelegate>

-(NSMutableArray *)GenerateSectionsArray:(NSMutableArray *)itemTagsArrayOfArrays taskListDict:(NSMutableDictionary *)taskListDict sectionDict:(NSMutableDictionary *)sectionDict sideBarCategorySectionArrayAltered:(NSMutableArray *)sideBarCategorySectionArrayAltered sideBarCategorySectionArrayOriginal:(NSMutableArray *)sideBarCategorySectionArrayOriginal sectionOriginalSection:(int)sectionOriginalSection usersSection:(int)usersSection tagsSection:(int)tagsSection colorsSection:(int)colorsSection;



@property (weak, nonatomic) IBOutlet UIView *addTaskBackDropView;
@property (weak, nonatomic) IBOutlet UIView *addTaskAddingView;
@property (weak, nonatomic) IBOutlet UIView *addTaskTextViewView;
@property (weak, nonatomic) IBOutlet UITextView *addTaskItemNameTextView;
@property (weak, nonatomic) IBOutlet UITextView *addTaskItemNotesTextView;
@property (weak, nonatomic) IBOutlet UITextView *addTaskItemAmountTextView;
@property (weak, nonatomic) IBOutlet UITextView *addTaskItemListItemsTextView;
@property (weak, nonatomic) IBOutlet UIView *addTaskOptionsScrollViewView;
@property (weak, nonatomic) IBOutlet UIScrollView *addTaskOptionsScrollView;
@property (weak, nonatomic) IBOutlet UIView *addTaskOptionsScrollViewViewNo1;
@property (weak, nonatomic) IBOutlet UIScrollView *addTaskOptionsScrollViewNo1;

@property (weak, nonatomic) IBOutlet UIImageView *addTaskScrollViewAssignedToIcon;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskScrollViewDueDateIcon;
@property (weak, nonatomic) IBOutlet UIButton *addTaskScrollViewDueDateIconButton;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskScrollViewRepeatsIcon;
@property (weak, nonatomic) IBOutlet UIButton *addTaskScrollViewRepeatsIconButton;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskScrollViewPriorityIcon;
@property (weak, nonatomic) IBOutlet UIButton *addTaskScrollViewPriorityIconButton;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskScrollViewExpandIcon;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskScrollViewDaysIcon;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskScrollViewTimeIcon;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskScrollViewTakeTurnsIcon;
@property (weak, nonatomic) IBOutlet UIButton *addTaskScrollViewTakeTurnsIconButton;
@property (weak, nonatomic) IBOutlet UIView *addTaskAddButtonView;
@property (weak, nonatomic) IBOutlet UIButton *addTaskAddButton;
@property (weak, nonatomic) IBOutlet UIView *addTaskAddButtonCover;

@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewAssignedTo;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewImageViewAssignedTo;
@property (weak, nonatomic) IBOutlet UILabel *addTaskSelectedViewLabelAssignedTo;
@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewXViewAssignedTo;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewXImageViewAssignedTo;

//@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewCostPerPerson;
//@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewImageViewCostPerPerson;
//@property (weak, nonatomic) IBOutlet UILabel *addTaskSelectedViewLabelCostPerPerson;
//@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewXViewCostPerPerson;
//@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewXImageViewCostPerPerson;

@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewRepeats;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewImageViewRepeats;
@property (weak, nonatomic) IBOutlet UILabel *addTaskSelectedViewLabelRepeats;
@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewXViewRepeats;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewXImageViewRepeats;
@property (weak, nonatomic) IBOutlet UIButton *addTaskSelectedViewButtonRepeats;

@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewDueDate;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewImageView3;
@property (weak, nonatomic) IBOutlet UILabel *addTaskSelectedViewLabelDueDate;
@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewXViewDueDate;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewXImageViewDueDate;
@property (weak, nonatomic) IBOutlet UIButton *addTaskSelectedViewButtonDueDate;

//@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewReminder;
//@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewImageViewReminder;
//@property (weak, nonatomic) IBOutlet UILabel *addTaskSelectedViewLabelReminder;
//@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewXViewReminder;
//@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewXImageViewReminder;

//@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewNotes;
//@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewImageViewNotes;
//@property (weak, nonatomic) IBOutlet UILabel *addTaskSelectedViewLabelNotes;
//@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewXViewNotes;
//@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewXImageViewNotes;

@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewPriority;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewImageViewPriority;
@property (weak, nonatomic) IBOutlet UILabel *addTaskSelectedViewLabelPriority;
@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewXViewPriority;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewXImageViewPriority;
@property (weak, nonatomic) IBOutlet UIButton *addTaskSelectedViewButtonPriority;

@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewTakeTurns;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewImageViewTakeTurns;
@property (weak, nonatomic) IBOutlet UILabel *addTaskSelectedViewLabelTakeTurns;
@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewXViewTakeTurns;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewXImageViewTakeTurns;
@property (weak, nonatomic) IBOutlet UIButton *addTaskSelectedViewButtonTakeTurns;

@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewTime;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewImageViewTime;
@property (weak, nonatomic) IBOutlet UILabel *addTaskSelectedViewLabelTime;
@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewXViewTime;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewXImageViewTime;

@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewDays;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewImageViewDays;
@property (weak, nonatomic) IBOutlet UILabel *addTaskSelectedViewLabelDays;
@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewXViewDays;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewXImageViewDays;

//@property (weak, nonatomic) IBOutlet UIView *addTaskButtonImage;





@property (weak, nonatomic) IBOutlet UIView *bottomOptionsView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomOptionsPinImage;
@property (weak, nonatomic) IBOutlet UIImageView *bottomOptionsFolderImage;
@property (weak, nonatomic) IBOutlet UIImageView *bottomOptionsMoveToTrashImage;
@property (weak, nonatomic) IBOutlet UIImageView *bottomOptionsEllipsisImage;
@property (weak, nonatomic) IBOutlet UIImageView *bottomOptionsMoveOutOfTrashImage;
@property (weak, nonatomic) IBOutlet UIImageView *bottomOptionsDeleteTrashImage;
@property (weak, nonatomic) IBOutlet UIButton *bottomOptionsPinImageOverlay;
@property (weak, nonatomic) IBOutlet UIButton *bottomOptionsFolderImageOverlay;
@property (weak, nonatomic) IBOutlet UIButton *bottomOptionsMoveToTrashImageOverlay;
@property (weak, nonatomic) IBOutlet UIButton *bottomOptionsEllipsisImageOverlay;
@property (weak, nonatomic) IBOutlet UIButton *bottomOptionsMoveOutOfTrashImageOverlay;
@property (weak, nonatomic) IBOutlet UIButton *bottomOptionsDeleteTrashImageOverlay;




@property (weak, nonatomic) IBOutlet UIView *sideBarView;
@property (weak, nonatomic) IBOutlet UITableView *sideBarTableView;
@property (weak, nonatomic) IBOutlet UIView *sideBarAddView;
@property (weak, nonatomic) IBOutlet UIImageView *sideBarAddImage;
@property (weak, nonatomic) IBOutlet UILabel *sideBarAddLabel;




@property (strong, nonatomic) NSString *homeIDChosen;
@property (strong, nonatomic) NSString *homeNameChosen;




@property (weak, nonatomic) IBOutlet UIScrollView *customScrollView;




@property (weak, nonatomic) IBOutlet UIView *statusBarOverView;
@property (weak, nonatomic) IBOutlet UIView *topView;




@property (weak, nonatomic) IBOutlet UIView *notificationReminderView;
@property (weak, nonatomic) IBOutlet UILabel *notificationitemReminderLabel;
@property (weak, nonatomic) IBOutlet UIImageView *notificationitemReminderImage;
@property (weak, nonatomic) IBOutlet UIView *notificationReminderSeparator;




@property (weak, nonatomic) IBOutlet UIImageView *homeMemberImage;
@property (weak, nonatomic) IBOutlet UIImageView *notificationImage;
@property (weak, nonatomic) IBOutlet UIImageView *settingsImage;
@property (weak, nonatomic) IBOutlet UIImageView *calendarImage;
@property (weak, nonatomic) IBOutlet UIImageView *searchImage;
@property (weak, nonatomic) IBOutlet UIImageView *searchPremiumImage;
@property (weak, nonatomic) IBOutlet UIImageView *activityImage;
@property (weak, nonatomic) IBOutlet UIImageView *activityPremiumImage;




@property (weak, nonatomic) IBOutlet UIButton *sideBarImage;
@property (weak, nonatomic) IBOutlet UIButton *sideBarImageOverlayView;
@property (weak, nonatomic) IBOutlet UILabel *middleLabel;
@property (weak, nonatomic) IBOutlet UIButton *walletImage;
@property (weak, nonatomic) IBOutlet UIButton *walletOverlayView;
@property (weak, nonatomic) IBOutlet UIButton *ellipsisImage;
@property (weak, nonatomic) IBOutlet UIButton *ellipsisOverlayView;
@property (weak, nonatomic) IBOutlet UIView *separatorView;




@property (weak, nonatomic) IBOutlet UIView *pendingInvitesView;
@property (weak, nonatomic) IBOutlet UILabel *pendingInvitesLabel;

@property (weak, nonatomic) IBOutlet UIView *unreadActivityView;
@property (weak, nonatomic) IBOutlet UILabel *unreadActivityLabel;

@property (weak, nonatomic) IBOutlet UIView *unreadNotificationsView;
@property (weak, nonatomic) IBOutlet UILabel *unreadNotificationsViewLabel;




@property (weak, nonatomic) IBOutlet UITableView *customTableView;




@property (weak, nonatomic) IBOutlet UIView *addTaskView;
@property (weak, nonatomic) IBOutlet UIButton *addTaskButton;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskButtonImage;
@property (weak, nonatomic) IBOutlet UIButton *addTaskButtonCover;




@property (weak, nonatomic) IBOutlet UIView *tabBarView;




@property (weak, nonatomic) IBOutlet UIImageView *choreIconImage;
@property (weak, nonatomic) IBOutlet UILabel *choreIconLabel;
@property (weak, nonatomic) IBOutlet UIView *choreIconTapView;

@property (weak, nonatomic) IBOutlet UIImageView *expenseIconImage;
@property (weak, nonatomic) IBOutlet UILabel *expenseLabelImage;
@property (weak, nonatomic) IBOutlet UIView *expenseIconTapView;

@property (weak, nonatomic) IBOutlet UIImageView *listsIconImage;
@property (weak, nonatomic) IBOutlet UILabel *listsLabelImage;
@property (weak, nonatomic) IBOutlet UIView *listsIconTapView;

@property (weak, nonatomic) IBOutlet UIImageView *chatsIconImage;
@property (weak, nonatomic) IBOutlet UILabel *chatsLabelImage;
@property (weak, nonatomic) IBOutlet UIView *chatsIconTapView;




@property (weak, nonatomic) IBOutlet UIView *emptyTableViewView;
@property (weak, nonatomic) IBOutlet UIImageView *emptyTableViewImage;
@property (weak, nonatomic) IBOutlet UILabel *emptyTableViewTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *emptyTableViewBodyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *emptyTableViewArrowImage;




@property (weak, nonatomic) IBOutlet UIView *requestFeedbackBackdropView;
@property (weak, nonatomic) IBOutlet UIView *requestFeedbackAlertView;
@property (weak, nonatomic) IBOutlet UIScrollView *requestFeedbackAlertViewScrollView;




@property (weak, nonatomic) IBOutlet UIView *requestFeedbackAlertViewOption1;
@property (weak, nonatomic) IBOutlet UIView *requestFeedbackAlertViewOption2;
@property (weak, nonatomic) IBOutlet UIView *requestFeedbackAlertViewOption3;
@property (weak, nonatomic) IBOutlet UIView *requestFeedbackAlertViewOption4;
@property (weak, nonatomic) IBOutlet UIView *requestFeedbackAlertViewOption5;
@property (weak, nonatomic) IBOutlet UIView *requestFeedbackAlertViewOption6;
@property (weak, nonatomic) IBOutlet UIView *requestFeedbackAlertViewOption7;
@property (weak, nonatomic) IBOutlet UIView *requestFeedbackAlertViewOption8;
@property (weak, nonatomic) IBOutlet UIView *requestFeedbackAlertViewOption9;
@property (weak, nonatomic) IBOutlet UIView *requestFeedbackAlertViewOption10;

@property (weak, nonatomic) IBOutlet UILabel *requestFeedbackAlertViewOptionLabel1;
@property (weak, nonatomic) IBOutlet UILabel *requestFeedbackAlertViewOptionLabel2;
@property (weak, nonatomic) IBOutlet UILabel *requestFeedbackAlertViewOptionLabel3;
@property (weak, nonatomic) IBOutlet UILabel *requestFeedbackAlertViewOptionLabel4;
@property (weak, nonatomic) IBOutlet UILabel *requestFeedbackAlertViewOptionLabel5;
@property (weak, nonatomic) IBOutlet UILabel *requestFeedbackAlertViewOptionLabel6;
@property (weak, nonatomic) IBOutlet UILabel *requestFeedbackAlertViewOptionLabel7;
@property (weak, nonatomic) IBOutlet UILabel *requestFeedbackAlertViewOptionLabel8;
@property (weak, nonatomic) IBOutlet UILabel *requestFeedbackAlertViewOptionLabel9;
@property (weak, nonatomic) IBOutlet UILabel *requestFeedbackAlertViewOptionLabel10;

@property (weak, nonatomic) IBOutlet UILabel *requestFeedbackAlertViewQuestionLabel1;
@property (weak, nonatomic) IBOutlet UILabel *requestFeedbackAlertViewQuestionLabel2;
@property (weak, nonatomic) IBOutlet UILabel *requestFeedbackAlertViewQuestionLabel3;
@property (weak, nonatomic) IBOutlet UILabel *requestFeedbackAlertViewThankYouLabel;

@property (weak, nonatomic) IBOutlet UIImageView *requestFeedbackAlertViewXIcon1;
@property (weak, nonatomic) IBOutlet UIImageView *requestFeedbackAlertViewXIcon2;
@property (weak, nonatomic) IBOutlet UIImageView *requestFeedbackAlertViewXIcon3;

@property (weak, nonatomic) IBOutlet UIView *requestFeedbackAlertViewXIcon1Cover;
@property (weak, nonatomic) IBOutlet UIView *requestFeedbackAlertViewXIcon2Cover;
@property (weak, nonatomic) IBOutlet UIView *requestFeedbackAlertViewXIcon3Cover;

@property (weak, nonatomic) IBOutlet UILabel *requestFeedbackAlertViewSubmitButtonLabel1;
@property (weak, nonatomic) IBOutlet UILabel *requestFeedbackAlertViewSubmitButtonLabel2;
@property (weak, nonatomic) IBOutlet UILabel *requestFeedbackAlertViewRateOurAppButtonLabel;

@property (weak, nonatomic) IBOutlet UIView *requestFeedbackAlertViewNotesView;
@property (weak, nonatomic) IBOutlet UITextView *requestFeedbackAlertViewNotesTextView;

@property (weak, nonatomic) IBOutlet UIImageView *requestFeedbackAlertViewCheckmarkImage;




@property (weak, nonatomic) IBOutlet UIView *reportCrashBackdropView;
@property (weak, nonatomic) IBOutlet UIView *reportCrashAlertView;
@property (weak, nonatomic) IBOutlet UIScrollView *reportCrashAlertViewScrollView;




@property (weak, nonatomic) IBOutlet UILabel *reportCrashAlertViewQuestionLabel1;
@property (weak, nonatomic) IBOutlet UIImageView *reportCrashAlertViewXIcon1;
@property (weak, nonatomic) IBOutlet UIView *reportCrashAlertViewXIcon1Cover;
@property (weak, nonatomic) IBOutlet UIView *reportCrashAlertViewNotesView;
@property (weak, nonatomic) IBOutlet UITextView *reportCrashAlertViewNotesTextView;
@property (weak, nonatomic) IBOutlet UILabel *reportCrashAlertViewSubmitButtonLabel1;




@end

NS_ASSUME_NONNULL_END
