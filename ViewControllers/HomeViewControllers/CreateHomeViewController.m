//
//  CreateHomeViewController.m
//  RoommateApp
//
//  Created by Philip Nagel on 5/23/21.
//

#import "CreateHomeViewController.h"
#import "AppDelegate.h"

#import <Mixpanel/Mixpanel.h>
#import <SDWebImage/SDWebImage.h>
#import <MRProgress/MRProgress.h>

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "PushObject.h"
#import "HomesViewControllerObject.h"
#import "NotificationsObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@interface CreateHomeViewController () {
    
    MRProgressOverlayView *progressView;
    
    NSMutableDictionary *homeToJoinDict;
    
    BOOL findHomeClicked;
    
    UIColor *defaultFieldColor;
    
    NSMutableArray *premiumPlanProductsArray;
    NSMutableDictionary *premiumPlanPricesDict;
    NSMutableDictionary *premiumPlanExpensivePricesDict;
    NSMutableDictionary *premiumPlanPricesDiscountDict;
    NSMutableDictionary *premiumPlanPricesNoFreeTrialDict;
    
}

@end

@implementation CreateHomeViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self FetchAvailableProducts];
        
    });
    
    [self InitMethod];
    
    [self BarButtonItems];
    
    _codeKeyView.hidden = YES;
    _codeKeyImage.hidden = YES;
    _codeKeyTextField.hidden = YES;
    
}

