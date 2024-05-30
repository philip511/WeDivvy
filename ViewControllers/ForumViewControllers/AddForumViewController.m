//
//  AddForumViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 8/11/21.
//

#import "AddForumViewController.h"
#import "AppDelegate.h"

#import <MRProgress/MRProgressOverlayView.h>

#import "GeneralObject.h"
#import "SetDataObject.h"
#import "NotificationsObject.h"
#import "ForumObject.h"
#import "PushObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@interface AddForumViewController () {
    
    MRProgressOverlayView *progressView;

    NSString *collectionKey;
    
    UIButton *addPhotoViewOverlay;
    
    UIColor *defaultFieldColor;
    
}

@end

@implementation AddForumViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self InitMethod];
    
    [self BarButtonItems];
    
    [self SetUpKeyBoardToolBar];
    
}

-(void)viewDidLayoutSubviews {
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    
    CGFloat textFieldSpacing = (height*0.024456);
    
    self->_itemNameView.frame = CGRectMake(textFieldSpacing, navigationBarHeight + textFieldSpacing, (width*1 - (textFieldSpacing*2)), (self.view.frame.size.height*0.07472826 > 55?55:(self.view.frame.size.height*0.07472826)));
    self->_addImageView.frame = CGRectMake(self->_itemNameView.frame.origin.x, self->_itemNameView.frame.origin.y + self->_itemNameView.frame.size.height + textFieldSpacing, self->_itemNameView.frame.size.width, (self->_itemNameView.frame.size.height));
    self->_itemNotesView.frame = CGRectMake(self->_itemNameView.frame.origin.x, self->_addImageView.frame.origin.y + self->_addImageView.frame.size.height + textFieldSpacing, self->_itemNameView.frame.size.width, height*0.24456522);
    
    
    
    
    CGFloat fontSize = (self.view.frame.size.height*0.02173813 > 16?16:(self.view.frame.size.height*0.02173813));
    
    self->_itemNameTextField.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightRegular];
    self->_itemNotesTextField.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightRegular];
    self->_itemNameTextField.adjustsFontSizeToFitWidth = YES;
    self->_itemNameTextField.minimumFontSize = (height*0.25454545 > 14?14:(height*0.25454545));

    self->_itemAddImageLabel.titleLabel.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightRegular];
    self->_itemAddImageLabel.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    
    
    
    width = CGRectGetWidth(self.itemNameView.bounds);
    height = CGRectGetHeight(self.itemNameView.bounds);
    
    _itemNameTextField.frame = CGRectMake(width*0.04830918, height*0, width*1 - ((width*0.04830918)*2), height);
    
    _itemNotesTextField.frame = CGRectMake(width*0.04830918, width*0.04830918, width*1 - ((width*0.04830918)*2), _itemNotesView.frame.size.height - ((width*0.04830918)*2));
    
    _itemAddImageLabel.frame = CGRectMake(width*0.04830918 - (width*0.01932367), height*0, width*1 - ((width*0.04830918)*2), height);
    _addImageImage.frame = CGRectMake(width - (height*0.5) - width*0.04830918, height*0.5 - ((height*0.5)*0.5), height*0.5, height*0.5);
    
    _addImageImage.clipsToBounds = YES;
    _addImageImage.contentMode = UIViewContentModeScaleAspectFill;
    
    [self SetUpAddPhotoContextMenu];
    
    
    
    
    CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
    
    _itemNameView.layer.cornerRadius = cornerRadius;
    _itemNotesView.layer.cornerRadius = cornerRadius;
    _addImageView.layer.cornerRadius = cornerRadius;
    _addImageImage.layer.cornerRadius = (_addImageImage.frame.size.height*0.2181818182);
    
    
    
    
    _itemNameView.backgroundColor = [UIColor whiteColor];
    _itemNotesView.backgroundColor = _itemNameView.backgroundColor;
    _addImageView.backgroundColor = _itemNameView.backgroundColor;
    
    UIColor *textColor = [UIColor colorWithRed:138.0f/255.0f green:137.0f/255.0f blue:142.0f/255.0f alpha:1.0f];
    
    _itemNameTextField.textColor = textColor;
    
    UIColor *backgroundColor = [UIColor clearColor];
    
    _itemNameTextField.backgroundColor = backgroundColor;
    _itemNotesTextField.backgroundColor = backgroundColor;

    
    
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.navigationController.navigationBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        
        self.itemNameView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.addImageView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.itemNotesView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        
        self.itemNameTextField.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.itemNotesTextField.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        
        [self preferredStatusBarStyle];
        
        UIWindow *currentwindow = [UIApplication sharedApplication].windows.firstObject;
        UIView *statusBar = [[UIView alloc]initWithFrame:currentwindow.windowScene.statusBarManager.statusBarFrame] ;
        statusBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        [currentwindow addSubview:statusBar];
        
    } else {
        
        UIWindow *currentwindow = [UIApplication sharedApplication].windows.firstObject;
        UIView *statusBar = [[UIView alloc]initWithFrame:currentwindow.windowScene.statusBarManager.statusBarFrame] ;
        statusBar.backgroundColor = [UIColor whiteColor];
        [currentwindow addSubview:statusBar];
        
    }
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        return UIStatusBarStyleLightContent;
        
    } else {
        
        return UIStatusBarStyleDefault;
        
    }
 
}

