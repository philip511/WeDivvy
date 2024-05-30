//
//  InviteMembersViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 11/13/21.
//

#import "InviteMembersViewController.h"

#import "GeneralObject.h"
#import "SetDataObject.h"
#import "PushObject.h"
#import "NotificationsObject.h"
#import "HomesViewControllerObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

#import <MRProgress/MRProgress.h>

@interface InviteMembersViewController () {
    
    MRProgressOverlayView *progressView;
    NSMutableDictionary *homeMembersDict;
    NSMutableArray *homeMembersArray;
    NSMutableDictionary *homeMembersUnclaimedDict;
    NSMutableDictionary *homeKeysDict;
    NSMutableArray *homeKeysArray;
    
}

@end

@implementation InviteMembersViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self InitMethod];
    
    [self BarButtonItems];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        return UIStatusBarStyleLightContent;
        
    } else {
        
        return UIStatusBarStyleDefault;
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    _inviteFriendsButton.backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    
}

-(void)viewWillLayoutSubviews {
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    _mainImage.frame = CGRectMake(0, height*0.32608696, width, height*0.20380435);
    
    _titleLabel.frame = CGRectMake(width*0.5 -((width*0.5821256)*0.5), _mainImage.frame.origin.y + _mainImage.frame.size.height + (height*0.02717391), width*0.5821256, height*0.05298913);
    _subTitleLabel.frame = CGRectMake(width*0.5 - ((width*0.69565217)*0.5), _titleLabel.frame.origin.y + _titleLabel.frame.size.height + (height*0.01630435), width*0.69565217, height*0.05027174);
    
    _titleLabel.font = [UIFont systemFontOfSize:(_titleLabel.frame.size.height*0.4 > 16?(16):_titleLabel.frame.size.height*0.4) weight:UIFontWeightSemibold];
    _subTitleLabel.font = [UIFont systemFontOfSize:(_subTitleLabel.frame.size.height*0.4 > 15?(15):_subTitleLabel.frame.size.height*0.4) weight:UIFontWeightMedium];
    
    _maybeLabelButton.frame = CGRectMake(0, height - (self.view.frame.size.height*0.03532609 > 26?(26):self.view.frame.size.height*0.03532609) - (height*0.02717391) - bottomPadding, width, (self.view.frame.size.height*0.03532609 > 26?(26):self.view.frame.size.height*0.03532609));
    _maybeLabelButton.titleLabel.font = [UIFont systemFontOfSize:_maybeLabelButton.frame.size.height*0.53846 weight:UIFontWeightMedium];
    _inviteFriendsButton.frame = CGRectMake(width*0.5 - (width*0.90)*0.5, height - (height - _maybeLabelButton.frame.origin.y) - (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934) - (height*0.02309783), width*0.90, (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934));
    _inviteFriendsButton.titleLabel.font = [UIFont systemFontOfSize:_inviteFriendsButton.frame.size.height*0.32 weight:UIFontWeightSemibold];
    _inviteFriendsButton.layer.cornerRadius = 7;
    _whoWasInvitedLabel.frame = CGRectMake(_inviteFriendsButton.frame.origin.x, _inviteFriendsButton.frame.origin.y - (self.view.frame.size.height*0.03532609 > 26?(26):self.view.frame.size.height*0.03532609) - (height*0.02717391), _inviteFriendsButton.frame.size.width, (self.view.frame.size.height*0.03532609 > 26?(26):self.view.frame.size.height*0.03532609));
    _whoWasInvitedLabel.numberOfLines = 0;

    self->_whoWasInvitedLabel.text = [self GenerateWhoWasInvitedString];
    
    NSInteger numberOfLines = [[[GeneralObject alloc] init] LineCountForText:self->_whoWasInvitedLabel.text label:self->_whoWasInvitedLabel];
    
    CGRect newRect = self->_whoWasInvitedLabel.frame;
    newRect.size.height = numberOfLines * (self.view.frame.size.height*0.03532609 > 26?(26):self.view.frame.size.height*0.03532609);
    newRect.origin.y =  self->_inviteFriendsButton.frame.origin.y - newRect.size.height - (height*0.02717391);
    self->_whoWasInvitedLabel.frame = newRect;
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.titleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.subTitleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextSecondary];
        self.maybeLabelButton.titleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextSecondary];
        
        [self preferredStatusBarStyle];
        
    }
    
}