-(void)viewDidLayoutSubviews {
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
    
    _topView.frame = CGRectMake(0, 0, width, navigationBarHeight + height*0.15);
    
    width = CGRectGetWidth(_topView.bounds);
    height = CGRectGetHeight(_topView.bounds);
    
    _separatorView.frame = CGRectMake(0, navigationBarHeight + self.view.frame.size.height*0.01358696, width, 1);
    
    _createHomeButton.frame = CGRectMake(width*0.5 - (width*0.3)*0.5 - width*0.2, _separatorView.frame.origin.y + self.view.frame.size.height*0.01358696, (width*0.3), (height*0.10));
    _findHomeButton.frame = CGRectMake((width*0.5 - (width*0.3)*0.5 + width*0.2), _createHomeButton.frame.origin.y, (width*0.3), _createHomeButton.frame.size.height);
    
    _createHomeButtonCover.frame = CGRectMake(_createHomeButton.frame.origin.x - (width*0.01207), _createHomeButton.frame.origin.y - (((width*0.01207))*2), _createHomeButton.frame.size.width + (((width*0.01207))*2), _createHomeButton.frame.size.height + (((width*0.01207))*4));
    _findHomeButtonCover.frame = CGRectMake(_findHomeButton.frame.origin.x - (width*0.01207), _findHomeButton.frame.origin.y - (((width*0.01207))*2), _findHomeButton.frame.size.width + (((width*0.01207))*2), _findHomeButton.frame.size.height + (((width*0.01207))*4));
    
    _createHomeButton.titleLabel.font = [UIFont systemFontOfSize: (self.view.frame.size.height*0.01630435 > 13?(13):self.view.frame.size.height*0.01630435) weight:UIFontWeightBold];
    _findHomeButton.titleLabel.font = _createHomeButton.titleLabel.font;
    
    _createHomeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    _findHomeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    CGRect newRect = self.topView.frame;
    newRect.size.height = _createHomeButton.frame.origin.y + _createHomeButton.frame.size.height + self.view.frame.size.height*0.01358696;
    self.topView.frame = newRect;
    
    _topView.layer.borderWidth = 0.0;
    _topView.layer.shadowColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeShadow].CGColor :  [[[LightDarkModeObject alloc] init] LightModeShadow].CGColor;
    _topView.layer.shadowRadius = 5;
    _topView.layer.shadowOpacity = 1.0;
    _topView.layer.shadowOffset = CGSizeMake(0, 0);
    
    if (!findHomeClicked) {
        
        _slidingBar.frame = CGRectMake(_createHomeButton.frame.origin.x + (_createHomeButton.frame.size.width*0.5 - ((width*0.333)*0.5)), _topView.frame.origin.y + _topView.frame.size.height - 2, width*0.333, 2);
        _slidingBar.layer.cornerRadius = _slidingBar.frame.size.height/2;
        
        _viewOne.frame = CGRectMake(0, _topView.frame.size.height + self.view.frame.size.height*0.01358696, width, height - (_slidingBar.frame.origin.y + _slidingBar.frame.size.height + self.view.frame.size.height*0.01358696) - bottomPadding);
        _viewTwo.frame = CGRectMake(width*5, _viewOne.frame.origin.y, width, _viewOne.frame.size.height);
        
        [_createHomeButton setTitleColor:[[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[GeneralObject alloc] init] GenerateAppColor:1.0f] forState:UIControlStateNormal];
        [_findHomeButton setTitleColor:[[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [[[LightDarkModeObject alloc] init] LightModeTextSecondary] forState:UIControlStateNormal];
        
    }
    
    width = CGRectGetWidth(_viewOne.bounds);
    height = CGRectGetHeight(_viewOne.bounds);
    
    CGFloat textFieldSpacing = (self.view.frame.size.height*0.024456);
    
    _titleLabel.frame = CGRectMake(self.view.frame.size.width*0.5 -((self.view.frame.size.width*0.85)*0.5), textFieldSpacing, self.view.frame.size.width*0.85, self.view.frame.size.height*0.0298913); //22
    _subTitleLabel.frame = CGRectMake(self.view.frame.size.width*0.5 - ((self.view.frame.size.width*0.816425)*0.5), _titleLabel.frame.origin.y + _titleLabel.frame.size.height + textFieldSpacing, self.view.frame.size.width*0.816425, self.view.frame.size.height*0.05027174); //37
    
    _titleLabel.font = [UIFont systemFontOfSize:(_titleLabel.frame.size.height*0.681818 > 15?(15):_titleLabel.frame.size.height*0.681818) weight:UIFontWeightSemibold];
    _subTitleLabel.font = [UIFont systemFontOfSize:(_subTitleLabel.frame.size.height*0.37837838 > 14?(14):_subTitleLabel.frame.size.height*0.37837838) weight:UIFontWeightMedium];
    
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    _subTitleLabel.adjustsFontSizeToFitWidth = YES;
    
    _homeView.frame = CGRectMake(textFieldSpacing, textFieldSpacing, (self.view.frame.size.width*1 - (textFieldSpacing*2)), (self.view.frame.size.height*0.07472826 > 55?55:self.view.frame.size.height*0.07472826));
//    _codeKeyView.frame = CGRectMake(textFieldSpacing, _homeView.frame.origin.y + _homeView.frame.size.height, (self.view.frame.size.width*1 - (textFieldSpacing*2)), (self.view.frame.size.height*0.07472826 > 55?55:self.view.frame.size.height*0.07472826));
    _keyView.frame = CGRectMake(textFieldSpacing, _subTitleLabel.frame.origin.y + _subTitleLabel.frame.size.height + textFieldSpacing, (self.view.frame.size.width*1 - (textFieldSpacing*2)), (self.view.frame.size.height*0.07472826 > 55?55:self.view.frame.size.height*0.07472826));
    
    _homeNameTextField.frame = CGRectMake(_viewOne.frame.origin.x + textFieldSpacing + width*0.04830918 + ((width*0.0275)*2) + height*0.5, _viewOne.frame.origin.y + _homeView.frame.origin.y, _homeView.frame.size.width - ((_homeView.frame.size.width*0.04830918)*3) - _homeView.frame.size.height*0.5, _homeView.frame.size.height);
//    _codeKeyTextField.frame = CGRectMake(_viewOne.frame.origin.x + textFieldSpacing + width*0.04830918 + ((width*0.0275)*2) + height*0.5, _viewOne.frame.origin.y + _codeKeyView.frame.origin.y, _codeKeyView.frame.size.width - ((_codeKeyView.frame.size.width*0.04830918)*3) - _codeKeyView.frame.size.height*0.5, _codeKeyView.frame.size.height);
    _keyTextField.frame = CGRectMake(_viewTwo.frame.origin.x + textFieldSpacing + width*0.04830918 + ((width*0.0275)*2) + height*0.5, _viewTwo.frame.origin.y + _keyView.frame.origin.y, _keyView.frame.size.width - ((_keyView.frame.size.width*0.04830918)*3) - _keyView.frame.size.height*0.5, _keyView.frame.size.height);
    
    width = CGRectGetWidth(_homeView.bounds);
    height = CGRectGetHeight(_homeView.bounds);
    
    CGFloat fontSize = (self.view.frame.size.height*0.02173813 > 16?16:(self.view.frame.size.height*0.02173813));
    
    self->_homeNameTextField.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightRegular];
    self->_keyTextField.font = self->_homeNameTextField.font;
//    self->_codeKeyTextField.font = self->_homeNameTextField.font;
    
    self->_homeNameTextField.adjustsFontSizeToFitWidth = YES;
    self->_keyTextField.adjustsFontSizeToFitWidth = YES;
//    self->_codeKeyTextField.adjustsFontSizeToFitWidth = YES;
    
    self->_homeNameTextField.minimumFontSize = (height*0.25454545 > 14?14:(height*0.25454545));
    self->_keyTextField.minimumFontSize = (height*0.25454545 > 14?14:(height*0.25454545));
//    self->_codeKeyTextField.minimumFontSize = (height*0.25454545 > 14?14:(height*0.25454545));
    
    CGRect imageFrmae = CGRectMake(width*0.04830918, height*0.5 - ((height*0.5)*0.5), height*0.5, height*0.5);
   
    _homeImage.frame = imageFrmae;
    _keyImage.frame = imageFrmae;
//    _codeKeyImage.frame = imageFrmae;
    
    CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
    
    [[[GeneralObject alloc] init] RoundingCorners:_homeView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
    _keyView.layer.cornerRadius = cornerRadius;
//    [[[GeneralObject alloc] init] RoundingCorners:_codeKeyView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
    
    _homeView.backgroundColor = [UIColor whiteColor];
    _keyView.backgroundColor = [UIColor whiteColor];
//    _codeKeyView.backgroundColor = [UIColor whiteColor];
    
    _homeNameTextField.textColor = [UIColor colorWithRed:138.0f/255.0f green:137.0f/255.0f blue:142.0f/255.0f alpha:1.0f];
    _keyTextField.textColor =  _homeNameTextField.textColor;
//    _codeKeyTextField.textColor =  _homeNameTextField.textColor;
    
    _keyTextField.backgroundColor = _homeNameTextField.backgroundColor;
//    _codeKeyTextField.backgroundColor = _homeNameTextField.backgroundColor;
    
    _createHomeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    _findHomeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModePrimary]};
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.topView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModePrimary];
        self.separatorView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTextSecondary];
        self.homeView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModePrimary];
        self.keyView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModePrimary];
