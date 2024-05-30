//
//  AddForumViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 8/11/21.
//

#import "AddChatViewController.h"
#import "AppDelegate.h"

#import <MRProgress/MRProgressOverlayView.h>

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "PushObject.h"
#import "NotificationsObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@interface AddChatViewController () {
    
    MRProgressOverlayView *progressView;
    
    UIColor *defaultFieldColor;
    
    NSMutableArray *assignedToIDArray;
    NSMutableArray *assignedToUsernameArray;
    NSMutableArray *assignedToUsernameExclusiveArray;
    NSMutableArray *assignedToProfileImageArray;
    
    NSMutableDictionary *userDictForHomeMembers;
    
    NSString *itemType;
    NSString *chosenItemAssignedToNewHomeMembers;
    
    BOOL AddOrEditIsProcessing;
    
    UIButton *addPhotoViewOverlay;
    
}

@end

@implementation AddChatViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self InitMethod];
    
    [self BarButtonItems];
    
    [self TapGestures];
    
    [self SetUpKeyBoardToolBar];
    
    [self NSNotificatinObservers];
    
    addPhotoViewOverlay = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _itemNameView.frame.size.width, _addImageView.frame.size.height)];
    [_addImageView addSubview:addPhotoViewOverlay];
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Choose Photo Clicked For Chat"] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableArray* actions = [[NSMutableArray alloc] init];
    NSMutableArray* noPhotoActions = [[NSMutableArray alloc] init];
    
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
        
        self->_addImageImage.image = nil;
        self->_addImageImage.hidden = YES;
        
    }];
    
    [noPhotoAction setAttributes:UIMenuElementAttributesDestructive];
    [noPhotoActions addObject:noPhotoAction];
    
    UIMenu *noPhotoMenuActions = [UIMenu menuWithTitle:@"" image:nil identifier:@"" options:UIMenuOptionsDisplayInline children:noPhotoActions];
    [actions addObject:noPhotoMenuActions];
    
    addPhotoViewOverlay.menu = [UIMenu menuWithTitle:@"" children:actions];
    addPhotoViewOverlay.showsMenuAsPrimaryAction = true;
    
    if ([[self->_itemToEditDict allKeys] containsObject:@"ChatID"]) {
        
        [self SetUpEdittingData];
        
    }
 
}

-(void)viewDidLayoutSubviews {
    
    _itemAssignedToView.hidden = YES;
    _itemAssignedToTextField.hidden = YES;
    _itemAssignedToImage.hidden = YES;
    _itemAssignedToLabel.hidden = YES;
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    
    CGFloat textFieldSpacing = (height*0.024456);
    
    self->_itemNameView.frame = CGRectMake(textFieldSpacing, navigationBarHeight + textFieldSpacing, (width*1 - (textFieldSpacing*2)), (self.view.frame.size.height*0.07472826 > 55?55:(self.view.frame.size.height*0.07472826)));
    
//    self->_itemAssignedToView.frame = CGRectMake(self->_itemNameView.frame.origin.x, self->_itemNameView.frame.origin.y + self->_itemNameView.frame.size.height + textFieldSpacing, self->_itemNameView.frame.size.width, (self->_itemNameView.frame.size.height));
    
    self->_addImageView.frame = CGRectMake(self->_itemNameView.frame.origin.x, self->_itemNameView.frame.origin.y + self->_itemNameView.frame.size.height + textFieldSpacing, self->_itemNameView.frame.size.width, (self->_itemNameView.frame.size.height));
    
    CGFloat fontSize = (self.view.frame.size.height*0.02173813 > 16?16:(self.view.frame.size.height*0.02173813));
    
    self->_itemNameTextField.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightRegular];
    self->_itemNameTextField.adjustsFontSizeToFitWidth = YES;
    self->_itemNameTextField.minimumFontSize = (height*0.25454545 > 14?14:(height*0.25454545));
    
//    self->_itemAssignedToTextField.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightRegular];
//    self->_itemAssignedToTextField.adjustsFontSizeToFitWidth = YES;
//    self->_itemAssignedToTextField.minimumFontSize = (height*0.25454545 > 14?14:(height*0.25454545));
    