#pragma mark - Mail Methdos

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    switch (result)
    {
        case MFMailComposeResultCancelled:
            
            NSLog(@"Mail cancelled");
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Invite Canceled"] completionHandler:^(BOOL finished) {
                
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
    
    [self SetUpDicts];
  
}

-(void)BarButtonItems {
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *barButtonitem;
    
    barButtonitem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(DoneInvitingAction:)];
    
    self.navigationItem.rightBarButtonItem = barButtonitem;
    
}

#pragma mark - SetUp Methods

-(void)SetUpAnalytics {

    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"InviteMembersViewController" completionHandler:^(BOOL finished) {
        
    }];

}

-(void)SetUpDicts {
    
    homeMembersDict = [@{@"UserID" : @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]], @"Username" : @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]], @"Notifications" : @[@"No"], @"ProfileImageURL" : @[@"xxx"]} mutableCopy];
    homeMembersArray = [@[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] mutableCopy];
    homeMembersUnclaimedDict = [NSMutableDictionary dictionary];
    homeKeysDict = [NSMutableDictionary dictionary];
    homeKeysArray = [NSMutableArray array];
    
}

#pragma mark - UI Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

#pragma mark - IBAction Methods

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)DoneInvitingAction:(id)sender {
    
    [[[PushObject alloc] init] PushToEnableNotificationsViewController:self comingFromCreateHome:YES clickedUnclaimedUser:NO homeIDLinkedToKey:@"" homeKey:@""];
    
}

-(IBAction)InviteRoommates:(id)sender {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"New Home Member" message:@"Enter your new home members name"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Add"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *newName = controller.textFields[0].text;
        
        NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
        NSString *trimmedStringItemName = [newName stringByTrimmingCharactersInSet:charSet];
        
        if (trimmedStringItemName.length > 0) {
            
            [self StartProgressView];
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Invite Roomates Clicked"] completionHandler:^(BOOL finished) {
                
            }];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString *inviteKey = [[[GeneralObject alloc] init] GenerateRandomSmallNumberIntoString:100000 upperBound:999999];
                __block NSString *inviteKeyExtraWithNumber = inviteKeyExtraWithNumber = [NSString stringWithFormat:@"%@•••%@•••", inviteKey, [[[GeneralObject alloc] init] GenerateRandomSmallNumberIntoString:100 upperBound:999]];
                
                NSString *body = [NSString stringWithFormat:@"Hey, here's an invitation code to join my home - %@ 🏠🔐", inviteKey];
                
                NSArray* dataToShare = @[body, [NSURL URLWithString:@"https://apps.apple.com/us/app/wedivvy/id1570700094"]];
                UIActivityViewController* activityViewController =[[UIActivityViewController alloc] initWithActivityItems:dataToShare applicationActivities:nil];
                [activityViewController setValue:@"Invitation From a Friend" forKey:@"subject"];
                activityViewController.excludedActivityTypes = @[UIActivityTypeAirDrop];
                
                [activityViewController setCompletionWithItemsHandler:^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError) {
                    
                    NSArray *dontAccept = @[@"com.apple.UIKit.activity.CopyToPasteboard", @"com.apple.DocumentManagerUICore.SaveToFiles"];
                    
                    if (completed && [dontAccept containsObject:activityType] == NO) {
                        
                        [self->progressView setHidden:YES];
                        
                        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Invite Roommates Completed"] completionHandler:^(BOOL finished) {
                            
                        }];
                        
                        
                        
                        NSString *selectedUserID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
                        NSString *selectedUsername = controller.textFields[0].text;
                        
                        
                        
                        NSDictionary *userDictLocal = [self InviteRoommates_GenerateUserDict:selectedUserID selectedUsername:selectedUsername];
                        
                        [self InviteRoommates_UpdateHomeDict:inviteKey inviteKeyExtraWithNumber:inviteKeyExtraWithNumber selectedUserID:selectedUserID selectedUsername:selectedUsername];
                        
                        [self InviteRoommates_LocalNotifications];
                        
                        [self InviteRoommates_CompletionBlock:1 completedQueries:1];
                        
                        
                        