//        self.codeKeyView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModePrimary];
        self.homeNameTextField.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModePrimary];
        self.homeNameTextField.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.keyTextField.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModePrimary];
        self.keyTextField.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
//        self.codeKeyTextField.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModePrimary];
//        self.codeKeyTextField.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.titleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.subTitleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextSecondary];
        _slidingBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        
        [_createHomeButton setTitleColor:[[[LightDarkModeObject alloc] init] DarkModeTextPrimary] forState:UIControlStateNormal];
        [_findHomeButton setTitleColor:[[[LightDarkModeObject alloc] init] DarkModeTextSecondary] forState:UIControlStateNormal];
        
        [self preferredStatusBarStyle];
        
    }
    
    NSArray *arrView = @[_homeView, /*_codeKeyView*/];
    
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

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        return UIStatusBarStyleLightContent;
        
    } else {
        
        return UIStatusBarStyleDefault;
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    _slidingBar.backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    [_createHomeButton setTitleColor:[[[GeneralObject alloc] init] GenerateAppColor:1.0f] forState:UIControlStateNormal];
    [_findHomeButton setTitleColor:[[[GeneralObject alloc] init] GenerateAppColor:1.0f] forState:UIControlStateNormal];
    
    //    CGFloat width = CGRectGetWidth(self.view.bounds);
    //    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat bottomPadding = 0.0;
    
    UIWindow *currentwindow = [UIApplication sharedApplication].windows.firstObject;
    bottomPadding = currentwindow.safeAreaInsets.bottom;
    
    [_homeNameTextField becomeFirstResponder];
    
}

