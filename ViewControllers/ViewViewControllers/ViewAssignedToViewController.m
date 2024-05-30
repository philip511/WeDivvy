//
//  ViewAssignedToViewController.m
//  RoommateApp
//
//  Created by Philip Nagel on 5/21/21.
//

#import "UIImageView+Letters.h"

#import "ViewAssignedToViewController.h"
#import "AppDelegate.h"
#import "AssignedToCell.h"

#import <SDWebImage/SDWebImage.h>
#import <MRProgress/MRProgressOverlayView.h>
#import <Mixpanel/Mixpanel.h>

#import "GeneralObject.h"
#import "SetDataObject.h"
#import "DeleteDataObject.h"
#import "BoolDataObject.h"
#import "NotificationsObject.h"
#import "HomesViewControllerObject.h"
#import "SettingsObject.h"
#import "LightDarkModeObject.h"
#import "PushObject.h"

@interface ViewAssignedToViewController () {
    
    MRProgressOverlayView *progressView;
    
    NSMutableDictionary *oldHomeMembersDict;
    NSMutableDictionary *lastHomeMemberAddedUserDict;
    
    UILabel *notificationTaskTypesTopLabel;
    UILabel *notificationTaskTypesTopLabelNo1;
    
    NSString *topLabelString;
    NSString *mySubscriptionPlan;
    
    BOOL RanOutOfAccounts;

    int usersCellHeight;
    int unclaimedUsersCellHeight;
    
}

@end

@implementation ViewAssignedToViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Post-Spike
    //_assignedToAnybodyView.hidden = YES;
    _hasAndroidButton.hidden = YES;
    
    [self InitMethod];
    
    [self BarButtonItem];
    
    [self TapGesture];
    
    [self.customTableView reloadData];
    
}

-(void)viewDidLayoutSubviews {
    
    float cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
    
    if (_viewingChatMembers) {
        
        [[[GeneralObject alloc] init] RoundingCorners:_customTableView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
        _addHomeMemberButton.hidden = YES;
        _hasAndroidButton.hidden = YES;
        
    } else {
        
        [[[GeneralObject alloc] init] RoundingCorners:_customTableView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
        [[[GeneralObject alloc] init] RoundingCorners:_addHomeMemberButton topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
        
    }
    
    _assignNewHomeMembersSwitch.onTintColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    
    
    
    
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.navigationController.navigationBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.customTableView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.assignedToAnybodyView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.assignedToAnybodyLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.assignNewHomeMembersView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.assignNewHomeMembersLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.inviteHomeMemberBackDropView.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.1f];
        self.inviteHomeMemberAlertView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModePrimary];
        self.inviteHomeMemberAlertViewTitleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.inviteHomeMemberAlertViewSubTitleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        
        [self preferredStatusBarStyle];
        
    } else {
        
        self.navigationController.navigationBar.backgroundColor = self.view.backgroundColor;
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [_addHomeMemberButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _addHomeMemberButton.backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    _inviteHomeMemberAlertViewSubmitButton.backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    
    CGFloat textFieldSpacing = (height*0.024456);
    
    usersCellHeight = (self.view.frame.size.height*0.11005435 > 81?(81):self.view.frame.size.height*0.11005435)*0.7037037;
    unclaimedUsersCellHeight = (self.view.frame.size.height*0.10326087 > 76?(76):self.view.frame.size.height*0.10326087);
    
    _inviteHomeMemberBackDropView.frame = CGRectMake(0, 0, width, height);
    _inviteHomeMemberBackDropView.alpha = 0.0;
    
    _inviteHomeMemberAlertView.frame = CGRectMake(0, height, width, ((height*0.33967391) > 250?(250):(height*0.33967391)));
    
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.inviteHomeMemberAlertView.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(_inviteHomeMemberAlertView.frame.size.height*0.15, _inviteHomeMemberAlertView.frame.size.height*0.15)];
    
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = self.inviteHomeMemberAlertView.bounds;
    maskLayer1.path  = maskPath1.CGPath;
    self.inviteHomeMemberAlertView.layer.mask = maskLayer1;
    
    
    
    
    notificationTaskTypesTopLabel = [[UILabel alloc] init];
    notificationTaskTypesTopLabelNo1 = [[UILabel alloc] init];
    
    notificationTaskTypesTopLabel.frame = CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), navigationBarHeight + textFieldSpacing, width - (textFieldSpacing+10)*2, (self.view.frame.size.height*0.08152174 > 60?(60):self.view.frame.size.height*0.08152174));
    notificationTaskTypesTopLabel.textColor = [UIColor colorWithRed:115.0f/255.0f green:126.0f/255.0f blue:143.0f/255.0f alpha:1.0f];
    notificationTaskTypesTopLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02038043 > 15?(15):self.view.frame.size.height*0.02038043) weight:UIFontWeightMedium];
    notificationTaskTypesTopLabel.numberOfLines = 0;
    notificationTaskTypesTopLabel.adjustsFontSizeToFitWidth = YES;
    
    CGFloat stringWidth = [[[GeneralObject alloc] init] WidthOfString:[NSString stringWithFormat:@"(You can always change this in the\nWeDivvy Premium Settings page)"] withFont:notificationTaskTypesTopLabelNo1.font];
    notificationTaskTypesTopLabelNo1.frame = CGRectMake(self.view.frame.size.width*0.5 - (stringWidth)*0.5, notificationTaskTypesTopLabel.frame.origin.y + notificationTaskTypesTopLabel.frame.size.height + textFieldSpacing, stringWidth, (self.view.frame.size.height*0.04755435 > 35?(35):self.view.frame.size.height*0.04755435));
    notificationTaskTypesTopLabelNo1.textColor = [UIColor colorWithRed:115.0f/255.0f green:126.0f/255.0f blue:143.0f/255.0f alpha:1.0f];
    notificationTaskTypesTopLabelNo1.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.01766304 > 13?(13):self.view.frame.size.height*0.01766304) weight:UIFontWeightSemibold];
    notificationTaskTypesTopLabelNo1.numberOfLines = 0;
    notificationTaskTypesTopLabelNo1.textAlignment = NSTextAlignmentCenter;
    notificationTaskTypesTopLabelNo1.backgroundColor = [UIColor clearColor];
    notificationTaskTypesTopLabelNo1.clipsToBounds = YES;
    notificationTaskTypesTopLabelNo1.layer.cornerRadius = 7;
    notificationTaskTypesTopLabelNo1.adjustsFontSizeToFitWidth = YES;
    
    
    
    
    [self GenerateUpdatedTopLabel];
    
    [self.view addSubview:notificationTaskTypesTopLabel];
    [self.view addSubview:notificationTaskTypesTopLabelNo1];
    
    
    
    
    float cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
    
    _assignedToAnybodyView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), navigationBarHeight + textFieldSpacing, width*0.90338164, (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934));
    
    CGFloat yPos = _viewingChatMembers ? navigationBarHeight + textFieldSpacing : _assignedToAnybodyView.frame.origin.y + _assignedToAnybodyView.frame.size.height;
    
    if (_viewingWeDivvyPremiumAddingAccounts) {
        
        yPos = notificationTaskTypesTopLabelNo1.frame.origin.y + notificationTaskTypesTopLabelNo1.frame.size.height + textFieldSpacing;
        
    } else if (_viewingWeDivvyPremiumEditingAccounts) {
        
        yPos = notificationTaskTypesTopLabel.frame.origin.y + notificationTaskTypesTopLabel.frame.size.height + textFieldSpacing;
        
    }
    
    _assignNewHomeMembersView.frame = CGRectMake(_assignedToAnybodyView.frame.origin.x, yPos, _assignedToAnybodyView.frame.size.width, _assignedToAnybodyView.frame.size.height);
    
    _assignedToAnybodyView.hidden = _viewingChatMembers || _viewingWeDivvyPremiumAddingAccounts || _viewingWeDivvyPremiumEditingAccounts ? YES : NO;
    _assignNewHomeMembersView.hidden = _viewingWeDivvyPremiumAddingAccounts || _viewingWeDivvyPremiumEditingAccounts ? YES : NO;
    
    
    
    
    
    self->_customTableView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), yPos, width*0.90338164, 0);
    self->_addHomeMemberButton.frame = CGRectMake(self->_customTableView.frame.origin.x, self->_customTableView.frame.origin.y + self->_customTableView.frame.size.height, self->_customTableView.frame.size.width, usersCellHeight);
    self->_addHomeMemberButton.titleLabel.font = [UIFont systemFontOfSize:((_addHomeMemberButton.frame.size.height*0.34) > 17?(17):(_addHomeMemberButton.frame.size.height*0.34)) weight:UIFontWeightMedium];
    
    [self AdjustTableViewHeight];
    
    
    
    
    _hasAndroidButton.frame = CGRectMake(0, self->_addHomeMemberButton.frame.origin.y + self->_addHomeMemberButton.frame.size.height + 20, width, 32);
    _hasAndroidButton.titleLabel.numberOfLines = 0;
    _hasAndroidButton.titleLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174) weight:UIFontWeightSemibold];
    _hasAndroidButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_hasAndroidButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    
    
    
    width = CGRectGetWidth(self.assignNewHomeMembersView.bounds);
    height = CGRectGetHeight(self.assignNewHomeMembersView.bounds);
    //374
    
    CGFloat switchTransform = height*0.55/31;
    
    _assignedToAnybodySwitch.transform = CGAffineTransformMakeScale(switchTransform, switchTransform);
    _assignedToAnybodySwitch.frame = CGRectMake(width*1 - _assignedToAnybodySwitch.frame.size.width - width*0.04830918, height*0.5 - (_assignedToAnybodySwitch.frame.size.height*0.5), _assignedToAnybodySwitch.frame.size.width, _assignedToAnybodySwitch.frame.size.height);
    
    _assignNewHomeMembersSwitch.transform = CGAffineTransformMakeScale(switchTransform, switchTransform);
    _assignNewHomeMembersSwitch.frame = CGRectMake(width*1 - _assignNewHomeMembersSwitch.frame.size.width - width*0.04830918, height*0.5 - (_assignNewHomeMembersSwitch.frame.size.height*0.5), _assignNewHomeMembersSwitch.frame.size.width, _assignNewHomeMembersSwitch.frame.size.height);
    
    _assignedToAnybodyLabel.frame = CGRectMake(width*0.04830918, height*0, 0, height);
    _assignedToAnybodyLabel.font = [UIFont systemFontOfSize:(height*0.34 > 17?17:(height*0.34)) weight:UIFontWeightRegular];
    _assignedToAnybodyLabel.adjustsFontSizeToFitWidth = YES;
    
    stringWidth = [[[GeneralObject alloc] init] WidthOfString:@"Assigned to Anybody" withFont:_assignedToAnybodyLabel.font];
    CGRect newRect = _assignedToAnybodyLabel.frame;
    newRect.size.width = stringWidth;
    _assignedToAnybodyLabel.frame = newRect;
    
    _assignNewHomeMembersLabel.frame = CGRectMake(width*0.04830918, height*0, width - width*0.04830918 - _assignNewHomeMembersSwitch.frame.size.width - width*0.04830918, height);
    _assignNewHomeMembersLabel.font = [UIFont systemFontOfSize:(height*0.34 > 17?17:(height*0.34)) weight:UIFontWeightRegular];
    
    stringWidth = [[[GeneralObject alloc] init] WidthOfString:@"Assign New Home Members" withFont:_assignNewHomeMembersLabel.font];
    newRect = _assignNewHomeMembersLabel.frame;
    newRect.size.width = stringWidth;
    _assignNewHomeMembersLabel.frame = newRect;
    
    _assignedToAnybodyInfoImage.frame = CGRectMake(_assignedToAnybodyLabel.frame.origin.x + _assignedToAnybodyLabel.frame.size.width + (width*0.02139037), 0, width*0.05347594, height);
    _assignNewHomeMembersInfoImage.frame = CGRectMake(_assignNewHomeMembersLabel.frame.origin.x + _assignNewHomeMembersLabel.frame.size.width + (width*0.02139037), 0, width*0.05347594, height);
    _assignNewHomeMembersLabel.adjustsFontSizeToFitWidth = YES;
    
    
    
    
    width = CGRectGetWidth(self.inviteHomeMemberAlertView.bounds);
    height = CGRectGetHeight(self.inviteHomeMemberAlertView.bounds);
    
    _inviteHomeMemberAlertViewXIcon.frame = CGRectMake(width - ((height*0.1) > 20?(20):(height*0.1)) - height*0.1, height*0.1, ((height*0.1) > 20?(20):(height*0.1)), ((height*0.1) > 20?(20):(height*0.1)));
    
    _inviteHomeMemberAlertViewXIconCover.frame = CGRectMake(_inviteHomeMemberAlertViewXIcon.frame.origin.x - height*0.1, _inviteHomeMemberAlertViewXIcon.frame.origin.y - height*0.1, _inviteHomeMemberAlertViewXIcon.frame.size.width + ((height*0.1)*2), _inviteHomeMemberAlertViewXIcon.frame.size.height + ((height*0.1)*2));
    
    _inviteHomeMemberAlertViewTitleLabel.frame = CGRectMake((width - _inviteHomeMemberAlertViewXIcon.frame.origin.x) + height*0.05, height*0.1, width - (((width -_inviteHomeMemberAlertViewXIcon.frame.origin.x))*2) - height*0.1, ((height*0.1) > 20?(20):(height*0.1)));
    _inviteHomeMemberAlertViewTitleLabel.font = [UIFont systemFontOfSize:_inviteHomeMemberAlertViewTitleLabel.frame.size.height*0.9 weight:UIFontWeightHeavy];
    
    _inviteHomeMemberAlertViewSubTitleLabel.frame = CGRectMake(height*0.1, _inviteHomeMemberAlertViewTitleLabel.frame.origin.y + _inviteHomeMemberAlertViewTitleLabel.frame.size.height + height*0.125, width - ((height*0.1)*2), ((height*0.2) > 40?(40):(height*0.2)));
    _inviteHomeMemberAlertViewSubTitleLabel.font = [UIFont systemFontOfSize:_inviteHomeMemberAlertViewSubTitleLabel.frame.size.height*0.375 weight:UIFontWeightHeavy];
    
    _inviteHomeMemberAlertViewSubmitButton.frame = CGRectMake(width*0.5 - ((width - ((width*0.09661836)*2))*0.5), height - ((height*0.2375) > 47.5?(47.5):(height*0.2375)) - height*0.1 - height*0.1, width - ((width*0.09661836)*2), ((height*0.2375) > 47.5?(47.5):(height*0.2375)));
    _inviteHomeMemberAlertViewSubmitButton.titleLabel.font = [UIFont systemFontOfSize:((_inviteHomeMemberAlertViewSubmitButton.frame.size.height*0.31578947) > 15?(15):(_inviteHomeMemberAlertViewSubmitButton.frame.size.height*0.31578947)) weight:UIFontWeightSemibold];
    _inviteHomeMemberAlertViewSubmitButton.clipsToBounds = YES;
    _inviteHomeMemberAlertViewSubmitButton.layer.cornerRadius = 7;
    
    _inviteHomeMemberAlertViewLaterButton.frame = CGRectMake(width*0.5 - ((width - ((width*0.09661836)*2))*0.5), height - ((height*0.1) > 20?(20):(height*0.1)) - ((height*0.1) > 20?(20):(height*0.1)), width - ((width*0.09661836)*2), ((height*0.1) > 20?(20):(height*0.1)));
    _inviteHomeMemberAlertViewLaterButton.titleLabel.font = [UIFont systemFontOfSize:_inviteHomeMemberAlertViewLaterButton.frame.size.height*0.7 weight:UIFontWeightSemibold];
    _inviteHomeMemberAlertViewLaterButton.clipsToBounds = YES;
    _inviteHomeMemberAlertViewLaterButton.layer.cornerRadius = 7;
    
    _inviteHomeMemberAlertViewTitleLabel.text = @"Invite your home member. 💌";
    _inviteHomeMemberAlertViewSubTitleLabel.text = [NSString stringWithFormat:@"Send an invitation code so\nthey can join your home."];
    [_inviteHomeMemberAlertViewSubmitButton setTitle:@"Send Invitation" forState:UIControlStateNormal];
    
    
    
    
    [[[GeneralObject alloc] init] RoundingCorners:_assignedToAnybodyView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
    
    if (_viewingChatMembers || _viewingWeDivvyPremiumAddingAccounts || _viewingWeDivvyPremiumEditingAccounts) {
        
        [[[GeneralObject alloc] init] RoundingCorners:_assignNewHomeMembersView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
        
    } else {
        
        [[[GeneralObject alloc] init] RoundingCorners:_assignNewHomeMembersView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
        
    }
    
    NSArray *arrView = @[_assignedToAnybodyView, _assignNewHomeMembersView];
    
    for (UIView *viewNo1 in arrView) {
        
        for (UIView *subViewNo1 in [viewNo1 subviews]) {
            
            if (subViewNo1.tag == 1111) {
                
                [subViewNo1 removeFromSuperview];
                
            }
            
        }
        
    }
    
    for (UIView *viewNo1 in arrView) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(viewNo1.frame.size.width*0.04830918, viewNo1.frame.size.height-1, viewNo1.frame.size.width - (viewNo1.frame.size.width*0.04830918), 1)];
        view.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [[[LightDarkModeObject alloc] init] LightModeSubviewLine];
        view.tag = 1111;
        [viewNo1 addSubview:view];
        
    }
    
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpAnalytics];
    
    [self SetUpDicts];
    
    [self SetUpTopLabel];
    
    [self SetUpTableView];
    
    [self SetUpCustomSwitch];
    
    [self SetUpViewingDetails];
    
    [self SetUpHasAnAndroidButtonText];
    
}

