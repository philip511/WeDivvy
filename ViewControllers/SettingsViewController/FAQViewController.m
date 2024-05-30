//
//  FAQViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 11/19/22.
//

#import "FAQViewController.h"

#import "GeneralObject.h"
#import "SetDataObject.h"
#import "NotificationsObject.h"
#import "PushObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

#import "FAQCell.h"

@interface FAQViewController () {
    
    MRProgressOverlayView *progressView;
    
    NSMutableArray *faqTitleArray;
    NSMutableArray *faqBodyArray;
    NSIndexPath *selectedIndex;
    
    NSArray *arrayOfHeights;
    NSArray *arrayOfHeightsNo1;
    
}

@end

@implementation FAQViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self InitMethod];
    
    [self BarButtonItem];

    [self TapGestures];
    
}

-(void)viewDidLayoutSubviews {
    
    _customTableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);

    _sendMessageView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, (self.view.frame.size.height*0.0679 > 50?(50):self.view.frame.size.height*0.0679));
    _sendMessageLiveView.frame = CGRectMake(0, 0, self.view.frame.size.width, 1);
    _sendMessageLabel.frame = CGRectMake(0, (self.view.frame.size.height*0.01086957)*2, self.view.frame.size.width, (self.view.frame.size.height*0.02717 > 20?(20):self.view.frame.size.height*0.02717));
    _sendMessageLabel.font = [UIFont systemFontOfSize:_sendMessageLabel.frame.size.height*0.8 weight:UIFontWeightSemibold];
    _sendMessageLabel.adjustsFontSizeToFitWidth = YES;
    _sendMessageButton.frame = CGRectMake(self.view.frame.size.width*0.5 - (self.view.frame.size.width*0.90)*0.5, _sendMessageLabel.frame.origin.y + _sendMessageLabel.frame.size.height + (self.view.frame.size.height*0.01086957)*2, self.view.frame.size.width*0.90, (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934));
    _sendMessageButton.titleLabel.font = [UIFont systemFontOfSize:_sendMessageButton.frame.size.height*0.32 weight:UIFontWeightSemibold];
    _sendMessageButton.layer.cornerRadius = 7;
    _sendMessageSubmitQuestionLabel.frame = CGRectMake(0, _sendMessageButton.frame.origin.y + _sendMessageButton.frame.size.height + (self.view.frame.size.height*0.01086957)*2, self.view.frame.size.width, (self.view.frame.size.height*0.02717 > 20?(20):self.view.frame.size.height*0.02717));
    _sendMessageSubmitQuestionLabel.font = [UIFont systemFontOfSize:(_sendMessageSubmitQuestionLabel.frame.size.height*0.6 > 12?12:_sendMessageSubmitQuestionLabel.frame.size.height*0.6) weight:UIFontWeightMedium];
    _sendMessageSubmitQuestionLabel.adjustsFontSizeToFitWidth = YES;
    
    CGRect newRect = _sendMessageView.frame;
    newRect.size.height = _sendMessageSubmitQuestionLabel.frame.origin.y + _sendMessageSubmitQuestionLabel.frame.size.height + ((self.view.frame.size.height*0.01086957)*2);
    newRect.origin.y = self.view.frame.size.height - newRect.size.height;
    _sendMessageView.frame = newRect;
    
    newRect = _customTableView.frame;
    newRect.size.height = self.view.frame.size.height - _sendMessageView.frame.size.height;
    _customTableView.frame = newRect;
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.navigationController.navigationBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.customTableView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModePrimary];
        self.sendMessageView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModePrimary];
        self.sendMessageLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.sendMessageSubmitQuestionLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextSecondary];
        
    } else {
        
        self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
        
    }
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(nullable NSError *)error {
    
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            
            break;
            
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            
            break;
            
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            
            break;
            
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@",error.description);
            
            break;
    }
    
    // Dismiss the mail compose view controller.
    [controller dismissViewControllerAnimated:true completion:nil];
    
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpTitle];
    
    [self SetUpTableView];
    
    [self SetUpArrays];
    
    [self SetUpAttributedString];
    
    [self SetUpSendMessageContextMenu];
    
}

-(void)BarButtonItem {
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(NavigationBackButtonAction:)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
}

-(void)TapGestures {
    
    UITapGestureRecognizer *tapGesture;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SubmitQuestion:)];
    [_sendMessageSubmitQuestionLabel addGestureRecognizer:tapGesture];
    _sendMessageSubmitQuestionLabel.userInteractionEnabled = YES;
    
}

#pragma mark - Setup Methods

-(void)SetUpTitle {
    
    self.title = @"WeDivvy Premium FAQ's";
    
}

