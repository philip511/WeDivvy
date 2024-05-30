//
//  SettingsViewController.h
//  RoommateApp
//
//  Created by Philip Nagel on 5/18/21.
//

#import <UIKit/UIKit.h>
#import <MRProgressOverlayView.h>
#import <MessageUI/MessageUI.h>
#import <StoreKit/StoreKit.h>
#import <EventKit/EventKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingsViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, MFMailComposeViewControllerDelegate, UIScrollViewDelegate, SKProductsRequestDelegate>

@property (assign, nonatomic) BOOL viewingPremiumSettings;
@property (strong, nonatomic) NSMutableArray * _Nullable allItemAssignedToArrays;




@property (weak, nonatomic) IBOutlet UIScrollView *customScrollView;




@property (weak, nonatomic) IBOutlet UIView *requestFeedbackAlertView;
@property (weak, nonatomic) IBOutlet UIView *requestFeedbackBackdropView;
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

@end

NS_ASSUME_NONNULL_END