//                        __block int totalQueries = 2;
//                        __block int completedQueries = 0;
                        
                        
                        
                        /*
                         //
                         //
                         //Update Home Data
                         //
                         //
                         */
                        [self InviteRoommates_UpdateHomeData:^(BOOL finished) {
                            
//                            [self InviteRoommates_CompletionBlock:totalQueries completedQueries:(completedQueries+=1)];
                            
                        }];
                        
                        
                        /*
                         //
                         //
                         //Set User Data
                         //
                         //
                         */
                        [self InviteRoommates_SetUserData:userDictLocal selectedUserID:userDictLocal[@"UserID"] completionHandler:^(BOOL finished) {
                            
//                            [self InviteRoommates_CompletionBlock:totalQueries completedQueries:(completedQueries+=1)];
                            
                        }];
                        
                    } else {
                        
                        [self->progressView setHidden:YES];
                        
                    }
                    
                }];
                
                [self presentViewController:activityViewController animated:YES completion:^{}];

            });
            
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
    
}

-(IBAction)MaybeLabel:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Maybe Later Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[PushObject alloc] init] PushToEnableNotificationsViewController:self comingFromCreateHome:YES clickedUnclaimedUser:NO homeIDLinkedToKey:@"" homeKey:@""];
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark IBAction Methods

-(void)CompleteInviteRoommates {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self->_whoWasInvitedLabel.text = [self GenerateWhoWasInvitedString];
        
        NSInteger numberOfLines = [[[GeneralObject alloc] init] LineCountForText:self->_whoWasInvitedLabel.text label:self->_whoWasInvitedLabel];
        
        CGRect newRect = self->_whoWasInvitedLabel.frame;
        newRect.size.height = numberOfLines * (self.view.frame.size.height*0.03532609 > 26?(26):self.view.frame.size.height*0.03532609);
        newRect.origin.y =  self->_inviteFriendsButton.frame.origin.y - newRect.size.height - (self.view.frame.size.height*0.02717391);
        self->_whoWasInvitedLabel.frame = newRect;
        
        if ([self->_whoWasInvitedLabel.text length] > 0) {
            [self->_inviteFriendsButton setTitle:@"Invite Someone Else" forState:UIControlStateNormal];
        }
        
        [self->_maybeLabelButton setTitle:@"I'm finished" forState:UIControlStateNormal];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"SeenNoInvitationsPopup"];
        
    }];
    
}

-(NSString *)GenerateWhoWasInvitedString {
    
    NSString *whoWasInvitedString = @"";
    
    NSMutableArray *memberNameArray = [NSMutableArray array];
    
    for (NSString *key in [self->homeKeysDict allKeys]) {
        
        NSString *memeberName = self->homeKeysDict[key] && self->homeKeysDict[key][@"MemberName"] ? self->homeKeysDict[key][@"MemberName"] : @"";
        
        if ([memeberName length] > 0) {
            
            [memberNameArray addObject:memeberName];
            
        }
        
    }
    
    if ([memberNameArray count] == 1) {
        
        whoWasInvitedString = [NSString stringWithFormat:@"%@ has been invited", memberNameArray[0]];
        
    } else if ([memberNameArray count] == 2) {
        
        whoWasInvitedString = [NSString stringWithFormat:@"%@ and %@ have been invited", memberNameArray[0], memberNameArray[1]];
        
    } else if ([memberNameArray count] > 2) {
        
        for (NSString *username in memberNameArray) {
            
            if ([whoWasInvitedString length] == 0) {
                
                whoWasInvitedString = [NSString stringWithFormat:@"%@", username];
                
            } else if ([username isEqualToString:[memberNameArray lastObject]]) {
                
                whoWasInvitedString = [NSString stringWithFormat:@"%@, and %@ have been invited", whoWasInvitedString, username];
                
            } else {
                
                whoWasInvitedString = [NSString stringWithFormat:@"%@, %@", whoWasInvitedString, username];
                
            }
            
        }
        
    }
    
    return whoWasInvitedString;
}

#pragma mark

