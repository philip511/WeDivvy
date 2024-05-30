//
//  SignUpViewController.m
//  RoommateApp
//
//  Created by Philip Nagel on 5/17/21.
//

#import "SignUpViewController.h"
#import "AppDelegate.h"

#import <Photos/Photos.h>
#import <Mixpanel/Mixpanel.h>
#import <MRProgress/MRProgress.h>

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "PushObject.h"
#import "InitialViewControllerObject.h"

@interface SignUpViewController () {
    
    MRProgressOverlayView *progressView;
    
    UIColor *activatedBackgroundColor;
    UIColor *activatedTextColor;
    UIColor *deActivatedBackgroundColor;
    UIColor *deActivatedTextColor;

    BOOL keyboardIsShown;

}

@end

@implementation SignUpViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self InitMethod];
    
    [self BarButtonItems];
    
    [self TapGestures];
    
    if (_ThirdPartySignup == YES) {
    
        [_UsernameTextField becomeFirstResponder];

    } else {
        
        [_EmailTextField becomeFirstResponder];
        
    }

}

-(void)viewWillAppear:(BOOL)animated {
    
    _whoIsThisForView.hidden = YES;
    _whoIsThisForView.userInteractionEnabled = NO;
 
    _hearAboutUsView.hidden = YES;
    _hearAboutUsView.userInteractionEnabled = NO;
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
    
    _receiveEmailsView.hidden = YES;
    _receiveEmailsLabel.hidden = YES;
    _receiveEmailsSwitch.hidden = YES;
    _receiveEmailsSubLabel.hidden = YES;
    
    self->_middleImage.alpha = 0.0;
    
    self->_createAccountButton.frame = CGRectMake(width*0.5 - (width*0.90)*0.5, height - (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934) - 8 - bottomPadding, width*0.90, self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934);
    self->_createAccountButton.titleLabel.font = [UIFont systemFontOfSize:_createAccountButton.frame.size.height*0.36 weight:UIFontWeightSemibold];
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    CGFloat textFieldSpacing = (height*0.024456);
    
    if (_ThirdPartySignup) {
        
        _usernameView.frame = CGRectMake(textFieldSpacing, navigationBarHeight + textFieldSpacing, (width*1 - (textFieldSpacing*2)), (self.view.frame.size.height*0.07472826 > 55?55:(self.view.frame.size.height*0.07472826)));
        
        _whoIsThisForView.frame = CGRectMake(_usernameView.frame.origin.x, _usernameView.frame.origin.y + _usernameView.frame.size.height + textFieldSpacing, _usernameView.frame.size.width, _usernameView.frame.size.height);
        _hearAboutUsView.frame = CGRectMake(_usernameView.frame.origin.x, _whoIsThisForView.frame.origin.y + _whoIsThisForView.frame.size.height, _usernameView.frame.size.width, _usernameView.frame.size.height);
        
        _emailView.hidden = YES;
        _passwordView.hidden = YES;
        
    } else {
        
        _emailView.frame = CGRectMake(textFieldSpacing, navigationBarHeight + textFieldSpacing, (width*1 - (textFieldSpacing*2)), (self.view.frame.size.height*0.07472826 > 55?55:(self.view.frame.size.height*0.07472826)));
        _passwordView.frame = CGRectMake(_emailView.frame.origin.x, _emailView.frame.origin.y + _emailView.frame.size.height, _emailView.frame.size.width, _emailView.frame.size.height);
        _usernameView.frame = CGRectMake(_emailView.frame.origin.x, _passwordView.frame.origin.y + _passwordView.frame.size.height, _emailView.frame.size.width, _emailView.frame.size.height);
        
        _whoIsThisForView.frame = CGRectMake(_usernameView.frame.origin.x, _usernameView.frame.origin.y + _usernameView.frame.size.height + textFieldSpacing, _usernameView.frame.size.width, _usernameView.frame.size.height);
        _hearAboutUsView.frame = CGRectMake(_usernameView.frame.origin.x, _whoIsThisForView.frame.origin.y + _whoIsThisForView.frame.size.height, _usernameView.frame.size.width, _usernameView.frame.size.height);
        
    }
    
    self->_TOSandPPTextView.frame = CGRectMake(_usernameView.frame.origin.x, _createAccountButton.frame.origin.y - 40, _usernameView.frame.size.width*0.95, 40);
    
    CGFloat fontSize = (self.view.frame.size.height*0.02173813 > 16?16:(self.view.frame.size.height*0.02173813));
    
    self->_EmailTextField.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium];
    self->_PasswordTextField.font = self->_EmailTextField.font;
    self->_UsernameTextField.font = self->_EmailTextField.font;
    
    self->_emailLabel.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium];
    self->_passwordLabel.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium];
    self->_usernameLabel.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium];
    self->_hearAboutUsLabel.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium];
    self->_whoIsThisForLabel.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium];
    
    self->_emailLabel.adjustsFontSizeToFitWidth = YES;
    self->_passwordLabel.adjustsFontSizeToFitWidth = YES;
    self->_usernameLabel.adjustsFontSizeToFitWidth = YES;
    self->_hearAboutUsLabel.adjustsFontSizeToFitWidth = YES;
    self->_whoIsThisForLabel.adjustsFontSizeToFitWidth = YES;
    
    
    CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
    
    if (_ThirdPartySignup) {
        
        [[[GeneralObject alloc] init] RoundingCorners:_usernameView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
        
        [[[GeneralObject alloc] init] RoundingCorners:_whoIsThisForView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
        [[[GeneralObject alloc] init] RoundingCorners:_hearAboutUsView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
        
    } else {
        
        [[[GeneralObject alloc] init] RoundingCorners:_emailView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
        [[[GeneralObject alloc] init] RoundingCorners:_usernameView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
        
        [[[GeneralObject alloc] init] RoundingCorners:_whoIsThisForView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
        [[[GeneralObject alloc] init] RoundingCorners:_hearAboutUsView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
        
    }
    
    UIView *topBarrier = _usernameView;
    UIView *bottomBarrier = _TOSandPPTextView;
 
    CGFloat centerY = CGRectGetMaxY(topBarrier.frame) + (CGRectGetMinY(bottomBarrier.frame) - CGRectGetMaxY(topBarrier.frame)) / 2.0;
    CGFloat yPos = centerY - height*0.3 / 2.0;
    
    _middleImage.frame = CGRectMake(0, yPos, width, height*0.3);
    
    if (_ThirdPartySignup) {
        
        width = CGRectGetWidth(_usernameView.bounds);
        height = CGRectGetHeight(_usernameView.bounds);
        
    } else {
        
        width = CGRectGetWidth(_emailView.bounds);
        height = CGRectGetHeight(_emailView.bounds);
        
    }
    
    
    
    _emailLabel.frame = CGRectMake(12, 0, 100, height);
    _passwordLabel.frame = CGRectMake(12, 0, 100, height);
    _usernameLabel.frame = CGRectMake(12, 0, 100, height);
    _hearAboutUsLabel.frame = CGRectMake(12, 0, 215, height);
    _whoIsThisForLabel.frame = CGRectMake(12, 0, 215, height);
    
    
    
    _EmailTextField.frame = CGRectMake(100+12, 0, width-24-100, height);
    _PasswordTextField.frame = CGRectMake(100+12, 0, width-24-100, height);
    _UsernameTextField.frame = CGRectMake(100+12, 0, width-24-100, height);
    _HearAboutUsTextField.frame = CGRectMake(215+12, 0, width-24-215, height);
    _whoIsThisForTextField.frame = CGRectMake(215+12, 0, width-24-215, height);
    _hearAboutUsButton.frame = _HearAboutUsTextField.frame;
    _whoIsThisForButton.frame = _whoIsThisForTextField.frame;
    
    
    
    _createAccountButton.layer.cornerRadius = 7;
    
    
    
    NSArray *arrView = @[_emailView, _passwordView, _usernameView, _hearAboutUsView, _whoIsThisForView];
    
    for (UIView *viewNo1 in arrView) {
        
        for (UIView *subViewNo1 in [viewNo1 subviews]) {
            
            if (subViewNo1.tag == 1111) {
                
                [subViewNo1 removeFromSuperview];
                
            }
            
        }
        
    }
    
    for (UIView *viewNo1 in arrView) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(viewNo1.frame.size.width*0.04830918, viewNo1.frame.size.height-1, viewNo1.frame.size.width - (viewNo1.frame.size.width*0.04830918), 1)];
        view.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:231.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
        view.tag = 1111;
        [viewNo1 addSubview:view];
        
    }
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
   
    if ((
         
         [self TextBeingChangedIsValid:_EmailTextField textFieldToCheck:textField range:range replacementString:string ThirdPartySignup:NO] &&
         
         [self TextBeingChangedIsValid:_PasswordTextField textFieldToCheck:textField range:range replacementString:string ThirdPartySignup:NO] &&
         
         [self TextBeingChangedIsValid:_UsernameTextField textFieldToCheck:textField range:range replacementString:string ThirdPartySignup:NO]
         
//         &&
//         
//         [self TextBeingChangedIsValid:_HearAboutUsTextField textFieldToCheck:textField range:range replacementString:string ThirdPartySignup:NO] &&
//
//         [self TextBeingChangedIsValid:_whoIsThisForTextField textFieldToCheck:textField range:range replacementString:string ThirdPartySignup:NO]
         
         ) ||
        
        ([self TextBeingChangedIsValid:_UsernameTextField textFieldToCheck:textField range:range replacementString:string ThirdPartySignup:YES]
        
//        &&
//        
//        [self TextBeingChangedIsValid:_HearAboutUsTextField textFieldToCheck:textField range:range replacementString:string ThirdPartySignup:YES] &&
//
//        [self TextBeingChangedIsValid:_whoIsThisForTextField textFieldToCheck:textField range:range replacementString:string ThirdPartySignup:YES]
        
        )) {
        
        [self ActiveNextButton:YES completionHandler:^(BOOL finished) {
           
            [self EnableNextButton];
            
        }];
        
    } else {
        
        [self ActiveNextButton:NO completionHandler:^(BOOL finished) {
            
        }];
        
    }
    
    return YES;
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField == _EmailTextField) {
        
        if ([_EmailTextField.text containsString:@"@"]) {
            
            NSString *str = [_EmailTextField.text componentsSeparatedByString:@"@"][0];
            str = [[[GeneralObject alloc] init] RemoveSpecialCharactersFromString:str];
            _UsernameTextField.text = str;
            
            [self EnableNextButton];
            
        }
        
    } else if (textField == _PasswordTextField || textField == _UsernameTextField) {

//        NSString *hearAboutUsTextField = [[[GeneralObject alloc] init] TrimString:_HearAboutUsTextField.text];
//        NSString *whoIsThisForTextField = [[[GeneralObject alloc] init] TrimString:_whoIsThisForTextField.text];
//        
//        if (hearAboutUsTextField.length > 0 && whoIsThisForTextField.length > 0) {
            
            [self EnableNextButton];
            
//        }
        
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
   
    if (textField == _EmailTextField) {
        
        if ([_EmailTextField.text containsString:@"@"]) {
            NSString *str = [_EmailTextField.text componentsSeparatedByString:@"@"][0];
            str = [[[GeneralObject alloc] init] RemoveSpecialCharactersFromString:str];
            _UsernameTextField.text = str;
        }
        
        [_PasswordTextField becomeFirstResponder];
        
    } else if (textField == _PasswordTextField) {
        
        [_UsernameTextField becomeFirstResponder];
        
    } else if (textField == _UsernameTextField) {
        
        [_EmailTextField resignFirstResponder];
        [_PasswordTextField resignFirstResponder];
        [_UsernameTextField resignFirstResponder];
        
    }
     
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    return YES;
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpAnalytics];
    
    [self SetUpHeardAboutUsContextMenu];
    
    [self SetUpWhoIsThisForContextMenu];
    
    [self SetUpColors];
    
    [self SetUpCreateAccountButton];
    
    [self SetUpTextFieldDelegates];
    
    [self SetUpKeyboardNSNotifications];
 
    [self SetUpThirdPartyUsername];
    
    [self SetUpTOSAndPPTextView];
    
}

-(void)BarButtonItems {
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(NavigationBackButtonAction:)];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
}

-(void)TapGestures {

}

#pragma mark - Setup Methods

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"SignUpViewController" completionHandler:^(BOOL finished) {
        
    }];
    
    [[[GeneralObject alloc] init] TrackInMixPanel:@"SignUpViewController"];
    
}

