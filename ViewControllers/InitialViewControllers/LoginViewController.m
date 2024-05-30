//
//  LoginViewController.m
//  RoommateApp
//
//  Created by Philip Nagel on 5/17/21.
//

#import "LoginViewController.h"
#import "AppDelegate.h"

#import <MRProgress/MRProgress.h>

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "DeleteDataObject.h"
#import "PushObject.h"
#import "InitialViewControllerObject.h"

@interface LoginViewController () {
    
    MRProgressOverlayView *progressView;
    
}

@end

@implementation LoginViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self InitMethod];
    
    [self BarButtonItems];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
   
    if (textField == _EmailTextField) {

        [_PasswordTextField becomeFirstResponder];
        
    } else if (textField == _PasswordTextField) {
        
        [self NextButtonAction:self];
        
    }
     
    return YES;
}

-(void)viewDidLayoutSubviews {
 
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    CGFloat textFieldSpacing = (height*0.024456);
    
    
    
    _emailView.frame = CGRectMake(textFieldSpacing, navigationBarHeight + textFieldSpacing, (width*1 - (textFieldSpacing*2)), (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934));
    _passwordView.frame = CGRectMake(_emailView.frame.origin.x, _emailView.frame.origin.y + _emailView.frame.size.height, _emailView.frame.size.width, _emailView.frame.size.height);
    _forgotPasswordButton.frame = CGRectMake(0, _passwordView.frame.origin.y + _passwordView.frame.size.height + 8, width*1, 35);
    
    
    
    width = CGRectGetWidth(_emailView.bounds);
    height = CGRectGetHeight(_emailView.bounds);
    
    
    
    
    _EmailTextField.frame = CGRectMake(12, 0, width-24, height);
    
    
    
    CGFloat fontSize = (self.view.frame.size.height*0.02173813 > 16?16:(self.view.frame.size.height*0.02173813));
    
    _EmailTextField.font = [UIFont systemFontOfSize:_emailView.frame.size.height*0.315 weight:UIFontWeightSemibold];
    _PasswordTextField.font = _EmailTextField.font;
    _forgotPasswordButton.titleLabel.font = [UIFont systemFontOfSize:_emailView.frame.size.height*0.315 weight:UIFontWeightRegular];
    
    
    self->_EmailTextField.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium];
    self->_PasswordTextField.font = self->_EmailTextField.font;
 
    
    
    
    _forgotPasswordButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    
    
    
    CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
    
    UIBezierPath *maskPath;
    CAShapeLayer *maskLayer;
    
    maskPath = [UIBezierPath bezierPathWithRoundedRect:_emailView.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    
    maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _emailView.bounds;
    maskLayer.path  = maskPath.CGPath;
    _emailView.layer.mask = maskLayer;
    
    maskPath = [UIBezierPath bezierPathWithRoundedRect:_passwordView.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    
    maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _passwordView.bounds;
    maskLayer.path  = maskPath.CGPath;
    _passwordView.layer.mask = maskLayer;
    
    
    
    
    NSArray *arrView = @[_emailView, _passwordView];
    
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

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpAnalytics];
    
    [self SetUpTextFieldDelegates];
    
}

-(void)BarButtonItems {
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *barButtonItem;
    
    barButtonItem = [[UIBarButtonItem alloc]
                     initWithTitle:@"Back"
                     style:UIBarButtonItemStylePlain
                     target:self
                     action:@selector(NavigationBackButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    barButtonItem = [[UIBarButtonItem alloc]
                     initWithTitle:@"Next"
                     style:UIBarButtonItemStyleDone
                     target:self
                     action:@selector(NextButtonAction:)];
    
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
}

#pragma mark - Setup Methods

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"LoginViewController" completionHandler:^(BOOL finished) {
        
    }];
    
}

-(void)SetUpTextFieldDelegates {
    
    _EmailTextField.delegate = self;
    _PasswordTextField.delegate = self;
    
    [_EmailTextField becomeFirstResponder];
    
}

#pragma mark - Custom Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

#pragma mark - IBAction Methods

-(IBAction)NextButtonAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Next Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self StartProgressView];
    
    NSString *userEmail = [[[GeneralObject alloc] init] TrimString:_EmailTextField.text];
    NSString *userPassword = _PasswordTextField.text;
    
    [[[InitialViewControllerObject alloc] init] LogInUser_StandardLogIn:userEmail userPassword:userPassword currentViewController:self completionHandler:^(BOOL finished, NSString * _Nonnull errorString) {
       
        [self->progressView setHidden:YES];
        
        if (errorString.length > 0) {
            
            [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:errorString currentViewController:self];
            
        }
        
    }];

}

- (IBAction)ForgotPasswordButtonAction:(id)sender {

    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Forgot Password Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Enter your email" message:nil
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Reset"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *userEmail = [controller.textFields[0].text lowercaseString];
        
        [[FIRAuth auth] sendPasswordResetWithEmail:userEmail completion:^(NSError * _Nullable error) {
           
            NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
            NSString *trimmedStringString = [userEmail stringByTrimmingCharactersInSet:charSet];
            
            if ([trimmedStringString isEqualToString:@""]) {
                
                [self->progressView setHidden:YES];
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"Email field is empty" currentViewController:self];
                
            } else if (error) {
                
                [self->progressView setHidden:YES];
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"That email doesn't exist" currentViewController:self];
                
            } else if (error == nil) {
            
                [self->progressView setHidden:YES];
                [[[GeneralObject alloc] init] CreateAlert:@"Yay!" message:@"Your reset email has been sent" currentViewController:self];
            
            }
            
        }];
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {}];
    
    
    
    [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        textField.delegate = self;
        textField.placeholder = @"Email";
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

@end