#pragma mark - Init Methods
 
-(void)InitMethod {
 
    [self SetUpAnalytics];
    
    [self SetUpTitle];
    
    [self SetUpCollection];
    
    [self SetUpDelegates];
    
    [self SetUpHidden];
    
    [self SetUpTextFields];
    
    [self SetUpDetailsTextView];
    
    [self SetUpColor];
    
    [self SetUpViewing];
    
    [self SetUpAddPhotoContextMenu];
    
}

-(void)BarButtonItems {
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *barButtonItem;
    
    barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(NavigationBackButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    if (_editingSpecificForumPost) {
        
        barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                         style:UIBarButtonItemStyleDone
                                                        target:self
                                                        action:@selector(EditForumPost:)];
        
    } else {
        
        barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add"
                                                         style:UIBarButtonItemStyleDone
                                                        target:self
                                                        action:@selector(AddForumPost:)];
        
    }
    
    if (_viewingSpecificForumPost == NO) {
        
        
        self.navigationItem.rightBarButtonItem = barButtonItem;
        
    }
    
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
    self.itemNotesTextField.inputAccessoryView = keyboardToolbar;
    
}

#pragma mark - Setup Methods

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"AddForumViewController" completionHandler:^(BOOL finished) {
        
    }];
    
}

-(void)SetUpTitle {
    
    self.title = _viewingFeatureForum == YES ? @"Feature Forum" : @"Bug Forum";
    
}

-(void)SetUpCollection {
    
    collectionKey = _viewingFeatureForum == YES ? @"FeatureForum" : @"BugForum";
    
}

-(void)SetUpDelegates {
    
    _itemNameTextField.delegate = self;
    _itemNotesTextField.delegate = self;
    
}

-(void)SetUpHidden {
    
    if (_editingSpecificForumPost) {
        
        if ([self->_itemToEditDict[@"ForumImageURL"] isEqualToString:@"xxx"]) {
            
            _addImageImage.hidden = YES;
            
        } else {
            
            _addImageImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self->_itemToEditDict[@"ForumImageURL"]]]];
            _addImageImage.hidden = NO;
            
        }
        
    }
    
}

-(void)SetUpTextFields {
    
    if (_editingSpecificForumPost || _viewingSpecificForumPost) {
       
        self->_itemNameTextField.text = self->_itemToEditDict[@"ForumTitle"];
        self->_itemNotesTextField.text = self->_itemToEditDict[@"ForumDetails"];
        
        BOOL NotesHasText = self->_itemNotesTextField.text.length > 0;
        
        UIColor *notesColor = NotesHasText == YES ? [UIColor colorWithRed:138.0f/255.0f green:137.0f/255.0f blue:142.0f/255.0f alpha:1.0f] : [UIColor colorWithRed:181.0f/255.0f green:188.0f/255.0f blue:193.0f/255.0f alpha:1.0f];
        
        _itemNotesTextField.textColor = notesColor;
        
    }
    
}

-(void)SetUpDetailsTextView {
    
    [self textViewDidChange:_itemNotesTextField];
    
}

-(void)SetUpColor {
    
    [[[GeneralObject alloc] init] SetAttributedPlaceholder:_itemNameTextField color:[UIColor colorWithRed:181.0f/255.0f green:188.0f/255.0f blue:193.0f/255.0f alpha:1.0f]];
    
    defaultFieldColor = _itemNameView.backgroundColor;
    
}

