//
//  ViewPromoCodeViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 4/20/23.
//

#import "UIImageView+Letters.h"

#import "ViewPromoCodeViewController.h"
#import "AppDelegate.h"

#import "HomeMemberCell.h"

#import <SDWebImage/SDWebImage.h>
#import <MRProgressOverlayView.h>
#import <Mixpanel/Mixpanel.h>

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "DeleteDataObject.h"
#import "PushObject.h"
#import "NotificationsObject.h"
#import "HomesViewControllerObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"
#import "SettingsObject.h"

@interface ViewPromoCodeViewController () {
    
    MRProgressOverlayView *progressView;
    UIActivityIndicatorView *activityControl;
    UIRefreshControl *refreshControl;
    
    NSMutableDictionary *promoCodeDict;
    NSMutableArray *sectionsArray;
    NSMutableDictionary *lastHomeMemberAddedUserDict;
    
    BOOL queryCompleted;

    NSMutableDictionary *premiumPlanPricesDict;
    NSMutableDictionary *premiumPlanExpensivePricesDict;
    NSMutableDictionary *premiumPlanPricesDiscountDict;
    NSMutableDictionary *premiumPlanPricesNoFreeTrialDict;
    NSMutableArray *premiumPlanProductsArray;
    
    int cellHeight;
    
}

@end

@implementation ViewPromoCodeViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self InitMethod];
    
    [self BarButtonItems];
    
    [self TapGestures];
    
    [self QueryInitialData];
    
}

-(void)viewDidLayoutSubviews {
    
    cellHeight = (self.view.frame.size.height*0.10326087 > 76?(76):self.view.frame.size.height*0.10326087);
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    self->_sharePromoCodeButton.frame = CGRectMake(width*0.5 - (width*0.90338164)*0.5, _customTableView.frame.origin.y + _customTableView.frame.size.height, width*0.90338164, self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934);
    self->_sharePromoCodeButton.titleLabel.font = [UIFont systemFontOfSize:((_sharePromoCodeButton.frame.size.height*0.34) > 17?(17):(_sharePromoCodeButton.frame.size.height*0.34)) weight:UIFontWeightMedium];
    
    CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
    [[[GeneralObject alloc] init] RoundingCorners:_customTableView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
    [[[GeneralObject alloc] init] RoundingCorners:_sharePromoCodeButton topCorners:[(NSArray *)promoCodeDict[@"PromotionalCodeID"] count] > 0 ? NO : YES bottomCorners:YES cornerRadius:cornerRadius];

    activityControl.frame = CGRectMake((self.view.frame.size.width*0.5)-(12.5), (self.view.frame.size.height*0.5) - (12.5), 25, 25);
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    _sharePromoCodeButton.backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    _inviteReminderAlertViewSubmitButton.backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    _inviteReminderBackDropView.frame = CGRectMake(0, 0, width, height);
    _inviteReminderBackDropView.alpha = 0.0;
    
    _inviteReminderAlertView.frame = CGRectMake(0, height, width, ((height*0.33967391) > 250?(250):(height*0.33967391)));
    //278
  
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.inviteReminderAlertView.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(_inviteReminderAlertView.frame.size.height*0.15, _inviteReminderAlertView.frame.size.height*0.15)];
    
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = self.inviteReminderAlertView.bounds;
    maskLayer1.path  = maskPath1.CGPath;
    self.inviteReminderAlertView.layer.mask = maskLayer1;
    
    
    
    width = CGRectGetWidth(self.inviteReminderAlertView.bounds);
    height = CGRectGetHeight(self.inviteReminderAlertView.bounds);
    
    _inviteReminderAlertViewXIcon.frame = CGRectMake(width - ((height*0.1) > 20?(20):(height*0.1)) - height*0.1, height*0.1, ((height*0.1) > 20?(20):(height*0.1)), ((height*0.1) > 20?(20):(height*0.1)));
    
    _inviteReminderAlertViewXIconCover.frame = CGRectMake(_inviteReminderAlertViewXIcon.frame.origin.x - height*0.1, _inviteReminderAlertViewXIcon.frame.origin.y - height*0.1, _inviteReminderAlertViewXIcon.frame.size.width + ((height*0.1)*2), _inviteReminderAlertViewXIcon.frame.size.height + ((height*0.1)*2));
    
    _inviteReminderAlertViewTitleLabel.frame = CGRectMake((width - _inviteReminderAlertViewXIcon.frame.origin.x) + height*0.05, height*0.1, width - (((width -_inviteReminderAlertViewXIcon.frame.origin.x))*2) - height*0.1, ((height*0.1) > 20?(20):(height*0.1)));
    _inviteReminderAlertViewTitleLabel.font = [UIFont systemFontOfSize:_inviteReminderAlertViewTitleLabel.frame.size.height*0.9 weight:UIFontWeightHeavy];
    
    _inviteReminderAlertViewSubTitleLabel.frame = CGRectMake(height*0.1, height*0.275, width - ((height*0.1)*2), 50);
    _inviteReminderAlertViewSubTitleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightHeavy];

    _inviteReminderAlertViewSubmitButton.frame = CGRectMake(width*0.5 - ((width - ((width*0.09661836)*2))*0.5), height - ((height*0.2375) > 47.5?(47.5):(height*0.2375)) - height*0.1 - 20 - 8, width - ((width*0.09661836)*2), ((height*0.2375) > 47.5?(47.5):(height*0.2375)));
    _inviteReminderAlertViewSubmitButton.titleLabel.font = [UIFont systemFontOfSize:((_inviteReminderAlertViewSubmitButton.frame.size.height*0.31578947) > 15?(15):(_inviteReminderAlertViewSubmitButton.frame.size.height*0.31578947)) weight:UIFontWeightSemibold];
    _inviteReminderAlertViewSubmitButton.clipsToBounds = YES;
    _inviteReminderAlertViewSubmitButton.layer.cornerRadius = 7;
    
    _inviteReminderAlertViewAlertLabel.frame = CGRectMake(height*0.1, _inviteReminderAlertViewSubmitButton.frame.origin.y + _inviteReminderAlertViewSubmitButton.frame.size.height + 8, width - ((height*0.1)*2), 20);
    _inviteReminderAlertViewAlertLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightSemibold];
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    self->_inviteReminderAlertViewSubTitleLabel.text = [NSString stringWithFormat:@"Share and get 50%% off Premium\nfor you and a friend after they use your code."];
    self->_inviteReminderAlertViewSubTitleLabel.numberOfLines = 0;

    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"SeenSharePromoCodePopup"]) {
    
        [UIView animateWithDuration:0.25 animations:^{
            
            CGFloat width = CGRectGetWidth(self.view.bounds);
            CGFloat height = CGRectGetHeight(self.view.bounds);
            
            self->_inviteReminderBackDropView.frame = CGRectMake(0, 0, width, height);
            self->_inviteReminderBackDropView.alpha = 1.0;
            
            self->_inviteReminderAlertView.frame = CGRectMake(0, height - ((height*0.33967391) > 250?(250):(height*0.33967391)), width, ((height*0.33967391) > 250?(250):(height*0.33967391)));
            
        } completion:^(BOOL finished) {
            
            [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"SeenSharePromoCodePopup"];
           
        }];
        
    }
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Home Members View Controller Scrolling"] completionHandler:^(BOOL finished) {
        
    }];
    
}