-(void)SetUpHeardAboutUsContextMenu {
    
    NSMutableArray *actions = [[NSMutableArray alloc] init];
    NSMutableArray *inPerson = [[NSMutableArray alloc] init];
    NSMutableArray *onlineAds = [[NSMutableArray alloc] init];
    NSMutableArray *search = [[NSMutableArray alloc] init];
    NSMutableArray *socialMedia = [[NSMutableArray alloc] init];
    NSMutableArray *other = [[NSMutableArray alloc] init];
    
    NSString *imageString = [_HearAboutUsTextField.text isEqualToString:@"Never"] ? @"checkmark" : @"";
    
    NSArray *optionArray = @[@"Friend or Family"];
    
    for (NSString *option in optionArray) {
        
        imageString = [_HearAboutUsTextField.text isEqualToString:option] ? @"checkmark" : @"";
        
        [inPerson addObject:[UIAction actionWithTitle:option image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ Clicked", option] completionHandler:^(BOOL finished) {
                
            }];
    
            self->_HearAboutUsTextField.text = option;
            [self SetUpHeardAboutUsContextMenu];
            [self EnableNextButton];
            
        }]];
        
    }
    
    optionArray = @[/*@"Reddit Ad", */@"App Store Ad"/*, @"Google Ad", @"Instagram Ad", @"Facebook Ad"*/];
    
    for (NSString *option in optionArray) {
        
        imageString = [_HearAboutUsTextField.text isEqualToString:option] ? @"checkmark" : @"";
        
        [onlineAds addObject:[UIAction actionWithTitle:option image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ Clicked", option] completionHandler:^(BOOL finished) {
                
            }];
            
            self->_HearAboutUsTextField.text = option;
            [self SetUpHeardAboutUsContextMenu];
            [self EnableNextButton];
            
        }]];
        
    }
    
    optionArray = @[@"Google Search", @"App Store Search"];
    
    for (NSString *option in optionArray) {
        
        imageString = [_HearAboutUsTextField.text isEqualToString:option] ? @"checkmark" : @"";
        
        [search addObject:[UIAction actionWithTitle:option image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ Clicked", option] completionHandler:^(BOOL finished) {
                
            }];
            
            self->_HearAboutUsTextField.text = option;
            [self SetUpHeardAboutUsContextMenu];
            [self EnableNextButton];
            
        }]];
        
    }
    
    optionArray = @[@"Reddit", @"Instagram", @"Facebook"];
    
    for (NSString *option in optionArray) {
        
        imageString = [_HearAboutUsTextField.text isEqualToString:option] ? @"checkmark" : @"";
        
        [socialMedia addObject:[UIAction actionWithTitle:option image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ Clicked", option] completionHandler:^(BOOL finished) {
                
            }];
            
            self->_HearAboutUsTextField.text = option;
            [self SetUpHeardAboutUsContextMenu];
            [self EnableNextButton];
            
        }]];
        
    }
    
    optionArray = @[@"Other"];
    
    for (NSString *option in optionArray) {
        
        imageString = [_HearAboutUsTextField.text isEqualToString:option] ? @"checkmark" : @"";
        
        [other addObject:[UIAction actionWithTitle:option image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ Clicked", option] completionHandler:^(BOOL finished) {
                
            }];
            
            self->_HearAboutUsTextField.text = option;
            [self SetUpHeardAboutUsContextMenu];
            [self EnableNextButton];
            
        }]];
        
    }
    
    UIMenu *inPersonInlineMenu = [UIMenu menuWithTitle:@"In-Person Ads" image:nil identifier:@"In-Person Ads" options:UIMenuOptionsDisplayInline children:inPerson];
    UIMenu *onlineInlineMenu = [UIMenu menuWithTitle:@"Online Ads" image:nil identifier:@"Online Ads" options:UIMenuOptionsDisplayInline children:onlineAds];