-(void)SetUpCustomSwitch {
    
    if (self->_itemAssignedToAnybody != NULL) {
        [_assignedToAnybodySwitch setOn:[self->_itemAssignedToAnybody isEqualToString:@"Yes"] ? YES : NO];
    }
    
    if (self->_itemAssignedToNewHomeMembers != NULL) {
        [_assignNewHomeMembersSwitch setOn:[self->_itemAssignedToNewHomeMembers isEqualToString:@"Yes"] ? YES : NO];
    }
    
}

-(void)SetUpViewingDetails {
    
    if (_viewingItemDetails == YES) {
        _assignNewHomeMembersSwitch.userInteractionEnabled = NO;
        _assignedToAnybodySwitch.userInteractionEnabled = NO;
        _addHomeMemberButton.userInteractionEnabled = NO;
    }
    
}

-(void)BarButtonItem {
    
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(NavigationBackButtonAction:)];
    
    if (_viewingWeDivvyPremiumAddingAccounts == NO) {
        
        self.navigationItem.leftBarButtonItem = newBackButton;
        
    }
    
    if (_viewingItemDetails == NO && _viewingWeDivvyPremiumAddingAccounts == NO) {
        
        newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(SaveButtonAction:)];
        
        self.navigationItem.rightBarButtonItem = newBackButton;
        
    } else if (_viewingWeDivvyPremiumAddingAccounts == YES) {
        
        newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(SaveButtonAction:)];
        
        self.navigationItem.rightBarButtonItem = newBackButton;
        
    }
    
}

-(void)TapGesture {
    
    UITapGestureRecognizer *tapGesture;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(AssignedToAnybodyPopup)];
    [_assignedToAnybodyInfoImage addGestureRecognizer:tapGesture];
    _assignedToAnybodyInfoImage.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(AssignNewHomeMembersPopup)];
    [_assignNewHomeMembersInfoImage addGestureRecognizer:tapGesture];
    _assignNewHomeMembersInfoImage.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureInviteHomeMemberClose:)];
    [_inviteHomeMemberAlertViewLaterButton addGestureRecognizer:tapGesture];
    _inviteHomeMemberAlertViewLaterButton.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureInviteHomeMemberClose:)];
    [_inviteHomeMemberAlertViewXIconCover addGestureRecognizer:tapGesture];
    _inviteHomeMemberAlertViewXIconCover.userInteractionEnabled = YES;
    
}

#pragma mark - Setup Methods

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"ViewAssignedToViewController" completionHandler:^(BOOL finished) {
        
    }];
    
    [[[GeneralObject alloc] init] TrackInMixPanel:@"ViewAssignedToViewController"];
    
}

-(void)SetUpDicts {
    
    oldHomeMembersDict = [_homeMembersDict mutableCopy];
    
}

-(void)SetUpTopLabel {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    if ([itemType isEqualToString:@"GroupChat"]) { itemType = @"group chat"; }
    
    if (_viewingWeDivvyPremiumAddingAccounts || _viewingWeDivvyPremiumEditingAccounts) {
        
        self.title = @"Premium Accounts";
        
        [self GenerateUpdatedTopLabel];
        
    }
    
}

-(void)SetUpTableView {
    
    _customTableView.delegate = self;
    _customTableView.dataSource = self;
    
}

-(void)SetUpItemViewContextMenu:(AssignedToCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *actions = [[NSMutableArray alloc] init];
    NSMutableArray *bottomMenuActions = [[NSMutableArray alloc] init];
    
    
    
    UIAction *sendInvitationAction = [self SendInvitationContextMenuAction:indexPath];
    UIAction *resendInvitationAction = [self ResendInvitationContextMenuAction:indexPath];
    UIAction *copyKeyAction = [self CopyKeyContextMenuAction:indexPath];
    UIAction *editMemberNameAction = [self EditMemberNameContextMenuAction:indexPath];
    UIAction *deleteMemberAction = [self DeleteMemberContextMenuAction:indexPath];
    
    [deleteMemberAction setAttributes:UIMenuElementAttributesDestructive];
    
    
    
    NSMutableDictionary *tempHomeMembersUnclaimedDictLocal = [_homeMembersUnclaimedDict mutableCopy];
    
    NSString *userIDToEdit = self->_homeMembersDict[@"UserID"] && [(NSArray *)self->_homeMembersDict[@"UserID"] count] > indexPath.row ? self->_homeMembersDict[@"UserID"][indexPath.row] : @"";
    NSUInteger index = [[tempHomeMembersUnclaimedDictLocal allKeys] containsObject:userIDToEdit] ? [[tempHomeMembersUnclaimedDictLocal allKeys] indexOfObject:userIDToEdit] : -1;
    NSString *keyToUse = [[tempHomeMembersUnclaimedDictLocal allKeys] count] > index ? [tempHomeMembersUnclaimedDictLocal allKeys][index] : @"";
    NSMutableDictionary *tempHomeMembersUnclaimedDictLocalInnerDict = tempHomeMembersUnclaimedDictLocal[keyToUse] ? [tempHomeMembersUnclaimedDictLocal[keyToUse] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSString *invitationKeyToEdit = tempHomeMembersUnclaimedDictLocalInnerDict[@"InvitationSent"] ? tempHomeMembersUnclaimedDictLocalInnerDict[@"InvitationSent"] : @"";
    
    
    
    if ([invitationKeyToEdit isEqualToString:@"No"]) {
        [actions addObject:sendInvitationAction];
    } else {
        [actions addObject:resendInvitationAction];
        [actions addObject:copyKeyAction];
    }
    
    
    
    [bottomMenuActions addObject:editMemberNameAction];
    [bottomMenuActions addObject:deleteMemberAction];
    
    UIMenu *bottomActionsMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"1" options:UIMenuOptionsDisplayInline children:bottomMenuActions];
    
    [actions addObject:bottomActionsMenu];
    
    
    
    cell.ellipsisImageOverlay.menu = [UIMenu menuWithTitle:@"" children:actions];
    cell.ellipsisImageOverlay.showsMenuAsPrimaryAction = true;
    
}

-(void)SetUpHasAnAndroidButtonText {
    
    [_hasAndroidButton setTitle:[NSString stringWithFormat:@"Does one of your home members\nhave an Android? Click here"] forState:UIControlStateNormal];
    
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:_hasAndroidButton.currentTitleColor, NSForegroundColorAttributeName, nil];
    
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Does one of your home members\nhave an Android? Click here"] attributes:attrsDictionary];
    
    NSRange range0 = [[NSString stringWithFormat:@"%@", str] rangeOfString:@"Click here"];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.0f/255.0f green:122.0f/255.0f blue:255.0f/255.0f alpha:1.0f] range: NSMakeRange(range0.location, range0.length)];
    
    [_hasAndroidButton setAttributedTitle:str forState:UIControlStateNormal];
    
}

#pragma mark - UI Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
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