#pragma mark - Text Methdos

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    switch (result)
    {
        case MFMailComposeResultCancelled:
            
            NSLog(@"Mail cancelled");
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Invite Cancelled"] completionHandler:^(BOOL finished) {
                
            }];
            
            break;
            
        case MFMailComposeResultSaved:
            
            NSLog(@"Mail saved");
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Invite Contact"] completionHandler:^(BOOL finished) {
                
            }];
            
            break;
            
        case MFMailComposeResultSent:
            
            NSLog(@"Mail sent");
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Invite Contact Sent"] completionHandler:^(BOOL finished) {
                
            }];
            
            break;
            
        case MFMailComposeResultFailed:
            
            NSLog(@"Mail sent failure");
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Invite Failure"] completionHandler:^(BOOL finished) {
                
            }];
            
            break;
            
        default:
            
            break;
            
    }
    
    [controller dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpAnalytics];
    
    [self SetUpTitle];
    
    [self SetUpTableView];
    
    [self SetUpActivityControl];
    
    [self SetUpRefreshControl];
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary]};
        self.inviteReminderBackDropView.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.1f];
        self.inviteReminderAlertView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModePrimary];
        self.inviteReminderAlertViewTitleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.inviteReminderAlertViewSubTitleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];

        [self preferredStatusBarStyle];
        
        self.navigationController.navigationBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        
    } else {
        
        self.navigationController.navigationBar.backgroundColor = self.view.backgroundColor;
        
    }
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        return UIStatusBarStyleLightContent;
        
    } else {
        
        return UIStatusBarStyleDefault;
        
    }
    
}

-(void)BarButtonItems {
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *barButtonitem;
    
    barButtonitem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(NavigationBackButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = barButtonitem;
   
    barButtonitem = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"info.circle"] style:UIBarButtonItemStylePlain target:self action:@selector(TapGestureAddPromotionalCodePopupDisplay:)];
    
    self.navigationItem.rightBarButtonItem = barButtonitem;
    
}

-(void)TapGestures {
    
    UITapGestureRecognizer *tapGesture;

    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureAddPromotionalCodePopupClose:)];
    [_inviteReminderAlertViewXIconCover addGestureRecognizer:tapGesture];
    _inviteReminderAlertViewXIconCover.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureRestrictionsAction:)];
    [_inviteReminderAlertViewAlertLabel addGestureRecognizer:tapGesture];
    _inviteReminderAlertViewAlertLabel.userInteractionEnabled = YES;
    
}

#pragma mark - Setup Methods

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"ViewPromoCodeViewController" completionHandler:^(BOOL finished) {
        
    }];
    
    [[[GeneralObject alloc] init] TrackInMixPanel:@"ViewPromoCodeViewController"];
    
}

-(void)SetUpTitle {
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeName"]) {
        self.title = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeName"];
    } else {
        self.title = @"Members";
    }
    
}

-(void)SetUpSectionsArray {
    
    self->sectionsArray = [@[@"Home Members"] mutableCopy];
    
}

-(void)SetUpTableView {
    
    self->_customTableView.delegate = self;
    self->_customTableView.dataSource = self;
    
}