- (void)keyboardWillShow: (NSNotification *) notification{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        //        CGFloat height = CGRectGetHeight(self.view.bounds);
        
        //        NSDictionary* keyboardInfo = [notification userInfo];
        //        NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
        //        CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
        
    }];
    
}

- (void)keyboardWillHide: (NSNotification *) notification{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        //        CGFloat width = CGRectGetWidth(self.view.bounds);
        //        CGFloat height = CGRectGetHeight(self.view.bounds);
        //        CGFloat bottomPadding = 0.0;
        //
        //        if (@available(iOS 11.0, *)) {
        //           UIWindow *window = UIApplication.sharedApplication.keyWindow;
        //           bottomPadding = window.safeAreaInsets.bottom;
        //        }
        
    }];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == _homeNameTextField) {
        
        [self NextButtonAction:self];
        
        [_homeNameTextField becomeFirstResponder];
        
    } else if (textField == _keyTextField) {
        
        [self NextButtonAction:self];
        
        [_keyTextField becomeFirstResponder];
        
    }
    
    return YES;
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpAnalytics];
    
    [self SetUpTitle];
    
    [self SetUpKeyboardNSNotifications];
    
    [self SetUpColors];
    
    [self SetUpTextFieldDelegates];
    
}

-(void)BarButtonItems {
    
    self.navigationItem.hidesBackButton = YES;
    
    if (_comingFromSignUp == NO) {
        
        UIBarButtonItem *barButtonitem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(NavigationBackButtonAction:)];
        
        self.navigationItem.leftBarButtonItem = barButtonitem;
        
    }
    
    UIBarButtonItem *barButtonitem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(NextButtonAction:)];
    
    self.navigationItem.rightBarButtonItem = barButtonitem;
    
}

#pragma mark - Setup Methods

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"CreateHomeViewController" completionHandler:^(BOOL finished) {
        
    }];
    
    [[[GeneralObject alloc] init] TrackInMixPanel:@"CreateHomeViewController"];
    
}

