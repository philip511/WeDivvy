//
//  InitialViewController.h
//  RoommateApp
//
//  Created by Philip Nagel on 5/17/21.
//

#import <UIKit/UIKit.h>
#import "AnalyticsViewController.h"
#import <AuthenticationServices/AuthenticationServices.h>
#import <CommonCrypto/CommonHMAC.h>

NS_ASSUME_NONNULL_BEGIN

@import GoogleSignIn;

extern NSString* const nonce;

@interface InitialViewController : AnalyticsViewController <UITextFieldDelegate, UIScrollViewDelegate, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding>

@property (nonatomic, strong) NSString *currentNonce;
@property (nonatomic, strong) NSString *currentSHANonce;

@property (weak, nonatomic) IBOutlet UIView *dotOne;
@property (weak, nonatomic) IBOutlet UIView *dotTwo;
@property (weak, nonatomic) IBOutlet UIView *dotThree;
@property (weak, nonatomic) IBOutlet UIView *dotFour;
@property (weak, nonatomic) IBOutlet UIView *dotFive;

@property (nonatomic, strong) UITextView *appleIDLoginInfoTextView;

@property (weak, nonatomic) IBOutlet UIButton *appleSignInButton;
@property (weak, nonatomic) IBOutlet UIButton *googleSignInButton;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIView *googleLogoView;
@property (weak, nonatomic) IBOutlet UIView *leftLineLabel;
@property (weak, nonatomic) IBOutlet UIView *rightLineLabel;

@property (weak, nonatomic) IBOutlet UIImageView *appleLogo;
@property (weak, nonatomic) IBOutlet UIImageView *googleLogo;

@property (weak, nonatomic) IBOutlet UILabel *orLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *customScrollView;

@end

NS_ASSUME_NONNULL_END
