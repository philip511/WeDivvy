//
//  EditProfileViewController.m
//  RoommateApp
//
//  Created by Philip Nagel on 5/22/21.
//

#import "UIImageView+Letters.h"

#import "EditProfileViewController.h"
#import "AppDelegate.h"

#import <Photos/Photos.h>
#import <SDWebImage/SDWebImage.h>

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "DeleteDataObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@interface EditProfileViewController () {
    
    MRProgressOverlayView *progressView;
    
    BOOL defaultImageSelected;
    BOOL imagePickerClicked;
    
    NSString *newUsername;
    NSString *newProfileImageURL;
    
    UIButton *greyViewOverlay;
    
    NSManagedObjectContext *managedObjectContext;
    
}

@end

@implementation EditProfileViewController

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

-(void)viewDidLayoutSubviews {
 
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height;
    
    _profileImage.frame = CGRectMake((width*0.5) - 50, navigationBarHeight + 30, 100, 100);
    _greyView.frame = _profileImage.frame;
    
    greyViewOverlay = [[UIButton alloc] initWithFrame:_greyView.frame];
    [self.view addSubview:greyViewOverlay];
    
    [self SetUpAddPhotoContextMenu];
    
    width = CGRectGetWidth(self.greyView.bounds);
    height = CGRectGetHeight(self.greyView.bounds);
    
    _cameraImage.frame = CGRectMake(width*0.5 - 12.5, height*0.5 - 12.5, 25, 25);
    
    width = CGRectGetWidth(self.view.bounds);
    height = CGRectGetHeight(self.view.bounds);
    
    _usernameView.frame =  CGRectMake(0, _profileImage.frame.origin.y + _profileImage.frame.size.height + 15, width*1, 45);
    _nameTextField.frame =  CGRectMake(0, 0, width*1, 45);
    
    _profileImage.layer.cornerRadius = _profileImage.frame.size.height/2;
    _profileImage.clipsToBounds = YES;
    _profileImage.contentMode = UIViewContentModeScaleAspectFill;
    
    _greyView.layer.cornerRadius = _greyView.frame.size.height/2;
    _greyView.clipsToBounds = YES;
    _greyView.contentMode = UIViewContentModeScaleAspectFill;
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.usernameView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.nameTextField.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        
        [self preferredStatusBarStyle];
        
    }
    
}

#pragma mark - Photo Methods

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self->progressView setHidden:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    [self->progressView setHidden:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];

    _profileImage.image = image;

    defaultImageSelected = NO;
    
}

#pragma mark - Custom Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

-(BOOL)InformationHasErrors {
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedStringChoreName = [[[[GeneralObject alloc] init] RemoveSpecialCharactersFromString:_nameTextField.text] stringByTrimmingCharactersInSet:charSet];
    
    if (trimmedStringChoreName.length == 0) {
        
        [progressView setHidden:YES];
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"One or more fields are empty" currentViewController:self];
        
        return true;
        
    }
    
    return false;
}

#pragma mark - Init Methods

-(void)InitMethod {

    [self SetUpAnalytics];

    [self SetUpAddPhotoContextMenu];
    
    [self SetUpData];
    
}

-(void)BarButtonItems {
    
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(NavigationBackButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = newBackButton;
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                  style:UIBarButtonItemStyleDone
                                 target:self
                                 action:@selector(EditInfo:)];
  
    self.navigationItem.rightBarButtonItem = button;

}

#pragma mark - Photo Methods