-(void)SetUpActivityControl {
    
    activityControl = [[UIActivityIndicatorView alloc] init];
    activityControl.color = [UIColor lightGrayColor];
    [activityControl setHidden:NO];
    [activityControl startAnimating];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [activityControl startAnimating];
        
    });
    
    [self.view addSubview:activityControl];
    
}

-(void)SetUpRefreshControl {
    
    if (refreshControl == nil){
        refreshControl = [[UIRefreshControl alloc] init];
    }
    
    refreshControl.tintColor = [UIColor lightGrayColor];
    [refreshControl addTarget:self action:@selector(RefreshPageAction:) forControlEvents:UIControlEventValueChanged];
    [_customTableView addSubview:refreshControl];
    
}

-(void)SetUpItemViewContextMenu:(HomeMemberCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *actions = [[NSMutableArray alloc] init];
    NSMutableArray *bottomMenuActions = [[NSMutableArray alloc] init];
    
    
    
    UIAction *redeemPromoCodeAction = [self RedeemDiscountContextMenuAction:indexPath];
    UIAction *resendInvitationAction = [self ResendPromoCodeContextMenuAction:indexPath];
    UIAction *copyKeyAction = [self CopyPromoCodeContextMenuAction:indexPath];
    UIAction *editMemberNameAction = [self EditReceiverNameContextMenuAction:indexPath];
    UIAction *deleteMemberAction = [self DeletePromoCodeContextMenuAction:indexPath];
    
    [deleteMemberAction setAttributes:UIMenuElementAttributesDestructive];
    
    
    
    BOOL PromotionalCodeUsedByReceiver = [self->promoCodeDict[@"PromotionalCodeDateUsedByReceiver"][indexPath.row] length] > 0;
    BOOL PromotionalCodeUsedBySender = [self->promoCodeDict[@"PromotionalCodeDateUsedBySender"][indexPath.row] length] > 0;
    
    if (PromotionalCodeUsedByReceiver == YES && PromotionalCodeUsedBySender == NO) {
        [actions addObject:redeemPromoCodeAction];
    } else if (PromotionalCodeUsedByReceiver == NO) {
        [actions addObject:resendInvitationAction];
    }
    
    [actions addObject:copyKeyAction];
    
    
    
    [bottomMenuActions addObject:editMemberNameAction];
    [bottomMenuActions addObject:deleteMemberAction];
    
    UIMenu *bottomActionsMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"1" options:UIMenuOptionsDisplayInline children:bottomMenuActions];
    
    [actions addObject:bottomActionsMenu];
    
    
    
    cell.ellipsisImageOverlay.menu = [UIMenu menuWithTitle:@"" children:actions];
    cell.ellipsisImageOverlay.showsMenuAsPrimaryAction = true;
    
}

#pragma mark - Context Menu Actions

-(UIAction *)RedeemDiscountContextMenuAction:(NSIndexPath *)indexPath {
    
    UIAction *action = [UIAction actionWithTitle:@"Redeem Discount" image:[UIImage systemImageNamed:@"tag"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
            [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
            return;
        }
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Redeem Discount Clicked"] completionHandler:^(BOOL finished) {
            
        }];
        
        NSString *promoCodeID = self->promoCodeDict[@"PromotionalCodeID"][indexPath.row];
        
        [[[PushObject alloc] init] PushToWeDivvyPremiumViewController:NO comingFromSignUp:NO defaultPlan:@"" displayDiscount:@"Promo Code Discount" selectedSlide:@"" promoCodeID:promoCodeID premiumPlanProductsArray:self->premiumPlanProductsArray premiumPlanPricesDict:self->premiumPlanPricesDict premiumPlanExpensivePricesDict:self->premiumPlanExpensivePricesDict premiumPlanPricesDiscountDict:self->premiumPlanPricesDiscountDict premiumPlanPricesNoFreeTrialDict:self->premiumPlanPricesDiscountDict currentViewController:self Superficial:NO];
        
    }];
    
    return action;
}

-(UIAction *)ResendPromoCodeContextMenuAction:(NSIndexPath *)indexPath {
    
    UIAction *action = [UIAction actionWithTitle:@"Resend Invitation" image:[UIImage systemImageNamed:@"paperplane"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
            [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
            return;
        }
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Resend Invitation Clicked"] completionHandler:^(BOOL finished) {
            
        }];
        
        NSString *promoCode = self->promoCodeDict[@"PromotionalCode"][indexPath.row];
        
        NSString *body = [NSString stringWithFormat:@"Hey again, just in case you missed it, here's promo code for WeDivvy Premium. Use it to get 50%% off! - %@ 🏠⭐️", promoCode];
        
        NSArray* dataToShare = @[body, [NSURL URLWithString:@"https://apps.apple.com/us/app/wedivvy/id1570700094"]];
        
        UIActivityViewController* activityViewController = [[UIActivityViewController alloc] initWithActivityItems:dataToShare applicationActivities:nil];
        [activityViewController setValue:@"A Gift From a Friend" forKey:@"subject"];
        activityViewController.excludedActivityTypes = @[UIActivityTypeAirDrop];
        
        [activityViewController setCompletionWithItemsHandler:^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError) {
            
            NSArray *dontAccept = @[@"com.apple.UIKit.activity.CopyToPasteboard", @"com.apple.DocumentManagerUICore.SaveToFiles"];
            
            if (completed && [dontAccept containsObject:activityType] == NO) {
                
                [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Resend Promo Code Completed"] completionHandler:^(BOOL finished) {
                    
                }];
                
            }
            
        }];
        
        [self presentViewController:activityViewController animated:YES completion:^{}];
        
    }];
    
    return action;
}