-(void)SetUpViewing {
    
    if (_viewingSpecificForumPost) {
        
        _itemNameView.userInteractionEnabled = NO;
        _itemNameTextField.userInteractionEnabled = NO;
        _itemAddImageLabel.titleLabel.text = @"View Image";
        
    }
    
}

-(void)SetUpAddPhotoContextMenu {
    
    addPhotoViewOverlay = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _addImageView.frame.size.width, _addImageView.frame.size.height)];
    [_addImageView addSubview:addPhotoViewOverlay];
    
    NSMutableArray* actions = [[NSMutableArray alloc] init];
    NSMutableArray* noPhotoActions = [[NSMutableArray alloc] init];
    
    [actions addObject:[UIAction actionWithTitle:@"Camera" image:[UIImage systemImageNamed:@"camera"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Camera Clicked For %@", @"Forum"] completionHandler:^(BOOL finished) {
            
        }];
        
        [self StartProgressView];
        
        [self openCamera];
        
        [self.itemNameTextField resignFirstResponder];
        [self.itemNotesTextField resignFirstResponder];
        
    }]];
    
    [actions addObject:[UIAction actionWithTitle:@"Photo Library" image:[UIImage systemImageNamed:@"photo.on.rectangle"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Photo Library For %@", @"Forum"] completionHandler:^(BOOL finished) {
            
        }];
        
        [self StartProgressView];
        
        [self openPhotoLibrary];
        
        [self.itemNameTextField resignFirstResponder];
        [self.itemNotesTextField resignFirstResponder];
        
    }]];
    
    UIAction *noPhotoAction = [UIAction actionWithTitle:@"No Photo" image:[UIImage systemImageNamed:@"nosign"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"No Photo Clicked For %@", @"Forum"] completionHandler:^(BOOL finished) {
            
        }];
        
        self->_addImageImage.image = nil;
        self->_addImageImage.hidden = YES;
        
        [self.itemNameTextField resignFirstResponder];
        [self.itemNotesTextField resignFirstResponder];
        
    }];
    
    [noPhotoAction setAttributes:UIMenuElementAttributesDestructive];
    
    [noPhotoActions addObject:noPhotoAction];
    
    UIMenu *noPhotoMenuActions = [UIMenu menuWithTitle:@"" image:nil identifier:@"" options:UIMenuOptionsDisplayInline children:noPhotoActions];
    
    [actions addObject:noPhotoMenuActions];
    
    if (!_viewingSpecificForumPost) {
        
        addPhotoViewOverlay.menu = [UIMenu menuWithTitle:@"" children:actions];
        addPhotoViewOverlay.showsMenuAsPrimaryAction = true;
        
    }
    
}

#pragma mark - Custom Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

-(void)DismissAllKeyboards {
    
    [self.itemNameTextField resignFirstResponder];
    [self.itemNotesTextField resignFirstResponder];

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

#pragma mark - IBAction Methods

- (IBAction)ChoosePhotoAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"ChoosePhoto"] completionHandler:^(BOOL finished) {
        
    }];
    
    BOOL SpecificForumPostHasValidImage = ([self->_itemToEditDict[@"ForumImageURL"] isEqualToString:@"xxx"] == NO &&
                                           self->_itemToEditDict[@"ForumImageURL"] != nil &&
                                           [self->_itemToEditDict[@"ForumImageURL"] length] != 0);
    
    if (SpecificForumPostHasValidImage == YES) {
        
        UIImage *itemImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self->_itemToEditDict[@"ForumImageURL"]]]];
        [[[PushObject alloc] init] PushToViewImageViewController:self itemImage:itemImage];
        
        _itemAddImageLabel.titleLabel.text = @"View Image";
        
    }

}

- (IBAction)CloseImageAction:(id)sender {
 
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Close"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)AddForumPost:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"AddForum"] completionHandler:^(BOOL finished) {
        
    }];
    
    if ([self ForumPostHasErrors] == NO) {
    
        [self StartProgressView];

        NSString *forumDetails = _itemNotesTextField.text;
        
        forumDetails = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:forumDetails arrayOfSymbols:@[@"Details"]];
    
        NSString *forumID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
        NSString *forumTitle = _itemNameTextField.text;
        NSString *forumDatePosted = [[[GeneralObject alloc] init] GenerateCurrentDateString];
        NSArray *forumLikes = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
        NSString *forumCompleted = @"No";
        
        [[[ForumObject alloc] init] AddForumPost:forumID forumTitle:forumTitle forumDetails:forumDetails forumDatePosted:forumDatePosted forumImage:_addImageImage.image forumLikes:forumLikes forumCompleted:forumCompleted collection:collectionKey EditForum:NO completionHandler:^(BOOL finished) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self->progressView setHidden:YES];
                [self.navigationController popViewControllerAnimated:YES];
                
            });
            
        }];
        
    }
    
}