-(void)GenerateUpdatedTopLabel {
    
    if (_viewingWeDivvyPremiumAddingAccounts == NO && _viewingWeDivvyPremiumEditingAccounts == NO) {
        
        notificationTaskTypesTopLabel.hidden = YES;
        notificationTaskTypesTopLabelNo1.hidden = YES;
        
    } else if (_viewingWeDivvyPremiumAddingAccounts == NO && _viewingWeDivvyPremiumEditingAccounts == YES) {
        
        notificationTaskTypesTopLabelNo1.hidden = YES;
        
    }
    
    if ([self->_homeMembersDict[@"UserID"] containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]]) {
        
        NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] homeMembersDict:_homeMembersDict];
        
        NSMutableDictionary *weDivvyPremium = [dataDict[@"WeDivvyPremium"] mutableCopy];
        
        mySubscriptionPlan = weDivvyPremium[@"SubscriptionPlan"];
        NSString *startAmount = @"0";
        NSString *planAmount = @"1";
        
        if ([mySubscriptionPlan isEqualToString:@"Housemate Plan"]) {
            
            startAmount = @"2";
            planAmount = @"3";
            
        } else if ([mySubscriptionPlan isEqualToString:@"Family Plan"]) {
            
            startAmount = @"5";
            planAmount = @"6";
            
        }
        
        int amount = [startAmount intValue];
        
        for (NSDictionary *weDivvyPremiumDict in self->_homeMembersDict[@"WeDivvyPremium"]) {
            
            if ([weDivvyPremiumDict[@"SubscriptionGivenBy"] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]]) {
                amount -= 1;
            }
        }
        
        startAmount = [NSString stringWithFormat:@"%d", amount];
        
        topLabelString = [NSString stringWithFormat:@"Select which accounts you'd like to give WeDivvy Premium to. You have %@/%@ subscriptions available to give through your %@.", startAmount, planAmount, mySubscriptionPlan];
        
        notificationTaskTypesTopLabel.text = topLabelString;
        notificationTaskTypesTopLabelNo1.text = [NSString stringWithFormat:@"(You can always change this in the\nWeDivvy Premium Settings page)"];
        
        RanOutOfAccounts = [startAmount isEqualToString:@"0"] ? YES : NO;
        
        if (notificationTaskTypesTopLabel != nil && notificationTaskTypesTopLabel != NULL) {
            
            NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:notificationTaskTypesTopLabel.textColor, NSForegroundColorAttributeName, nil];
            
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:notificationTaskTypesTopLabel.text attributes:attrsDictionary];
            
            NSArray *arr = @[@"0/3", @"1/3", @"2/3", @"0/6", @"1/6", @"2/6", @"3/6", @"4/6", @"5/6"];
            NSArray *arr1 = @[@"Individual Plan", @"Housemate Plan", @"Family Plan"];
            
            NSRange range0 = [[NSString stringWithFormat:@"%@", str] rangeOfString:@""];
            NSRange range1 = [[NSString stringWithFormat:@"%@", str] rangeOfString:@""];
            
            for (NSString *innerStr in arr) {
                if ([notificationTaskTypesTopLabel.text containsString:[NSString stringWithFormat:@" %@ ", innerStr]]) {
                    range0 = [[NSString stringWithFormat:@"%@", str] rangeOfString:innerStr];
                    break;
                }
            }
            
            for (NSString *innerStr in arr1) {
                if ([notificationTaskTypesTopLabel.text containsString:[NSString stringWithFormat:@" %@.", innerStr]]) {
                    range1 = [[NSString stringWithFormat:@"%@", str] rangeOfString:innerStr];
                    break;
                }
            }
            
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:(self.view.frame.size.height*0.02038043 > 15?(15):self.view.frame.size.height*0.02038043) weight:UIFontWeightSemibold] range: NSMakeRange(range0.location, range0.length)];
            [str addAttribute:NSUnderlineStyleAttributeName
                        value:[NSNumber numberWithInt:1]
                        range: NSMakeRange(range0.location, range0.length)];
            
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:(self.view.frame.size.height*0.02038043 > 15?(15):self.view.frame.size.height*0.02038043) weight:UIFontWeightSemibold] range: NSMakeRange(range1.location, range1.length)];
            [str addAttribute:NSUnderlineStyleAttributeName
                        value:[NSNumber numberWithInt:1]
                        range: NSMakeRange(range1.location, range1.length)];
            
            notificationTaskTypesTopLabel.attributedText = str;
            
        }
        
    }
    
}

-(void)AssignedToAnybodyPopup {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Assigned to Anybody" message:@"This option assigns everybody to a task but does not require everyone to complete it."
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Got it!"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {}];
    
    [controller addAction:cancel];
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(void)AssignNewHomeMembersPopup {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Assign New Home Members" message:[NSString stringWithFormat:@"This option automatically assigns anyone that joins your home to this %@.", [itemType lowercaseString]] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Got it!"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {}];
    
    [controller addAction:cancel];
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(void)AdjustTableViewHeight {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGFloat width = CGRectGetWidth(self.view.bounds);
        CGFloat height = CGRectGetHeight(self.view.bounds);
        
        CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
        
        int alteredCells = 0;
        
        for (NSString *userID in self->_homeMembersDict[@"UserID"]) {
            
            if (self->_homeMembersUnclaimedDict[userID]) {
                
                alteredCells += 1;
                
            }
            
        }
        
        CGFloat textFieldSpacing = (height*0.024456);
        CGFloat tableViewHeight = self->usersCellHeight*([(NSArray *)self->_homeMembersDict[@"Username"] count] - alteredCells);
        
        tableViewHeight += self->unclaimedUsersCellHeight * alteredCells;
        
        CGFloat maxHeight = height - (self->_assignNewHomeMembersView.frame.origin.y + self->_assignNewHomeMembersView.frame.size.height + textFieldSpacing + textFieldSpacing);
        
        if (tableViewHeight > maxHeight) {
            tableViewHeight = maxHeight;
        }
        
        CGFloat yPos = self->_viewingWeDivvyPremiumAddingAccounts || self->_viewingWeDivvyPremiumEditingAccounts ? navigationBarHeight + textFieldSpacing : (self->_assignNewHomeMembersView.frame.origin.y + self->_assignNewHomeMembersView.frame.size.height) + textFieldSpacing;
        
        if (self->_viewingWeDivvyPremiumAddingAccounts) {
            
            yPos = self->notificationTaskTypesTopLabelNo1.frame.origin.y + self->notificationTaskTypesTopLabelNo1.frame.size.height + textFieldSpacing;
            
        } else if (self->_viewingWeDivvyPremiumEditingAccounts) {
            
            yPos = self->notificationTaskTypesTopLabel.frame.origin.y + self->notificationTaskTypesTopLabel.frame.size.height + textFieldSpacing;
            
        }
        
        self->_customTableView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), yPos, width*0.90338164, tableViewHeight);
        self->_addHomeMemberButton.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), self->_customTableView.frame.origin.y + self->_customTableView.frame.size.height, width*0.90338164, self->usersCellHeight);
        self->_hasAndroidButton.frame = CGRectMake(0, self->_addHomeMemberButton.frame.origin.y + self->_addHomeMemberButton.frame.size.height + 20, width, 32);
        
    } completion:^(BOOL finished) {
        
    }];
    
}

-(void)DisplayInviteHomeMembersPopup:(BOOL)Display {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGFloat width = CGRectGetWidth(self.view.bounds);
        CGFloat height = CGRectGetHeight(self.view.bounds);
        
        self->_inviteHomeMemberBackDropView.frame = CGRectMake(0, 0, width, height);
        self->_inviteHomeMemberBackDropView.alpha = Display ? 1.0 : 0.0;
        
        self->_inviteHomeMemberAlertView.frame = Display ? CGRectMake(0, height - ((height*0.33967391) > 250?(250):(height*0.33967391)), width, ((height*0.33967391) > 250?(250):(height*0.33967391))) : CGRectMake(0, height, width, ((height*0.33967391) > 250?(250):(height*0.33967391)));
        
    } completion:^(BOOL finished) {
        
    }];
    
}

#pragma mark - IBAction Methods

- (IBAction)AssignedToAnybodySwitch:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Assigned To Anybody Switch Turned %@ For %@", _assignedToAnybodySwitch.isOn == YES ? @"On" : @"Off", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self->_selectedArray = [NSMutableArray array];
        
        [self.customTableView reloadData];
        
    }];
    
}

- (IBAction)AssignedNewHomeMembersSwitch:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Assigned New Home Members Switch Turned %@ For %@", _assignNewHomeMembersSwitch.isOn == YES ? @"On" : @"Off", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
}

-(IBAction)SaveButtonAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Save Button Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    NSDictionary *dataDict = @{
        @"AssignedToUsername" : _selectedArray,
        @"AssignedToNewHomeMembers" : [_assignNewHomeMembersSwitch isOn] ? @"Yes" : @"No",
        @"AssignedToAnybody" : [_assignedToAnybodySwitch isOn] ? @"Yes" : @"No"};
    
    if (_viewingWeDivvyPremiumAddingAccounts == NO && _viewingWeDivvyPremiumEditingAccounts == NO) {
        
        if (_viewingChatMembers) {
            
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemAssignedTo" userInfo:dataDict locations:@[@"Chats", @"AddChat"]];
            
        } else {
            
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemAssignedTo" userInfo:dataDict locations:@[@"Tasks", @"AddTask", @"MultiAddTasks"]];
            
        }
        
    }
    
    //Update Local HomeMembersDict, Update Database Data For All Home Members
    //Send Notifications To Users Who Received Premium And Users Who Lost Premium
    if (_viewingWeDivvyPremiumAddingAccounts || _viewingWeDivvyPremiumEditingAccounts) {
        
        [self StartProgressView];
        
        [[[SetDataObject alloc] init] UpdateDataWeDivvyPremiumUsersSelected:self->_homeMembersDict oldHomeMembersDict:oldHomeMembersDict completionHandler:^(BOOL finished) {
            
            [[NSUserDefaults standardUserDefaults] setObject:self->_homeMembersDict forKey:@"HomeMembersDict"];
            
            [self->progressView setHidden:YES];
            
            [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewDidLoadShouldStart"];
            
            NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
            
            if ([itemType isEqualToString:@"Expense"]) {
                
                [[[PushObject alloc] init] PushToTasksNavigationController:NO Expenses:YES Lists:NO Animated:NO currentViewController:self];
                
            } else if ([itemType isEqualToString:@"List"]) {
                
                [[[PushObject alloc] init] PushToTasksNavigationController:NO Expenses:NO Lists:YES Animated:NO currentViewController:self];
                
            } else {
                
                [[[PushObject alloc] init] PushToTasksNavigationController:YES Expenses:NO Lists:NO Animated:NO currentViewController:self];
                
            }
            
        }];
        
    } else {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}

-(IBAction)AddHomeMember:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Add Home Member Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"New Home Member" message:@"Enter your new home members name"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Add"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *newName = controller.textFields[0].text;
        
        NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
        NSString *trimmedStringItemName = [newName stringByTrimmingCharactersInSet:charSet];
        
        if (trimmedStringItemName.length > 0) {
            
            if ([self->_homeMembersDict[@"Username"] containsObject:controller.textFields[0].text] == NO) {
                
                [self StartProgressView];
                
                
                
                NSString *inviteKey = [[[GeneralObject alloc] init] GenerateRandomSmallNumberIntoString:100000 upperBound:999999];
                __block NSString *inviteKeyExtraWithNumber = [NSString stringWithFormat:@"%@•••%@•••", inviteKey, [[[GeneralObject alloc] init] GenerateRandomSmallNumberIntoString:100 upperBound:999]];
                
                
                
                NSMutableDictionary *userDictLocal = [self AddHomeMember_GenerateUserDict:trimmedStringItemName];
                self->lastHomeMemberAddedUserDict = [self AddHomeMember_GenerateLastHomeMemberAddedUserDict:[userDictLocal mutableCopy] inviteKey:inviteKey inviteKeyExtraWithNumber:inviteKeyExtraWithNumber];
                
                NSString *newUserID = userDictLocal[@"UserID"] ? userDictLocal[@"UserID"] : @"";
                NSString *newUsername = userDictLocal[@"Username"] ? userDictLocal[@"Username"] : @"";
                
              
                
                [self AddHomeMember_UpdateSelectedArray:userDictLocal[@"Username"]];
                
                [self AddHomeMember_UpdateHomeMembersDict:userDictLocal];
                
                [self AddHomeMember_UpdateHomeDict:userDictLocal inviteKey:inviteKey inviteKeyExtraWithNumber:inviteKeyExtraWithNumber];
                
                [self AddHomeMember_LocalNotifications];
                
               
                
                __block int totalQueries = 4;
                __block int completedQueries = 0;
                
                
                
                /*
                 //
                 //
                 //Update Home Data
                 //
                 //
                 */
                [self AddHomeMember_UpdateHomeData:^(BOOL finished) {
                 
                    [self AddHomeMember_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
                        
                        [self AddHomeMember_UpdateAppDataWithNewHomeMember:newUserID];
                        
                        [self AddHomeMember_CompletionBlock:userDictLocal];
                        
                    }];
                    
                }];
                
                
                /*
                 //
                 //
                 //Set User Data
                 //
                 //
                 */
                [self AddHomeMember_SetUserData:userDictLocal selectedUserID:newUserID completionHandler:^(BOOL finished) {
                   
                    [self AddHomeMember_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
                        
                        [self AddHomeMember_UpdateAppDataWithNewHomeMember:newUserID];
                        
                        [self AddHomeMember_CompletionBlock:userDictLocal];
                        
                    }];
                    
                }];
                
                
                /*
                 //
                 //
                 //Update Data For New Home Member
                 //
                 //
                 */
                [self AddHomeMember_UpdateDataForNewHomeMember:newUserID completionHandler:^(BOOL finished) {
                   
                    [self AddHomeMember_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
                        
                        [self AddHomeMember_UpdateAppDataWithNewHomeMember:newUserID];
                        
                        [self AddHomeMember_CompletionBlock:userDictLocal];
                        
                    }];
                    
                }];
                
                
                /*
                 //
                 //
                 //Send Push Notifications To Existing Home Members
                 //
                 //
                 */
                [self AddHomeMember_SendPushNotificationsToExistingHomeMembers:newUsername completionHandler:^(BOOL finished) {
                   
                    [self AddHomeMember_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
                        
                        [self AddHomeMember_UpdateAppDataWithNewHomeMember:newUserID];
                        
                        [self AddHomeMember_CompletionBlock:userDictLocal];
                        
                    }];
                    
                }];
                
                
                
            } else {
                
                [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:[NSString stringWithFormat:@"A home member with the name, %@, already exists", controller.textFields[0].text] currentViewController:self];
                
            }
            
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

-(IBAction)AndroidButtonAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Android Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://forms.gle/rMsGtgYN1URpmVxe9"] options:@{} completionHandler:^(BOOL success) {
        
    }];
    
    [[[SetDataObject alloc] init] SetDataAndroid:^(BOOL finished) {
        
    }];
    
}

-(IBAction)InviteHomeMemberSubmitButtonAction:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"InviteHomeMemberAccepted"];
    
    [[[GeneralObject alloc] init] InvitingHomeMembersAcceptedPopup:^(BOOL finished) {
        
    }];
    
    [self StartProgressView];
    [self DisplayInviteHomeMembersPopup:NO];
    [self AddHomeMember_InviteHomeMember:lastHomeMemberAddedUserDict];
}