-(UIAction *)CopyPromoCodeContextMenuAction:(NSIndexPath *)indexPath {
    
    UIAction *action = [UIAction actionWithTitle:@"Copy Promo Code" image:[UIImage systemImageNamed:@"clipboard"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Copy Invitation Clicked"] completionHandler:^(BOOL finished) {
            
        }];

        NSString *receiverName = self->promoCodeDict[@"PromotinoalCodeReceiverName"][indexPath.row];
        NSString *promoCode = self->promoCodeDict[@"PromotionalCode"][indexPath.row];
        
        UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
        [pasteBoard setString:promoCode];
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Copied!"
                                                                            message:[NSString stringWithFormat:@"%@'s promo code, %@, was copied!", receiverName, promoCode]
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Got it!"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {
            
            
            
        }];
        
        [controller addAction:cancel];
        [self presentViewController:controller animated:YES completion:nil];
        
    }];
    
    return action;
}

-(UIAction *)EditReceiverNameContextMenuAction:(NSIndexPath *)indexPath {
    
    UIAction *action = [UIAction actionWithTitle:@"Edit Name" image:[UIImage systemImageNamed:@"pencil"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Edit Name Clicked"] completionHandler:^(BOOL finished) {
            
        }];
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Update Name" message:@"Enter your new home members name"
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Update"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
            
            NSString *newName = controller.textFields[0].text;
            
            NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
            NSString *trimmedStringItemName = [newName stringByTrimmingCharactersInSet:charSet];
            
            if (trimmedStringItemName.length > 0) {
                
                [self StartProgressView];
                
                NSString *promoCodeID = self->promoCodeDict[@"PromotionalCodeID"][indexPath.row];
                
                [[[SetDataObject alloc] init] UpdateDataPromotionalCodeUsed:promoCodeID dataDict:@{@"PromotionalCodeReceiverName" : trimmedStringItemName} completionHandler:^(BOOL finished) {
                    
                    [self->progressView setHidden:YES];
                    [self.customTableView reloadData];
                    
                    [self AdjustTableViewFrames];
                    
                }];
                
            } else {
                
                [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"Looks like you forgot to enter a name." currentViewController:self];
                
            }
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {}];
        
        
        
        [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            
            textField.delegate = self;
            textField.placeholder = @"New Member Name";
            textField.text = @"";
            textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
            
        }];
        
        [controller addAction:action1];
        [controller addAction:cancel];
        [self presentViewController:controller animated:YES completion:nil];
            
    }];
    
    return action;
}

-(UIAction *)DeletePromoCodeContextMenuAction:(NSIndexPath *)indexPath {
    
    UIAction *action = [UIAction actionWithTitle:@"Delete" image:[UIImage systemImageNamed:@"trash"] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Delete Promo Code Clicked"] completionHandler:^(BOOL finished) {
            
        }];
        
        [self StartProgressView];
        
        NSString *promoCodeID = self->promoCodeDict[@"PromotionalCodeID"][indexPath.row];
        
        [[[DeleteDataObject alloc] init] DeleteDataPromotionalCode:promoCodeID completionHandler:^(BOOL finishe) {
            
            [self->progressView setHidden:YES];
            [self.customTableView reloadData];
            
            [self AdjustTableViewFrames];
            
        }];
        
    }];
    
    return action;
}

#pragma mark - UI Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

-(void)AdjustTableViewFrames {
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGFloat tableViewHeight = 0;
        
        if (self->queryCompleted) {
            
            for (NSString *promotionalCodeID in self->promoCodeDict[@"PromotionalCodeID"]) {
                
                NSUInteger index = [self->promoCodeDict[@"PromotionalCodeID"] indexOfObject:promotionalCodeID];
                
                BOOL PromotionalCodeUsedByReceiver = [self->promoCodeDict[@"PromotionalCodeDateUsedByReceiver"][index] length] > 0;
                BOOL PromotionalCodeUsedBySender = [self->promoCodeDict[@"PromotionalCodeDateUsedBySender"][index] length] > 0;
                
                if (PromotionalCodeUsedByReceiver == NO || (PromotionalCodeUsedByReceiver == YES && PromotionalCodeUsedBySender == NO)) {
                    
                    tableViewHeight += self->cellHeight;
                    
                } else {
                    
                    tableViewHeight += (((height*0.11005435 > 81?(81):height*0.11005435)*0.7037037));
                    
                }
                
            }
            
        } else {
            
            tableViewHeight += (((height*0.11005435 > 81?(81):height*0.11005435)*0.7037037) * [(NSArray *)self->promoCodeDict[@"PromotionalCodeID"] count]);
            
        }
        
        CGFloat inviteFriendsButton = (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934);
        
        CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
        [[[GeneralObject alloc] init] RoundingCorners:self->_customTableView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
        self->_customTableView.frame = CGRectMake(width*0.5 - (width*0.90338164)*0.5, navigationBarHeight + 12, width*0.90338164, tableViewHeight);
        self->_sharePromoCodeButton.frame = CGRectMake(width*0.5 - (width*0.90338164)*0.5, self->_customTableView.frame.origin.y + self->_customTableView.frame.size.height, width*0.90338164, inviteFriendsButton);
        
    }];
    
}