-(void)SetUpTitle {
    
    self.title = @"Create Home";
    
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

-(void)SetUpColors {
    
    [[[GeneralObject alloc] init] SetAttributedPlaceholder:_homeNameTextField color:[UIColor colorWithRed:181.0f/255.0f green:188.0f/255.0f blue:193.0f/255.0f alpha:1.0f]];
    [[[GeneralObject alloc] init] SetAttributedPlaceholder:_keyTextField color:[UIColor colorWithRed:181.0f/255.0f green:188.0f/255.0f blue:193.0f/255.0f alpha:1.0f]];
    defaultFieldColor = _homeView.backgroundColor;
    defaultFieldColor = _keyView.backgroundColor;
    
}

-(void)SetUpTextFieldDelegates {
    
    _homeNameTextField.delegate = self;
    _keyTextField.delegate = self;
    
}

#pragma mark - Photo Methods

-(void)openCamera {
    
    AVAuthorizationStatus authStatusCamera = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (authStatusCamera == AVAuthorizationStatusAuthorized) {
        
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        
        picker.delegate = self;
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    } else if (authStatusCamera != AVAuthorizationStatusAuthorized) {
        
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            
            if (granted) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
                    
                    picker.delegate = self;
                    
                    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    
                    [self presentViewController:picker animated:YES completion:nil];
                    
                });
                
            } else {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Oops!"
                                                                                        message:@"In order upload a profile picture you must allow access to your camera 📷"
                                                                                 preferredStyle:UIAlertControllerStyleAlert];
                    
                    
                    UIAlertAction *gotit = [UIAlertAction actionWithTitle:@"Sure"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * _Nonnull action) {
                        
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
                            
                            [self->progressView setHidden:YES];
                            
                        }];
                        
                    }];
                    
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Nevermind"
                                                                     style:UIAlertActionStyleCancel
                                                                   handler:^(UIAlertAction * _Nonnull action) {
                        
                        [self->progressView setHidden:YES];
                        
                    }];
                    
                    [controller addAction:cancel];
                    [controller addAction:gotit];
                    [self presentViewController:controller animated:YES completion:nil];
                    
                });
                
            }
            
        }];
        
    }
    
}

-(void)openPhotoLibrary {
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusAuthorized) {
        
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        
        picker.delegate = self;
        
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    } else if (status != PHAuthorizationStatusAuthorized) {
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            
            if (status == PHAuthorizationStatusAuthorized) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
                    
                    picker.delegate = self;
                    
                    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                    
                    [self presentViewController:picker animated:YES completion:nil];
                    
                });
                
            } else {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Oops!"
                                                                                        message:@"In order to upload a profile picture you must allow access to your photo library 💾"
                                                                                 preferredStyle:UIAlertControllerStyleAlert];
                    
                    
                    UIAlertAction *gotit = [UIAlertAction actionWithTitle:@"Sure thing"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * _Nonnull action) {
                        
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
                            
                            [self->progressView setHidden:YES];
                            
                        }];
                        
                    }];
                    
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Nevermind"
                                                                     style:UIAlertActionStyleCancel
                                                                   handler:^(UIAlertAction * _Nonnull action) {
                        
                        [self->progressView setHidden:YES];
                        
                    }];
                    
                    [controller addAction:cancel];
                    [controller addAction:gotit];
                    [self presentViewController:controller animated:YES completion:nil];
                    
                });
                
            }
            
        }];
        
    }
    
}

#pragma mark - UI Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

#pragma mark - IBAction Methods