//    UIMenu *searchInlineMenu = [UIMenu menuWithTitle:@"Search" image:nil identifier:@"Search" options:UIMenuOptionsDisplayInline children:search];
//    UIMenu *socialMediaInlineMenu = [UIMenu menuWithTitle:@"Social Media" image:nil identifier:@"Social Media" options:UIMenuOptionsDisplayInline children:socialMedia];
    UIMenu *otherInlineMenu = [UIMenu menuWithTitle:@"Other" image:nil identifier:@"Other" options:UIMenuOptionsDisplayInline children:other];
    
    [actions addObject:inPersonInlineMenu];
    [actions addObject:onlineInlineMenu];
//    [actions addObject:searchInlineMenu];
//    [actions addObject:socialMediaInlineMenu];
    [actions addObject:otherInlineMenu];
    
    _hearAboutUsButton.menu = [UIMenu menuWithTitle:@"" children:actions];
    _hearAboutUsButton.showsMenuAsPrimaryAction = true;
    
}

// NSArray *optionArray = @[@"Roommate", @"Housemate", @"Partner", @"Spouse", @"Family", @"Other"];
-(void)SetUpWhoIsThisForContextMenu {
    
    NSMutableArray *actions = [[NSMutableArray alloc] init];
    NSMutableArray *myself = [[NSMutableArray alloc] init];
    NSMutableArray *college = [[NSMutableArray alloc] init];
    NSMutableArray *partner = [[NSMutableArray alloc] init];
    NSMutableArray *family = [[NSMutableArray alloc] init];
    NSMutableArray *other = [[NSMutableArray alloc] init];
    
    NSString *imageString = [_whoIsThisForTextField.text isEqualToString:@"Never"] ? @"checkmark" : @"";
    
    NSArray *optionArray = @[@"Myself"];
    
    for (NSString *option in optionArray) {
        
        imageString = [_whoIsThisForTextField.text isEqualToString:option] ? @"checkmark" : @"";
        
        [myself addObject:[UIAction actionWithTitle:option image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ Clicked", option] completionHandler:^(BOOL finished) {
                
            }];
            
            self->_whoIsThisForTextField.text = option;
            [self SetUpWhoIsThisForContextMenu];
            [self EnableNextButton];
            
        }]];
        
    }
    
    optionArray = @[@"Roommates", @"Housemates"];
    
    for (NSString *option in optionArray) {
        
        imageString = [_whoIsThisForTextField.text isEqualToString:option] ? @"checkmark" : @"";
        
        [college addObject:[UIAction actionWithTitle:option image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ Clicked", option] completionHandler:^(BOOL finished) {
                
            }];
            
            self->_whoIsThisForTextField.text = option;
            [self SetUpWhoIsThisForContextMenu];
            [self EnableNextButton];
            
        }]];
        
    }
    
    optionArray = @[@"Partner", @"Spouse"];
    
    for (NSString *option in optionArray) {
        
        imageString = [_whoIsThisForTextField.text isEqualToString:option] ? @"checkmark" : @"";
        
        [partner addObject:[UIAction actionWithTitle:option image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ Clicked", option] completionHandler:^(BOOL finished) {
                
            }];
            
            self->_whoIsThisForTextField.text = option;
            [self SetUpWhoIsThisForContextMenu];
            [self EnableNextButton];
            
        }]];
        
    }
    
    optionArray = @[@"Family"];
    
    for (NSString *option in optionArray) {
        
        imageString = [_whoIsThisForTextField.text isEqualToString:option] ? @"checkmark" : @"";
        
        [family addObject:[UIAction actionWithTitle:option image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ Clicked", option] completionHandler:^(BOOL finished) {
                
            }];
            
            self->_whoIsThisForTextField.text = option;
            [self SetUpWhoIsThisForContextMenu];
            [self EnableNextButton];
            
        }]];
        
    }
    
    optionArray = @[@"Other"];
    
    for (NSString *option in optionArray) {
        
        imageString = [_whoIsThisForTextField.text isEqualToString:option] ? @"checkmark" : @"";
        
        [other addObject:[UIAction actionWithTitle:option image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ Clicked", option] completionHandler:^(BOOL finished) {
                
            }];
            
            self->_whoIsThisForTextField.text = option;
            [self SetUpWhoIsThisForContextMenu];
            [self EnableNextButton];
            
        }]];
        
    }
   
    UIMenu *myselfInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"Myself" options:UIMenuOptionsDisplayInline children:myself];
    UIMenu *collegeInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"College" options:UIMenuOptionsDisplayInline children:college];
    UIMenu *partnerInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"Partner" options:UIMenuOptionsDisplayInline children:partner];
    UIMenu *familyInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"Family" options:UIMenuOptionsDisplayInline children:family];
    UIMenu *otherInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"Other" options:UIMenuOptionsDisplayInline children:other];
    
    [actions addObject:myselfInlineMenu];
    [actions addObject:collegeInlineMenu];
    [actions addObject:partnerInlineMenu];
    [actions addObject:familyInlineMenu];
    [actions addObject:otherInlineMenu];
 
    _whoIsThisForButton.menu = [UIMenu menuWithTitle:@"" children:actions];
    _whoIsThisForButton.showsMenuAsPrimaryAction = true;
    
}

