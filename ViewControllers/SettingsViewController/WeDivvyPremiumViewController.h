//
//  WeDivvyPremiumViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 3/11/22.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeDivvyPremiumViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver, UITextViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *saleImage;

@property (assign, nonatomic) BOOL comingFromSignUp;
@property (assign, nonatomic) BOOL viewingSlideShow;

@property (strong, nonatomic) NSString *defaultPlan;
@property (strong, nonatomic) NSString *displayDiscount;
@property (strong, nonatomic) NSString *selectedSlide;
@property (strong, nonatomic) NSString *promoCodeID;

@property (strong, nonatomic) NSMutableDictionary *itemsDict;
@property (strong, nonatomic) NSMutableDictionary *itemsDictNo2;
@property (strong, nonatomic) NSMutableDictionary *itemsDictNo3;

@property (strong, nonatomic) NSMutableDictionary *premiumPlanPricesDict;
@property (strong, nonatomic) NSMutableDictionary *premiumPlanExpensivePricesDict;
@property (strong, nonatomic) NSMutableDictionary *premiumPlanPricesDiscountDict;
@property (strong, nonatomic) NSMutableDictionary *premiumPlanPricesNoFreeTrialDict;
@property (strong, nonatomic) NSMutableArray *premiumPlanProductsArray;

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *premiumFeaturesScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *premiumFeatureSlidesScrollViewNo1;

@property (weak, nonatomic) IBOutlet UITableView *premiumFeaturesTableView;

@property (weak, nonatomic) IBOutlet UIView *purchaseSubscriptionView;

@property (weak, nonatomic) IBOutlet UIView *purchaseViewTopLineView;

@property (weak, nonatomic) IBOutlet UIView *premiumPlanLabelBackView;
@property (weak, nonatomic) IBOutlet UIButton *premiumPlanBackViewOverlay;
@property (weak, nonatomic) IBOutlet UILabel *premiumPlanLabel;
@property (weak, nonatomic) IBOutlet UIImageView *downArrow;

@property (weak, nonatomic) IBOutlet UIImageView *promotionalCodeButton;

//@property (weak, nonatomic) IBOutlet UIImageView *faqButton;
//@property (weak, nonatomic) IBOutlet UIImageView *freeTrialFaqButton;
//
//@property (weak, nonatomic) IBOutlet UILabel *premiumPlanDetailsLabel;

@property (weak, nonatomic) IBOutlet UILabel *simpleOptionLabel;
@property (weak, nonatomic) IBOutlet UITableView *premiumPlanTableView;

@property (weak, nonatomic) IBOutlet UIButton *purchaseSubscriptionButton;
@property (weak, nonatomic) IBOutlet UILabel *moreOptionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *TOSLabel;
@property (weak, nonatomic) IBOutlet UILabel *restorePurchasesLabel;

@property (weak, nonatomic) IBOutlet UIView *requestFeedbackBackDropView;
@property (weak, nonatomic) IBOutlet UIView *requestFeedbackAlertView;

@property (weak, nonatomic) IBOutlet UILabel *requestFeedbackAlertViewQuestionLabel;
@property (weak, nonatomic) IBOutlet UITextView *buttonQuestionSubLabel;

@property (weak, nonatomic) IBOutlet UIImageView *requestFeedbackAlertViewXIcon;
@property (weak, nonatomic) IBOutlet UIView *requestFeedbackAlertViewXIconCover;
@property (weak, nonatomic) IBOutlet UIButton *requestFeedbackAlertViewSubmitButtonLabel;

@property (weak, nonatomic) IBOutlet UIView *enterPromoCodeBackdropView;
@property (weak, nonatomic) IBOutlet UIView *enterPromoCodeAlertView;
@property (weak, nonatomic) IBOutlet UILabel *enterPromoCodeTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *enterPromoCodeCloseImage;
@property (weak, nonatomic) IBOutlet UIView *enterPromoCodeCloseImageCover;
@property (weak, nonatomic) IBOutlet UIView *enterPromoCodeTextFieldView;
@property (weak, nonatomic) IBOutlet UITextField *enterPromoCodeTextField;
@property (weak, nonatomic) IBOutlet UILabel *enterPromoCodeRulesAndRegulationsLabel;

@end

NS_ASSUME_NONNULL_END