- (IBAction)ViewCreateHomeAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Create Home Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    self.title = @"Create Home";
    
    [_homeNameTextField becomeFirstResponder];
    
    findHomeClicked = NO;
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    [UIView animateWithDuration:0.25 animations:^{
        
        
        [self->_createHomeButton setTitleColor:[[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[GeneralObject alloc] init] GenerateAppColor:1.0f] forState:UIControlStateNormal];
        [self->_findHomeButton setTitleColor:[[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [[[LightDarkModeObject alloc] init] LightModeTextSecondary] forState:UIControlStateNormal];
        
        self->_slidingBar.frame = CGRectMake(
                                             self->_createHomeButton.frame.origin.x + (self->_createHomeButton.frame.size.width*0.5 - ((self.view.frame.size.width*0.333)*0.5)),
                                             self->_topView.frame.origin.y + self->_topView.frame.size.height - 2,
                                             self.view.frame.size.width*0.333,
                                             2);
        
        CGRect newRect = self->_viewOne.frame;
        newRect.origin.x = 0;
        self->_viewOne.frame = newRect;
        
        self->_viewTwo.frame = CGRectMake(width*5, self->_viewOne.frame.origin.y, width, self->_viewOne.frame.size.height);
        
        CGFloat width = CGRectGetWidth(self->_viewOne.bounds);
        CGFloat height = CGRectGetHeight(self->_viewOne.bounds);
        
        CGFloat textFieldSpacing = (self.view.frame.size.height*0.024456);
        
        newRect = self->_homeNameTextField.frame;
        newRect.origin.x = self->_viewOne.frame.origin.x + textFieldSpacing + width*0.04830918 + ((width*0.0275)*2) + height*0.5;
        self->_homeNameTextField.frame = newRect;
        
//        newRect = self->_codeKeyTextField.frame;
//        newRect.origin.x = self->_viewOne.frame.origin.x + textFieldSpacing + width*0.04830918 + ((width*0.0275)*2) + height*0.5;
//        self->_codeKeyTextField.frame = newRect;
        
        newRect = self->_keyTextField.frame;
        newRect.origin.x = self->_viewTwo.frame.origin.x + textFieldSpacing + width*0.04830918 + ((width*0.0275)*2) + height*0.5;
        self->_keyTextField.frame = newRect;
        
    }];
    
}

- (IBAction)ViewJoinHomeAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Find Home Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    self.title = @"Join Home";
    
    [_keyTextField becomeFirstResponder];
    
    findHomeClicked = YES;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [self->_findHomeButton setTitleColor:[[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[GeneralObject alloc] init] GenerateAppColor:1.0f] forState:UIControlStateNormal];
        [self->_createHomeButton setTitleColor:[[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [[[LightDarkModeObject alloc] init] LightModeTextSecondary] forState:UIControlStateNormal];
        
        self->_slidingBar.frame = CGRectMake(
                                             self->_findHomeButton.frame.origin.x + (self->_findHomeButton.frame.size.width*0.5 - ((self.view.frame.size.width*0.333)*0.5)),
                                             self->_topView.frame.origin.y + self->_topView.frame.size.height - 2,
                                             self.view.frame.size.width*0.333,
                                             2);
        
        CGRect newRect = self->_viewOne.frame;
        newRect.origin.x = (-1)*newRect.size.width;
        self->_viewOne.frame = newRect;
        
        newRect = self->_viewTwo.frame;
        newRect.origin.x = 0;
        self->_viewTwo.frame = newRect;
        
        CGFloat width = CGRectGetWidth(self->_viewOne.bounds);
        CGFloat height = CGRectGetHeight(self->_viewOne.bounds);
        
        CGFloat textFieldSpacing = (self.view.frame.size.height*0.024456);
        
        newRect = self->_homeNameTextField.frame;
        newRect.origin.x = self->_viewOne.frame.origin.x + textFieldSpacing + width*0.04830918 + ((width*0.0275)*2) + height*0.5;
        self->_homeNameTextField.frame = newRect;
        
//        newRect = self->_codeKeyTextField.frame;
//        newRect.origin.x = self->_viewOne.frame.origin.x + textFieldSpacing + width*0.04830918 + ((width*0.0275)*2) + height*0.5;
//        self->_codeKeyTextField.frame = newRect;
      
        newRect = self->_keyTextField.frame;
        newRect.origin.x = self->_viewTwo.frame.origin.x + textFieldSpacing + width*0.04830918 + ((width*0.0275)*2) + height*0.5;
        self->_keyTextField.frame = newRect;
        
    }];
    
}

-(IBAction)NextButtonAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Next Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    if (findHomeClicked == NO) {
        
        [self CreateHomeAction:sender];
        
    } else {
        
        [self JoinHomeAction:sender];
        
    }
    
}