-(void)SetUpCreateAccountButton {
    
    [self ActiveNextButton:NO completionHandler:^(BOOL finished) {
        
    }];
    
}

-(void)SetUpTextFieldDelegates {
    
    _UsernameTextField.delegate = self;
    _EmailTextField.delegate = self;
    _PasswordTextField.delegate = self;

}

-(void)SetUpKeyboardNSNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

-(void)SetUpThirdPartyUsername {
    
    if (_ThirdPartySignup == YES && [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersEmail"]) {
        
        NSString *userEmail = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersEmail"];
        
        if ([userEmail containsString:@"@gmail.com"]) {
            
            _UsernameTextField.text = [userEmail componentsSeparatedByString:@"@gmail.com"][0];
            [self EnableNextButton];
            
        } else if ([userEmail containsString:@"@icloud.com"]) {
            
            _UsernameTextField.text = [userEmail componentsSeparatedByString:@"@icloud.com"][0];
            [self EnableNextButton];
            
        } else if ([userEmail containsString:@"@outlook.com"]) {
            
            _UsernameTextField.text = [userEmail componentsSeparatedByString:@"@outlook.com"][0];
            [self EnableNextButton];
            
        } else if ([userEmail containsString:@"@aol.com"]) {
            
            _UsernameTextField.text = [userEmail componentsSeparatedByString:@"@aol.com"][0];
            [self EnableNextButton];
            
        } else if ([userEmail containsString:@"@yahoo.com"]) {
            
            _UsernameTextField.text = [userEmail componentsSeparatedByString:@"@yahoo.com"][0];
            [self EnableNextButton];
            
        } else if ([userEmail containsString:@"@protonmail.com"]) {
            
            _UsernameTextField.text = [userEmail componentsSeparatedByString:@"@protonmail.com"][0];
            [self EnableNextButton];
            
        }
        
    }
    
}

-(void)SetUpTOSAndPPTextView {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    UIFont *font = [UIFont systemFontOfSize:12 weight:UIFontWeightBold];
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,
                                     [UIColor colorWithRed:55.0f/255.0f green:81.0f/255.0f blue:101.0f/255.0f alpha:0.85], NSForegroundColorAttributeName,
                                     paragraphStyle, NSParagraphStyleAttributeName, nil];
    
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"By continuing you agree to our\nTerms of Service and Privacy Policy"] attributes:attrsDictionary];
    
    NSRange range = [[NSString stringWithFormat:@"%@", str] rangeOfString:@"Terms of Service"];
    NSRange range1 = [[NSString stringWithFormat:@"%@", str] rangeOfString:@"Privacy Policy"];
    
    
    [str addAttribute: NSLinkAttributeName value: [NSURL URLWithString:@"https://www.wedivvyapp.com/terms-of-service"] range: NSMakeRange(range.location, range.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.0f/255.0f green:122.0f/255.0f blue:255.0f/255.0f alpha:1.0f] range: NSMakeRange(range.location, range.length)];
    [str addAttribute: NSLinkAttributeName value: [NSURL URLWithString:@"https://www.wedivvyapp.com/privacy-policy"] range: NSMakeRange(range1.location, range1.length)];
    
    _TOSandPPTextView.attributedText = str;
    
    
    _TOSandPPTextView.scrollEnabled = NO;
    _TOSandPPTextView.editable = NO;
    _TOSandPPTextView.textContainer.lineFragmentPadding = 0;
    _TOSandPPTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _TOSandPPTextView.delegate = self;
    
}