-(void)InviteRoommates_UpdateHomeDict:(NSString *)inviteKey inviteKeyExtraWithNumber:(NSString *)inviteKeyExtraWithNumber selectedUserID:(NSString *)selectedUserID selectedUsername:(NSString *)selectedUsername {
    
    NSString *currentDateString = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy hh:mm a" returnAs:[NSString class]];
    
    [self->homeKeysDict setObject:@{@"DateSent" : currentDateString, @"DateUsed" : @"", @"MemberName" : selectedUsername, @"SentBy" : [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], @"ViewController" : @"InviteMembers"} forKey:inviteKeyExtraWithNumber];
    [self->homeKeysArray addObject:inviteKey];
    
    NSMutableArray *homeMembersArrayLocal = self->homeMembersArray ? [self->homeMembersArray mutableCopy] : [NSMutableArray array];
    [homeMembersArrayLocal addObject:selectedUserID];
    self->homeMembersArray = [homeMembersArrayLocal mutableCopy];
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    NSMutableDictionary *homeMembersUnclaimedDictLocal = self->homeMembersUnclaimedDict ? [self->homeMembersUnclaimedDict mutableCopy] : [NSMutableDictionary dictionary];
    [homeMembersUnclaimedDictLocal setObject:@{@"UserID" : selectedUserID, @"Username" : selectedUsername, @"CreatedBy" : userID, @"InvitationSent" : inviteKeyExtraWithNumber, @"ViewController" : @"InviteMembers"} forKey:selectedUserID];
    self->homeMembersUnclaimedDict = [homeMembersUnclaimedDictLocal mutableCopy];
    
}

-(NSDictionary *)InviteRoommates_GenerateUserDict:(NSString *)selectedUserID selectedUsername:(NSString *)selectedUsername {
    
    NSString *mixPanelID = @""; //[[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString]
    NSString *userEmail = @"";
    NSString *userID = selectedUserID;
    NSString *username = selectedUsername;
    NSString *receiveEmails = @"Yes";
    
    NSDictionary *userDictLocal = @{
        
        @"UserID": userID ? userID : @"",
        @"Email": userEmail ? userEmail : @"",
        @"Username": username ? username : @"",
        @"ProfileImageURL" : @"https://firebasestorage.googleapis.com/v0/b/wedivvy-afe04.appspot.com/o/DefaultImages%2FdefaultProfileImage.png?alt=media&token=6892f430-8337-4327-89a4-53a403d1186c",
        @"MixPanelID" : mixPanelID ? mixPanelID : @"",
        @"HeardAboutUs" : @"xxx",
        @"Notifications" : @"No",
        @"ReceiveUpdateEmails" : receiveEmails ? receiveEmails : @"Yes",
        @"WeDivvyPremium" : [[[GeneralObject alloc] init] GenerateDefaultWeDivvyPremiumPlan]
        
    };
    
    return userDictLocal;
}

-(void)InviteRoommates_LocalNotifications {
    
    [[[NotificationsObject alloc] init] SendLocalNotificationHomeMemberNoInvitationNotification_LocalOnly:self->homeKeysDict homeMembersUnclaimedDict:self->homeMembersUnclaimedDict completionHandler:^(BOOL finished) {
        
    }];
    
    [[[NotificationsObject alloc] init] SendLocalNotificationHomeMemberHasNotJoinedNotification_LocalOnly:self->homeKeysDict homeMembersUnclaimedDict:self->homeMembersUnclaimedDict completionHandler:^(BOOL finished) {
        
    }];
    
}

-(void)InviteRoommates_UpdateHomeData:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        [[[SetDataObject alloc] init] UpdateDataHome:homeID homeDict:@{@"HomeKeys" : self->homeKeysDict, @"HomeKeysArray" : self->homeKeysArray, @"HomeMembers" : self->homeMembersArray, @"HomeMembersUnclaimed" : self->homeMembersUnclaimedDict} completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)InviteRoommates_SetUserData:(NSDictionary *)userDictLocal selectedUserID:(NSString *)selectedUserID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] SetDataUserData:selectedUserID userDict:userDictLocal completionHandler:^(BOOL finished, NSError * _Nonnull error) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)InviteRoommates_CompletionBlock:(int)totalQueries completedQueries:(int)completedQueries {
    
    if (totalQueries == completedQueries) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self CompleteInviteRoommates];
            [self->progressView setHidden:YES];
            
        });
        
    }
    
}

@end