-(IBAction)CreateHomeAction:(id)sender {
    
    NSString *homeName = [[[GeneralObject alloc] init] TrimString:[[[GeneralObject alloc] init] RemoveSpecialCharactersFromString:_homeNameTextField.text]];
//    NSString *keyCode = [[[GeneralObject alloc] init] TrimString:[[[GeneralObject alloc] init] RemoveSpecialCharactersFromString:_codeKeyTextField.text]];
    
    if (homeName.length > 0/* && keyCode.length > 0*/) {
        
        [self StartProgressView];
        
        [self CheckIfUserCanCreateThisHome:homeName keyCode:@""];
        
    }
    
    if (homeName.length == 0) {
        
        [[[GeneralObject alloc] init] TextFieldIsEmptyColorChange:self->_homeView textFieldField:self->_homeNameTextField textFieldShouldDisplay:YES defaultColor:self->defaultFieldColor];
        
    }
    
//    if (keyCode.length == 0) {
//        
//        [[[GeneralObject alloc] init] TextFieldIsEmptyColorChange:self->_codeKeyView textFieldField:self->_codeKeyTextField textFieldShouldDisplay:YES defaultColor:self->defaultFieldColor];
//        
//    }
    
}

- (IBAction)JoinHomeAction:(id)sender {
    
    NSString *homeName = [[[GeneralObject alloc] init] TrimString:[[[GeneralObject alloc] init] RemoveSpecialCharactersFromString:_keyTextField.text]];
    
    if (homeName.length > 0) {
        
        [self StartProgressView];
        
        NSString *homeKey = [NSString stringWithFormat:@"%@", _keyTextField.text];
        
        __block int totalQueries = 2;
        __block int completedQueries = 0;
        
        //
        //
        //Check If Home Key Is The Main Home Key
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[[GetDataObject alloc] init] GetDataFindHomeKey:homeKey completionHandler:^(BOOL finished, BOOL homeKeyExists, NSString * _Nonnull homeIDLinkedToKey, NSString * _Nonnull errorString) {
                
                BOOL HomeKeyExistsWithoutError = (homeKeyExists && errorString.length == 0);
               
                if (HomeKeyExistsWithoutError == YES || (totalQueries == (completedQueries+=1))) {
                    
                    [self CheckIfUserCanJoinThisHome:homeKeyExists homeIDLinkedToKey:homeIDLinkedToKey homeKey:homeKey errorString:errorString clickedUnclaimedUser:NO];
                    
                }
                
            }];
            
        });
        
        //
        //
        //Check If Home Key Is One That Was Generated
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[[GetDataObject alloc] init] GetDataFindHomeKeyInKeyArray:homeKey completionHandler:^(BOOL finished, BOOL homeKeyExists, NSString * _Nonnull homeIDLinkedToKey, NSString * _Nonnull errorString) {
               
                BOOL HomeKeyExistsWithoutError = (homeKeyExists && errorString.length == 0);
               
                if (HomeKeyExistsWithoutError == YES || (totalQueries == (completedQueries+=1))) {
                   
                    [self CheckIfUserCanJoinThisHome:homeKeyExists homeIDLinkedToKey:homeIDLinkedToKey homeKey:homeKey errorString:errorString clickedUnclaimedUser:YES];
                    
                }
                
            }];
            
        });
        
    } else {
        
        [[[GeneralObject alloc] init] TextFieldIsEmptyColorChange:self->_keyView textFieldField:self->_keyTextField textFieldShouldDisplay:YES defaultColor:self->defaultFieldColor];
        
    }
    
}

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
    
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

#pragma mark CreateHomeAction

-(void)CheckIfUserCanCreateThisHome:(NSString *)homeName keyCode:(NSString *)keyCode {
    
    NSString *homeID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    NSMutableArray *homeMemberArray = [@[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] mutableCopy];
  
//    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
//    
//    [[[defaultFirestore collectionWithPath:@"InvitationCodes"] queryWhereField:@"InvitationCode" isEqualTo:keyCode] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
//        
//        if (snapshot.documents.count > 0) {
//            
//            BOOL CodeUsed = NO;
//            
//            for (FIRDocumentSnapshot *doc in snapshot.documents) {
//                
//                if ([doc.data[@"InvitationCodeUsed"] isEqualToString:@"Yes"]) {
//                    CodeUsed = YES;
//                    break;
//                }
//                
//            }
//            
//            if (CodeUsed == NO) {
                
                [[[HomesViewControllerObject alloc] init] CreateHome:homeID homeName:homeName homeMemberArray:homeMemberArray keyCode:keyCode completionHandler:^(BOOL finished, NSDictionary *returningHomeDict) {
                    
                    [self PushToInviteHomeMembersViewController:returningHomeDict];
                    
                }];
                
//            } else {
//                
//                [self->progressView setHidden:YES];
//                
//                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"This invitiation code has already been used" currentViewController:self];
//                
//            }
//            
//        } else {
//            
//            [self->progressView setHidden:YES];
//            
//            [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"This invitiation code is not valid" currentViewController:self];
//            
//        }
//        
//    }];
    
}