-(void)SetUpTableView {
    
    _customTableView.delegate = self;
    _customTableView.dataSource = self;
    
    [self.customTableView reloadData];
    
}

-(void)SetUpArrays {
    
    arrayOfHeights = @[@1, @2, @2, @2, @2, @2, @2];
    arrayOfHeightsNo1 = @[@4, @5, @4, @5, @6, @2, @8];
    
    faqTitleArray = [NSMutableArray array];
    faqBodyArray = [NSMutableArray array];
    
    [faqTitleArray addObject:@"Is there a free trial? How does it work?"];
    [faqTitleArray addObject:@"I forgot to cancel my subscription, how do I get a refund?"];
    
    [faqTitleArray addObject:@"How do I choose the accounts I’d like to give WeDivvy Premium to?"];
    [faqTitleArray addObject:@"How do I give WeDivvy Premium to home members that have not joined my home yet?"];
    [faqTitleArray addObject:@"How do I change which accounts get WeDivvy Premium?"];
    [faqTitleArray addObject:@"Can I give WeDivvy Premium to accounts that are not in my home?"];
    [faqTitleArray addObject:@"What if I want to give WeDivvy Premium to more than 5 other accounts?"];
    
    [faqBodyArray addObject:@"Everyone automatically gets a one-time only 1 week free trial to try out WeDivvy Premium. To avoid any charge simply cancel your subscription before the end of the free trial."];
    [faqBodyArray addObject:@"As a courtesy we offer a 1 week grace period for refunds. Simply email us at wedivvy@wedivvyapp.com within the first week of your subscription renewal to get a full refund for the current subscription period."];
    
    [faqBodyArray addObject:@"After your purchase is completed you will be taken to a page where you can select the accounts you’d like to give WeDivvy Premium to. You can add home members that have not signed up or joined your home yet. Also, the accounts you select can be changed later on."];
    [faqBodyArray addObject:@"After purchasing WeDivvy Premium you’ll be taken to a page where you can add home members that have not signed up or joined your home yet. Once your home members sign up and join your home they will automatically have full access to WeDivvy Premium."];
    [faqBodyArray addObject:@"Open the Side Bar Menu and click “WeDivvy Premium”. On the following page, click “WeDivvy Premium Accounts”. You will be taken to a page where you can grant or revoke access to WeDivvy Premium for any account. Only the purchaser of WeDivvy Premium has the ability to do this."];
    [faqBodyArray addObject:@"As of right now, you can only give WeDivvy Premium to your home members."];
    [faqBodyArray addObject:@"As of right now we do not offer an option to give WeDivvy Premium to more than 5 additional accounts. Any extra home members would need to purchase their own WeDivvy Preimum subscription. We have set it up this way in order to prevent people from giving WeDivvy Premium to large groups of people who they may or may not live with. We are really sorry for any inconvience. 😢"];
    
}

-(void)SetUpAttributedString {
    
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:_sendMessageSubmitQuestionLabel.textColor, NSForegroundColorAttributeName, nil];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"Think a question is missing? Let us know and we'll add it" attributes:attrsDictionary];
    
    NSRange range0 = [[NSString stringWithFormat:@"%@", str] rangeOfString:@"Let us know"];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor linkColor] range: NSMakeRange(range0.location, range0.length)];
    
    [_sendMessageSubmitQuestionLabel setAttributedText:str];
    
}

-(void)SetUpSendMessageContextMenu {
    
    NSMutableArray* actions = [[NSMutableArray alloc] init];
    
    [actions addObject:[UIAction actionWithTitle:@"Live Chat" image:[UIImage systemImageNamed:@"ellipsis.bubble"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Live Chat Clicked"] completionHandler:^(BOOL finished) {
            
        }];
        
        [self SendChat];
        
    }]];
    
    [actions addObject:[UIAction actionWithTitle:@"Email" image:[UIImage systemImageNamed:@"envelope"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Email Clicked"] completionHandler:^(BOOL finished) {
            
        }];
        
        [self SendEmail];
        
    }]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self->_sendMessageButton.menu = [UIMenu menuWithTitle:@"" children:actions];
        self->_sendMessageButton.showsMenuAsPrimaryAction = true;
        
    });
    
}

#pragma mark - Context Menu Actions

-(void)SendChat {
    
    BOOL UserIsAppCreator = [[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] isEqualToString:@"2021-08-24 23:51:563280984"];
    
    if (UserIsAppCreator == NO) {
        
        [self StartProgressView];
        
        BOOL UserNeverStartedLiveChat = [[NSUserDefaults standardUserDefaults] objectForKey:@"StartedLiveChat"];
        
        if (UserNeverStartedLiveChat == YES) {
            
            [self UserStartedLiveSupportChat];
            
        } else {
            
            [self UserOpennedExistingLiveSupportChat];
            
        }
        
    } else {
        
        [self UserOpennedMasterLiveChat];
        
    }
    
}