//    self->_itemAssignedToLabel.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightRegular];
//    self->_itemAssignedToLabel.adjustsFontSizeToFitWidth = YES;
    
    self->_itemAddImageLabel.titleLabel.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightRegular];
    self->_itemAddImageLabel.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    width = CGRectGetWidth(self.itemNameView.bounds);
    height = CGRectGetHeight(self.itemNameView.bounds);
    
    _rightArrowImage1.frame = CGRectMake(width*1 - width*0.02339181 - width*0.04830918, height*0, width*0.02339181, height*1);
    
    _itemNameTextField.frame = CGRectMake(width*0.04830918, height*0, width*1 - ((width*0.04830918)*2), height);
//    _itemAssignedToTextField.frame = CGRectMake(width*0.04830918, height*0, width*1 - ((width*0.04830918)*2), height);
    
    _itemAddImageLabel.frame =CGRectMake(width*0.04830918 - (width*0.01932367), height*0, width*1 - ((width*0.04830918)*2), height);
    _addImageImage.frame = CGRectMake(width - (height*0.5) - width*0.04830918, height*0.5 - ((height*0.5)*0.5), height*0.5, height*0.5);
    
    _addImageImage.clipsToBounds = YES;
    _addImageImage.contentMode = UIViewContentModeScaleAspectFill;
    
    CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
    
    _itemNameView.layer.cornerRadius = cornerRadius;
//    _itemAssignedToView.layer.cornerRadius = cornerRadius;
    _addImageView.layer.cornerRadius = cornerRadius;
    _addImageImage.layer.cornerRadius = (_addImageImage.frame.size.height*0.2181818182);
    
    _itemNameView.backgroundColor = [UIColor whiteColor];
//    _itemAssignedToView.backgroundColor = [UIColor whiteColor];
    _addImageView.backgroundColor = _itemNameView.backgroundColor;
    
    UIColor *textColor = [UIColor colorWithRed:138.0f/255.0f green:137.0f/255.0f blue:142.0f/255.0f alpha:1.0f];
    
    _itemNameTextField.textColor = textColor;
//    _itemAssignedToTextField.textColor = textColor;
    
    UIColor *backgroundColor = [UIColor clearColor];
    
    _itemNameTextField.backgroundColor = backgroundColor;
//    _itemAssignedToTextField.backgroundColor = backgroundColor;
    
    
//    NSArray *labelWithImageArray = @[
//
//        @{@"View" : _itemAssignedToLabel, @"Width" : @"0.205"},
//
//    ];
//
//    [self LabelWithImage:labelWithImageArray];
//
//
//
//
//    NSArray *textFieldWithArrowArray = @[
//
//        @{@"View" : _itemAssignedToTextField, @"Label" : _itemAssignedToLabel}
//
//    ];
//
//    [self TextFieldWithArrow:textFieldWithArrowArray];
    
    
    
    
//    CGRect imageFrmae = CGRectMake(width*0.04830918, height*0.5 - ((height*0.5)*0.5), height*0.5, height*0.5);
//
//    NSArray *imageArr = @[_itemAssignedToImage];
//
//    for (UIImageView *image in imageArr) {
//        image.frame = imageFrmae;
//    }
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary]};
        
        self.itemNameView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
//        self.itemAssignedToView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.addImageView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        
        self.itemNameTextField.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextSecondary];
//        self.itemAssignedToTextField.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextSecondary];
        
//        self.itemAssignedToLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        
        [self preferredStatusBarStyle];
        
    }
    
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        return UIStatusBarStyleLightContent;
        
    } else {
        
        return UIStatusBarStyleDefault;
        
    }
    
}

-(BOOL)prefersStatusBarHidden {
    
    return YES;
}

#pragma mark

-(void)LabelWithoutImage:(NSArray *)viewArray {
    
    CGFloat width = CGRectGetWidth(self.itemNameView.bounds);
    CGFloat height = CGRectGetHeight(self.itemNameView.bounds);
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UIView *viewToUse = dictToUse[@"View"];
        float labelWidth = [dictToUse[@"Width"] floatValue];
        
        viewToUse.frame = CGRectMake(width*0.04830918, height*0, width*labelWidth, height);
        
    }
    
}