-(void)DisplayAlertView:(BOOL)display backDropView:(UIView *)backDropView alertViewNoButton:(UIButton * _Nullable)alertViewNoButton alertViewYesButton:(UIButton *)alertViewYesButton {
    
    if (display) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            backDropView.alpha = 1.0f;
            alertViewNoButton.userInteractionEnabled = YES;
            alertViewYesButton.userInteractionEnabled = YES;
            
        }];
        
    } else {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            backDropView.alpha = 0.0;
            alertViewNoButton.userInteractionEnabled = NO;
            alertViewYesButton.userInteractionEnabled = NO;
            
        }];
        
    }
    
}

#pragma mark - UX Methods

-(void)QueryInitialData {
    
    [self StartProgressView];
    
    NSArray *keyArray = [[[GeneralObject alloc] init] GeneratePromotionalCodesKeyArray];
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    [[[GetDataObject alloc] init] GetDataSpecificUserPromotionalCodeData:userID keyArray:keyArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningPromotionalCodeDict) {
        
        self->promoCodeDict = [returningPromotionalCodeDict mutableCopy];
      
        self->queryCompleted = YES;
        
        [self SetUpSectionsArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self->activityControl stopAnimating];
            [self->refreshControl endRefreshing];
            [self->progressView setHidden:YES];
            [self.customTableView reloadData];

            [self AdjustTableViewFrames];
            
        });
        
    }];
    
}

#pragma mark Add Promotional Code

-(void)SendPromoCode:(NSDictionary *)dataDictLocal {
    
    dispatch_async(dispatch_get_main_queue(), ^{

        NSString *body = [NSString stringWithFormat:@"Hey %@, here's a promo code for WeDivvy Premium. Use it to get 50%% off! - %@ 🏠⭐️", dataDictLocal[@"PromotinoalCodeReceiverName"], dataDictLocal[@"PromotionalCode"]];
        
        NSArray* dataToShare = @[body, [NSURL URLWithString:@"https://apps.apple.com/us/app/wedivvy/id1570700094"]];
        
        UIActivityViewController* activityViewController = [[UIActivityViewController alloc] initWithActivityItems:dataToShare applicationActivities:nil];
        [activityViewController setValue:@"A Gift From a Friend" forKey:@"subject"];
        activityViewController.excludedActivityTypes = @[UIActivityTypeAirDrop];
        
        [activityViewController setCompletionWithItemsHandler:^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError) {
            
            NSArray *dontAccept = @[@"com.apple.UIKit.activity.CopyToPasteboard", @"com.apple.DocumentManagerUICore.SaveToFiles"];
            
            if (completed && [dontAccept containsObject:activityType] == NO) {
                
                [[[SetDataObject alloc] init] SetDataPromotionalCode:dataDictLocal completionHandler:^(BOOL finished) {
                    
                    [self UpdateAppDataWithNewPromoCode];
                    
                }];
                
            }
            
        }];
        
        [self presentViewController:activityViewController animated:YES completion:^{}];
        
    });
    
}

-(void)UpdateAppDataWithNewPromoCode {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self->progressView setHidden:YES];
        [self.customTableView reloadData];
        
        [self AdjustTableViewFrames];
        
    });
    
}

#pragma mark - IBAction Methods

-(IBAction)AddPromotionalCode:(id)sender {

    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Invite Roommates Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    if (queryCompleted) {
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Sending Promo Code" message:@"Enter the name of the person you are sending a promo code to"
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Send"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
            
            NSString *newName = controller.textFields[0].text;
            
            NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
            NSString *trimmedStringItemName = [newName stringByTrimmingCharactersInSet:charSet];
            
            if (trimmedStringItemName.length > 0) {
                
                    NSDictionary *dataDict = @{
                        @"PromotionalCodeID" : [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString],
                        @"PromotionalCodeDateSent" : [[[GeneralObject alloc] init] GenerateCurrentDateString],
                        @"PromotionalCodeSentBy" : [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"],
                        @"PromotionalCodeDateUsedByReceiver" : @"",
                        @"PromotionalCodeDateUsedBySender" : @"",
                        @"PromotionalCodeUsedBy" : @"",
                        @"PromotionalCode" : [[[GeneralObject alloc] init] GenerateRandomSmallAlphaNumberIntoString:6],
                        @"PromotinoalCodeReceiverName" : trimmedStringItemName,
                    };
                
                    [self SendPromoCode:dataDict];
                    
            } else {
                
                [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"Looks like you forgot to enter a name." currentViewController:self];
                
            }
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {}];
        
        
        
        [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            
            textField.delegate = self;
            textField.placeholder = @"New Member Name";
            textField.text = @"";
            textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
            
        }];
        
        [controller addAction:action1];
        [controller addAction:cancel];
        [self presentViewController:controller animated:YES completion:nil];
        
    } else {
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"We're still processing some data, please wait until WeDivvy has fully loaded. 😄" currentViewController:self];
        
    }
    
}