-(void)SetUpColors {
    
    activatedBackgroundColor = [UIColor colorWithRed:16.0f/255.0f green:156.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    activatedTextColor = [UIColor whiteColor];
    deActivatedBackgroundColor = [UIColor colorWithRed:205.0f/255.0f green:214.0f/255.0f blue:221.0f/255.0f alpha:1.0f];
    deActivatedTextColor = [UIColor colorWithRed:155.0f/255.0f green:164.0f/255.0f blue:171.0f/255.0f alpha:1.0f];
    
}

#pragma mark - UI Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

#pragma mark - UX Methods

-(void)EnableNextButton {
    
    if (
        
        ([self TextFieldIsValid:_EmailTextField ThirdPartySignup:NO] &&
         
         [self TextFieldIsValid:_PasswordTextField ThirdPartySignup:NO] &&
         
         [self TextFieldIsValid:_UsernameTextField ThirdPartySignup:NO]
         
         //         &&
         //
         //         [self TextFieldIsValid:_HearAboutUsTextField ThirdPartySignup:NO] &&
         //
         //         [self TextFieldIsValid:_whoIsThisForTextField ThirdPartySignup:NO]
         
         )
        
        ||
        
        ([self TextFieldIsValid:_UsernameTextField ThirdPartySignup:YES]
         
         //         &&
         //
         //         [self TextFieldIsValid:_HearAboutUsTextField ThirdPartySignup:YES] &&
         //
         //         [self TextFieldIsValid:_whoIsThisForTextField ThirdPartySignup:NO]
         
         )
        
        ) {
            
            [self ActiveNextButton:YES completionHandler:^(BOOL finished) {
                
            }];
            
        } else {
            
            [self ActiveNextButton:NO completionHandler:^(BOOL finished) {
                
            }];
            
        }
    
}

- (void)keyboardWillShow: (NSNotification *) notification{
    
    keyboardIsShown = true;
    
    [UIView animateWithDuration:0.25 animations:^{
   
        NSDictionary* keyboardInfo = [notification userInfo];
        NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];

        CGRect sendCoinsButton = self->_createAccountButton.frame;

        sendCoinsButton.origin.y = CGRectGetHeight(self.view.bounds)-keyboardFrameBeginRect.size.height-self->_createAccountButton.frame.size.height - 8;
        self->_createAccountButton.frame = sendCoinsButton;
       
        
        self->_TOSandPPTextView.frame = CGRectMake(self->_usernameView.frame.origin.x, self->_createAccountButton.frame.origin.y - 40, self->_usernameView.frame.size.width*0.95, 40);
        
        
        self->_middleImage.alpha = 0.0;
        
    }];

}