-(void)LabelWithImage:(NSArray *)viewArray {
    
    CGFloat width = CGRectGetWidth(self.itemNameView.bounds);
    CGFloat height = CGRectGetHeight(self.itemNameView.bounds);
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UIView *viewToUse = dictToUse[@"View"];
        float labelWidth = [dictToUse[@"Width"] floatValue];
        
        viewToUse.frame = CGRectMake(width*0.04830918 + width*0.0275 + height*0.5, height*0, width*labelWidth, height);
        
    }
    
}

-(void)TextFieldWithArrow:(NSArray *)viewArray {
    
    CGFloat width = CGRectGetWidth(self.itemNameView.bounds);
    CGFloat height = CGRectGetHeight(self.itemNameView.bounds);
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UIView *viewToUse = dictToUse[@"View"];
        UILabel *labelToUse = dictToUse[@"Label"];
        
        CGFloat textFieldWidth = (width*1 - (width*0.04830918) - _itemNameView.frame.origin.x - labelToUse.frame.origin.x - labelToUse.frame.size.width);
        
        viewToUse.frame = CGRectMake(_rightArrowImage1.frame.origin.x - textFieldWidth - width*0.025 + width*0.025, height*0, textFieldWidth - width*0.025, height);
        
    }
    
}

-(void)TextFieldWithoutArrow:(NSArray *)viewArray {
    
    CGFloat width = CGRectGetWidth(self.itemNameView.bounds);
    CGFloat height = CGRectGetHeight(self.itemNameView.bounds);
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UIView *viewToUse = dictToUse[@"View"];
        UILabel *labelToUse = dictToUse[@"Label"];
        
        CGFloat textFieldWidth = (width*1 - ((width*0.04830918)*0.5) - _itemNameView.frame.origin.x - labelToUse.frame.origin.x - labelToUse.frame.size.width);
        
        viewToUse.frame = CGRectMake(width - textFieldWidth - width*0.04830918, height*0, textFieldWidth, height);
        
    }
    
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

#pragma mark - Image Picker Methods

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self->progressView setHidden:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    _addImageImage.image = image;
    
    if (_addImageImage.image != nil) {
        
        _addImageImage.hidden = NO;
        [self->progressView setHidden:YES];
        
    } else {
        
        _addImageImage.hidden = YES;
        [self->progressView setHidden:YES];
        
    }
    
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpAnalytics];
    
    [self SetUpItemType];
    
    [self SetUpTitle];
    
    [self SetUpDelegates];
    
    [self SetUpHidden];
    
    [self SetUpTextFields];
    
    [self SetUpColor];
    
}

-(void)BarButtonItems {
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *barButtonItem;
    
    barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(NavigationBackButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    if ([[self->_itemToEditDict allKeys] containsObject:@"ChatID"]) {
        
        barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                         style:UIBarButtonItemStyleDone
                                                        target:self
                                                        action:@selector(EditItem:)];
        
    } else {
        
        barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add"
                                                         style:UIBarButtonItemStyleDone
                                                        target:self
                                                        action:@selector(AddItem:)];
        
    }
    
    
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
}

-(void)TapGestures {
    
    UITapGestureRecognizer *tapGesture;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureAssignedTo:)];
    [_itemAssignedToTextField addGestureRecognizer:tapGesture];
    [_itemAssignedToView addGestureRecognizer:tapGesture];
    _itemAssignedToTextField.userInteractionEnabled = NO;
    _itemAssignedToView.userInteractionEnabled = YES;
    
}

-(void)SetUpKeyBoardToolBar {
    
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    
    [keyboardToolbar sizeToFit];
    
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                      target:self action:@selector(DismissAllKeyboards)];
    
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    
    self.itemNameTextField.inputAccessoryView = keyboardToolbar;
    
}

-(void)NSNotificatinObservers {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_AddChat_ItemAssignedTo" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_AddChat_ItemAssignedTo:) name:@"NSNotification_AddChat_ItemAssignedTo" object:nil];
    
}

#pragma mark - Setup Methods

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"AddChatViewController" completionHandler:^(BOOL finished) {
        
    }];
    
}

-(void)SetUpTitle {
    
    self.title = @"New Chat";
    
}

-(void)SetUpDelegates {
    
    _itemNameTextField.delegate = self;
    
}