-(IBAction)TapGestureInviteHomeMemberClose:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Invite Others Reminder Popup Closed"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self->progressView setHidden:YES];
    [self->progressView setHidden:YES];
    [self DisplayInviteHomeMembersPopup:NO];
    [self AddHomeMember_UpdateAppDataWithNewHomeMember:lastHomeMemberAddedUserDict[@"UserID"]];
    //    [[[GeneralObject alloc] init] CreateAlert:@"❗️Important Reminder❗️" message:@"Don't forget to send your home member their invitation code or they won't be able to join your home." currentViewController:self];
    
}

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Table View Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    AssignedToCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AssignedToCell"];
    
    NSString *username = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexPath.row ? _homeMembersDict[@"Username"][indexPath.row] : @"";
    NSString *profileImageURL = _homeMembersDict && _homeMembersDict[@"ProfileImageURL"] && [(NSArray *)_homeMembersDict[@"ProfileImageURL"] count] > indexPath.row ? _homeMembersDict[@"ProfileImageURL"][indexPath.row] : @"";
    
    cell.usernameLabel.text = username;
    
    cell.subLabel.text = [self GenerateSubLabelText:indexPath];
    
    UIColor *backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:0.15f];
    UIColor *textColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    
    BOOL CustomProfileImageDoesNotExist = (profileImageURL == nil || profileImageURL.length == 0 || [profileImageURL containsString:@"(null)"] || [profileImageURL isEqualToString:@"xxx"] || [profileImageURL isEqualToString:@"XXX"] || [profileImageURL isEqualToString:@"https://firebasestorage.googleapis.com/v0/b/wedivvy-afe04.appspot.com/o/DefaultImages%2FdefaultProfileImage.png?alt=media&token=6892f430-8337-4327-89a4-53a403d1186c"] || [profileImageURL containsString:@"DefaultImage"]);
    
    if (CustomProfileImageDoesNotExist == YES) {
        
        [cell.profileImage setImageWithString:username color:backgroundColor circular:YES textAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Medium" size:cell.profileImage.frame.size.height*0.45], NSForegroundColorAttributeName:textColor}];
        
    } else {
        
        [cell.profileImage sd_setImageWithURL:[NSURL URLWithString:profileImageURL]];
        
    }
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return [(NSArray *)_homeMembersDict[@"Username"] count];
    
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(AssignedToCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BOOL ShowCompletedImage = NO;
    
    //Show checkmark for selected premium users
    if (_viewingWeDivvyPremiumAddingAccounts || _viewingWeDivvyPremiumEditingAccounts) {
        
        NSDictionary *dict = _homeMembersDict && _homeMembersDict[@"WeDivvyPremium"] && [(NSArray *)_homeMembersDict[@"WeDivvyPremium"] count] > indexPath.row ? _homeMembersDict[@"WeDivvyPremium"][indexPath.row] : [NSDictionary dictionary];
        
        if (dict[@"SubscriptionPlan"] && [dict[@"SubscriptionPlan"] length] > 0) {
            ShowCompletedImage = YES;
        }
        
    } else {
        
        BOOL UsernameIsSelected = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexPath.row ? [_selectedArray containsObject:self->_homeMembersDict[@"Username"][indexPath.row]] : NO;
        ShowCompletedImage = UsernameIsSelected;
        
    }
    
    cell.checkmarkImage.image = ShowCompletedImage == YES ? [UIImage systemImageNamed:@"checkmark"] : nil;
    
    
    
    
    CGFloat width = CGRectGetWidth(cell.contentView.bounds);
    CGFloat height = usersCellHeight;//CGRectGetHeight(cell.contentView.bounds);
    
    NSString *userID = _homeMembersDict && _homeMembersDict[@"UserID"] && [(NSArray *)_homeMembersDict[@"UserID"] count] > indexPath.row ? _homeMembersDict[@"UserID"][indexPath.row] : @"";
    
    cell.cautionImage.hidden = (self->_homeMembersUnclaimedDict[userID]) ? NO : YES;
    cell.subLabel.hidden = (self->_homeMembersUnclaimedDict[userID]) ? NO : YES;
    cell.ellipsisImage.hidden = (self->_homeMembersUnclaimedDict[userID]) ? NO : YES;
    cell.ellipsisImageOverlay.hidden = (self->_homeMembersUnclaimedDict[userID]) ? NO : YES;
    
    cell.cautionImage.tintColor = (self->_homeMembersUnclaimedDict[userID] && [self->_homeMembersUnclaimedDict[userID][@"InvitationSent"] isEqualToString:@"No"]) ? [UIColor systemPinkColor] : [UIColor systemYellowColor];
    
    if (self->_homeMembersUnclaimedDict[userID]) {
        
        cell.cautionImage.frame = CGRectMake(width*0.04830918 + (height*0.43859)*0.5 - (height*0.4)*0.5, height*0.5 - ((height*0.4)*0.5), height*0.4, height*0.4);
        cell.profileImage.frame = CGRectMake(cell.cautionImage.frame.origin.x + cell.cautionImage.frame.size.width + (width*0.04830918)*0.5, height*0.5 - ((height*0.5)*0.5), height*0.5, height*0.5);
        
    } else {
        
        cell.profileImage.frame = CGRectMake(width*0.04830918, height*0.5 - ((height*0.5)*0.5), height*0.5, height*0.5);
        
    }
    
    
    
    
    if (self->_homeMembersUnclaimedDict[userID]) {
        
        cell.usernameLabel.frame = CGRectMake(cell.profileImage.frame.origin.x + cell.profileImage.frame.size.width + ((width*0.04278075)*0.5), height*0.14035, width*0.772727, height*0.350878);
        cell.subLabel.frame = CGRectMake(cell.usernameLabel.frame.origin.x, height - cell.usernameLabel.frame.size.height - height*0.14035, cell.usernameLabel.frame.size.width, cell.usernameLabel.frame.size.height);
        
    } else {
        
        cell.usernameLabel.frame = CGRectMake(cell.profileImage.frame.origin.x + cell.profileImage.frame.size.width + (width*0.01932367), height*0.5 - ((height*0.350878)*0.5), width*0.772727, height*0.350878);
        
    }
    
    
    
    
    CGFloat bellHeight = height*0.35;
    
    cell.ellipsisImage.frame = CGRectMake((width*1 - height*0.5 - width*0.04830918) + (height*0.5)*0.5 - bellHeight*0.5, height*0.5 - ((bellHeight)*0.5), ((bellHeight)), bellHeight);
    
    if (self->_homeMembersUnclaimedDict[userID]) {
        CGRect newRect = cell.ellipsisImage.frame;
        newRect.origin.y = unclaimedUsersCellHeight*0.5 - ((bellHeight)*0.5);
        cell.ellipsisImage.frame = newRect;
    }
    
    cell.ellipsisImageOverlay.frame = CGRectMake(cell.ellipsisImage.frame.origin.x - (width*0.026738), cell.ellipsisImage.frame.origin.y - (width*0.026738), cell.ellipsisImage.frame.size.width + ((width*0.026738)*2), cell.ellipsisImage.frame.size.height + ((width*0.026738)*2));
    cell.ellipsisImage.image = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [UIImage imageNamed:@"GeneralIcons.Ellipsis.White"] : [UIImage imageNamed:@"GeneralIcons.Ellipsis"];
    
    
    
    
    if (self->_homeMembersUnclaimedDict[userID]) {
        
        cell.checkmarkImage.frame = CGRectMake(width*1 - (width - cell.ellipsisImage.frame.origin.x) - height*0.5 - (width*0.04830918)*0.5, unclaimedUsersCellHeight*0.5 - ((height*0.5)*0.5), height*0.5, height*0.5);
        cell.lockImage.frame = CGRectMake(cell.checkmarkImage.frame.origin.x + (cell.checkmarkImage.frame.size.width*0.5 - (cell.usernameLabel.frame.size.height*0.7)*0.5), 0, cell.usernameLabel.frame.size.height*0.7, height);
        
    } else {
        
        cell.checkmarkImage.frame = CGRectMake(width*1 - height*0.5 - cell.profileImage.frame.origin.x, height*0.5 - ((height*0.5)*0.5), height*0.5, height*0.5);
        cell.lockImage.frame = CGRectMake(cell.ellipsisImage.frame.origin.x + (cell.ellipsisImage.frame.size.width*0.5 - (cell.usernameLabel.frame.size.height*0.7)*0.5), 0, cell.usernameLabel.frame.size.height*0.7, height);
        
    }
    
    
    
    
    cell.usernameLabel.font = [UIFont systemFontOfSize:cell.usernameLabel.frame.size.height*0.75 weight:UIFontWeightSemibold];
    cell.subLabel.font = [UIFont systemFontOfSize:cell.subLabel.frame.size.height*0.65 weight:UIFontWeightSemibold];
    cell.usernameLabel.adjustsFontSizeToFitWidth = YES;
    
    CGFloat widthOfItemLabel = [[[GeneralObject alloc] init] WidthOfString:cell.usernameLabel.text withFont:cell.usernameLabel.font];
    CGFloat widthOfCompletedLabel = [[[GeneralObject alloc] init] WidthOfString:cell.subLabel.text withFont:cell.subLabel.font];
    
    CGRect newRect = cell.usernameLabel.frame;
    newRect.size.width = widthOfItemLabel;
    cell.usernameLabel.frame = newRect;
    
    CGFloat maxHeight = cell.checkmarkImage.image != nil && cell.checkmarkImage.hidden == NO ?
    cell.contentView.frame.size.width - (cell.subLabel.frame.origin.x + ((width*0.04278075)*3) + cell.ellipsisImage.frame.size.width + cell.checkmarkImage.frame.size.width) :
    cell.contentView.frame.size.width - (cell.subLabel.frame.origin.x + ((width*0.04278075)*2) + cell.ellipsisImage.frame.size.width);
    
    newRect = cell.subLabel.frame;
    newRect.size.width = widthOfCompletedLabel > maxHeight ? maxHeight : widthOfCompletedLabel;
    newRect.size.height = widthOfCompletedLabel > maxHeight ? newRect.size.height*2 : newRect.size.height;
    cell.subLabel.frame = newRect;
    
    
    
    
    cell.premiumImage.frame = CGRectMake(cell.usernameLabel.frame.origin.x + cell.usernameLabel.frame.size.width + 6, cell.usernameLabel.frame.origin.y, cell.usernameLabel.frame.size.height*0.7, cell.usernameLabel.frame.size.height);
    
    BOOL PremiumSubscriptionIsActiveForSpecificUserAtIndex = [[[BoolDataObject alloc] init] PremiumSubscriptionIsActiveForSpecificUserAtIndex:self->_homeMembersDict userID:userID];
    
    cell.premiumImage.hidden = PremiumSubscriptionIsActiveForSpecificUserAtIndex ? NO : YES;
    
    
    
    
    //Show lock image for purchasing user or users given subscription by someone who is not the purchasing user, and show completed image for users selected by purchasing user
    if (_viewingWeDivvyPremiumAddingAccounts || _viewingWeDivvyPremiumEditingAccounts) {
        
        NSDictionary *weDivvyPremium = [(NSArray *)self->_homeMembersDict[@"WeDivvyPremium"] count] > indexPath.row ? self->_homeMembersDict[@"WeDivvyPremium"][indexPath.row] : [[[[GeneralObject alloc] init] GenerateDefaultWeDivvyPremiumPlan] mutableCopy];
        
        BOOL UserHasSubscriptionPlan = [weDivvyPremium[@"SubscriptionPlan"] isEqualToString:@""] == NO;
        BOOL UserPurchasedSubscriptionPlan = [weDivvyPremium[@"SubscriptionDatePurchased"] isEqualToString:@""] == NO;
        BOOL UserWasGivenSubscriptionPlan = [weDivvyPremium[@"SubscriptionGivenBy"] isEqualToString:@""] == NO;
        BOOL UserWasGivenSubscriptionPlanByMe = [weDivvyPremium[@"SubscriptionGivenBy"] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
        
        BOOL SubscriptionPlanPurchsedByMe =
        UserHasSubscriptionPlan == YES &&
        UserPurchasedSubscriptionPlan == YES &&
        [userID isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] == YES;
        
        BOOL SubscriptionPlanPurchsedBySomeoneElse =
        UserHasSubscriptionPlan == YES &&
        (UserPurchasedSubscriptionPlan == YES ||
         (UserWasGivenSubscriptionPlan == YES && UserWasGivenSubscriptionPlanByMe == NO)) &&
        [userID isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] == NO;
        
        if (SubscriptionPlanPurchsedBySomeoneElse == YES || SubscriptionPlanPurchsedByMe == YES) {
            
            cell.lockImage.hidden = NO;
            cell.checkmarkImage.hidden = YES;
            
        } else {
            
            cell.lockImage.hidden = YES;
            cell.checkmarkImage.hidden = NO;
            
        }
        
    } else {
        
        cell.lockImage.hidden = YES;
        
    }
    
    
    
    
    [self SetUpItemViewContextMenu:cell indexPath:indexPath];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_viewingItemDetails == NO) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Did Select User %@ For %@", self->_homeMembersDict[@"Username"][indexPath.row], [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        //Generate an updated HomeMembersDict, WeDivvy Premium Array, Specific WeDivvy Premium Dict for each user selected/unselected.
        //We'll loop through this data later when user clicks "Save" in order to store each users WeDivvy Premium Dict locally and in database
        if (_viewingWeDivvyPremiumAddingAccounts || _viewingWeDivvyPremiumEditingAccounts) {
            
            [self DidSelectPremiumAccount:indexPath];
            
        }
        
        
        
        
        BOOL UsernameIsSelected = [_selectedArray containsObject:self->_homeMembersDict[@"Username"][indexPath.row]];
        
        if (UsernameIsSelected == YES) {
            
            if (_homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexPath.row) {
                
                [_selectedArray removeObject:self->_homeMembersDict[@"Username"][indexPath.row]];
                
            }
            
        } else {
            
            if (_homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexPath.row) {
                
                if ([self->_selectedArray containsObject:self->_homeMembersDict[@"Username"][indexPath.row]] == NO) {
                    
                    [_selectedArray addObject:self->_homeMembersDict[@"Username"][indexPath.row]];
                    
                }
                
            }
            
        }
        
        [_assignedToAnybodySwitch setOn:NO];
        
        if ([_selectedArray containsObject:@"Anybody"]) {
            
            [_selectedArray removeObject:@"Anybody"];
            
        }
        
        [self.customTableView reloadData];
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *userID = _homeMembersDict && _homeMembersDict[@"UserID"] && [(NSArray *)_homeMembersDict[@"UserID"] count] > indexPath.row ? _homeMembersDict[@"UserID"][indexPath.row] : @"";
    
    if (self->_homeMembersUnclaimedDict[userID]) {
        
        return unclaimedUsersCellHeight;
        
    }
    
    return usersCellHeight;
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark SetUp Methods

-(UIAction *)SendInvitationContextMenuAction:(NSIndexPath *)indexPath {
    
    UIAction *action = [UIAction actionWithTitle:@"Send Invitation" image:[UIImage systemImageNamed:@"paperplane"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Send Invitation Clicked"] completionHandler:^(BOOL finished) {
            
        }];
        
        
        
        NSString *inviteKey = [[[GeneralObject alloc] init] GenerateRandomSmallNumberIntoString:100000 upperBound:999999];
        __block NSString *inviteKeyExtraWithNumber = inviteKeyExtraWithNumber = [NSString stringWithFormat:@"%@•••%@•••", inviteKey, [[[GeneralObject alloc] init] GenerateRandomSmallNumberIntoString:100 upperBound:999]];
        
        NSString *body = [NSString stringWithFormat:@"Hey %@, here's an invitation code to join my home - %@ 🏠🔐", self->_homeMembersDict[@"Username"][indexPath.row], inviteKey];
        
        NSArray* dataToShare = @[body, [NSURL URLWithString:@"https://apps.apple.com/us/app/wedivvy/id1570700094"]];
        UIActivityViewController* activityViewController =[[UIActivityViewController alloc] initWithActivityItems:dataToShare applicationActivities:nil];
        [activityViewController setValue:@"Invitation From a Friend" forKey:@"subject"];
        activityViewController.excludedActivityTypes = @[UIActivityTypeAirDrop];
        
        [activityViewController setCompletionWithItemsHandler:^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError) {
            
            NSArray *dontAccept = @[@"com.apple.UIKit.activity.CopyToPasteboard", @"com.apple.DocumentManagerUICore.SaveToFiles"];
            
            if (completed && [dontAccept containsObject:activityType] == NO) {
                
            }
            
        }];
        
        [self presentViewController:activityViewController animated:YES completion:^{}];
        
    }];
    
    return action;
}