- (void)keyboardWillHide: (NSNotification *) notification{
    
    keyboardIsShown = false;
    
    [UIView animateWithDuration:0.25 animations:^{

        CGFloat width = CGRectGetWidth(self.view.bounds);
        CGFloat height = CGRectGetHeight(self.view.bounds);
        
        CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
        
        self->_createAccountButton.frame = CGRectMake(width*0.5 - (width*0.90)*0.5, height - (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934) - 8 - bottomPadding, width*0.90, self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934);
        
        self->_TOSandPPTextView.frame = CGRectMake(self->_usernameView.frame.origin.x, self->_createAccountButton.frame.origin.y - 40, self->_usernameView.frame.size.width*0.95, 40);
        self->_middleImage.alpha = 1.0;
        
    }];
    
}

#pragma mark - IBAction Methods

-(IBAction)NextButtonAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Next Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self StartProgressView];

    NSString *userID = _ThirdPartySignup == NO ? [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString] : [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"];
    NSString *username = [[[GeneralObject alloc] init] RemoveSpecialCharactersFromString:_UsernameTextField.text];
    NSString *userEmail = _ThirdPartySignup == NO ? [[[GeneralObject alloc] init] TrimString:_EmailTextField.text] : [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersEmail"];
    NSString *userPassword = _ThirdPartySignup == NO ? _PasswordTextField.text : @"password";
    NSString *howYouHeardAboutUs = @"zzz";//_HearAboutUsTextField.text;
    NSString *whoIsThisFor = @"zzz";//_whoIsThisForTextField.text;
    NSString *receiveEmails = @"Yes";
    
    [[[InitialViewControllerObject alloc] init] SignUpUser_StandardSignUp:userID username:username userEmail:userEmail userPassword:userPassword howYouHeardAboutUs:howYouHeardAboutUs whoIsThisFor:whoIsThisFor receiveEmails:receiveEmails thirdPartySignUp:_ThirdPartySignup completionHandler:^(BOOL finished, NSString * _Nonnull errorString) {
 
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSDate *dateStringCurrentDate = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy hh:mm a" returnAs:[NSDate class]];
            NSDate *dateStringWithAddedTime = [[[GeneralObject alloc] init] GenerateDateWithAddedTimeWithFormat:@"MMMM dd, yyyy hh:mm a" dateToAddTimeTo:dateStringCurrentDate timeToAdd:-1*(60*60*24*7) returnAs:[NSDate class]];
           
            NSString *dateStringCurrentDateWeekBefore = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:@"MMMM dd, yyyy hh:mm a" dateToConvert:dateStringWithAddedTime returnAs:[NSString class]];
            
            [[NSUserDefaults standardUserDefaults] setObject:dateStringCurrentDateWeekBefore forKey:@"CompletedSurveyDate"];
            
            [self->progressView setHidden:YES];
            
            if (errorString.length > 0) {
                
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:errorString currentViewController:self];
                
            }
            
            [[[PushObject alloc] init] PushToCreateHomeViewController:YES arrayOfHomeIDsYouAreAPartOf:nil currentViewController:self];
            
        });
        
    }];

}

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - Internal Methods