-(void)SetUpHidden {
    
    if ([[self->_itemToEditDict allKeys] containsObject:@"ChatID"]) {
        
        if ([self->_itemToEditDict[@"ChatImageURL"] isEqualToString:@"xxx"]) {
            
            _addImageImage.hidden = YES;
            
        } else {
            
            _addImageImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self->_itemToEditDict[@"ChatImageURL"]]]];
            _addImageImage.hidden = NO;
            
        }
        
    }
    
}

-(void)SetUpTextFields {
    
    [_itemNameTextField becomeFirstResponder];
    
    self->userDictForHomeMembers = [_homeMembersDict mutableCopy];
    assignedToIDArray = [NSMutableArray array];
    assignedToUsernameArray = [NSMutableArray array];
    assignedToProfileImageArray = [NSMutableArray array];
    
    if ([[self->_itemToEditDict allKeys] containsObject:@"ChatID"]) {
        
        self->_itemNameTextField.text = self->_itemToEditDict[@"ChatName"];
        
        self->assignedToIDArray = [self->_itemToEditDict[@"ChatAssignedTo"] mutableCopy];
        
        for (NSString *userID in self->assignedToIDArray) {
            
            NSUInteger index = [self->userDictForHomeMembers[@"UserID"] indexOfObject:userID];
            
            if ([(NSArray *)self->userDictForHomeMembers[@"Username"] count] > index) {
                [self->assignedToUsernameArray addObject:self->userDictForHomeMembers[@"Username"][index]];
            }
            if ([(NSArray *)self->userDictForHomeMembers[@"ProfileImageURL"] count] > index) {
                [self->assignedToProfileImageArray addObject:self->userDictForHomeMembers[@"ProfileImageURL"][index]];
            }
            
        }
        
    }
    
}

-(void)SetUpColor {
    
    [[[GeneralObject alloc] init] SetAttributedPlaceholder:_itemNameTextField color:[UIColor colorWithRed:181.0f/255.0f green:188.0f/255.0f blue:193.0f/255.0f alpha:1.0f]];
    
    defaultFieldColor = _itemNameView.backgroundColor;
    
}

-(void)SetUpItemType {
    
    self->itemType = @"GroupChat";
    
}

#pragma mark - UI Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

#pragma mark - UX Methods

-(void)DismissAllKeyboards {
    
    [self.itemNameTextField resignFirstResponder];
    
}

-(BOOL)GroupChatBeingAddedHasErrors {
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedStringItemName = [_itemNameTextField.text stringByTrimmingCharactersInSet:charSet];

    if (trimmedStringItemName.length == 0) {
        
        [[[GeneralObject alloc] init] TextFieldIsEmptyColorChange:_itemNameView textFieldField:_itemNameTextField textFieldShouldDisplay:YES  defaultColor:defaultFieldColor];
        
        [progressView setHidden:YES];
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Error"] completionHandler:^(BOOL finished) {
            
        }];
        
        return true;
        
    }

    return false;
}

-(void)SetUpEdittingData {
    
    self->_itemNameTextField.text = self->_itemToEditDict[@"ChatName"];
    self->chosenItemAssignedToNewHomeMembers = self->_itemToEditDict[@"ChatAssignedToNewHomeMembers"];
    
    
    
    
    
    
    
    self->assignedToIDArray = [self->_itemToEditDict[@"ChatAssignedTo"] mutableCopy];
    
    for (NSString *userID in self->assignedToIDArray) {
        
        NSUInteger index = [self->userDictForHomeMembers[@"UserID"] indexOfObject:userID];
        
        if ([(NSArray *)self->userDictForHomeMembers[@"Username"] count] > index) {
            [self->assignedToUsernameArray addObject:self->userDictForHomeMembers[@"Username"][index]];
        }
        if ([(NSArray *)self->userDictForHomeMembers[@"ProfileImageURL"] count] > index) {
            [self->assignedToProfileImageArray addObject:self->userDictForHomeMembers[@"ProfileImageURL"][index]];
        }
        
    }
    
    
    
    
    
    
    
    NSString *itemAssignedTo = @"";
    
    BOOL TaskIsAssignedToMyself = [[[BoolDataObject alloc] init] TaskIsAssignedToOnlyMyself:_itemToEditDict itemType:itemType];
    
    for (NSString *userID in self->assignedToIDArray) {
        
        NSUInteger index = [self->assignedToIDArray indexOfObject:userID];
        
        if (itemAssignedTo.length == 0 && TaskIsAssignedToMyself == NO) {
            
            itemAssignedTo = [NSString stringWithFormat:@"%@", self->assignedToUsernameArray[index]];
            
        } else if (TaskIsAssignedToMyself == YES) {
            
            itemAssignedTo = @"Myself";
            
        } else {
            
            itemAssignedTo = [NSString stringWithFormat:@"%@, %@", itemAssignedTo,  self->assignedToUsernameArray[index]];
            
        }
        
    }
    
    self->_itemAssignedToTextField.text = itemAssignedTo;
    
}