-(UIAction *)ResendInvitationContextMenuAction:(NSIndexPath *)indexPath {
    
    UIAction *action = [UIAction actionWithTitle:@"Send Invitation" image:[UIImage systemImageNamed:@"paperplane"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Resend Invitation Clicked"] completionHandler:^(BOOL finished) {
            
        }];
        
        NSString *selectedUserID = self->_homeMembersDict && self->_homeMembersDict[@"UserID"] && [(NSArray *)self->_homeMembersDict[@"UserID"] count] > indexPath.row ? self->_homeMembersDict[@"UserID"][indexPath.row] : @"";
        NSMutableDictionary *tempHomeMembersUnclaimedDictLocalInnerDict = [self GenerateHomeMembersUnclaimedDictForSpecificUser:indexPath selectedUserID:selectedUserID];
        NSString *unclaimedInvitation = tempHomeMembersUnclaimedDictLocalInnerDict && tempHomeMembersUnclaimedDictLocalInnerDict[@"InvitationSent"] ? tempHomeMembersUnclaimedDictLocalInnerDict[@"InvitationSent"] : @"";
        NSString *unclaimedInvitationWithDotsRemoved = [self GenerateInviteKeyWithDotsRemoved:unclaimedInvitation];
        
        NSString *body = [NSString stringWithFormat:@"Hey %@, here's an invitation code to join my home - %@ 🏠🔐", self->_homeMembersDict[@"Username"][indexPath.row], unclaimedInvitationWithDotsRemoved];
        
        NSArray* dataToShare = @[body, [NSURL URLWithString:@"https://apps.apple.com/us/app/wedivvy/id1570700094"]];
        UIActivityViewController* activityViewController =[[UIActivityViewController alloc] initWithActivityItems:dataToShare applicationActivities:nil];
        [activityViewController setValue:@"Invitation From a Friend" forKey:@"subject"];
        activityViewController.excludedActivityTypes = @[UIActivityTypeAirDrop];
        
        [activityViewController setCompletionWithItemsHandler:^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError) {
            
            NSArray *dontAccept = @[@"com.apple.UIKit.activity.CopyToPasteboard", @"com.apple.DocumentManagerUICore.SaveToFiles"];
            
            if (completed && [dontAccept containsObject:activityType] == NO) {
                
                [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Invite Roommates Completed"] completionHandler:^(BOOL finished) {
                    
                }];
                
            }
            
        }];
        
        [self presentViewController:activityViewController animated:YES completion:^{}];
        
    }];
    
    return action;
}

-(UIAction *)CopyKeyContextMenuAction:(NSIndexPath *)indexPath {
    
    UIAction *action = [UIAction actionWithTitle:@"Copy Invitation Code" image:[UIImage systemImageNamed:@"key"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Edit Invitation Clicked"] completionHandler:^(BOOL finished) {
            
        }];
        
        NSString *selectedUserID = self->_homeMembersDict && self->_homeMembersDict[@"UserID"] && [(NSArray *)self->_homeMembersDict[@"UserID"] count] > indexPath.row ? self->_homeMembersDict[@"UserID"][indexPath.row] : @"";
        NSMutableDictionary *tempHomeMembersUnclaimedDictLocalInnerDict = [self GenerateHomeMembersUnclaimedDictForSpecificUser:indexPath selectedUserID:selectedUserID];
        NSString *unclaimedInvitationKey = tempHomeMembersUnclaimedDictLocalInnerDict && tempHomeMembersUnclaimedDictLocalInnerDict[@"InvitationSent"] ? tempHomeMembersUnclaimedDictLocalInnerDict[@"InvitationSent"] : @"";
        NSString *unclaimedUsername = tempHomeMembersUnclaimedDictLocalInnerDict && tempHomeMembersUnclaimedDictLocalInnerDict[@"Username"] ? tempHomeMembersUnclaimedDictLocalInnerDict[@"Username"] : @"";
        NSString *unclaimedInvitationWithDotsRemoved = [self GenerateInviteKeyWithDotsRemoved:unclaimedInvitationKey];
        
        UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
        [pasteBoard setString:unclaimedInvitationWithDotsRemoved];
        
        NSString *message = [NSString stringWithFormat:@"%@'s invitation code, %@, was copied!", unclaimedUsername, unclaimedInvitationWithDotsRemoved];
        
        [[[GeneralObject alloc] init] CreateAlert:@"Copied!" message:message currentViewController:self];
        
    }];
    
    return action;
}

-(UIAction *)EditMemberNameContextMenuAction:(NSIndexPath *)indexPath {
    
    UIAction *action = [UIAction actionWithTitle:@"Edit" image:[UIImage systemImageNamed:@"pencil"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Edit Invitation Clicked"] completionHandler:^(BOOL finished) {
            
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
                
                
                NSString *selectedUserID =
                self->_homeMembersDict &&
                self->_homeMembersDict[@"UserID"] &&
                [(NSArray *)self->_homeMembersDict[@"UserID"] count] > indexPath.row ?
                self->_homeMembersDict[@"UserID"][indexPath.row] : @"";
                
                NSString *selectedUsername = controller.textFields[0].text;
                
                
                
                [self EditHomeMember_UpdateSelectedArray:selectedUsername];
                
                [self EditHomeMember_UpdateHomeMembersDict:selectedUsername selectedUserID:selectedUserID];
                
                [self EditHomeMember_UpdateHomeDict:selectedUsername selectedUserID:selectedUserID];
                
                [self AddHomeMember_UpdateAppDataWithNewHomeMember:@""];
                
                [[[GeneralObject alloc] init] CheckPremiumSubscriptionStatus:self->_homeMembersDict completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningHomeMembersDict) {
                    
                }];
                
                
                
                __block int totalQueries = 2;
                __block int completedQueries = 0;
                
                
                
                /*
                 //
                 //
                 //Update Home Data
                 //
                 //
                 */
                [self AddHomeMember_UpdateHomeData:^(BOOL finished) {
                   
                    [self AddHomeMember_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
                        
                    }];
                    
                }];
                
                
                /*
                 //
                 //
                 //Set User Data
                 //
                 //
                 */
                [self EditHomeMember_UpdateUserData:@{@"Username" : controller.textFields[0].text} selectedUserID:selectedUserID completionHandler:^(BOOL finished) {
                    
                    [self AddHomeMember_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
                        
                    }];
                    
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

-(UIAction *)DeleteMemberContextMenuAction:(NSIndexPath *)indexPath {
    
    UIAction *action = [UIAction actionWithTitle:@"Delete" image:[UIImage systemImageNamed:@"trash"] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Delete Invitation Clicked"] completionHandler:^(BOOL finished) {
            
        }];
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Deleting this home member will remove them from all chores, expenses, lists, and group chats" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        NSString *actionTitle = @"Delete Home Member";
        
        UIAlertAction *completeUncompleteAction = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self StartProgressView];
            
            
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Deleting Invitation"] completionHandler:^(BOOL finished) {
                
            }];
            
            
            
            NSString *selectedUserID = self->_homeMembersDict[@"UserID"] && [(NSArray *)self->_homeMembersDict[@"UserID"] count] > indexPath.row ? self->_homeMembersDict[@"UserID"][indexPath.row] : @"";
            NSString *selectedUsername = self->_homeMembersDict[@"Username"] && [(NSArray *)self->_homeMembersDict[@"Username"] count] > indexPath.row ? self->_homeMembersDict[@"Username"][indexPath.row] : @"";
            
          
            
            [self DeleteHomeMember_UpdateSelectedArray:selectedUsername];
            
            [self DeleteHomeMember_UpdateHomeMembersDict:selectedUserID];
            
            [self DeleteHomeMember_UpdateHomeDict:selectedUserID];
            
            [self AddHomeMember_LocalNotifications];
            
            
            
            __block int totalQueries = 3;
            __block int completedQueries = 0;
            
            
            
            /*
             //
             //
             //Update Home Data
             //
             //
             */
            [self AddHomeMember_UpdateHomeData:^(BOOL finished) {
                
                [self AddHomeMember_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
                    
                    [self AddHomeMember_UpdateAppDataWithNewHomeMember:@""];
                    
                }];
                
            }];
            
            
            /*
             //
             //
             //Delete User Data
             //
             //
             */
            [self DeleteHomeMember_DeleteUserData:selectedUserID completionHandler:^(BOOL finished) {
                
                [self AddHomeMember_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
                    
                    [self AddHomeMember_UpdateAppDataWithNewHomeMember:@""];
                    
                }];
                
            }];
            
            
            /*
             //
             //
             //Update Item Data (ItemTurnUserID)
             //
             //
             */
            [self DeleteHomeMember_UpdateItemData_ItemTurnUserID:selectedUserID completionHandler:^(BOOL finished) {
                
                [self AddHomeMember_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
                    
                    [self AddHomeMember_UpdateAppDataWithNewHomeMember:@""];
                    
                }];
                
            }];
            
            
            /*
             //
             //
             //Send Push Notifications To Existing Home Members
             //
             //
             */
            [self DeleteHomeMember_SendPushNotificationsToExistingHomeMembers:selectedUsername completionHandler:^(BOOL finished) {
                
                [self AddHomeMember_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
                   
                    [self AddHomeMember_UpdateAppDataWithNewHomeMember:@""];
                    
                }];
                
            }];
            
            
        }];
        
        [completeUncompleteAction setValue:[UIColor systemRedColor] forKey:@"titleTextColor"];
        
        [actionSheet addAction:completeUncompleteAction];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Move Out Cancelled"] completionHandler:^(BOOL finished) {
                
            }];
            
        }]];
        
        [self presentViewController:actionSheet animated:YES completion:nil];
        
    }];
    
    return action;
}

#pragma mark - UX Methods
#pragma mark QueryInitialData