-(IBAction)TapGestureAddPromotionalCodePopupDisplay:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Invite Others Reminder Popup Closed"] completionHandler:^(BOOL finished) {
        
    }];

    [UIView animateWithDuration:0.25 animations:^{
        
        CGFloat width = CGRectGetWidth(self.view.bounds);
        CGFloat height = CGRectGetHeight(self.view.bounds);
        
        self->_inviteReminderBackDropView.frame = CGRectMake(0, 0, width, height);
        self->_inviteReminderBackDropView.alpha = 1.0;
        
        self->_inviteReminderAlertView.frame = CGRectMake(0, height - ((height*0.33967391) > 250?(250):(height*0.33967391)), width, ((height*0.33967391) > 250?(250):(height*0.33967391)));
        
    } completion:^(BOOL finished) {
        
        [self DisplayAlertView:YES backDropView:self->_inviteReminderBackDropView alertViewNoButton:nil alertViewYesButton:nil];
        
    }];
    
}

-(IBAction)TapGestureAddPromotionalCodePopupClose:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Invite Others Reminder Popup Closed"] completionHandler:^(BOOL finished) {
        
    }];
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect newRect = self->_inviteReminderAlertView.frame;
        newRect.origin.y = height;
        self->_inviteReminderAlertView.frame = newRect;
        
    } completion:^(BOOL finished) {
        
        [self DisplayAlertView:NO backDropView:self->_inviteReminderBackDropView alertViewNoButton:nil alertViewYesButton:nil];
        
    }];
    
}

-(IBAction)TapGestureRestrictionsAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Restrictions Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[GeneralObject alloc] init] CreateAlert:@"Rules & Restrictions" message:[NSString stringWithFormat:@"1. Receiver must use their promo code when purchasing WeDivvy Premium.\n2. Receiver cannot join your home."] currentViewController:self];
    
}

-(IBAction)RefreshPageAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Refresh Page"] completionHandler:^(BOOL finished) {
        
    }];
    
    if (refreshControl == nil){
        
        [activityControl setHidden:NO];
        CGFloat height = CGRectGetHeight(self.view.bounds);
        CGFloat width = CGRectGetWidth(self.view.bounds);
        
        activityControl.frame = CGRectMake((width*0.5)-(12), (height*0.5)-(12), 25, 25);
        activityControl.color = [UIColor grayColor];
        [activityControl startAnimating];
        
        [self.view addSubview:activityControl];
        [self.view bringSubviewToFront:activityControl];
        
    }
    
    [self QueryInitialData];
    
}