#pragma mark - IBAction Methods

-(IBAction)AddItem:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Adding Chat"] completionHandler:^(BOOL finished) {
        
    }];
    
    if ([self GroupChatBeingAddedHasErrors] == NO) {
    
        NSMutableDictionary *setDataDict = [self AddItem_GenerateSetDataDict];
    
        [self AddItem_SetLocalItemData:setDataDict];
        
        [self AddItem_CompletionBlock];
    
        
        
        /*
         //
         //
         //Set Group Chat Data
         //
         //
         */
        [self AddItem_SetGroupChatData:setDataDict completionHandler:^(BOOL finished) {
            
        }];
        
        
        /*
         //
         //
         //Set Image Data
         //
         //
         */
        [self AddItem_SetImageData:setDataDict completionHandler:^(BOOL finished) {
            
        }];
        
        
        /*
         //
         //
         //Send Push Notification
         //
         //
         */
        [self AddItem_SendPushNotification:setDataDict completionHandler:^(BOOL finished) {
            
        }];
        
        
        /*
         //
         //
         //Set Topic Data
         //
         //
         */
        [self AddItem_SetTopicData:setDataDict completionHandler:^(BOOL finished) {
            
        }];
        
    }
    
}

-(IBAction)EditItem:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Editting Chat"] completionHandler:^(BOOL finished) {
        
    }];
    
    if ([self GroupChatBeingAddedHasErrors] == NO) {
        
        [self StartProgressView];
        
        NSMutableDictionary *setDataDict = [self EditItem_GenerateSetDataDict];

        [self EditItem_SetLocalItemData:setDataDict];
        
        [self EditItem_CompletionBlock];
        
        
        
        /*
         //
         //
         //Update Group Chat Data
         //
         //
         */
        [self EditItem_UpdateChatData:setDataDict completionHandler:^(BOOL finished) {
            
        }];
        
        
        /*
         //
         //
         //Update Image Data
         //
         //
         */ 
        [self EditItem_UpdateImageData:setDataDict completionHandler:^(BOOL finished) {
            
        }];
        
        
        /*
         //
         //
         //Send Push Notification
         //
         //
         */ 
        [self EditItem_SendPushNotification:setDataDict completionHandler:^(BOOL finished) {
            
        }];
        
        
        /*
         //
         //
         //Update Topic Data
         //
         //
         */
        [self EditItem_UpdateTopicData:setDataDict completionHandler:^(BOOL finished) {
            
        }];
        
    }
    
}

- (IBAction)CloseImageAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Close Image Clicked For Chat"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked For Chat"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Tap Gesture IBAction Methods

-(IBAction)TapGestureAssignedTo:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Assigned To Field Clicked For Chat"] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableArray *selectedArray = [NSMutableArray array];
    
    if ([_itemAssignedToTextField.text isEqualToString:@"Myself"]) {
        [selectedArray addObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]];
    } else if ([_itemAssignedToTextField.text isEqualToString:@"Nobody"] == NO) {
        selectedArray = [[_itemAssignedToTextField.text componentsSeparatedByString:@", "] mutableCopy];
    }
    
    [selectedArray removeObject:@""];
    
    NSString *itemAssignedToNewHomeMembers = self->chosenItemAssignedToNewHomeMembers != NULL ? self->chosenItemAssignedToNewHomeMembers : @"No";
    
    NSMutableDictionary *homeMembersUnclaimedDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersUnclaimedDict"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersUnclaimedDict"] : [NSMutableDictionary dictionary];
    NSMutableDictionary *homeKeysDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeKeysDict"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeKeysDict"] : [NSMutableDictionary dictionary];
    NSMutableArray *homeKeysArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeKeysArray"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeKeysArray"] : [NSMutableArray array];
    
    [[[PushObject alloc] init] PushToViewAssignedViewController:selectedArray itemAssignedToNewHomeMembers:itemAssignedToNewHomeMembers itemAssignedToAnybody:@"No" itemUniqueID:@"" homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict homeMembersUnclaimedDict:homeMembersUnclaimedDict homeKeysDict:homeKeysDict homeKeysArray:homeKeysArray notificationSettingsDict:_notificationSettingsDict topicDict:_topicDict viewingItemDetails:NO viewingExpense:NO viewingChatMembers:YES viewingWeDivvyPremiumAddingAccounts:NO viewingWeDivvyPremiumEditingAccounts:NO currentViewController:self];
    
}