-(void)SendEmail {

    if([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
        mailCont.mailComposeDelegate = self;
        
        [mailCont setSubject:[NSString stringWithFormat:@"WeDivvy Premium Question: %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]]];
        [mailCont setToRecipients:[NSArray arrayWithObjects:@"wedivvy@wedivvyapp.com", nil]];
        [mailCont setMessageBody:@"" isHTML:NO];
        mailCont.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:mailCont animated:YES completion:nil];
        
    } else {
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"This iPhone is not capable of sending emails" currentViewController:self];
        
    }
    
}

#pragma mark - Custom Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

#pragma mark - IBAction Methods

-(IBAction)SubmitQuestion:(id)sender {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Submit your question" message:@"What question should we add to our FAQ's?"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Submit"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *userEmail = [controller.textFields[0].text lowercaseString];
        
        NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
        NSString *trimmedStringString = [userEmail stringByTrimmingCharactersInSet:charSet];
        
        if ([trimmedStringString isEqualToString:@""]) {
            
            [self->progressView setHidden:YES];
            [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You forgot to write anything" currentViewController:self];
            
        } else {
            
            
            [self StartProgressView];
            
            NSDictionary *dataDict = @{
                @"FAQID" : [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString] ? [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString] : @"UnknownFAQID",
                @"FAQQuestion" : userEmail ? userEmail : @"UnknownFAQQuestion",
                @"FAQAppVersion" : @"6.5.98",
                @"FAQSubmittedBy" : [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"UnknownFAQSubmittedBy",
                @"FAQDatePosted" : [[[GeneralObject alloc] init] GenerateCurrentDateString] ? [[[GeneralObject alloc] init] GenerateCurrentDateString] : @"UnknownFAQDatePosted",
            };
            
            [[[SetDataObject alloc] init] SetDataFAQ:dataDict completionHandler:^(BOOL finished) {
                
                [[[GeneralObject alloc] init] CreateAlert:@"Yay!" message:@"Your question has been submitted!" currentViewController:self];
                
                [self->progressView setHidden:YES];
                
            }];
        }
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {}];
    
    
    
    [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        textField.delegate = self;
        textField.placeholder = @"Question";
        textField.text = @"";
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        
    }];
    
    [controller addAction:action1];
    [controller addAction:cancel];
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - Table View Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    FAQCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FAQCell"];
    
    cell.faqTitleLabel.text = faqTitleArray[indexPath.row];
    cell.faqBodyLabel.text = faqBodyArray[indexPath.row];

    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [faqTitleArray count];
    
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(FAQCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = CGRectGetHeight(cell.contentView.bounds);
    CGFloat width = CGRectGetWidth(cell.contentView.bounds);
    
    cell.rightArrowImage.contentMode = UIViewContentModeScaleAspectFit;
    cell.rightArrowImage.frame = CGRectMake(width*1 - (width*0.03623188 > 15?(15):width*0.03623188) - (width*0.04830918 > 20?(20):width*0.04830918), (self.view.frame.size.height*0.01630435 > 12?(12):self.view.frame.size.height*0.01630435), (width*0.03623188 > 15?(15):width*0.03623188), (width*0.03623188 > 15?(15):width*0.03623188));
    
    CGFloat titleHeight = [arrayOfHeights[indexPath.row] intValue] * (self.view.frame.size.height*0.0298913 > 22?(22):self.view.frame.size.height*0.0298913);
    CGFloat bodyHeight = [arrayOfHeightsNo1[indexPath.row] intValue] * (self.view.frame.size.height*0.03125 > 23?(23):self.view.frame.size.height*0.03125);
    
    cell.faqTitleLabel.frame = CGRectMake((width*0.04830918 > 20?(20):width*0.04830918), height*0.5 - (titleHeight)*0.5, width - (width*0.04830918 > 20?(20):width*0.04830918) - cell.rightArrowImage.frame.size.width - (width*0.04830918 > 20?(20):width*0.04830918) - (width*0.04830918 > 20?(20):width*0.04830918), titleHeight);
    cell.faqBodyLabel.frame = CGRectMake((width*0.04830918 > 20?(20):width*0.04830918), cell.faqTitleLabel.frame.origin.y + cell.faqTitleLabel.frame.size.height, cell.faqTitleLabel.frame.size.width, 0);
    cell.faqBodyLabel.hidden = YES;

    cell.faqTitleLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.0298913 > 22?(22):self.view.frame.size.height*0.0298913)*0.727272 weight:UIFontWeightMedium];
    cell.faqBodyLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.03125 > 23?(23):self.view.frame.size.height*0.03125)*0.60869565 weight:UIFontWeightMedium];
    
    if (selectedIndex != NULL && selectedIndex.row == indexPath.row) {
        
        cell.faqTitleLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02173913 > 16?(16):self.view.frame.size.height*0.02173913) weight:UIFontWeightSemibold];
        
        CGRect newRect = cell.faqTitleLabel.frame;
        newRect.origin.y = (self.view.frame.size.height*0.01630435 > 12?(12):self.view.frame.size.height*0.01630435);
        
        newRect.size.height = titleHeight;
        cell.faqTitleLabel.frame = newRect;
        
        newRect = cell.faqBodyLabel.frame;
        newRect.origin.y = cell.faqTitleLabel.frame.origin.y + cell.faqTitleLabel.frame.size.height + (self.view.frame.size.height*0.01086957 > 8?(8):self.view.frame.size.height*0.01086957);
        newRect.size.height = bodyHeight;
        cell.faqBodyLabel.frame = newRect;
        
        cell.faqBodyLabel.hidden = NO;
        cell.faqBodyLabel.adjustsFontSizeToFitWidth = YES;
        
    }
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        cell.contentView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        cell.faqTitleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        cell.faqBodyLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextSecondary];
        
    }
 
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"FAQ %@ Clicked", faqTitleArray[indexPath.row]] completionHandler:^(BOOL finished) {
        
    }];
    
    NSIndexPath *oldSelectedIndexPath = selectedIndex != NULL ? selectedIndex : NULL;
    
    if (indexPath != selectedIndex) {
        
        selectedIndex = indexPath;
        
    } else {
        
        selectedIndex = NULL;
        
    }
    
    NSMutableArray *arr = [NSMutableArray array];
    if (oldSelectedIndexPath != NULL) { [arr addObject:[NSIndexPath indexPathForRow:oldSelectedIndexPath.row inSection:0]]; }
    [arr addObject:[NSIndexPath indexPathForRow:selectedIndex.row inSection:0]];
    
    [self.customTableView beginUpdates];
    [self.customTableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
    [self.customTableView endUpdates];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    CGFloat titleHeight = [arrayOfHeights[indexPath.row] intValue] * (self.view.frame.size.height*0.0298913 > 22?(22):self.view.frame.size.height*0.0298913);
    CGFloat bodyHeight = [arrayOfHeightsNo1[indexPath.row] intValue] * (self.view.frame.size.height*0.03125 > 23?(23):self.view.frame.size.height*0.03125);
    
    if (selectedIndex != NULL && selectedIndex.row == indexPath.row) {
        
        return (self.view.frame.size.height*0.01630435 > 12?(12):self.view.frame.size.height*0.01630435) + titleHeight + (self.view.frame.size.height*0.01086957 > 8?(8):self.view.frame.size.height*0.01086957) + bodyHeight + (self.view.frame.size.height*0.01630435 > 12?(12):self.view.frame.size.height*0.01630435);
        
    }
    
    return (self.view.frame.size.height*0.0923913 > 68?(68):self.view.frame.size.height*0.0923913);
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

-(void)UserStartedLiveSupportChat {
    
    [[[NotificationsObject alloc] init] SendPushNotificationToCreator:[NSString stringWithFormat:@"%@ - New Support Chat", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] notificationBody:@"" badgeNumber:(NSInteger *)1 completionHandler:^(BOOL finished) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"StartedLiveChat"];
            
            [self->progressView setHidden:YES];
            
            [[[PushObject alloc] init] PushToLiveChatViewControllerFromSettingsPage:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] viewingLiveSupport:YES currentViewController:self Superficial:NO];
            
        });
        
    }];
    
}

-(void)UserOpennedExistingLiveSupportChat {
    
    [[[NotificationsObject alloc] init] SendPushNotificationToCreator:[NSString stringWithFormat:@"%@ - Existing Support Chat", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] notificationBody:@"" badgeNumber:(NSInteger *)1 completionHandler:^(BOOL finished) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self->progressView setHidden:YES];
            
            [[[PushObject alloc] init] PushToLiveChatViewControllerFromSettingsPage:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] viewingLiveSupport:YES currentViewController:self Superficial:NO];
            
        });
        
    }];
    
}

-(void)UserOpennedMasterLiveChat {
    
    [self->progressView setHidden:YES];
    
    [[[PushObject alloc] init] PushToMasterLiveChatViewController:self];
    
}

@end