-(void)openCamera {
    
    AVAuthorizationStatus authStatusCamera = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];

    if (authStatusCamera == AVAuthorizationStatusAuthorized) {

        UIImagePickerController * picker = [[UIImagePickerController alloc] init];

        picker.delegate = self;

        picker.sourceType = UIImagePickerControllerSourceTypeCamera;

        [self presentViewController:picker animated:YES completion:^{
           
            [self->progressView setHidden:YES];
            
        }];

    } else if (authStatusCamera != AVAuthorizationStatusAuthorized) {

        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {

            if (granted) {

              dispatch_async(dispatch_get_main_queue(), ^{

                  UIImagePickerController * picker = [[UIImagePickerController alloc] init];

                  picker.delegate = self;

                  picker.sourceType = UIImagePickerControllerSourceTypeCamera;

                  [self presentViewController:picker animated:YES completion:^{
                      
                      [self->progressView setHidden:YES];
                      
                  }];

              });

            } else {

              dispatch_async(dispatch_get_main_queue(), ^{

                  [self->progressView setHidden:YES];
                  
                  UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Oops 😪"
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
        
        [self presentViewController:picker animated:YES completion:^{
            
            [self->progressView setHidden:YES];
            
        }];
        
    } else if (status != PHAuthorizationStatusAuthorized) {
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            
            if (status == PHAuthorizationStatusAuthorized) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
                    
                    picker.delegate = self;
                    
                    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                    
                    [self presentViewController:picker animated:YES completion:^{
                        
                        [self->progressView setHidden:YES];
                        
                    }];
                    
                });
                
            } else {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self->progressView setHidden:YES];
                    
                    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Oops 😪"
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

#pragma mark - Setup Methods

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"EditProfileViewController" completionHandler:^(BOOL finished) {
        
    }];
    
}

-(void)SetUpAddPhotoContextMenu {
    
    NSMutableArray* actions = [[NSMutableArray alloc] init];
    NSMutableArray *noPhotoActions = [[NSMutableArray alloc] init];
    
    [actions addObject:[UIAction actionWithTitle:@"Photo Library" image:[UIImage systemImageNamed:@"photo.on.rectangle"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Photo Library"] completionHandler:^(BOOL finished) {
            
        }];
        
        [self StartProgressView];
        
        [self openPhotoLibrary];
        
    }]];
    
    [actions addObject:[UIAction actionWithTitle:@"Camera" image:[UIImage systemImageNamed:@"camera"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Camera"] completionHandler:^(BOOL finished) {
            
        }];
        
        [self StartProgressView];
        
        [self openCamera];
        
    }]];
    
    UIAction *noPhotoAction = [UIAction actionWithTitle:@"No Photo" image:[UIImage systemImageNamed:@"xmark.square"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Default Photo"] completionHandler:^(BOOL finished) {
            
        }];
        
        NSString *username = self->_nameTextField.text;
        
        UIColor *backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:0.15f];
        UIColor *textColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
        
        [self->_profileImage setImageWithString:username color:backgroundColor circular:YES textAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Medium" size:self->_profileImage.frame.size.height*0.45], NSForegroundColorAttributeName:textColor}];
        
        self->defaultImageSelected = YES;
        
    }];
    
    [noPhotoAction setAttributes:UIMenuElementAttributesDestructive];
    
    [noPhotoActions addObject:noPhotoAction];
    
    UIMenu *noPhotoMenuActions = [UIMenu menuWithTitle:@"" image:nil identifier:@"" options:UIMenuOptionsDisplayInline children:noPhotoActions];
    
    [actions addObject:noPhotoMenuActions];
    
    greyViewOverlay.menu = [UIMenu menuWithTitle:@"" children:actions];
    greyViewOverlay.showsMenuAsPrimaryAction = true;
    
}

-(void)SetUpData {
    
    NSString *username = self->_name;
    NSString *profileImageURL = self->_imageURL;
    
    self->_nameTextField.text = username;
    
    UIColor *backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:0.15f];
    UIColor *textColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    
    if (profileImageURL == nil || profileImageURL.length == 0 || [profileImageURL containsString:@"(null)"] || [profileImageURL isEqualToString:@"xxx"] || [profileImageURL isEqualToString:@"XXX"] || [profileImageURL isEqualToString:@"https://firebasestorage.googleapis.com/v0/b/wedivvy-afe04.appspot.com/o/DefaultImages%2FdefaultProfileImage.png?alt=media&token=6892f430-8337-4327-89a4-53a403d1186c"] || [profileImageURL containsString:@"DefaultImage"]) {
        
        self->defaultImageSelected = YES;
        
        [self.profileImage setImageWithString:username color:backgroundColor circular:YES textAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Medium" size:self.profileImage.frame.size.height*0.45], NSForegroundColorAttributeName:textColor}];
        
    } else {
        
        self->defaultImageSelected = NO;
        
        [self.profileImage sd_setImageWithURL:[NSURL URLWithString:profileImageURL]];
        
    }
    
}