-(void)PushToInviteHomeMembersViewController:(NSDictionary *)returningHomeDict {
    
    [self->progressView setHidden:YES];
    
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    [mixpanel identify:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    [mixpanel track:@"AddMember" properties:@{@"AddMember" : [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]}];
    
    [[NSUserDefaults standardUserDefaults] setObject:returningHomeDict forKey:@"HomeChosen"];
    
    [[[PushObject alloc] init] PushToInviteMembersViewController:self];
    
}

#pragma mark - JoinHomeAction

-(void)CheckIfUserCanJoinThisHome:(BOOL)homeKeyExists homeIDLinkedToKey:(NSString *)homeIDLinkedToKey homeKey:(NSString *)homeKey errorString:(NSString *)errorString clickedUnclaimedUser:(BOOL)clickedUnclaimedUser {
    
    BOOL HomeKeyIsValid = homeKeyExists == YES && errorString.length == 0;
    
    if (HomeKeyIsValid == YES) {
        
        
        
        /*
         //
         //
         //Check If User Is Joining Home Of Promo Code Sender
         //
         //
         */
        [[[GetDataObject alloc] init] GetDataHomeWithPromoCodeSender:homeIDLinkedToKey completionHandler:^(BOOL finished, BOOL HomeHasPromoCodeSender) {
            
            [self->progressView setHidden:YES];
            
            if (HomeHasPromoCodeSender) {
                
                [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"Your WeDivvy Premium subscription was purchased with a promo code sent by a user in the home you are trying to join. As per our rules and restrictions, this is not allowed. To join this home you must cancel your WeDivvy Premium subscription. If you'd like you can repurchase it without a promo code." currentViewController:self];
                
            } else {
                
                [self->progressView setHidden:YES];
                
                [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"QueryVeryFirstTime"];
                [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"DisplayWeDivvyPremiumPageDisplayedNumberOfTimes"];
                
                [self PushToEnableNotificationViewController:homeIDLinkedToKey homeKey:homeKey clickedUnclaimedUser:clickedUnclaimedUser];
                
            }
            
        }];
        
    } else if (errorString.length > 0) {
        
        [self->progressView setHidden:YES];
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"User Is Already Home Member - %@", homeKey] completionHandler:^(BOOL finished) {
            
        }];
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:errorString currentViewController:self];
        
    } else {
        
        [self->progressView setHidden:YES];
        
    }
    
}

-(void)PushToEnableNotificationViewController:(NSString *)homeIDLinkedToKey homeKey:(NSString *)homeKey clickedUnclaimedUser:(BOOL)clickedUnclaimedUser {
    
    [[[NotificationsObject alloc] init] SendPushNotificationToCreator:[NSString stringWithFormat:@"%@ - Found Home", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] notificationBody:[NSString stringWithFormat:@"Home ID - %@", homeIDLinkedToKey] badgeNumber:(NSInteger *)1 completionHandler:^(BOOL finished) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"SeenNoInvitationsPopup"];
            [[[PushObject alloc] init] PushToEnableNotificationsViewController:self comingFromCreateHome:NO clickedUnclaimedUser:clickedUnclaimedUser homeIDLinkedToKey:homeIDLinkedToKey homeKey:homeKey];
            [self->progressView setHidden:YES];
            
        });
        
    }];
    
}

@end