#pragma mark - NSNotification Methods

-(void)NSNotification_AddChat_ItemAssignedTo:(NSNotification *)notification {
    
    _itemAssignedToView.backgroundColor = _itemNameView.backgroundColor;
    
    
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSMutableArray *assignedToUsernameLocalArray = userInfo[@"AssignedToUsername"] ? [userInfo[@"AssignedToUsername"] mutableCopy] : [NSMutableArray array];
    self->chosenItemAssignedToNewHomeMembers = userInfo[@"AssignedToNewHomeMembers"] ? userInfo[@"AssignedToNewHomeMembers"] : @"";
    
    
    
    NSString *itemAssignedToTextFieldString = @"";
    
    if ([assignedToUsernameLocalArray count] > 1) {
        
        for (NSString *assignedToUsernameString in assignedToUsernameLocalArray) {
            
            BOOL AssignedToStringIsEmpty = itemAssignedToTextFieldString.length == 0;
            
            itemAssignedToTextFieldString = AssignedToStringIsEmpty == YES ?
            [NSString stringWithFormat:@"%@", assignedToUsernameString] :
            [NSString stringWithFormat:@"%@, %@", itemAssignedToTextFieldString, assignedToUsernameString];
            
        }
        
    } else if ([assignedToUsernameLocalArray count] == 1) {
        
        for (NSString *assignedToUsernameString in assignedToUsernameLocalArray) {
            
            BOOL UsernameIsMine = [assignedToUsernameString isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]];
            itemAssignedToTextFieldString = UsernameIsMine == YES ? @"Myself" : assignedToUsernameString;
            
        }
        
    } else if ([assignedToUsernameLocalArray count] == 0) {
        
        itemAssignedToTextFieldString = @"Nobody";
        
    }
    
    
    
    _itemAssignedToTextField.text = itemAssignedToTextFieldString;
    
    
    
    NSMutableArray *updatedAssignedIDArray = [NSMutableArray array];
    NSMutableArray *updatedAssignedProfileImageURLArray = [NSMutableArray array];
    
    for (NSString *username in assignedToUsernameLocalArray) {
        
        if ([userDictForHomeMembers[@"Username"] containsObject:username]) {
            
            NSUInteger index = [userDictForHomeMembers[@"Username"] indexOfObject:username];
            NSString *userID = userDictForHomeMembers[@"UserID"] && [(NSArray *)userDictForHomeMembers[@"UserID"] count] > index ? userDictForHomeMembers[@"UserID"][index] : @"";
            NSString *profileImageURL = userDictForHomeMembers[@"ProfileImageURL"] && [(NSArray *)userDictForHomeMembers[@"ProfileImageURL"] count] > index ? userDictForHomeMembers[@"ProfileImageURL"][index] : @"";
            [updatedAssignedIDArray addObject:userID];
            [updatedAssignedProfileImageURLArray addObject:profileImageURL];
            
        }
        
    }
    
    self->assignedToIDArray = [updatedAssignedIDArray mutableCopy];
    self->assignedToUsernameArray = [assignedToUsernameLocalArray mutableCopy];
    self->assignedToProfileImageArray = [updatedAssignedProfileImageURLArray mutableCopy];
  
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methodss
#pragma mark
#pragma mark
#pragma mark -