#pragma mark - Top Icon Actions

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Table View Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    HomeMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeMemberCell"];
    
    if (queryCompleted) {
        
        cell.titleLabel.text = self->promoCodeDict[@"PromotinoalCodeReceiverName"][indexPath.row];
 
        BOOL PromotionalCodeUsedByReceiver = [self->promoCodeDict[@"PromotionalCodeDateUsedByReceiver"][indexPath.row] length] > 0;
        BOOL PromotionalCodeUsedBySender = [self->promoCodeDict[@"PromotionalCodeDateUsedBySender"][indexPath.row] length] > 0;
        
        if (PromotionalCodeUsedByReceiver == NO) {
            
            cell.subLabel.text = [NSString stringWithFormat:@"Promo Code Not Used • Promo Code Sent %@", [[[[GeneralObject alloc] init] GetDisplayTimeSinceDate:self->promoCodeDict[@"PromotionalCodeDateSent"][indexPath.row] shortStyle:NO reallyShortStyle:NO] lowercaseString]];
            
        } else if (PromotionalCodeUsedByReceiver == YES && PromotionalCodeUsedBySender == NO) {
            
            cell.subLabel.text = [NSString stringWithFormat:@"Promo Code Used %@ • Discount Not Redeemed By Sender", [[[[GeneralObject alloc] init] GetDisplayTimeSinceDate:self->promoCodeDict[@"PromotionalCodeDateUsedByReceiver"][indexPath.row] shortStyle:NO reallyShortStyle:NO] lowercaseString]];
            
        } else if (PromotionalCodeUsedByReceiver == YES && PromotionalCodeUsedBySender == YES) {

            cell.subLabel.text = [NSString stringWithFormat:@"Promo Code Used • Discount Redeemed By Sender On %@", [[[[GeneralObject alloc] init] GetDisplayTimeSinceDate:self->promoCodeDict[@"PromotionalCodeDateUsedBySender"][indexPath.row] shortStyle:NO reallyShortStyle:NO] lowercaseString]];

        }
     
        NSString *username = @"";//dictToUse[@"Username"][indexPath.row];
        NSString *profileImageURL = @"";//dictToUse[@"ProfileImageURL"][indexPath.row];
        
        UIColor *backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:0.15f];
        UIColor *textColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
        
        if (profileImageURL == nil || profileImageURL.length == 0 || [profileImageURL containsString:@"(null)"] || [profileImageURL isEqualToString:@"xxx"] || [profileImageURL isEqualToString:@"XXX"] || [profileImageURL isEqualToString:@"https://firebasestorage.googleapis.com/v0/b/wedivvy-afe04.appspot.com/o/DefaultImages%2FdefaultProfileImage.png?alt=media&token=6892f430-8337-4327-89a4-53a403d1186c"] || [profileImageURL containsString:@"DefaultImage"]) {
            
            [cell.profileImage setImageWithString:username color:backgroundColor circular:YES textAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Medium" size:cell.profileImage.frame.size.height*0.45], NSForegroundColorAttributeName:textColor}];
            
        } else {
            
            [cell.profileImage sd_setImageWithURL:[NSURL URLWithString:profileImageURL]];
            
        }
        
    }
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (queryCompleted) {
        
        NSMutableDictionary *dictToUse = promoCodeDict;
        return [(NSArray *)dictToUse[@"PromotionalCodeID"] count];
        
    }
    
    return 0;
    
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(HomeMemberCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = CGRectGetWidth(cell.contentView.bounds);
    CGFloat height = (self.view.frame.size.height*0.11005435 > 81?(81):self.view.frame.size.height*0.11005435)*0.7037037;//CGRectGetHeight(cell.contentView.bounds);
    
    if (indexPath.section == 0) {
        
        
        
        
        width = CGRectGetWidth(cell.contentView.bounds);
        height = (self.view.frame.size.height*0.11005435 > 81?(81):self.view.frame.size.height*0.11005435)*0.7037037;//CGRectGetHeight(cell.homeMembersMainView.bounds);
        
        CGFloat xPos = width*0.04278075;
        CGFloat yPos = height*0.5 - ((height*0.5)*0.5);
        CGFloat yPosNo3 = height*0.14035;
        CGFloat yPosNo4 = height - cell.titleLabel.frame.size.height - height*0.14035;
  
        BOOL PromotionalCodeUsedByReceiver = [self->promoCodeDict[@"PromotionalCodeDateUsedByReceiver"][indexPath.row] length] > 0;
        BOOL PromotionalCodeUsedBySender = [self->promoCodeDict[@"PromotionalCodeDateUsedBySender"][indexPath.row] length] > 0;

        cell.profileImage.frame = CGRectMake(xPos, yPos, height*0.5, height*0.5);
        cell.cautionImage.frame = CGRectMake(width*0.04278075, cell.profileImage.frame.origin.y + (cell.profileImage.frame.size.height)*0.5 - (height*0.4)*0.5, height*0.4, height*0.4);

        cell.titleLabel.frame = CGRectMake(cell.cautionImage.frame.origin.x + cell.cautionImage.frame.size.width + ((width*0.04278075)*0.5), yPosNo3, width, height*0.350878);
        cell.subLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, yPosNo4, width, cell.titleLabel.frame.size.height);

        cell.titleLabel.font = [UIFont systemFontOfSize:cell.titleLabel.frame.size.height*0.85 weight:UIFontWeightSemibold];
        cell.titleLabel.font = [UIFont systemFontOfSize:cell.subLabel.frame.size.height*0.75 weight:UIFontWeightSemibold];

        cell.separatorLineView.frame = CGRectMake(width*0.04278075, cell.contentView.frame.size.height - 1, width*1 - width*0.04278075, 1);

        CGFloat bellHeight = height*0.35;

        cell.ellipsisImage.frame = CGRectMake(width - bellHeight - (width*0.04278075) + (bellHeight*0.5) - (((height*0.4385965)*0.24)*0.5), cell.contentView.frame.size.height*0.5 - ((height*0.4385965)*0.5), ((height*0.4385965)*0.24), height*0.4385965);
        cell.ellipsisImageOverlay.frame = CGRectMake(cell.ellipsisImage.frame.origin.x - (width*0.026738), cell.ellipsisImage.frame.origin.y - (width*0.026738), cell.ellipsisImage.frame.size.width + ((width*0.026738)*2), cell.ellipsisImage.frame.size.height + ((width*0.026738)*2));

        CGFloat widthOfItemLabel = [[[GeneralObject alloc] init] WidthOfString:cell.titleLabel.text ? cell.titleLabel.text : @"" withFont:cell.titleLabel.font];
        CGFloat widthOfCompletedLabel = [[[GeneralObject alloc] init] WidthOfString:cell.subLabel.text ? cell.subLabel.text : @"" withFont:cell.subLabel.font];

        CGRect newRect = cell.titleLabel.frame;
        newRect.size.width = widthOfItemLabel;
        cell.titleLabel.frame = newRect;

        CGFloat maxHeight = cell.contentView.frame.size.width - (cell.subLabel.frame.origin.x + ((width*0.04278075)*2) + cell.ellipsisImage.frame.size.width);

        newRect = cell.subLabel.frame;
        newRect.size.width = widthOfCompletedLabel > maxHeight ? maxHeight : widthOfCompletedLabel;
        newRect.size.height = widthOfCompletedLabel > maxHeight ? newRect.size.height*2 : newRect.size.height;
        cell.subLabel.frame = newRect;

        if (PromotionalCodeUsedByReceiver == NO) {
            
            cell.cautionImage.image = [UIImage systemImageNamed:@"exclamationmark.triangle.fill"];
            cell.cautionImage.tintColor = [UIColor systemYellowColor];
            
        } else if (PromotionalCodeUsedByReceiver == YES && PromotionalCodeUsedBySender == NO) {
            
            cell.cautionImage.image = [UIImage systemImageNamed:@"checkmark.circle"];
            cell.cautionImage.tintColor = [UIColor systemGreenColor];
            
        } else if (PromotionalCodeUsedByReceiver == YES && PromotionalCodeUsedBySender == YES) {
            
            cell.cautionImage.image = [UIImage systemImageNamed:@"checkmark.circle.fill"];
            cell.cautionImage.tintColor = [UIColor systemGreenColor];
            
        }
        
    }

    [self SetUpItemViewContextMenu:cell indexPath:indexPath];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (queryCompleted) {
        
        BOOL PromotionalCodeUsedByReceiver = [self->promoCodeDict[@"PromotionalCodeDateUsedByReceiver"][indexPath.row] length] > 0;
        BOOL PromotionalCodeUsedBySender = [self->promoCodeDict[@"PromotionalCodeDateUsedBySender"][indexPath.row] length] > 0;
        
        if (PromotionalCodeUsedByReceiver == NO || (PromotionalCodeUsedByReceiver == YES && PromotionalCodeUsedBySender == NO)) {
            
            return cellHeight;
            
        }
        
    }
    
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    return (height*0.11005435 > 81?(81):height*0.11005435)*0.7037037;
    
}

