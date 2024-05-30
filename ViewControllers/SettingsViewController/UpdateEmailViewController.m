//
//  UpdateEmailViewController.m
//  RoommateApp
//
//  Created by Philip Nagel on 5/22/21.
//

#import "UpdateEmailViewController.h"
#import "AppDelegate.h"

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "SettingsObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@interface UpdateEmailViewController () {
    
    MRProgressOverlayView *progressView;

}

@end

@implementation UpdateEmailViewController

#pragma mark - System Method

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

-(void)viewDidLayoutSubviews {
 
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height;
    
    self->_firstTopLabel.frame = CGRectMake(15, navigationBarHeight + 8, width*1 - 30, 15);
    self->_currentEmailView.frame = CGRectMake(0, _firstTopLabel.frame.origin.y + _firstTopLabel.frame.size.height + 8, width*1, 44);
    self->_secondTopLabel.frame = CGRectMake(15, _currentEmailView.frame.origin.y + _currentEmailView.frame.size.height + 8, width*1 - 30, 15);
    self->_emailView.frame = CGRectMake(0, _secondTopLabel.frame.origin.y + _secondTopLabel.frame.size.height + 8, width*1, 44);
    
    width = CGRectGetWidth(self.emailView.bounds);
    _emailTextField.frame = CGRectMake(20, 0, width*1 - 40, 45);
    _currentEmailLabel.frame = CGRectMake(20, 0, width*1 - 40, 45);

    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.emailView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.emailTextField.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.currentEmailView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.currentEmailLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.firstTopLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.secondTopLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        
        [self preferredStatusBarStyle];
        
    }
    
}

#pragma mark - Init Methods

-(void)InitMethod {

    [self SetUpAnalytics];
    
    [self SetUpEmailLabel];
    
}

-(void)BarButtonItems {
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *barButtonItem;
    
    barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(NavigationBackButtonAction:)];
   
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                      style:UIBarButtonItemStyleDone
                                     target:self
                                     action:@selector(UpdateEmailAction:)];
   
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
}

#pragma mark - Setup Methods

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"UpdateEmailViewController" completionHandler:^(BOOL finished) {
        
    }];
    
}

-(void)SetUpEmailLabel {
    
    _currentEmailLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersEmail"];
    
}

#pragma mark - IBAction Methods

-(IBAction)UpdateEmailAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Next Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Enter your credentials to update your email" message:nil
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Update"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Update Settings Clicked"] completionHandler:^(BOOL finished) {
            
        }];
        
        NSString *lowerCaseEmail = controller.textFields[0].text;
   
        [[FIRAuth auth] signInWithEmail:lowerCaseEmail password:controller.textFields[1].text completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
           
            [self UpdateEmail:error];
            
        }];
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Cancel"] completionHandler:^(BOOL finished) {
            
        }];
        
    }];
    
    
    
    [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        textField.delegate = self;
        textField.placeholder = @"Email";
        textField.text = @"";
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;

    }];
    
    [controller addTextFieldWithConfigurationHandler:^(UITextField *textField1) {
        
        textField1.delegate = self;
        textField1.placeholder = @"Password";
        textField1.text = @"";
        textField1.autocapitalizationType = UITextAutocapitalizationTypeWords;
        textField1.secureTextEntry = YES;
        
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

#pragma mark - Custom Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

-(void)UpdateEmail:(NSError *)error {
    
    if (error == nil) {
        
        [self StartProgressView];
        
        NSString *userEmail = [[[GeneralObject alloc] init] TrimString:self->_emailTextField.text];
        
        [[[SettingsObject alloc] init] UpdateEmail:userEmail completionHandler:^(BOOL finished, NSString * _Nonnull errorString) {
            
            [self->progressView setHidden:YES];
            
            if (errorString.length == 0) {
                
                UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Yay!"
                                                                                    message:@"Your info was updated!"
                                                                             preferredStyle:UIAlertControllerStyleAlert];
                
                
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Got it!"
                                                                 style:UIAlertActionStyleCancel
                                                               handler:^(UIAlertAction * _Nonnull action) {
                    
                    self->_emailTextField.text = userEmail;
                    [[NSUserDefaults standardUserDefaults] setObject:userEmail forKey:@"UsersEmail"];
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }];
                
                [controller addAction:cancel];
                [self presentViewController:controller animated:YES completion:nil];
 
            } else {
                
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:errorString currentViewController:self];
                
            }
            
        }];
        
    } else if ([error.description containsString:@"There is no user record corresponding to this identifier. The user may have been deleted."]) {
        
        [self->progressView setHidden:YES];
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"A user with that email doesn't exist" currentViewController:self];
        
    } else if ([error.description containsString:@"The email address is badly formatted"]) {
        
        [self->progressView setHidden:YES];
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"That email is incorrectly formatted" currentViewController:self];
        
    } else if ([error.description containsString:@"The password is invalid or the user does not have a password"]) {
        
        [self->progressView setHidden:YES];
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"That email/password combination doesn't exist" currentViewController:self];
        
    } else {
        
        [self->progressView setHidden:YES];
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"An error has occurred please try again" currentViewController:self];
        
    }
    
}

@end