-(NSMutableDictionary *)AddItem_GenerateSetDataDict {
    
    NSString *chatID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    NSString *chatCreatedBy = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    NSString *chatDateCreated = [[[GeneralObject alloc] init] GenerateCurrentDateString];
    NSString *chatName = self->_itemNameTextField.text;
    NSString *chatImageURL = [[[GeneralObject alloc] init] GenerateItemImageURL:self->itemType itemUniqueID:chatID];
    NSMutableArray *chatAssignedTo = [NSMutableArray array];
    NSString *chatAssignedToNewHomeMembers = self->chosenItemAssignedToNewHomeMembers != NULL ? self->chosenItemAssignedToNewHomeMembers : @"No";
    NSString *chatHomeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    __block NSMutableDictionary *setDataDict = [@{
        
        @"ChatID" : chatID,
        @"ChatCreatedBy" : chatCreatedBy,
        @"ChatDateCreated" : chatDateCreated,
        @"ChatName" : chatName,
        @"ChatImageURL" : chatImageURL,
        @"ChatAssignedTo" : chatAssignedTo,
        @"ChatAssignedToNewHomeMembers" : chatAssignedToNewHomeMembers,
        @"ChatHomeID" : chatHomeID
        
    } mutableCopy];
    
    return setDataDict;
}

-(void)AddItem_SetLocalItemData:(NSMutableDictionary *)setDataDict {
    
    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddChat" userInfo:setDataDict locations:@[@"Chats"]];
    
}

-(void)AddItem_SetGroupChatData:(NSMutableDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] SetDataAddGroupChat:setDataDict[@"ChatHomeID"] itemDict:setDataDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)AddItem_SetImageData:(NSMutableDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    UIImage *chatImage = self->_addImageImage.image;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *imgData = UIImageJPEGRepresentation(chatImage, 0.15);
        
        [[[SetDataObject alloc] init] SetDataItemImage:setDataDict[@"ChatID"] itemType:self->itemType imgData:imgData completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)AddItem_SendPushNotification:(NSMutableDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", setDataDict[@"ChatName"]];
        NSString *notificationBody = [NSString stringWithFormat:@"This group chat was created by %@. 💬", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]];
        
        
        
        NSMutableArray *userIDArray = setDataDict[@"ChatAssignedTo"] ? [setDataDict[@"ChatAssignedTo"] mutableCopy] : [NSMutableArray array];
        NSMutableArray *usersToSendNotificationTo = [self->_homeMembersArray mutableCopy];
        
        NSString *chatCreatedBy = setDataDict[@"ChatCreatedBy"] ? setDataDict[@"ChatCreatedBy"] : @"";
        
        if ([chatCreatedBy length] == 0) {
            chatCreatedBy = setDataDict[@"ItemCreatedBy"] ? setDataDict[@"ItemCreatedBy"] : @"";
        }
        
        
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Chats:usersToSendNotificationTo userID:@""
                                                                              homeID:setDataDict[@"ChatHomeID"] homeMembersDict:self->_homeMembersDict
                                                                              chatID:setDataDict[@"ChatID"] chatName:setDataDict[@"ChatName"] chatAssignedTo:userIDArray
                                                                              itemID:@"" itemName:@"" itemCreatedBy:@"" itemAssignedTo:[NSMutableArray array]
                                                            notificationSettingsDict:self->_notificationSettingsDict notificationItemType:self->itemType notificationType:self->itemType
                                                                           topicDict:self->_topicDict
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                                    viewingGroupChat:YES viewingComments:NO viewingLiveSupport:NO
                                                             SetDataHomeNotification:YES RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)AddItem_SetTopicData:(NSMutableDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
      
        NSDictionary *dataDict = @{@"TopicID" : setDataDict[@"ChatID"], @"TopicCreatedBy" : userID, @"TopicSubscribedTo" : @[userID], @"TopicAssignedTo" : setDataDict[@"ChatAssignedTo"], @"TopicDateCreated" : setDataDict[@"ChatDateCreated"], @"TopicDeleted" : @"No"};
        
        [[[SetDataObject alloc] init] SubscribeAndSetDataTopic:setDataDict[@"ChatHomeID"] topicID:setDataDict[@"ChatID"] dataDict:dataDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)AddItem_CompletionBlock {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self->progressView setHidden:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    });
    
}

#pragma mark