#pragma mark - TableView Sections

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(((width*1 - width*0.9034)*0.5), 0, width*0.9034, width*0.060386)];
    UIView *squareView = [[UIView alloc] initWithFrame:CGRectMake(((width*1 - width*0.9034)*0.5), label.frame.origin.y + (label.frame.size.height*0.5 - ((width*0.04831)*0.5)), width*0.04831, width*0.04831)];
    
    squareView.layer.cornerRadius = squareView.frame.size.width*0.25;
    
    [label setFont:[UIFont systemFontOfSize:label.frame.size.height*0.56 weight:UIFontWeightBold]];
    [label setTextAlignment:NSTextAlignmentLeft];
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        [label setTextColor:[[[LightDarkModeObject alloc] init] DarkModeTextPrimary]];
    } else {
        [label setTextColor:[[[LightDarkModeObject alloc] init] LightModeTextPrimary]];
    }
    
    NSString *string = [self->sectionsArray objectAtIndex:section];
    
    [label setText:string];
    [view setBackgroundColor:self.view.backgroundColor];
    [label setBackgroundColor:[UIColor clearColor]];
    //[view addSubview:squareView];
    [view addSubview:label];
    
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger )section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    //CGFloat height = CGRectGetHeight(self.view.bounds);
    return 0.1;//(height*0.033967 > 25?(25):height*0.033967);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger )section {
    return 1.0;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}

#pragma mark - IAP Methods

- (BOOL)CanMakePurchases {
    
    return [SKPaymentQueue canMakePayments];
    
}

-(void)FetchAvailableProducts {
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"PremiumPlanProductsArray"] || ![[NSUserDefaults standardUserDefaults] objectForKey:@"PremiumPlanPricesDict"]) {
        
        if ([self CanMakePurchases]) {
            
            //NSLog(@"Subscription - products fetchAvailableProducts");
            NSSet *productIdentifiers = [[[GeneralObject alloc] init] GenerateSubscriptionsKeyArray];
            SKProductsRequest *productsRequest = [[SKProductsRequest alloc]
                                                  initWithProductIdentifiers:productIdentifiers];
            productsRequest.delegate = self;
            [productsRequest start];
            
        }
        
    }
    
}

-(void)productsRequest:(SKProductsRequest *)request
    didReceiveResponse:(SKProductsResponse *)response {
   
    //NSLog(@"Subscription - How many products retrieved? %lu", (unsigned long)count);
    
    [[[GeneralObject alloc] init] GenerateProducts:response.products completionHandler:^(BOOL finished, NSString * _Nonnull errorString, NSMutableArray * _Nonnull returningPremiumPlanProductsArray, NSMutableDictionary * _Nonnull returningPremiumPlanPricesDict, NSMutableDictionary * _Nonnull returningPremiumPlanExpensivePricesDict, NSMutableDictionary * _Nonnull returningPremiumPlanPricesDiscountDict, NSMutableDictionary * _Nonnull returningPremiumPlanPricesNoFreeTrialDict) {
        
        self->premiumPlanProductsArray = [returningPremiumPlanProductsArray mutableCopy];
        self->premiumPlanPricesDict = [returningPremiumPlanPricesDict mutableCopy];
        self->premiumPlanExpensivePricesDict = [returningPremiumPlanExpensivePricesDict mutableCopy];
        self->premiumPlanPricesDiscountDict = [returningPremiumPlanPricesDiscountDict mutableCopy];
        self->premiumPlanPricesNoFreeTrialDict = [returningPremiumPlanPricesNoFreeTrialDict mutableCopy];
        
    }];
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

-(NSMutableDictionary *)RemoveHomeMember:(NSMutableDictionary *)userDict indexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *userDictLocal = [userDict mutableCopy];
    
    for (NSString *key in [userDict allKeys]) {
        
        NSMutableArray *tempArray;
        
        tempArray = [userDictLocal[key] mutableCopy];
        [tempArray removeObjectAtIndex:indexPath.row];
        [userDictLocal setObject:tempArray forKey:key];
        
    }
    
    return userDictLocal;
}


@end