-(NSMutableDictionary *)GenerateHomeMembersUnclaimedDictForSpecificUser:(NSIndexPath *)indexPath selectedUserID:(NSString *)selectedUserID {
    
    NSMutableDictionary *tempHomeMembersUnclaimedDictLocal = [_homeMembersUnclaimedDict mutableCopy];
    
    NSUInteger index = [[tempHomeMembersUnclaimedDictLocal allKeys] containsObject:selectedUserID] ? [[tempHomeMembersUnclaimedDictLocal allKeys] indexOfObject:selectedUserID] : -1;
    NSString *keyToUse = [[tempHomeMembersUnclaimedDictLocal allKeys] count] > index ? [tempHomeMembersUnclaimedDictLocal allKeys][index] : @"";
    NSMutableDictionary *tempHomeMembersUnclaimedDictLocalInnerDict = tempHomeMembersUnclaimedDictLocal[keyToUse] ? [tempHomeMembersUnclaimedDictLocal[keyToUse] mutableCopy] : [NSMutableDictionary dictionary];
    
    return tempHomeMembersUnclaimedDictLocalInnerDict;
}

-(NSString *)GenerateInviteKeyWithDotsRemoved:(NSString *)invitationCode {
    
    NSString *homeKeyWithDotsRemoved = invitationCode;
    
    if ([homeKeyWithDotsRemoved containsString:@"•••"]) {
        homeKeyWithDotsRemoved = [homeKeyWithDotsRemoved componentsSeparatedByString:@"•••"][0];
    }
    
    return homeKeyWithDotsRemoved;
}

#pragma mark - IBAction Methods
#pragma mark AddHomeMember

-(NSMutableDictionary *)AddHomeMember_GenerateUserDict:(NSString *)newName {
    
    NSString *mixPanelID = @""; //[[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString]
    NSString *userID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    NSString *userEmail = @"";
    NSString *username = newName;
    NSString *receiveEmails = @"Yes";
    
    NSMutableDictionary *userDictLocal = [@{
        
        @"UserID": userID ? userID : @"",
        @"Email": userEmail ? userEmail : @"",
        @"Username": username ? username : @"",
        @"ProfileImageURL" : @"https://firebasestorage.googleapis.com/v0/b/wedivvy-afe04.appspot.com/o/DefaultImages%2FdefaultProfileImage.png?alt=media&token=6892f430-8337-4327-89a4-53a403d1186c",
        @"MixPanelID" : mixPanelID ? mixPanelID : @"",
        @"HeardAboutUs" : @"xxx",
        @"Notifications" : @"No",
        @"ReceiveUpdateEmails" : receiveEmails ? receiveEmails : @"Yes",
        @"WeDivvyPremium" : [[[GeneralObject alloc] init] GenerateDefaultWeDivvyPremiumPlan]
        
    } mutableCopy];
    
    return userDictLocal;
}


-(NSMutableDictionary *)AddHomeMember_GenerateLastHomeMemberAddedUserDict:(NSMutableDictionary *)userDictLocal inviteKey:(NSString *)inviteKey inviteKeyExtraWithNumber:(NSString *)inviteKeyExtraWithNumber {
    
    NSMutableDictionary *lastHomeMemberAddedUserDict = userDictLocal;
    
    [lastHomeMemberAddedUserDict setObject:inviteKey forKey:@"InviteKey"];
    [lastHomeMemberAddedUserDict setObject:inviteKeyExtraWithNumber forKey:@"InviteKeyWithExtraNumbers"];
    
    return lastHomeMemberAddedUserDict;
}

-(void)AddHomeMember_UpdateSelectedArray:(NSString *)selectedUsername {
    
    //Update SelectedArray
    if ([self->_selectedArray containsObject:selectedUsername] == NO) {
        
        [self->_selectedArray addObject:selectedUsername];
        
    }
    
}

-(void)AddHomeMember_UpdateHomeMembersDict:(NSDictionary *)userDictLocal {
    
    //Update Home Members Dict With New UsersDict Data
    NSArray *keyArray = [[[GeneralObject alloc] init] GenerateUserKeyArray];
    
    for (NSString *key in keyArray) {
        
        NSMutableArray *updatedArray = self->_homeMembersDict[key] ? [self->_homeMembersDict[key] mutableCopy] : [NSMutableArray array];
        [updatedArray addObject:userDictLocal[key]];
        [self->_homeMembersDict setObject:updatedArray forKey:key];
        
    }
    
}

-(void)AddHomeMember_UpdateHomeDict:(NSMutableDictionary *)userDictLocal inviteKey:(NSString *)inviteKey inviteKeyExtraWithNumber:(NSString *)inviteKeyExtraWithNumber {
    
    NSMutableArray *homeMembersArray = [self->_homeMembersArray mutableCopy];
    NSMutableDictionary *homeMembersUnclaimedDict = [self->_homeMembersUnclaimedDict mutableCopy];
    
    //Update Home Members Array With New UsersDict Data
    [homeMembersArray addObject:userDictLocal[@"UserID"]];
    self->_homeMembersArray = [homeMembersArray mutableCopy];
    
    //Update Home Members Unclaimed Dict With New UsersDict Data
    [homeMembersUnclaimedDict setObject:@{@"UserID" : userDictLocal[@"UserID"], @"Username" : userDictLocal[@"Username"], @"CreatedBy" : [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], @"InvitationSent" : @"No", @"ViewController" : @"ViewAssignedTo"} forKey:userDictLocal[@"UserID"]];
    self->_homeMembersUnclaimedDict = [homeMembersUnclaimedDict mutableCopy];
    
    
    
    NSMutableDictionary *tempHomeKeysDictLocal = [self->_homeKeysDict mutableCopy];
    NSMutableArray *tempHomeKeysArrayLocal = [self->_homeKeysArray mutableCopy];
    
    NSString *currentDateString = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy hh:mm a" returnAs:[NSString class]];
    
    tempHomeKeysDictLocal = [self->_homeKeysDict mutableCopy];
    tempHomeKeysArrayLocal = [self->_homeKeysArray mutableCopy];
    
    [tempHomeKeysDictLocal setObject:@{@"DateSent" : currentDateString, @"DateUsed" : @"", @"MemberName" : userDictLocal[@"Username"], @"SentBy" : [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], @"ViewController" : @"ViewAssignedTo"} forKey:inviteKeyExtraWithNumber];
    [tempHomeKeysArrayLocal addObject:inviteKey];
    
    self->_homeKeysDict = [tempHomeKeysDictLocal mutableCopy];
    self->_homeKeysArray = [tempHomeKeysArrayLocal mutableCopy];
    
    
    
    homeMembersUnclaimedDict = [self->_homeMembersUnclaimedDict mutableCopy];
    NSMutableDictionary *tempDict = [homeMembersUnclaimedDict[userDictLocal[@"UserID"]] mutableCopy];
    [tempDict setObject:inviteKeyExtraWithNumber forKey:@"InvitationSent"];
    [homeMembersUnclaimedDict setObject:tempDict forKey:userDictLocal[@"UserID"]];
    self->_homeMembersUnclaimedDict = [homeMembersUnclaimedDict mutableCopy];
    
}

-(void)AddHomeMember_LocalNotifications {
    
    [[[NotificationsObject alloc] init] SendLocalNotificationHomeMemberNoInvitationNotification_LocalOnly:self->_homeKeysDict homeMembersUnclaimedDict:self->_homeMembersUnclaimedDict completionHandler:^(BOOL finished) {
        
    }];
    
    [[[NotificationsObject alloc] init] SendLocalNotificationHomeMemberHasNotJoinedNotification_LocalOnly:self->_homeKeysDict homeMembersUnclaimedDict:self->_homeMembersUnclaimedDict completionHandler:^(BOOL finished) {
        
    }];
    
}

-(void)AddHomeMember_CompletionBlock:(NSDictionary *)userDictLocal {
 
    NSString *username = userDictLocal[@"Username"] ? userDictLocal[@"Username"] : @"";
    
    if ([self->_selectedArray containsObject:username] == NO) {
        [self->_selectedArray addObject:username];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"InviteHomeMemberAccepted"] &&
        [[[NSUserDefaults standardUserDefaults] objectForKey:@"InviteHomeMemberAccepted"] isEqualToString:@"Yes"]) {
        
        [self AddHomeMember_InviteHomeMember:userDictLocal];
        
    } else {
       
        [self->progressView setHidden:YES];
        
        [[[GeneralObject alloc] init] InvitingHomeMembersPopup:^(BOOL finished) {
            
            [self DisplayInviteHomeMembersPopup:YES];
            
        }];
        
    }

    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    NSDictionary *dataDict = @{@"HomeID" : homeID, @"HomeMembers" : self->_homeMembersArray, @"HomeKeys" : self->_homeKeysDict, @"HomeKeysArray" : self->_homeKeysArray, @"HomeMembersUnclaimed" : self->_homeMembersUnclaimedDict};
    
    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"EditHome" userInfo:dataDict locations:@[@"Homes"]];
    
}

-(void)AddHomeMember_CompletionBlock:(int)totalQueries completedQueries:(int)completedQueries completionHandler:(void (^)(BOOL finished))finishBlock {
    
    if (totalQueries == completedQueries) {
       
        finishBlock(YES);
        
    }
    
}

#pragma mark

-(void)AddHomeMember_UpdateHomeData:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        NSDictionary *dataDict = @{@"HomeKeys" : self->_homeKeysDict, @"HomeKeysArray" : self->_homeKeysArray, @"HomeMembersUnclaimed" : self->_homeMembersUnclaimedDict, @"HomeMembers" : self->_homeMembersArray};
        
        [[[SetDataObject alloc] init] UpdateDataHome:homeID homeDict:dataDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)AddHomeMember_SetUserData:(NSDictionary *)userDictLocal selectedUserID:(NSString *)selectedUserID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] SetDataUserData:selectedUserID userDict:userDictLocal completionHandler:^(BOOL finished, NSError * _Nonnull error) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)AddHomeMember_UpdateDataForNewHomeMember:(NSString *)selectedUserID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        [[[HomesViewControllerObject alloc] init] UserJoiningHome_UpdateDataForNewHomeMemberLocal:homeID userToAdd:selectedUserID homeMembersDict:self->_homeMembersDict notificationSettingsDict:self->_notificationSettingsDict topicDict:self->_topicDict clickedUnclaimedUser:NO QueryAssignedToNewHomeMember:YES QueryAssignedTo:NO queryAssignedToUserID:@"" ResetNotifications:NO completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)AddHomeMember_SendPushNotificationsToExistingHomeMembers:(NSString *)selectedUsername completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                       SkippingTurn:NO RemovingUser:NO
                                                                                                     FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                            DueDate:NO Reminder:NO
                                                                                                     SubtaskEditing:NO SubtaskDeleting:NO
                                                                                                   SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                     AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                                EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                                  GroupChatMessages:NO LiveSupportMessages:NO
                                                                                                 SendingInvitations:YES DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                                FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                           itemType:@"HomeMembers"];
        
        
        
        NSString *someoneString = [selectedUsername length] > 0 && selectedUsername != nil && [selectedUsername containsString:@"(null)"] == NO ? selectedUsername : @"someone";
        
        NSString *notificationTitle = [NSString stringWithFormat:@"Home Member Added 🏠"];
        NSString *notificationBody = [NSString stringWithFormat:@"%@ added %@ to your home! 🏠", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"], someoneString];
        
        
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        NSString *homeName = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeName"] : @"xxx";
        NSMutableArray *userIDArray = [self->_homeMembersArray mutableCopy];
        
        
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Homes:userIDArray
                                           viewingHomeMembersFromHomesViewController:NO homeID:homeID homeName:homeName homeMembersDict:nil notificationSettingsDict:self->_notificationSettingsDict notificationItemType:@"HomeMembers" notificationType:notificationType
                                                                           topicDict:self->_topicDict
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                        RemoveUsersNotInHome:YES
                                                                  completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

#pragma mark

-(void)AddHomeMember_InviteHomeMember:(NSDictionary *)userDictLocal {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString *inviteKey = userDictLocal[@"InviteKey"];
        
        NSString *body = [NSString stringWithFormat:@"Hey %@, here's an invitation code to join my home - %@ 🏠🔐", userDictLocal[@"Username"], inviteKey];
        
        NSArray* dataToShare = @[body, [NSURL URLWithString:@"https://apps.apple.com/us/app/wedivvy/id1570700094"]];
        
        UIActivityViewController* activityViewController = [[UIActivityViewController alloc] initWithActivityItems:dataToShare applicationActivities:nil];
        [activityViewController setValue:@"Invitation From a Friend" forKey:@"subject"];
        activityViewController.excludedActivityTypes = @[UIActivityTypeAirDrop];
        
        [activityViewController setCompletionWithItemsHandler:^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError) {
            
            [self->progressView setHidden:YES];
            
            
            
            
            
            
            
            NSArray *dontAccept = @[@"com.apple.UIKit.activity.CopyToPasteboard", @"com.apple.DocumentManagerUICore.SaveToFiles"];
            
            if (completed && [dontAccept containsObject:activityType] == NO) {
                
            } else {
                
                [[[GeneralObject alloc] init] AddingHomeMembersMessage:^(BOOL finished) {
                    
                    [self DisplayAlertView:NO backDropView:self->_inviteHomeMemberBackDropView alertViewNoButton:nil alertViewYesButton:nil];
                    
                    [[[GeneralObject alloc] init] CreateAlert:@"❗️Important Reminder❗️" message:@"Don't forget to send your home member their invitation code or they won't be able to join your home." currentViewController:self];
                    
                }];
                
            }
            
        }];
        
        [self presentViewController:activityViewController animated:YES completion:^{}];
        
    });
    
}