#pragma mark - IBAction Methods

-(IBAction)EditInfo:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Update User Info"] completionHandler:^(BOOL finished) {
        
    }];
    
    if ([self InformationHasErrors] == NO) {
    
        if (_editingHome) {
            
            if (defaultImageSelected == YES) {
                
                [self DeletePhotoAndUpdateHomeInfo];
                
            } else {
                
                [self UpdatePhotoAndUpdateHomeInfo];
                
            }
            
        } else {
            
            if (defaultImageSelected == YES) {
               
                [self DeletePhotoAndUpdateUserInfo];
                
            } else {
                
                [self UpdatePhotoAndUpdateUserInfo];
                
            }
            
        }
        
    }
    
}

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark Update Info

-(void)UpdatePhotoAndUpdateHomeInfo {
    
    [self StartProgressView];
    
    
    
    UIImage *profileImage = self->_profileImage.image;
    
 
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] SetDataHomeImage:profileImage homeID:self->_homeID completionHandler:^(BOOL finished, NSString * _Nonnull homeImageURL) {
            
            
            
            self->newProfileImageURL = homeImageURL;
            self->newUsername = [[[GeneralObject alloc] init] RemoveSpecialCharactersFromString:self->_nameTextField.text];
            
            
            
            NSDictionary *userDict = @{
                @"HomeID" : self->_homeID,
                @"HomeName" : self->newUsername,
                @"HomeImageURL" : self->newProfileImageURL
            };
            
            
            
            [[[SetDataObject alloc] init] UpdateDataHome:self->_homeID homeDict:userDict completionHandler:^(BOOL finished) {
                
                [self EditInfo_CompletionBlock:@"EditHome" dataDict:userDict locations:@[@"Homes"] totalQueries:1 completedQueries:1];
                
            }];
            
        }];
        
    });
    
}

-(void)DeletePhotoAndUpdateHomeInfo {
    
    [self StartProgressView];
    
    
    
    __block int totalQueries = 2;
    __block int completedQueries = 0;
    
    
    
    self->newProfileImageURL = @"xxx";
    self->newUsername = [[[GeneralObject alloc] init] RemoveSpecialCharactersFromString:self->_nameTextField.text];
    
    
    
    NSDictionary *userDict = @{
        @"HomeID" : self->_homeID,
        @"HomeName" : self->newUsername,
        @"HomeImageURL" : self->newProfileImageURL
    };
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[DeleteDataObject alloc] init] DeleteDataHomeImage:self->_homeID completionHandler:^(BOOL finished) {
            
            [self EditInfo_CompletionBlock:@"EditHome" dataDict:userDict locations:@[@"Homes"] totalQueries:totalQueries completedQueries:(completedQueries+=1)];
            
        }];
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataHome:self->_homeID homeDict:userDict completionHandler:^(BOOL finished) {
            
            [self EditInfo_CompletionBlock:@"EditHome" dataDict:userDict locations:@[@"Homes"] totalQueries:totalQueries completedQueries:(completedQueries+=1)];
            
        }];
        
    });
    
}


-(void)UpdatePhotoAndUpdateUserInfo {
    
    [self StartProgressView];
    
    
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"];
    UIImage *profileImage = self->_profileImage.image;
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] SetDataProfileImage:profileImage completionHandler:^(BOOL finished, NSString * _Nonnull profileImageURL) {
            
            
            
            self->newProfileImageURL = profileImageURL;
            self->newUsername = [[[GeneralObject alloc] init] RemoveSpecialCharactersFromString:self->_nameTextField.text];
            
            
            
            NSDictionary *userDict = @{
                @"Username" : self->newUsername,
                @"ProfileImageURL" : self->newProfileImageURL
            };
            
        
            
            [[NSUserDefaults standardUserDefaults] setObject:self->newUsername forKey:@"UsersUsername"];
            [[NSUserDefaults standardUserDefaults] setObject:self->newProfileImageURL forKey:@"UsersProfileImage"];
            
            
            
            NSMutableDictionary *homeMembersDict = [self User_UpdateHomeMembersDict:userID];
            [[NSUserDefaults standardUserDefaults] setObject:homeMembersDict forKey:@"HomeMembersDict"];
            
            
            
            [[[SetDataObject alloc] init] UpdateDataUserData:userID userDict:userDict completionHandler:^(BOOL finished, NSError * _Nonnull error) {
               
                [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ReloadView" userInfo:userDict locations:@[@"Profile"]];
                [self EditInfo_CompletionBlock:@"UpdateHomeMembersDict" dataDict:@{@"HomeMembersDict" : homeMembersDict} locations:@[@"Tasks"] totalQueries:1 completedQueries:1];
                
            }];
            
        }];
        
    });
    
}