-(void)ActiveNextButton:(BOOL)Enable completionHandler:(void (^)(BOOL finished))finishBlock {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self->_createAccountButton.userInteractionEnabled = Enable;
        self->_createAccountButton.backgroundColor = Enable ? self->activatedBackgroundColor : self->deActivatedBackgroundColor;
        self->_createAccountButton.titleLabel.textColor = Enable ? self->activatedTextColor : self->deActivatedTextColor;
        
    } completion:^(BOOL finished) {
       
        finishBlock(YES);
        
    }];
    
}

-(BOOL)TextBeingChangedIsValid:(UITextField *)textField textFieldToCheck:(UITextField *)textFieldToCheck range:(NSRange)range replacementString:(NSString *)string ThirdPartySignup:(BOOL)ThirdPartySignup {
    
    BOOL TextFieldIsCorrectTextField = (textField == textFieldToCheck);
    BOOL TextFieldHasCharacters_OR_FirstCharacterWasJustAdded = ([[NSString stringWithFormat:@"%@", textField.text] length] > 0 ||
                                                                 ([[NSString stringWithFormat:@"%@", textField.text] length] == 0 && string.length > 0));
    BOOL LastCharacterWasJustDeleted = (textField.text.length == 1 && string.length == 0);
    BOOL AllCharacterWereJustDeleted = (textField.text.length == range.length && string.length == 0);
    
    if ((
         
         (TextFieldIsCorrectTextField == YES &&
          TextFieldHasCharacters_OR_FirstCharacterWasJustAdded == YES &&
          LastCharacterWasJustDeleted == NO &&
          AllCharacterWereJustDeleted == NO) ||
         
         (TextFieldIsCorrectTextField == NO && textField.text.length > 0)) &&
        
        ThirdPartySignup == _ThirdPartySignup) {
        
        return YES;
        
    }
    
    return NO;
}

-(BOOL)TextFieldIsValid:(UITextField *)textField ThirdPartySignup:(BOOL)ThirdPartySignup {
    
    BOOL TextFieldHasCharacters = ([[NSString stringWithFormat:@"%@", textField.text] length] > 0);
    
    if (TextFieldHasCharacters == YES &&
        ThirdPartySignup == _ThirdPartySignup) {
        return YES;
    }
 
    return NO;
}

@end