-(NSMutableDictionary *)EditItem_GenerateSetDataDict {
    
    NSString *chatID = self->_itemToEditDict[@"ChatID"];
    NSString *chatCreatedBy = self->_itemToEditDict[@"ChatCreatedBy"];
    NSString *chatDateCreated = self->_itemToEditDict[@"ChatDateCreated"];
    NSString *chatName = self->_itemToEditDict[@"ChatName"];
    NSString *chatImageURL = [[[GeneralObject alloc] init] GenerateItemImageURL:itemType itemUniqueID:chatID];
    NSMutableArray *achatAssignedTo = [NSMutableArray array];
    NSString *chatAssignedToNewHomeMembers = self->chosenItemAssignedToNewHomeMembers != NULL ? self->chosenItemAssignedToNewHomeMembers : @"No";
    NSString *chatHomeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    NSMutableDictionary *setDataDict = [@{
        
        @"ChatID" : chatID,
        @"ChatCreatedBy" : chatCreatedBy,
        @"ChatDateCreated" : chatDateCreated,
        @"ChatName" : chatName,
        @"ChatImageURL" : chatImageURL,
        @"ChatAssignedTo" : achatAssignedTo,
        @"ChatAssignedToNewHomeMembers" : chatAssignedToNewHomeMembers,
        @"ChatHomeID" : chatHomeID
        
    } mutableCopy];
    
    return setDataDict;
}

-(void)EditItem_SetLocalItemData:(NSMutableDictionary *)setDataDict {
    
    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"EditChat" userInfo:setDataDict locations:@[@"Chats"]];
    
}

-(void)EditItem_UpdateChatData:(NSMutableDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *collection = [NSString stringWithFormat:@"%@s", itemType];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataEditChat:setDataDict itemID:setDataDict[@"ChatID"] collection:collection homeID:setDataDict[@"ChatHomeID"] completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)EditItem_UpdateImageData:(NSMutableDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    UIImage *chatImage = self->_addImageImage.image;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *imgData = UIImageJPEGRepresentation(chatImage, 0.15);
        
        [[[SetDataObject alloc] init] UpdateDataItemImage:setDataDict[@"ChatID"] itemType:self->itemType imgData:imgData completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)EditItem_SendPushNotification:(NSMutableDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:YES Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                       SkippingTurn:NO RemovingUser:NO
                                                                                                     FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                            DueDate:NO Reminder:NO
                                                                                                     SubtaskEditing:NO SubtaskDeleting:NO
                                                                                                   SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                     AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                                EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                                  GroupChatMessages:NO LiveSupportMessages:NO
                                                                                                 SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                                FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                           itemType:self->itemType];
        
        
        
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
        
        
        
        NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", setDataDict[@"ChatName"]];
        NSString *notificationBody = [NSString stringWithFormat:@"This group chat was updated by %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]];
        
        
        
        NSMutableArray *userIDArray = setDataDict[@"ChatAssignedTo"] ? [setDataDict[@"ChatAssignedTo"] mutableCopy] : [NSMutableArray array];
        NSMutableArray *usersToSendNotificationTo = [userIDArray mutableCopy];
        
        NSArray *addTheseUsers = @[setDataDict[@"ChatCreatedBy"]];
        NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
        
        usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
        
        
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Chats:usersToSendNotificationTo userID:userID
                                                                              homeID:setDataDict[@"ChatHomeID"] homeMembersDict:self->_homeMembersDict
                                                                              chatID:setDataDict[@"ChatID"] chatName:setDataDict[@"ChatName"] chatAssignedTo:userIDArray
                                                                              itemID:@"" itemName:@"" itemCreatedBy:@"" itemAssignedTo:[NSMutableArray array]
                                                            notificationSettingsDict:self->_notificationSettingsDict notificationItemType:self->itemType notificationType:notificationType
                                                                           topicDict:self->_topicDict
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                                    viewingGroupChat:YES viewingComments:NO viewingLiveSupport:NO
                                                             SetDataHomeNotification:YES RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)EditItem_UpdateTopicData:(NSMutableDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] SubsribeOrUnsubscribeAndUpdateTopic:setDataDict[@"ChatHomeID"] topicID:setDataDict[@"ChatID"] itemOccurrenceID:@"" dataDict:@{@"TopicAssignedTo" : setDataDict[@"ChatAssignedTo"]} SubscribeToTopic:YES UnsubscribeFromTopic:NO completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)EditItem_CompletionBlock {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self->progressView setHidden:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    });
    
}

@end