-(IBAction)EditForumPost:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"EditForum"] completionHandler:^(BOOL finished) {
        
    }];
    
    if ([self ForumPostHasErrors] == NO) {
            
        [self StartProgressView];

        NSString *forumDetails = _itemNotesTextField.text;
        
        forumDetails = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:forumDetails arrayOfSymbols:@[@"Details"]];
       
        NSString *forumID = _itemToEditDict[@"ForumID"];
        NSString *forumTitle = _itemNameTextField.text;
        NSString *forumDatePosted = _itemToEditDict[@"ForumDatePosted"];
        NSArray *forumLikes = _itemToEditDict[@"ForumLikes"];
        NSString *forumCompleted = _itemToEditDict[@"ForumCompleted"];
        
        [[[ForumObject alloc] init] AddForumPost:forumID forumTitle:forumTitle forumDetails:forumDetails forumDatePosted:forumDatePosted forumImage:_addImageImage.image forumLikes:forumLikes forumCompleted:forumCompleted collection:collectionKey EditForum:YES completionHandler:^(BOOL finished) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self->progressView setHidden:YES];
                [self.navigationController popViewControllerAnimated:YES];
                
            });
            
        }];
        
    }
    
}

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"BackButton"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(BOOL)ForumPostHasErrors {
    
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

#pragma mark - Image Picker Methods

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self->progressView setHidden:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    [self->progressView setHidden:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    _addImageImage.image = image;
    _addImageImage.hidden = _addImageImage.image != nil ? NO : YES;

}

#pragma mark - Text View Methods

-(void)textViewDidChange:(UITextView *)textView
{
    if(_itemNotesTextField.text.length == 0){
        
        _itemNotesTextField.textColor = [UIColor colorWithRed:181.0f/255.0f green:188.0f/255.0f blue:193.0f/255.0f alpha:1.0f];
        _itemNotesTextField.text = @"Details";
        [_itemNotesTextField resignFirstResponder];
        
    }
    
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (_itemNotesTextField.textColor == [UIColor colorWithRed:181.0f/255.0f green:188.0f/255.0f blue:193.0f/255.0f alpha:1.0f]) {
        
        _itemNotesTextField.text = @"";
        _itemNotesTextField.textColor = [UIColor colorWithRed:138.0f/255.0f green:137.0f/255.0f blue:142.0f/255.0f alpha:1.0f];
        
    }
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if (textView == self->_itemNotesTextField) {
        
        BOOL DetailsTextFieldHasText = (textView.text.length > 0 && [textView.text isEqualToString:@"Details"] == NO);
        
        textView.textColor = DetailsTextFieldHasText ?
        [UIColor colorWithRed:138.0f/255.0f green:137.0f/255.0f blue:142.0f/255.0f alpha:1.0f] :
        [UIColor colorWithRed:181.0f/255.0f green:188.0f/255.0f blue:193.0f/255.0f alpha:1.0f];
        
        
        
        BOOL ReturnKeyClicked = [text isEqualToString:@"\n"];
        BOOL DefaultTextIsDisplayed = [textView.text isEqualToString:@"Details"];
        
        if (ReturnKeyClicked == YES) {
            
            [textView resignFirstResponder];
            
            if (textView.text.length == 0){
                
                textView.textColor = [UIColor colorWithRed:181.0f/255.0f green:188.0f/255.0f blue:193.0f/255.0f alpha:1.0f];
                textView.text = @"Details";
                [textView resignFirstResponder];
                
            }
            
            return NO;
            
        } else if (DefaultTextIsDisplayed) {
            
            NSString *str = [NSString stringWithFormat:@"%@%@", textView.text, text];
            str = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:str arrayOfSymbols:@[@"Details"]];
            textView.text = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:textView.text arrayOfSymbols:@[@"Details"]];
            textView.textColor = [UIColor colorWithRed:138.0f/255.0f green:137.0f/255.0f blue:142.0f/255.0f alpha:1.0f];
            
        }
        
    }
    
    return YES;
}

@end