-(void)AddHomeMember_UpdateAppDataWithNewHomeMember:(NSString *)newUserID {
    
    if (_viewingWeDivvyPremiumAddingAccounts || _viewingWeDivvyPremiumEditingAccounts) {
        
        [self GenerateUpdatedTopLabel];
        
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSMutableDictionary *notificationSettingsDictCopy = self->_notificationSettingsDict ? [self->_notificationSettingsDict mutableCopy] : [NSMutableDictionary dictionary];
        
        NSDictionary *dataDict = @{@"HomeMembersArray" : self->_homeMembersArray,
                                   @"HomeMembersDict" : self->_homeMembersDict,
                                   @"HomeMembersUnclaimedDict" : self->_homeMembersUnclaimedDict,
                                   @"HomeKeysDict" : self->_homeKeysDict, @"HomeKeysArray" : self->_homeKeysArray,
                                   @"NotificationSettingsDict" : notificationSettingsDictCopy,
                                   @"NewUserID" : newUserID,
                                   @"ViewingItemUniqueID" : self->_itemUniqueID ? self->_itemUniqueID : @""};
        
        
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddHomeMember" userInfo:dataDict locations:@[@"Tasks", @"AddTask", @"MultiAddTasks", @"ViewTask", @"Chats", @"Notifications"]];
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"UnusedInvitations" userInfo:nil locations:@[@"Tasks", @"Chats"]];
        
        
        
        [[FIRCrashlytics crashlytics] logWithFormat:@"GenerateTwoWeekReminderNotification ViewAssigned"];
        
        [[[NotificationsObject alloc] init] RemoveLocalInactiveNotification];
        [[[NotificationsObject alloc] init] GenerateTwoWeekReminderNotification];
        
        
        
        [self.customTableView reloadData];
        [self->progressView setHidden:YES];
        
        
        
        [self AdjustTableViewHeight];
        
    });
    
}

#pragma mark - cellForRow

-(NSString *)GenerateSubLabelText:(NSIndexPath *)indexPath {
    
    NSString *userID = _homeMembersDict && _homeMembersDict[@"UserID"] && [(NSArray *)_homeMembersDict[@"UserID"] count] > indexPath.row ? _homeMembersDict[@"UserID"][indexPath.row] : @"";
    
    
    
    NSMutableDictionary *tempHomeMembersUnclaimedDictLocalInnerDict = [self GenerateHomeMembersUnclaimedDictForSpecificUser:indexPath selectedUserID:userID];
    NSString *unclaimedInvitation = tempHomeMembersUnclaimedDictLocalInnerDict && tempHomeMembersUnclaimedDictLocalInnerDict[@"InvitationSent"] ? tempHomeMembersUnclaimedDictLocalInnerDict[@"InvitationSent"] : @"";
    NSString *createdUserID = tempHomeMembersUnclaimedDictLocalInnerDict && tempHomeMembersUnclaimedDictLocalInnerDict[@"UserID"] ? tempHomeMembersUnclaimedDictLocalInnerDict[@"UserID"] : @"";
    
    
    
    NSArray *arr = [createdUserID componentsSeparatedByString:@":"];
    NSString *lastComp = [arr count] > 2 ? arr[2] : @"0000";
    NSString *lastCompNo1 = [NSString stringWithFormat:@"%@", [lastComp substringToIndex:2]];
    NSString *createdUserIDDWithLastComp = [arr count] > 1 ? [NSString stringWithFormat:@"%@:%@:%@", arr[0], arr[1], lastCompNo1] : @"";
    
    
    
    NSMutableDictionary *tempHomeKeysDictLocal = self->_homeKeysDict ? [self->_homeKeysDict mutableCopy] : [NSMutableDictionary dictionary];
    
    NSString *dateSent = @"";
    NSString *sentBy = @"";
    
    if (tempHomeKeysDictLocal[unclaimedInvitation]) {
        
        dateSent = tempHomeKeysDictLocal[unclaimedInvitation] && tempHomeKeysDictLocal[unclaimedInvitation][@"DateSent"] ? tempHomeKeysDictLocal[unclaimedInvitation][@"DateSent"] : @"";
        sentBy = tempHomeKeysDictLocal[unclaimedInvitation] && tempHomeKeysDictLocal[unclaimedInvitation][@"SentBy"] ? tempHomeKeysDictLocal[unclaimedInvitation][@"SentBy"] : @"";
        
    }
    
    
    
    if (self->_homeMembersUnclaimedDict[userID] && [self->_homeMembersUnclaimedDict[userID][@"InvitationSent"] isEqualToString:@"No"]) {
        
        return [NSString stringWithFormat:@"Invitation Code Not Sent • Home Member Added %@", [[[[GeneralObject alloc] init] GetDisplayTimeSinceDate:createdUserIDDWithLastComp shortStyle:NO reallyShortStyle:NO] lowercaseString]];
        
    } else {
        
        return [NSString stringWithFormat:@"Has Not Joined Yet • Invitation Code Created %@", [[[[GeneralObject alloc] init] GetDisplayTimeSinceDate:dateSent shortStyle:NO reallyShortStyle:NO] lowercaseString]];
        
    }
    
}

#pragma mark - didSelectRow