-(void)DeletePhotoAndUpdateUserInfo {
    
    [self StartProgressView];
    
    
    
    __block int totalQueries = 2;
    __block int completedQueries = 0;
    
    
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"];
    
    
    
    self->newProfileImageURL = @"xxx";
    self->newUsername = [[[GeneralObject alloc] init] RemoveSpecialCharactersFromString:self->_nameTextField.text];
    
    
    
    NSDictionary *userDict = @{
        @"Username" : self->newUsername,
        @"ProfileImageURL" : self->newProfileImageURL
    };
    
    
    
    [[NSUserDefaults standardUserDefaults] setObject:self->newUsername forKey:@"UsersUsername"];
    [[NSUserDefaults standardUserDefaults] setObject:self->newProfileImageURL forKey:@"UsersProfileImage"];
    
    
    
    NSMutableDictionary *homeMembersDict = [self User_UpdateHomeMembersDict:userID];
    [[NSUserDefaults standardUserDefaults] setObject:homeMembersDict forKey:@"HomeMembersDict"];
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[DeleteDataObject alloc] init] DeleteDataProfileImage:userID completionHandler:^(BOOL finished, NSError * _Nonnull error) {
       
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ReloadView" userInfo:userDict locations:@[@"Profile"]];
            [self EditInfo_CompletionBlock:@"UpdateHomeMembersDict" dataDict:@{@"HomeMembersDict" : homeMembersDict} locations:@[@"Tasks"] totalQueries:totalQueries completedQueries:(completedQueries+=1)];
            
        }];
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataUserData:userID userDict:userDict completionHandler:^(BOOL finished, NSError * _Nonnull error) {
            
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ReloadView" userInfo:userDict locations:@[@"Profile"]];
            [self EditInfo_CompletionBlock:@"UpdateHomeMembersDict" dataDict:@{@"HomeMembersDict" : homeMembersDict} locations:@[@"Tasks"] totalQueries:totalQueries completedQueries:(completedQueries+=1)];
            
        }];
        
    });
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

-(NSMutableDictionary *)User_UpdateHomeMembersDict:(NSString *)userID {
    
    NSMutableDictionary *homeMembersDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersDict"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSUInteger index = [homeMembersDict[@"UserID"] containsObject:userID] ? [homeMembersDict[@"UserID"] indexOfObject:userID] : 10000;
    NSMutableArray *usernameArray = homeMembersDict[@"Username"] ? [homeMembersDict[@"Username"] mutableCopy] : [NSMutableArray array];
    NSMutableArray *userProfileImageArray = homeMembersDict[@"ProfileImageURL"] ? [homeMembersDict[@"ProfileImageURL"] mutableCopy] : [NSMutableArray array];
    
    if ([usernameArray count] > index) { [usernameArray replaceObjectAtIndex:index withObject:self->newUsername]; }
    if ([userProfileImageArray count] > index) { [userProfileImageArray replaceObjectAtIndex:index withObject:self->newProfileImageURL]; }
    
    [homeMembersDict setObject:usernameArray forKey:@"Username"];
    [homeMembersDict setObject:userProfileImageArray forKey:@"ProfileImageURL"];
    
    return homeMembersDict;
}

-(void)EditInfo_CompletionBlock:(NSString *)notificationMethod dataDict:(NSDictionary *)dataDict locations:(NSArray *)locations totalQueries:(int)totalQueries completedQueries:(int)completedQueries {
    
    if (totalQueries == completedQueries) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self->progressView setHidden:YES];
            [[[GeneralObject alloc] init] CallNSNotificationMethods:notificationMethod userInfo:dataDict locations:locations];
           
            [self.navigationController popViewControllerAnimated:YES];
            
        });
        
    }
    
}

@end