-(void)DidSelectPremiumAccount:(NSIndexPath *)indexPath {
    
    NSDictionary *weDivvyPremium = [(NSArray *)self->_homeMembersDict[@"WeDivvyPremium"] count] > indexPath.row ? self->_homeMembersDict[@"WeDivvyPremium"][indexPath.row] : [[[[GeneralObject alloc] init] GenerateDefaultWeDivvyPremiumPlan] mutableCopy];
    NSDictionary *weDivvyPremiumPurchasedDict = [NSDictionary dictionary];
    
    BOOL UserHasSubscriptionPlan = [weDivvyPremium[@"SubscriptionPlan"] isEqualToString:@""] == NO;
    BOOL UserPurchasedSubscriptionPlan = [weDivvyPremium[@"SubscriptionDatePurchased"] isEqualToString:@""] == NO;
    BOOL UserWasGivenSubscriptionPlan = [weDivvyPremium[@"SubscriptionGivenBy"] isEqualToString:@""] == NO;
    BOOL UserWasGivenSubscriptionPlanByMe = [weDivvyPremium[@"SubscriptionGivenBy"] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    
    BOOL SubscriptionPlanPurchsedByMe =
    UserHasSubscriptionPlan == YES &&
    UserPurchasedSubscriptionPlan == YES &&
    [self->_homeMembersDict[@"UserID"][indexPath.row] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] == YES;
    
    BOOL SubscriptionPlanPurchsedBySomeoneElse =
    UserHasSubscriptionPlan == YES &&
    (UserPurchasedSubscriptionPlan == YES ||
     (UserWasGivenSubscriptionPlan == YES && UserWasGivenSubscriptionPlanByMe == NO)) &&
    [self->_homeMembersDict[@"UserID"][indexPath.row] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] == NO;
    
    if (SubscriptionPlanPurchsedBySomeoneElse == NO && SubscriptionPlanPurchsedByMe == NO) {
        
        for (NSDictionary *weDivvyPremiumDict in self->_homeMembersDict[@"WeDivvyPremium"]) {
            if ([weDivvyPremiumDict[@"SubscriptionDatePurchased"] isEqualToString:@""] == NO) {
                weDivvyPremiumPurchasedDict = weDivvyPremiumDict;
            }
        }
        
        if (RanOutOfAccounts == NO || (RanOutOfAccounts == YES && [weDivvyPremium[@"SubscriptionPlan"] isEqualToString:@""] == NO)) {
            
            if ([weDivvyPremium[@"SubscriptionPlan"] isEqualToString:@""]) {
                
                weDivvyPremium = @{@"SubscriptionPlan" : weDivvyPremiumPurchasedDict[@"SubscriptionPlan"],
                                   @"SubscriptionFrequency" : weDivvyPremiumPurchasedDict[@"SubscriptionFrequency"],
                                   @"SubscriptionDatePurchased" : @"",
                                   @"SubscriptionGivenBy" : [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx",
                                   @"SubscriptionHistory" : weDivvyPremium[@"SubscriptionHistory"]
                };
                
            } else {
                
                weDivvyPremium = [[[GeneralObject alloc] init] GenerateDefaultWeDivvyPremiumPlan];
                
            }
            
            NSUInteger index = [self->_homeMembersDict[@"UserID"] indexOfObject:self->_homeMembersDict[@"UserID"][indexPath.row]];
            NSMutableDictionary *tempDict = [_homeMembersDict mutableCopy];
            NSMutableArray *tempArr = [tempDict[@"WeDivvyPremium"] mutableCopy];
            [tempArr replaceObjectAtIndex:index withObject:weDivvyPremium];
            [tempDict setObject:tempArr forKey:@"WeDivvyPremium"];
            self->_homeMembersDict = [tempDict mutableCopy];
            
            [self GenerateUpdatedTopLabel];
            
        } else {
            
            [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You have no more subscriptions to give." currentViewController:self];
            
        }
        
    } else if (SubscriptionPlanPurchsedBySomeoneElse) {
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"This subscription was purchased by someone else, you can't remove it." currentViewController:self];
        
    } else if (SubscriptionPlanPurchsedByMe) {
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You can't remove your own subcription." currentViewController:self];
        
    }
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark Send Invitation Code

-(NSMutableDictionary *)UpdateHomeMembersUnclaimedWithNewInvitationCode:(NSMutableDictionary *)homeMembersUnclaimedDict indexPath:(NSIndexPath *)indexPath inviteKeyExtraWithNumber:(NSString *)inviteKeyExtraWithNumber selectedUserID:(NSString *)selectedUserID {
    
    NSMutableDictionary *tempHomeMembersUnclaimedDictLocal = homeMembersUnclaimedDict ? [homeMembersUnclaimedDict mutableCopy] : [NSMutableDictionary dictionary];
    NSUInteger index = [[tempHomeMembersUnclaimedDictLocal allKeys] containsObject:selectedUserID] ? [[tempHomeMembersUnclaimedDictLocal allKeys] indexOfObject:selectedUserID] : -1;
    NSString *keyToUse = [[tempHomeMembersUnclaimedDictLocal allKeys] count] > index ? [tempHomeMembersUnclaimedDictLocal allKeys][index] : @"";
    NSMutableDictionary *tempHomeMembersUnclaimedDictLocalInnerDict = tempHomeMembersUnclaimedDictLocal[keyToUse] ? [tempHomeMembersUnclaimedDictLocal[keyToUse] mutableCopy] : [NSMutableDictionary dictionary];
    
    [tempHomeMembersUnclaimedDictLocalInnerDict setObject:inviteKeyExtraWithNumber forKey:@"InvitationSent"];
    [tempHomeMembersUnclaimedDictLocal setObject:tempHomeMembersUnclaimedDictLocalInnerDict forKey:keyToUse];
    
    return tempHomeMembersUnclaimedDictLocal;
}

-(NSMutableDictionary *)UpdateHomeKeysWithNewInvitationCode:(NSMutableDictionary *)tempHomeKeysDictLocal tempHomeMembersUnclaimedDictLocal:(NSMutableDictionary *)tempHomeMembersUnclaimedDictLocal indexPath:(NSIndexPath *)indexPath currentDateString:(NSString *)currentDateString inviteKeyExtraWithNumber:(NSString *)inviteKeyExtraWithNumber selectedUserID:(NSString *)selectedUserID {
    
    NSUInteger indexOfSelectedUser = [[tempHomeMembersUnclaimedDictLocal allKeys] containsObject:selectedUserID] ? [[tempHomeMembersUnclaimedDictLocal allKeys] indexOfObject:selectedUserID] : -1;
    NSString *unclaimedUserID = [[tempHomeMembersUnclaimedDictLocal allKeys] count] > indexOfSelectedUser ? [tempHomeMembersUnclaimedDictLocal allKeys][indexOfSelectedUser] : @"";
    NSString *unclaimedUsername = tempHomeMembersUnclaimedDictLocal[unclaimedUserID] && tempHomeMembersUnclaimedDictLocal[unclaimedUserID][@"Username"] ? tempHomeMembersUnclaimedDictLocal[unclaimedUserID][@"Username"] : @"";
    
    [tempHomeKeysDictLocal setObject:@{@"DateSent" : currentDateString, @"DateUsed" : @"", @"MemberName" : unclaimedUsername, @"SentBy" : [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]} forKey:inviteKeyExtraWithNumber];
    
    return tempHomeKeysDictLocal;
}

#pragma mark Edit Home Member

-(void)EditHomeMember_UpdateSelectedArray:(NSString *)selectedUsername {
    
    //Update SelectedArray
    if ([self->_selectedArray containsObject:selectedUsername]) {
        
        NSUInteger index = [self->_selectedArray indexOfObject:selectedUsername];
        [self->_selectedArray replaceObjectAtIndex:index withObject:selectedUsername];
        
    }
    
}

-(void)EditHomeMember_UpdateHomeMembersDict:(NSString *)newUsername selectedUserID:(NSString *)selectedUserID {
    
    NSUInteger index = [_homeMembersDict[@"UserID"] containsObject:selectedUserID] ? [_homeMembersDict[@"UserID"] indexOfObject:selectedUserID] : 1000;
    
    NSMutableArray *updatedArray = self->_homeMembersDict[@"Username"] ? [self->_homeMembersDict[@"Username"] mutableCopy] : [NSMutableArray array];
    id object = newUsername ? newUsername : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:@"Username"];
    if ([updatedArray count] > index) { [updatedArray replaceObjectAtIndex:index withObject:object]; }
    [self->_homeMembersDict setObject:updatedArray forKey:@"Username"];
    
}

-(void)EditHomeMember_UpdateHomeDict:(NSString *)newUsername selectedUserID:(NSString *)selectedUserID {
    
    NSMutableDictionary *tempHomeMembersUnclaimedDictLocal = [self->_homeMembersUnclaimedDict mutableCopy];
    NSMutableDictionary *tempHomeKeysDictLocal = [self->_homeKeysDict mutableCopy];
    NSMutableDictionary *tempHomeMembersDictLocal = self->_homeMembersDict ? [self->_homeMembersDict mutableCopy] : [NSMutableDictionary dictionary];
    
    
    
    NSString *unclaimedInvitation =
    tempHomeMembersUnclaimedDictLocal &&
    tempHomeMembersUnclaimedDictLocal[selectedUserID] &&
    tempHomeMembersUnclaimedDictLocal[selectedUserID][@"InvitationSent"] ?
    tempHomeMembersUnclaimedDictLocal[selectedUserID][@"InvitationSent"] : @"";
    
    
    
    //Update HomeMembersUnclaimedDict
    tempHomeMembersUnclaimedDictLocal = [self UpdateHomeMembersUnclaimedWithNewUsername:tempHomeMembersUnclaimedDictLocal username:newUsername selectedUserID:selectedUserID];
    self->_homeMembersUnclaimedDict = [tempHomeMembersUnclaimedDictLocal mutableCopy];
    
    //Update HomeKeysDict
    tempHomeKeysDictLocal = [self UpdateHomeKeysWithNewUsername:tempHomeKeysDictLocal username:newUsername unclaimedInvitation:unclaimedInvitation];
    self->_homeKeysDict = [tempHomeKeysDictLocal mutableCopy];
    
    //Update HomeMembersDict
    tempHomeMembersDictLocal = [self UpdateHomeMembersDictWithNewUsername:tempHomeMembersDictLocal username:newUsername selectedUserID:selectedUserID];
    self->_homeMembersDict = [tempHomeMembersDictLocal mutableCopy];
    
}

-(void)EditHomeMember_UpdateUserData:(NSDictionary *)userDictLocal selectedUserID:(NSString *)selectedUserID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataUserData:selectedUserID userDict:userDictLocal completionHandler:^(BOOL finished, NSError * _Nonnull error) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

#pragma mark - Delete Home Member

-(void)DeleteHomeMember_UpdateSelectedArray:(NSString *)selectedUsername {
    
    //Update SelectedArray
    if ([self->_selectedArray containsObject:selectedUsername]) {
        
        [self->_selectedArray removeObject:selectedUsername];
        
    }
    
}

-(void)DeleteHomeMember_UpdateHomeMembersDict:(NSString *)selectedUserID {
    
    //Update HomeMembersDict
    NSArray *keyArray = [[[GeneralObject alloc] init] GenerateUserKeyArray];
    
    NSUInteger index = [self->_homeMembersDict[@"UserID"] containsObject:selectedUserID] ? [self->_homeMembersDict[@"UserID"] indexOfObject:selectedUserID] : -1;
    
    if (index != -1) {
        
        for (NSString *key in keyArray) {
            
            NSMutableArray *updatedArray = self->_homeMembersDict[key] ? [self->_homeMembersDict[key] mutableCopy] : [NSMutableArray array];
            if ([updatedArray count] > index) { [updatedArray removeObjectAtIndex:index]; }
            [self->_homeMembersDict setObject:updatedArray forKey:key];
            
        }
      
    }
    
}

-(void)DeleteHomeMember_UpdateHomeDict:(NSString *)selectedUserID {
    
    NSMutableDictionary *tempHomeMembersUnclaimedDictLocal = [self->_homeMembersUnclaimedDict mutableCopy];
    NSMutableDictionary *tempHomeKeysDictLocal = [self->_homeKeysDict mutableCopy];
    NSMutableArray *tempHomeKeysArrayLocal = [self->_homeKeysArray mutableCopy];
    
    
    
    NSString *unclaimedInvitation =
    tempHomeMembersUnclaimedDictLocal &&
    tempHomeMembersUnclaimedDictLocal[selectedUserID] &&
    tempHomeMembersUnclaimedDictLocal[selectedUserID][@"InvitationSent"] ?
    tempHomeMembersUnclaimedDictLocal[selectedUserID][@"InvitationSent"] : @"";
    
    
    
    //Update HomeMembersUnclaimedDict
    tempHomeMembersUnclaimedDictLocal = [self UpdateHomeMembersUnclaimedDeleteHomeMember:tempHomeMembersUnclaimedDictLocal selectedUserID:selectedUserID];
    self->_homeMembersUnclaimedDict = [tempHomeMembersUnclaimedDictLocal mutableCopy];
    
    //Update HomeKeysDict
    [tempHomeKeysDictLocal removeObjectForKey:unclaimedInvitation];
    self->_homeKeysDict = [tempHomeKeysDictLocal mutableCopy];
    
    //Update HomeKeysArray
    tempHomeKeysArrayLocal = [self UpdateHomeKeysArrayDeleteHomeMember:tempHomeKeysArrayLocal unclaimedInvitation:unclaimedInvitation];
    self->_homeKeysArray = [tempHomeKeysArrayLocal mutableCopy];
    
    NSMutableArray *homeMembersArray = [self->_homeMembersArray mutableCopy];
    if ([homeMembersArray containsObject:selectedUserID]) { [homeMembersArray removeObject:selectedUserID]; }
    self->_homeMembersArray = [homeMembersArray mutableCopy];
    
}

-(void)DeleteHomeMember_DeleteUserData:(NSString *)selectedUserID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[DeleteDataObject alloc] init] DeleteDataUser:selectedUserID completionHandler:^(BOOL finished, NSError * _Nonnull error) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)DeleteHomeMember_UpdateItemData_ItemTurnUserID:(NSString *)selectedUserID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataNextUsersTurnForDeletedHomeMember:homeID homeMembersDict:self->_homeMembersDict notificationSettingsDict:self->_notificationSettingsDict topicDict:self->_topicDict allItemTagsArrays:[NSMutableArray array] homeMembersArray:self->_homeMembersArray userID:selectedUserID completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)DeleteHomeMember_SendPushNotificationsToExistingHomeMembers:(NSString *)selectedUsername completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                       SkippingTurn:NO RemovingUser:NO
                                                                                                     FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                            DueDate:NO Reminder:NO
                                                                                                     SubtaskEditing:NO SubtaskDeleting:NO
                                                                                                   SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                     AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                                EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                                  GroupChatMessages:NO LiveSupportMessages:NO
                                                                                                 SendingInvitations:YES DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                                FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                           itemType:@"HomeMembers"];
        
        
        
        NSString *someoneString = [selectedUsername length] > 0 && selectedUsername != nil && [selectedUsername containsString:@"(null)"] == NO ? selectedUsername : @"someone";
        
        NSString *notificationTitle = [NSString stringWithFormat:@"Home Member Removed 🏠"];
        NSString *notificationBody = [NSString stringWithFormat:@"%@ removed %@ from your home! 🏠", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"], someoneString];
        
        
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        NSString *homeName = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeName"] : @"xxx";
        NSMutableArray *userIDArray = [self->_homeMembersArray mutableCopy];
        
        
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Homes:userIDArray
                                           viewingHomeMembersFromHomesViewController:NO homeID:homeID homeName:homeName homeMembersDict:nil notificationSettingsDict:self->_notificationSettingsDict notificationItemType:@"HomeMembers" notificationType:notificationType
                                                                           topicDict:self->_topicDict
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                        RemoveUsersNotInHome:YES
                                                                 completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark Edit Home Member

-(NSMutableDictionary *)UpdateHomeMembersUnclaimedDeleteHomeMember:(NSMutableDictionary *)homeMembersUnclaimedDict selectedUserID:(NSString *)selectedUserID {
    
    NSMutableDictionary *tempHomeMembersUnclaimedDictLocal = homeMembersUnclaimedDict ? [homeMembersUnclaimedDict mutableCopy] : [NSMutableDictionary dictionary];
    NSUInteger index = [[tempHomeMembersUnclaimedDictLocal allKeys] containsObject:selectedUserID] ? [[tempHomeMembersUnclaimedDictLocal allKeys] indexOfObject:selectedUserID] : -1;
    NSString *keyToUse = [[tempHomeMembersUnclaimedDictLocal allKeys] count] > index ? [tempHomeMembersUnclaimedDictLocal allKeys][index] : @"";
    
    [tempHomeMembersUnclaimedDictLocal removeObjectForKey:keyToUse];
    
    return tempHomeMembersUnclaimedDictLocal;
}

-(NSMutableArray *)UpdateHomeKeysArrayDeleteHomeMember:(NSMutableArray *)homeKeysArray unclaimedInvitation:(NSString *)unclaimedInvitation {
    
    NSString *inviteKeyWithDotsRemoved = [self GenerateInviteKeyWithDotsRemoved:unclaimedInvitation];
    
    NSMutableArray *tempHomeKeysArrayLocal = homeKeysArray ? [homeKeysArray mutableCopy] : [NSMutableArray array];
    
    int customCount = (int)tempHomeKeysArrayLocal.count;
    
    if ([tempHomeKeysArrayLocal containsObject:inviteKeyWithDotsRemoved]) { [tempHomeKeysArrayLocal removeObject:inviteKeyWithDotsRemoved]; }
    
    for (int i=0 ; (int)tempHomeKeysArrayLocal.count<customCount-1 ; i++) {
        [tempHomeKeysArrayLocal addObject:inviteKeyWithDotsRemoved];
    }
    
    [tempHomeKeysArrayLocal removeObject:inviteKeyWithDotsRemoved];
    
    return tempHomeKeysArrayLocal;
}

-(NSMutableDictionary *)UpdateHomeMembersUnclaimedWithNewUsername:(NSMutableDictionary *)homeMembersUnclaimedDict username:(NSString *)username selectedUserID:(NSString *)selectedUserID {
    
    NSMutableDictionary *tempHomeMembersUnclaimedDictLocal = homeMembersUnclaimedDict ? [homeMembersUnclaimedDict mutableCopy] : [NSMutableDictionary dictionary];
    NSUInteger index = [[tempHomeMembersUnclaimedDictLocal allKeys] containsObject:selectedUserID] ? [[tempHomeMembersUnclaimedDictLocal allKeys] indexOfObject:selectedUserID] : -1;
    NSString *keyToUse = [[tempHomeMembersUnclaimedDictLocal allKeys] count] > index ? [tempHomeMembersUnclaimedDictLocal allKeys][index] : @"";
    NSMutableDictionary *tempHomeMembersUnclaimedDictLocalInnerDict = tempHomeMembersUnclaimedDictLocal[keyToUse] ? [tempHomeMembersUnclaimedDictLocal[keyToUse] mutableCopy] : [NSMutableDictionary dictionary];
    
    [tempHomeMembersUnclaimedDictLocalInnerDict setObject:username forKey:@"Username"];
    [tempHomeMembersUnclaimedDictLocal setObject:tempHomeMembersUnclaimedDictLocalInnerDict forKey:keyToUse];
    
    return tempHomeMembersUnclaimedDictLocal;
}

-(NSMutableDictionary *)UpdateHomeKeysWithNewUsername:(NSMutableDictionary *)tempHomeKeysDictLocal username:(NSString *)username unclaimedInvitation:(NSString *)unclaimedInvitation {
    
    NSMutableDictionary *tempHomeKeysDictLocalInnerDict = tempHomeKeysDictLocal[unclaimedInvitation] ? [tempHomeKeysDictLocal[unclaimedInvitation] mutableCopy] : [NSMutableDictionary dictionary];
    
    if (tempHomeKeysDictLocal[unclaimedInvitation]) {
        
        [tempHomeKeysDictLocalInnerDict setObject:username forKey:@"MemberName"];
        [tempHomeKeysDictLocal setObject:tempHomeKeysDictLocalInnerDict forKey:unclaimedInvitation];
        
    }
    
    return tempHomeKeysDictLocal;
}

-(NSMutableDictionary *)UpdateHomeMembersDictWithNewUsername:(NSMutableDictionary *)tempHomeMembersDictLocal username:(NSString *)username selectedUserID:(NSString *)selectedUserID {
    
    NSMutableArray *userIDArray = tempHomeMembersDictLocal[@"UserID"] ? [tempHomeMembersDictLocal[@"UserID"] mutableCopy] : [NSMutableArray array];
    NSUInteger index = [userIDArray containsObject:selectedUserID] ? [userIDArray indexOfObject:selectedUserID] : -1;
    
    NSMutableArray *usernameArray = tempHomeMembersDictLocal[@"Username"] ? [tempHomeMembersDictLocal[@"Username"] mutableCopy] : [NSMutableArray array];
    [usernameArray replaceObjectAtIndex:index withObject:username];
    
    NSMutableDictionary *homeMembersDictCopy = tempHomeMembersDictLocal ? [tempHomeMembersDictLocal mutableCopy] : [NSMutableDictionary dictionary];
    [homeMembersDictCopy setObject:usernameArray forKey:@"Username"];
    tempHomeMembersDictLocal = [homeMembersDictCopy mutableCopy];
    
    return tempHomeMembersDictLocal;
}

@end
