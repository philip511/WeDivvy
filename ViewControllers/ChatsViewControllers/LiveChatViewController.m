//
//  LiveChatViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 6/18/21.
//

#import "UIImageView+Letters.h"

#import "LiveChatViewController.h"
#import "AppDelegate.h"
#import "GreyTextCell.h"
#import "BlueTextCell.h"
#import "EndTextCell.h"
#import "ChatFileCell.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <MRProgressOverlayView.h>
#import <SDWebImage/SDWebImage.h>

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "NotificationsObject.h"
#import "PushObject.h"
#import "ChatObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@interface LiveChatViewController () {
    
    MRProgressOverlayView *progressView;
    
    NSString *itemType;
    NSString *itemTypeCollection;
    
    NSMutableDictionary *messageDict;
    NSMutableDictionary *chatDict;
    NSMutableDictionary *userDict;
    NSString *chosenItemAssignedToNewHomeMembers;
    
    NSArray *chatKeyArray;
    NSArray *messageKeyArray;
    
    UIActivityIndicatorView *activityControl;
    
    UIImage *messageImage;
    NSData *messageVideoData;
    
    UIButton *addFileViewOverlay;
    UIButton *chatMembersImageCover;
    
    BOOL queryCompleted;
    
}

@end

@implementation LiveChatViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self InitMethod];

    [self TapGestures];

    [self BarButtonItems];

    NSMutableDictionary *tempMessageDict = [NSMutableDictionary dictionary];

    [[[ChatObject alloc] init] QueryDataLiveChatViewController:_userID homeID:_homeID itemType:itemType itemID:_itemID itemName:_itemName itemCreatedBy:_itemCreatedBy itemAssignedTo:_itemAssignedTo chatID:_chatID chatName:_chatName chatAssignedTo:_chatAssignedTo chatKeyArray:chatKeyArray messageKeyArray:messageKeyArray messageDict:tempMessageDict viewingGroupChat:_viewingGroupChat viewingComments:_viewingComments viewingLiveSupport:_viewingLiveSupport completionHandler:^(BOOL finished, BOOL callSecondBlock, NSMutableDictionary * _Nonnull returningMessageDict, NSMutableDictionary * _Nonnull returningChatDict, NSMutableDictionary * _Nonnull returningUserDict) {

        BOOL NewMessageFound = NO;

        for (NSString *messageID in returningMessageDict[@"MessageID"]) {

            if ([self->messageDict[@"MessageID"] containsObject:messageID] == NO) {

                self->messageDict = [returningMessageDict mutableCopy];
                NewMessageFound = YES;
                break;

            }

        }

        if (NewMessageFound) {

            [[[SetDataObject alloc] init] SetDataMessageRead:self->_userID homeID:self->_homeID itemType:self->itemType itemID:self->_itemID chatID:self->_chatID messageDict:returningMessageDict viewingGroupChat:self->_viewingGroupChat viewingComments:self->_viewingComments viewingLiveSupport:self->_viewingLiveSupport completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningMessageDict) {
               
                [self CompleteQueryUI:callSecondBlock userDict:returningUserDict chatDict:returningChatDict messageDict:returningMessageDict];

            }];

        } else {

            [self CompleteQueryUI:callSecondBlock userDict:returningUserDict chatDict:returningChatDict messageDict:returningMessageDict];

        }

    }];

    _sendButtonView.backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    
}

- (void)keyboardWillShow:(NSNotification *)notification {
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    CGFloat statusBarSizeHeight = [[[GeneralObject alloc] init] GetStatusBarHeight];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        NSDictionary* keyboardInfo = [notification userInfo];
        NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
        
        CGRect sendCoinsButton = self->_chatView.frame;
        
        sendCoinsButton.origin.y = CGRectGetHeight(self.view.bounds)-keyboardFrameBeginRect.size.height-sendCoinsButton.size.height;
        
        self->_chatView.frame = sendCoinsButton;
        self->_customTableView.frame = CGRectMake(0, navigationBarHeight, width, height - (navigationBarHeight + statusBarSizeHeight) - (height*1 - sendCoinsButton.origin.y));
        self->_encryptionLabel.frame = CGRectMake(20, self->_chatView.frame.origin.y - 20 - 8, width - 40, 20);
        [self->_customTableView setContentOffset:CGPointMake(0, height) animated:YES];
        
        self->_encryptionLabel.alpha = 0.0f;
        
    }];
    
    if ((_mainImageView.alpha == 1.0f) && ([(NSArray *)self->messageDict[@"MessageID"] count] == 0)) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self->_mainImageView.alpha = 0.0f;
            
        }];
        
    }
    
}

- (void)keyboardWillHide:(NSNotification *) notification{
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
    CGFloat statusBarSizeHeight = [[[GeneralObject alloc] init] GetStatusBarHeight];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self->_chatView.frame = CGRectMake(0, height - bottomPadding - ((self.view.frame.size.height*0.074728 > 55?(55):self.view.frame.size.height*0.074728)), width*1, (self.view.frame.size.height*0.074728 > 55?(55):self.view.frame.size.height*0.074728));
        [self->_customTableView setContentOffset:CGPointMake(0, height) animated:YES];
        self->_encryptionLabel.frame = CGRectMake(20, self->_chatView.frame.origin.y - 20 - 8, width - 40, 20);
        self->_customTableView.frame = CGRectMake(0, navigationBarHeight, width, height - (navigationBarHeight + statusBarSizeHeight) - (height*1 - self->_encryptionLabel.frame.origin.y));
        
        self->_encryptionLabel.alpha = 1.0f;
        
    }];
    
    if ((_mainImageView.alpha == 0.0f) && ([(NSArray *)self->messageDict[@"MessageID"] count] == 0)) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self->_mainImageView.alpha = 1.0f;
            
        }];
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [[NSUserDefaults standardUserDefaults] setObject:[[[GeneralObject alloc] init] GenerateCurrentDateString] forKey:@"LastTimeCheckingChat"];

    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"NewMessage"]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"NewMessage"];
    }

    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"CurrentInLiveChat"];

    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);

    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
    CGFloat statusBarSizeHeight = [[[GeneralObject alloc] init] GetStatusBarHeight];

    _chatView.frame = CGRectMake(0, height - bottomPadding - ((self.view.frame.size.height*0.074728 > 55?(55):self.view.frame.size.height*0.074728)), width*1, (self.view.frame.size.height*0.074728 > 55?(55):self.view.frame.size.height*0.074728));
    _bottomPaddingView.frame = CGRectMake(0, height - bottomPadding, width, bottomPadding);
    _encryptionLabel.frame = CGRectMake(20, _chatView.frame.origin.y - 20 - 8, width - 40, 20);
    _encryptionLabel.textColor = _hiddenLabel.textColor;

    _customTableView.frame = CGRectMake(0, navigationBarHeight, width, height - (navigationBarHeight + statusBarSizeHeight) - (height*1 - _encryptionLabel.frame.origin.y));

    activityControl.frame = CGRectMake((self.customTableView.frame.size.width*0.5)-(12.5), (self.customTableView.frame.size.height*0.5) - (12.5) + _customTableView.frame.origin.y, 25, 25);
    
}

-(void)viewWillDisappear:(BOOL)animated {

    [[NSUserDefaults standardUserDefaults] setObject:[[[GeneralObject alloc] init] GenerateCurrentDateString] forKey:@"LastTimeCheckingChat"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CurrentInLiveChat"];
    
}

-(void)viewWillLayoutSubviews {

    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {

        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.navigationController.navigationBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary]};
        self.customTableView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.chatView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModePrimary];
        self.chatTextFieldView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.chatTextField.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.chatTextField.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.addFileView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.encryptionLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextSecondary];
        self.encryptionLabel.backgroundColor = [UIColor clearColor];

        self.chatTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.chatTextField.placeholder attributes:@{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModeTextSecondary]}];
       
        [self preferredStatusBarStyle];

    }

    UIWindow *currentwindow = [UIApplication sharedApplication].windows.firstObject;

    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];

    [[self navigationController] setNavigationBarHidden:NO animated:NO];

    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);

    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
    CGFloat statusBarSizeHeight = [[[GeneralObject alloc] init] GetStatusBarHeight];

    _statusBarOverview.frame = CGRectMake(0, 0, width, statusBarSizeHeight);

    _mainImageView.frame = CGRectMake(0, height*0.5 - navigationBarHeight - bottomPadding, width, height*0.5);

    _chatMembersImage.frame = CGRectMake(width - width*0.05434783 - width*0.04830918, 0, width*0.05434783, self.navigationController.navigationBar.frame.size.height);
    chatMembersImageCover = [[UIButton alloc] initWithFrame:CGRectMake(_chatMembersImage.frame.origin.x + (_chatMembersImage.frame.size.width*0.5 - (_chatMembersImage.frame.size.width*2)*0.5), 0, _chatMembersImage.frame.size.width*2, self.navigationController.navigationBar.frame.size.height)];

    [chatMembersImageCover addTarget:self action:@selector(TapGestureAssignedTo:) forControlEvents:UIControlEventTouchUpInside];

    if (_viewingLiveSupport == NO && _viewingComments == NO) {

        currentwindow = [UIApplication sharedApplication].windows.firstObject;

        [currentwindow addSubview:_chatMembersImage];
        [currentwindow addSubview:chatMembersImageCover];

    }

    [self.navigationController.navigationBar addSubview:_chatMembersImage];
    [self.navigationController.navigationBar addSubview:chatMembersImageCover];

    width = CGRectGetWidth(self.chatView.bounds);
    height = CGRectGetHeight(self.chatView.bounds);

    CGFloat percentage = 0.7;

    _addFileView.frame = CGRectMake(8, (height*0.5) - ((height*percentage)*0.5), height*percentage, height*percentage);
    _sendButtonView.frame = CGRectMake(width*1 - (height*percentage) - 8, (height*0.5) - ((height*percentage)*0.5), height*percentage, height*percentage);
    _sendButtonOverlayView.frame = CGRectMake(0, 0, _sendButtonView.frame.size.width, _sendButtonView.frame.size.height);
    _chatTextFieldView.frame = CGRectMake(_addFileView.frame.origin.x + _addFileView.frame.size.width + 8, (height*0.5) - ((height*percentage)*0.5),
                                          width - (_addFileView.frame.origin.x + _addFileView.frame.size.width + 8) - (width - (width*1 - (height*percentage) - 8 - 8))
                                          , height*percentage);

    addFileViewOverlay = [[UIButton alloc] initWithFrame:_addFileView.frame];
    [_chatView addSubview:addFileViewOverlay];

    _addFileView.layer.cornerRadius = _addFileView.frame.size.height/2;
    _sendButtonView.layer.cornerRadius = _sendButtonView.frame.size.height/5;
    _chatTextFieldView.layer.cornerRadius = _chatTextFieldView.frame.size.height/5;

    [self SetUpAddFileContextMenu];

    width = CGRectGetWidth(_chatTextFieldView.bounds);
    height = CGRectGetHeight(_chatTextFieldView.bounds);

    _chatTextField.frame = CGRectMake(width*0.5 - ((width*0.95)*0.5), height*0.5 - ((height*0.8)*0.5), width*0.95, height*0.8);

    width = CGRectGetWidth(_addFileView.bounds);
    height = CGRectGetHeight(_addFileView.bounds);

    _addFileImage.frame = CGRectMake(width*0.5 - ((width*0.50)*0.5), height*0.5 - ((height*0.50)*0.5), width*0.50, height*0.50);
    _sendButton.frame = CGRectMake(width*0.5 - ((width*0.45)*0.5), height*0.5 - ((height*0.50)*0.5), width*0.50, height*0.50);

    width = CGRectGetWidth(_mainImageView.bounds);
    height = CGRectGetHeight(_mainImageView.bounds);

    _MessageImage.frame = CGRectMake(width*0.5 - ((width*0.8)*0.5), 0, width*0.8, height*0.30);
    _hiddenLabel.frame = CGRectMake(width*0.5 - ((width*0.65)*0.5), _MessageImage.frame.origin.y + _MessageImage.frame.size.height + height*0, width*0.65, self.view.frame.size.height*0.1);
    _hiddenLabel.font = [UIFont systemFontOfSize:self.view.frame.size.height*0.01902174 weight:UIFontWeightBold];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        return UIStatusBarStyleLightContent;
        
    } else {
        
        return UIStatusBarStyleDefault;
        
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_chatTextField resignFirstResponder];
    
    return YES;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y != 0) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self->_encryptionLabel.alpha = 0.0f;
            
            CGRect newRect = self->_customTableView.frame;
            newRect.size.height = self->_chatView.frame.origin.y - newRect.origin.y;
            self->_customTableView.frame = newRect;
            
        }];
        
    }
    
}

-(BOOL)prefersStatusBarHidden {
    
    return YES;
}

#pragma mark - Image Picker Methods

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self->progressView setHidden:YES];
    [self->progressView setHidden:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
        
        NSString *moviePath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
        
        if([[NSFileManager defaultManager] fileExistsAtPath:moviePath])
        {
            messageVideoData = [[NSFileManager defaultManager] contentsAtPath:moviePath];
            [self->progressView setHidden:YES];
            [self->progressView setHidden:YES];
        }
        else
        {
            NSLog(@"File not exits");
            [self->progressView setHidden:YES];
            [self->progressView setHidden:YES];
        }
        
    } else {
        
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        messageImage = image;
        [self->progressView setHidden:YES];
        [self->progressView setHidden:YES];
        
    }
    
    [self SendButtonAction:self];
    
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpItemType];
    
    [self SetUpAnalytics];
    
    [self SetUpDictionaries];
    
    [self SetUpTitle];
    
    [self SetUpHiddenLabel];
    
    [self SetUpKeyArray];
    
    [self SetUpTableView];
    
    [self SetUpActivityControl];
    
    [self SetUpKeyboardNSNotifications];
    
    [self SetUpTextFieldDelegates];
    
    [self SetUpMainImageView];
    
    [self SetUpAddFileContextMenu];
    
}

-(void)TapGestures {
    
    UITapGestureRecognizer *tapGesture;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureAssignedTo:)];
    _chatMembersImage.userInteractionEnabled = YES;
    [_chatMembersImage addGestureRecognizer:tapGesture];
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SendButtonAction:)];
    _sendButtonOverlayView.userInteractionEnabled = YES;
    [_sendButtonOverlayView addGestureRecognizer:tapGesture];
    
}

-(void)BarButtonItems {
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *barButtonItem;
    
    barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(NavigationBackButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    if (_viewingLiveSupport == YES) {
        
        barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"End" style:UIBarButtonItemStyleDone target:self action:@selector(EndConversation:)];
        
        self.navigationItem.rightBarButtonItem = barButtonItem;
        
    } else {
        
//        barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"person.fill"] style:UIBarButtonItemStyleDone target:self action:@selector(TapGestureAssignedTo:)];
//
//        self.navigationItem.rightBarButtonItem = barButtonItem;
        
    }
    
}

#pragma mark - Setup Methods

-(void)SetUpItemType {
    
    itemType = [[[GeneralObject alloc] init] GenerateItemType];
    itemTypeCollection = [NSString stringWithFormat:@"%@s", itemType];
    
}

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"LiveChatViewController" completionHandler:^(BOOL finished) {
        
    }];
    
}

-(void)SetUpDictionaries {
    
    if (messageDict == nil) {
        
        messageDict = [NSMutableDictionary dictionary];
        
    }
    
}

-(void)SetUpTitle {
    
    NSString *title;
    
    if (_viewingLiveSupport == YES) {
        title = @"Live Support";
    } else if (_viewingComments == YES) {
        title = _itemName;
    } else {
        title = _chatName;
    }
    
    if (title == nil || [title isEqualToString:@"(null)"]) {
        title = @"";
    }
    
    for (int i=0 ; i<[title length] ; i++) {
        if ([title length] > 32) {
            title = [title substringToIndex:[title length] - 1];
        } else {
            break;
        }
    }
    
    self.title = title;
    
}

-(void)SetUpHiddenLabel {
    
    if (_viewingComments) {
        
        self.hiddenLabel.text = [NSString stringWithFormat:@"Leave a comment for the creator of this %@ and everyone assigned", @"group chat"];
        
    } else {
        
        self.hiddenLabel.text = _viewingLiveSupport == YES ? @"Send a message and a team member will get back to you 😊" : @"Send a message to your peeps 😊";
        
    }
    
}

-(void)SetUpKeyArray {
    
    chatKeyArray = [[[GeneralObject alloc] init] GenerateChatKeyArray];
    messageKeyArray = [[[GeneralObject alloc] init] GenerateMessageKeyArray];
    
}

-(void)SetUpTableView {
    
    _customTableView.delegate = self;
    _customTableView.dataSource = self;
    _customTableView.estimatedRowHeight = 100.0;
    _customTableView.rowHeight = UITableViewAutomaticDimension;
    
}

-(void)SetUpActivityControl {
    
    activityControl = [[UIActivityIndicatorView alloc] init];
    activityControl.color = [UIColor lightGrayColor];
    [activityControl setHidden:NO];
    [activityControl startAnimating];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [activityControl startAnimating];
        
    });
    
    [self.view addSubview:activityControl];
    
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

-(void)SetUpTextFieldDelegates {
    
    _chatTextField.delegate = self;
    
}

-(void)SetUpMainImageView {
    
    _mainImageView.alpha = 0.0f;
    
}

-(void)SetUpAddFileContextMenu {

    NSMutableArray *actions = [[NSMutableArray alloc] init];
    
    [actions addObject:[UIAction actionWithTitle:@"Camera" image:[UIImage systemImageNamed:@"camera"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        if (self->queryCompleted) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Camera"] completionHandler:^(BOOL finished) {
                
            }];
            
            [self StartProgressView];
            
            [self openCamera];
            
            [self->_chatTextField resignFirstResponder];
            
        } else {
            
            [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"We're still processing some data, please wait until WeDivvy has fully loaded. 😄" currentViewController:self];
            
        }
        
    }]];
    
    [actions addObject:[UIAction actionWithTitle:@"Photo Library" image:[UIImage systemImageNamed:@"photo.on.rectangle"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        if (self->queryCompleted) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Photo Library"] completionHandler:^(BOOL finished) {
                
            }];
            
            [self StartProgressView];
            
            [self openPhotoLibrary];
            
            [self->_chatTextField resignFirstResponder];
            
        } else {
            
            [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"We're still processing some data, please wait until WeDivvy has fully loaded. 😄" currentViewController:self];
            
        }
        
    }]];
    
    addFileViewOverlay.menu = [UIMenu menuWithTitle:@"" children:actions];
    addFileViewOverlay.showsMenuAsPrimaryAction = true;
    
}

#pragma mark - Photo Methods

-(void)openCamera {
    
    AVAuthorizationStatus authStatusCamera = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (authStatusCamera == AVAuthorizationStatusAuthorized) {
        
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        
        picker.delegate = self;
        
        picker.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie];
        
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
                    
                    picker.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie];
                    
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
        
        picker.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie];
        
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
                    
                    picker.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie];
                    
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

#pragma mark - Custom Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

-(void)CompleteQueryUI:(BOOL)callSecondBlock userDict:(NSMutableDictionary *)userDict chatDict:(NSMutableDictionary *)chatDict messageDict:(NSMutableDictionary *)messageDict {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self->messageDict = [messageDict mutableCopy];
        
        [self->activityControl stopAnimating];
        
        if ([(NSArray *)self->messageDict[@"MessageID"] count] == 0) {
            
            self->_mainImageView.alpha = 1.0f;
            self->_customTableView.hidden = YES;
            
        } else {
            
            [UIView animateWithDuration:0.25 animations:^{
                self->_mainImageView.alpha = 0.0f;
                self->_customTableView.hidden = NO;
            }];
            
        }
       
        if (callSecondBlock == YES) {
            
            self->chatDict = [chatDict mutableCopy];
            self->userDict = [userDict mutableCopy];
            self->chosenItemAssignedToNewHomeMembers = chatDict[@"ChatAssignedToNewHomeMembers"] ? chatDict[@"ChatAssignedToNewHomeMembers"] : @"";
            
            [self.customTableView reloadData];
            
            if ([(NSArray *)self->messageDict[@"MessageID"] count] != 0) {
                
                [self.customTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[(NSArray *)self->messageDict[@"MessageID"] count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                
            }
            
        } else {
            
            [self.customTableView reloadData];
            
        }
        
        self->queryCompleted = true;
        
    });
    
}

#pragma mark - IBAction Methods

- (IBAction)SendButtonAction:(id)sender {
    
    if (queryCompleted) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Send Message Clicked"] completionHandler:^(BOOL finished) {
            
        }];
        
        NSString *messageID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
        NSString *messageText = [[[GeneralObject alloc] init] TrimString:_chatTextField.text];
        NSString *messageTimeStamp = [[[GeneralObject alloc] init] GenerateCurrentDateString];
        
        self->_chatTextField.text = @"";
        
        if (self->messageVideoData != nil || self->messageImage != nil) {
            
            [self StartProgressView];
            
        }
        
        if (messageText.length > 0 || self->messageVideoData != nil || self->messageImage != nil) {
           
            [[[SetDataObject alloc] init] SetDataMessageVideo:_homeID messageID:messageID messageVideoData:self->messageVideoData completionHandler:^(BOOL finished, NSString * _Nonnull videoURL, UIImage * _Nonnull videoImage) {
                
                if (videoImage == nil) {
                    videoImage = self->messageImage;
                }
              
                [[[SetDataObject alloc] init] SetDataMessageImage:self->_homeID messageID:messageID messageImage:videoImage completionHandler:^(BOOL finished, NSString * _Nonnull imageURL) {
                    
                    NSDictionary *dataDict = @{
                        @"MessageID" : messageID ? messageID :@"",
                        @"MessageText" : messageText ? messageText : @"",
                        @"MessageSentBy" : [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"],
                        @"MessageTimeStamp" : messageTimeStamp ? messageTimeStamp : @"",
                        @"MessageEnd" : @"No",
                        @"MessageRead" : [@[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] mutableCopy],
                        @"MessageImageURL" : imageURL ? imageURL : @"",
                        @"MessageVideoURL" : videoURL ? videoURL : @"",
                        @"MessageChatID" : self->_chatID,
                        @"MessageHomeID" : self->_homeID
                    };
                    
                    NSString *notificationItemType = self->itemType;
                   
                    [[[ChatObject alloc] init] SendChat:self->_userID homeID:self->_homeID itemType:self->itemType itemID:self->_itemID itemName:self->_itemName itemCreatedBy:self->_itemCreatedBy itemAssignedTo:self->_itemAssignedTo chatID:self->_chatID chatName:self->_chatName chatAssignedTo:self->_homeMembersDict[@"UserID"] homeMembersDict:self->_homeMembersDict notificationSettingsDict:self->_notificationSettingsDict notificationItemType:notificationItemType topicDict:self->_topicDict viewingGroupChat:self->_viewingGroupChat viewingComments:self->_viewingComments viewingLiveSupport:self->_viewingLiveSupport dataDict:dataDict completionHandler:^(BOOL finished) {
                        
                        [self SendButtonAction_CompletionBlock:messageText];
                        
                    }];
                    
                }];
                
            }];
            
            [self SendButtonAction_SetItemAndHomeActivity];
            
        }
        
    } else {
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"We're still processing some data, please wait until WeDivvy has fully loaded. 😄" currentViewController:self];
        
    }
    
}

-(IBAction)EndConversation:(id)sender {
    
    if (queryCompleted) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"End Conversation Clicked"] completionHandler:^(BOOL finished) {
            
        }];
        
        [self StartProgressView];
        
        self->_chatTextField.text = @"";
        [self.chatTextField resignFirstResponder];
        
        NSString *chatID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
       
        [[[ChatObject alloc] init] EndChat:_userID homeID:_homeID itemType:itemType itemID:_itemID chatID:chatID completionHandler:^(BOOL finished) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self->progressView setHidden:YES];
                
                [self.customTableView reloadData];
                
                if ([(NSArray *)self->messageDict[@"MessageID"] count] != 0) {
                    
                    [self.customTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[(NSArray *)self->messageDict[@"MessageID"] count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                    
                }
                
                [[NSUserDefaults standardUserDefaults] setObject:[[[GeneralObject alloc] init] GenerateCurrentDateString] forKey:@"LastTimeCheckingChat"];
                [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"EndedConversation"];
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
            });
            
        }];
        
    } else {
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"We're still processing some data, please wait until WeDivvy has fully loaded. 😄" currentViewController:self];
        
    }
    
}

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Tap Gesture Actions

-(IBAction)TapGestureAssignedTo:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Chat Members Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableArray *selectedArray = [self->userDict[@"ProfileImageURL"] mutableCopy];
    NSString *itemAssignedToNewHomeMembers = self->chosenItemAssignedToNewHomeMembers != NULL ? self->chosenItemAssignedToNewHomeMembers : @"No";
    
    NSMutableDictionary *homeMembersUnclaimedDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersUnclaimedDict"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersUnclaimedDict"] : [NSMutableDictionary dictionary];
    NSMutableDictionary *homeKeysDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeKeysDict"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeKeysDict"] : [NSMutableDictionary dictionary];
    NSMutableArray *homeKeysArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeKeysArray"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeKeysArray"] : [NSMutableArray array];
    
    [[[PushObject alloc] init] PushToViewAssignedViewController:selectedArray itemAssignedToNewHomeMembers:itemAssignedToNewHomeMembers itemAssignedToAnybody:@"No" itemUniqueID:@"" homeMembersArray:[NSMutableArray array] homeMembersDict:self->_homeMembersDict homeMembersUnclaimedDict:homeMembersUnclaimedDict homeKeysDict:homeKeysDict homeKeysArray:homeKeysArray notificationSettingsDict:self->_notificationSettingsDict topicDict:self->_topicDict viewingItemDetails:YES viewingExpense:NO viewingChatMembers:YES viewingWeDivvyPremiumAddingAccounts:NO viewingWeDivvyPremiumEditingAccounts:NO currentViewController:self];
    
}


- (void)BlueAndGreyCellLongPress:(UILongPressGestureRecognizer*)sender
{
    
    CGPoint location = [sender locationInView:_customTableView];
    NSIndexPath *indexPath = [_customTableView indexPathForRowAtPoint:location];
    
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Copy" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Copy Image"] completionHandler:^(BOOL finished) {
                
            }];
            
            UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
            pasteBoard.string = self->messageDict[@"MessageText"][indexPath.row];
            
        }]];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Image Options Cancelled"] completionHandler:^(BOOL finished) {
                
            }];
            
        }]];
        
        [self presentViewController:actionSheet animated:YES completion:nil];
    }
    
}

- (void)ImageFileCellLongPress:(UILongPressGestureRecognizer*)sender
{
    
    CGPoint location = [sender locationInView:_customTableView];
    NSIndexPath *indexPath = [_customTableView indexPathForRowAtPoint:location];
    
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Copy" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Copy Image"] completionHandler:^(BOOL finished) {
                
            }];
            
            UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
            pasteBoard.string = self->messageDict[@"MessageImageURL"][indexPath.row];
            
        }]];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Save Image"] completionHandler:^(BOOL finished) {
                
            }];
            
//            [self StartProgressView];
            
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self->messageDict[@"MessageImageURL"][indexPath.row]]]];
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
            
            [self->progressView setHidden:YES];
            
        }]];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Image Options Cancelled"] completionHandler:^(BOOL finished) {
                
            }];
            
        }]];
        
        [self presentViewController:actionSheet animated:YES completion:nil];
    }
    
}

- (void)VideoFileCellLongPress:(UILongPressGestureRecognizer*)sender
{
    
    CGPoint location = [sender locationInView:_customTableView];
    NSIndexPath *indexPath = [_customTableView indexPathForRowAtPoint:location];
    
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Copy" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Copy Video"] completionHandler:^(BOOL finished) {
                
            }];
            
            UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
            pasteBoard.string = self->messageDict[@"MessageVideoURL"][indexPath.row];
            
        }]];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Video Options Cancelled"] completionHandler:^(BOOL finished) {
                
            }];
            
        }]];
        
        [self presentViewController:actionSheet animated:YES completion:nil];
    }
    
}


#pragma mark - Table View Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    BOOL ChatSentByMe = [self->messageDict[@"MessageSentBy"][indexPath.row] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    BOOL ChatEndMessage = [self->messageDict[@"MessageEnd"][indexPath.row] isEqualToString:@"Yes"];
    BOOL ChatIsCustomerSupport = [self->messageDict[@"MessageSentBy"][indexPath.row] isEqualToString:@"2021-08-24 23:51:563280984"] && _viewingLiveSupport == YES;
    BOOL ChatIsImageOrVideo = [self->messageDict[@"MessageImageURL"][indexPath.row] isEqualToString:@"xxx"] == NO;
    
    if (ChatSentByMe == YES && ChatEndMessage == NO && ChatIsCustomerSupport == YES && ChatIsImageOrVideo == NO) {
        
        BlueTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BlueTextCell"];
        
        cell.userProfileImage.image = [UIImage imageNamed:@"WeDivvyOriginal"];
        cell.userNameLabel.text = @"WeDivvy Support";
        cell.messageLabel.text = self->messageDict && self->messageDict[@"MessageText"] && [(NSArray *)self->messageDict[@"MessageText"] count] > indexPath.row ? self->messageDict[@"MessageText"][indexPath.row] : @"";
        
        return cell;
        
    } else if (ChatSentByMe == NO && ChatEndMessage == NO && ChatIsCustomerSupport == YES && ChatIsImageOrVideo == NO) {
        
        GreyTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GreyTextCell"];
       
        cell.userProfileImage.image = [UIImage imageNamed:@"WeDivvyOriginal"];
        cell.userNameLabel.text = @"WeDivvy Support";
        cell.messageLabel.text = self->messageDict && self->messageDict[@"MessageText"] && [(NSArray *)self->messageDict[@"MessageText"] count] > indexPath.row ? self->messageDict[@"MessageText"][indexPath.row] : @"";
        
        return cell;
        
    } else if (ChatEndMessage == YES && ChatIsCustomerSupport == YES && ChatIsImageOrVideo == NO) {
        
        EndTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EndTextCell"];
        
        cell.messageLabel.text = @"WeDivvy Support ended this conversation";
        
        return cell;
        
    } else if (ChatEndMessage == YES && ChatIsCustomerSupport == NO && ChatIsImageOrVideo == NO) {
        
        EndTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EndTextCell"];
        
        cell.messageLabel.text = self->messageDict && self->messageDict[@"MessageText"] && [(NSArray *)self->messageDict[@"MessageText"] count] > indexPath.row ? self->messageDict[@"MessageText"][indexPath.row] : @"";
        
        return cell;
        
    } else if (ChatSentByMe == YES && ChatEndMessage == NO && ChatIsCustomerSupport == NO && ChatIsImageOrVideo == NO) {
        
        BlueTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BlueTextCell"];
        
        NSUInteger index = [self->userDict[@"UserID"] indexOfObject:messageDict[@"MessageSentBy"][indexPath.row]];
        
        if ([(NSArray *)self->userDict[@"Username"] count] > index && [(NSArray *)self->userDict[@"ProfileImageURL"] count] > index) {
            
            NSString *username = self->userDict[@"Username"][index];
            NSString *profileImageURL = self->userDict[@"ProfileImageURL"][index];
            
            UIColor *backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:0.15f];
            UIColor *textColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
            
            if (profileImageURL == nil || profileImageURL.length == 0 || [profileImageURL containsString:@"(null)"] || [profileImageURL isEqualToString:@"xxx"] || [profileImageURL isEqualToString:@"XXX"] || [profileImageURL isEqualToString:@"https://firebasestorage.googleapis.com/v0/b/wedivvy-afe04.appspot.com/o/DefaultImages%2FdefaultProfileImage.png?alt=media&token=6892f430-8337-4327-89a4-53a403d1186c"] || [profileImageURL containsString:@"DefaultImage"]) {
                
                [cell.userProfileImage setImageWithString:username color:backgroundColor circular:YES textAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Medium" size:cell.userProfileImage.frame.size.height*0.45], NSForegroundColorAttributeName:textColor}];
                
            } else {
                
                [cell.userProfileImage sd_setImageWithURL:[NSURL URLWithString:profileImageURL]];
                
            }
            
        } else {
            [cell.userProfileImage sd_setImageWithURL:[NSURL URLWithString:@"xxx"]];
        }
        
        if ([(NSArray *)self->userDict[@"Username"] count] > index) {
            cell.userNameLabel.text = self->userDict[@"Username"][index];
        } else {
            cell.userNameLabel.text = @"Unknown User";
        }
        
        cell.messageLabel.text = self->messageDict && self->messageDict[@"MessageText"] && [(NSArray *)self->messageDict[@"MessageText"] count] > indexPath.row ? self->messageDict[@"MessageText"][indexPath.row] : @"";
        
        return cell;
        
    } else if (ChatSentByMe == NO && ChatEndMessage == NO && ChatIsCustomerSupport == NO && ChatIsImageOrVideo == NO) {
        
        GreyTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GreyTextCell"];
        
        NSUInteger index = 0;
         
        if (self->messageDict && self->messageDict[@"MessageSentBy"] && [(NSArray *)self->messageDict[@"MessageSentBy"] count] > indexPath.row && [self->userDict[@"UserID"] containsObject:messageDict[@"MessageSentBy"][indexPath.row]]) {
            
            index = [self->userDict[@"UserID"] indexOfObject:messageDict[@"MessageSentBy"][indexPath.row]];
            
        }
        
        if ([(NSArray *)self->userDict[@"ProfileImageURL"] count] > index) {
            
            NSString *username = self->userDict[@"Username"][index];
            NSString *profileImageURL = self->userDict[@"ProfileImageURL"][index];
            
            UIColor *backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:0.15f];
            UIColor *textColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
            
            if (profileImageURL == nil || profileImageURL.length == 0 || [profileImageURL containsString:@"(null)"] || [profileImageURL isEqualToString:@"xxx"] || [profileImageURL isEqualToString:@"XXX"] || [profileImageURL isEqualToString:@"https://firebasestorage.googleapis.com/v0/b/wedivvy-afe04.appspot.com/o/DefaultImages%2FdefaultProfileImage.png?alt=media&token=6892f430-8337-4327-89a4-53a403d1186c"] || [profileImageURL containsString:@"DefaultImage"]) {
                
                [cell.userProfileImage setImageWithString:username color:backgroundColor circular:YES textAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Medium" size:cell.userProfileImage.frame.size.height*0.45], NSForegroundColorAttributeName:textColor}];
                
            } else {
                
                [cell.userProfileImage sd_setImageWithURL:[NSURL URLWithString:profileImageURL]];
                
            }
            
        } else {
            [cell.userProfileImage sd_setImageWithURL:[NSURL URLWithString:@"xxx"]];
        }
        
        if ([(NSArray *)self->userDict[@"Username"] count] > index) {
            cell.userNameLabel.text = self->userDict[@"Username"][index];
        } else {
            cell.userNameLabel.text = @"Unknown User";
        }
        
        cell.messageLabel.text = self->messageDict && self->messageDict[@"MessageText"] && [(NSArray *)self->messageDict[@"MessageText"] count] > indexPath.row ? self->messageDict[@"MessageText"][indexPath.row] : @"";
        
        return cell;
        
    } else if (ChatSentByMe == YES && ChatIsImageOrVideo == YES) {
        
        ChatFileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatFileCell"];
        
        NSUInteger index = 0;
        
        if (self->messageDict && self->messageDict[@"MessageSentBy"] && [(NSArray *)self->messageDict[@"MessageSentBy"] count] > indexPath.row && [self->userDict[@"UserID"] containsObject:messageDict[@"MessageSentBy"][indexPath.row]]) {
            
            index = [self->userDict[@"UserID"] indexOfObject:messageDict[@"MessageSentBy"][indexPath.row]];
            
        }
        
        if ([(NSArray *)self->userDict[@"ProfileImageURL"] count] > index) {
            
            NSString *username = self->userDict[@"Username"][index];
            NSString *profileImageURL = self->userDict[@"ProfileImageURL"][index];
            
            UIColor *backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:0.15f];
            UIColor *textColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
            
            if (profileImageURL == nil || profileImageURL.length == 0 || [profileImageURL containsString:@"(null)"] || [profileImageURL isEqualToString:@"xxx"] || [profileImageURL isEqualToString:@"XXX"] || [profileImageURL isEqualToString:@"https://firebasestorage.googleapis.com/v0/b/wedivvy-afe04.appspot.com/o/DefaultImages%2FdefaultProfileImage.png?alt=media&token=6892f430-8337-4327-89a4-53a403d1186c"] || [profileImageURL containsString:@"DefaultImage"]) {
                
                [cell.userProfileImage setImageWithString:username color:backgroundColor circular:YES textAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Medium" size:cell.userProfileImage.frame.size.height*0.45], NSForegroundColorAttributeName:textColor}];
                
            } else {
                
                [cell.userProfileImage sd_setImageWithURL:[NSURL URLWithString:profileImageURL]];
                
            }
            
        } else {
            [cell.userProfileImage sd_setImageWithURL:[NSURL URLWithString:@"xxx"]];
        }
        
        if ([(NSArray *)self->userDict[@"Username"] count] > index) {
            cell.userNameLabel.text = self->userDict[@"Username"][index];
        } else {
            cell.userNameLabel.text = @"Unknown User";
        }
        
        if (self->messageDict && self->messageDict[@"MessageImageURL"] && [(NSArray *)self->messageDict[@"MessageImageURL"] count] > indexPath.row) {
            
            [cell.chatImageView sd_setImageWithURL:[NSURL URLWithString:self->messageDict[@"MessageImageURL"][indexPath.row]]];
            
        }
        
        return cell;
        
    } else if (ChatSentByMe == NO && ChatIsImageOrVideo == YES) {
        
        ChatFileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatFileCell"];
        
        NSUInteger index = 0;
        
        if (self->messageDict && self->messageDict[@"MessageSentBy"] && [(NSArray *)self->messageDict[@"MessageSentBy"] count] > indexPath.row && [self->userDict[@"UserID"] containsObject:messageDict[@"MessageSentBy"][indexPath.row]]) {
            
            index = [self->userDict[@"UserID"] indexOfObject:messageDict[@"MessageSentBy"][indexPath.row]];
            
        }
        
        if ([(NSArray *)self->userDict[@"ProfileImageURL"] count] > index) {
            
            NSString *username = self->userDict[@"Username"][index];
            NSString *profileImageURL = self->userDict[@"ProfileImageURL"][index];
            
            UIColor *backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:0.15f];
            UIColor *textColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
            
            if (profileImageURL == nil || profileImageURL.length == 0 || [profileImageURL containsString:@"(null)"] || [profileImageURL isEqualToString:@"xxx"] || [profileImageURL isEqualToString:@"XXX"] || [profileImageURL isEqualToString:@"https://firebasestorage.googleapis.com/v0/b/wedivvy-afe04.appspot.com/o/DefaultImages%2FdefaultProfileImage.png?alt=media&token=6892f430-8337-4327-89a4-53a403d1186c"] || [profileImageURL containsString:@"DefaultImage"]) {
                
                [cell.userProfileImage1 setImageWithString:username color:backgroundColor circular:YES textAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Medium" size:cell.userProfileImage.frame.size.height*0.45], NSForegroundColorAttributeName:textColor}];
                
            } else {
                
                [cell.userProfileImage1 sd_setImageWithURL:[NSURL URLWithString:profileImageURL]];
                
            }
            
        } else {
            [cell.userProfileImage sd_setImageWithURL:[NSURL URLWithString:@"xxx"]];
        }
        
        if ([(NSArray *)self->userDict[@"Username"] count] > index) {
            cell.userNameLabel1.text = self->userDict[@"Username"][index];
        } else {
            cell.userNameLabel1.text = @"Unknown User";
        }
        
        if (self->messageDict && self->messageDict[@"MessageImageURL"] && [(NSArray *)self->messageDict[@"MessageImageURL"] count] > indexPath.row) {
            
            [cell.chatImageView sd_setImageWithURL:[NSURL URLWithString:self->messageDict[@"MessageImageURL"][indexPath.row]]];
            
        }
        
        return cell;
        
    }
    
    BlueTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BlueTextCell"];
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [(NSArray *)messageDict[@"MessageID"] count];
    
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(BlueTextCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
   
    BOOL ChatWasSentByMe = [self->messageDict[@"MessageSentBy"][indexPath.row] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    BOOL ChatWasEndMessage = [self->messageDict[@"MessageEnd"][indexPath.row] isEqualToString:@"Yes"];
    BOOL ChatIsImage = [self->messageDict[@"MessageImageURL"][indexPath.row] isEqualToString:@"xxx"] == NO;
    
    if (ChatWasEndMessage == NO) {
       
        CGFloat widthOfItemLabel = [[[GeneralObject alloc] init] WidthOfString:cell.userNameLabel.text withFont:cell.userNameLabel.font];
       
        CGRect newRect = cell.userNameLabel.frame;
        newRect.size.width = widthOfItemLabel;
        cell.userNameLabel.frame = newRect;
      
        cell.premiumImage.frame = CGRectMake(cell.userNameLabel.frame.origin.x - cell.userNameLabel.frame.size.height*0.7 - 6, cell.userNameLabel.frame.origin.y, cell.userNameLabel.frame.size.height*0.7, cell.userNameLabel.frame.size.height);
        
    }
    
    if (ChatWasSentByMe == NO && ChatWasEndMessage == NO && ChatIsImage == NO) {
       
        GreyTextCell *cell1 = (GreyTextCell *)cell;
        
        cell1.messageBubble.clipsToBounds = YES;
        cell1.messageBubble.layer.cornerRadius = 7;
        
        cell1.messageBubble.backgroundColor = [UIColor whiteColor];
        cell1.messageLabel.textColor = [UIColor colorWithRed:161.0f/255.0f green:163.0f/255.0f blue:173.0f/255.0f alpha:1.0f];
        
        UILongPressGestureRecognizer *gestureRecognizer = [[UILongPressGestureRecognizer alloc] init];
        [gestureRecognizer addTarget:self action:@selector(BlueAndGreyCellLongPress:)];
        gestureRecognizer.delegate = self;
        gestureRecognizer.minimumPressDuration = 0.5;
        cell1.messageBubble.userInteractionEnabled = YES;
        [cell1.messageBubble addGestureRecognizer:gestureRecognizer];
        
        
        
        CGFloat widthOfItemLabel = [[[GeneralObject alloc] init] WidthOfString:cell1.userNameLabel.text withFont:cell1.userNameLabel.font];
        
        CGRect newRect = cell1.userNameLabel.frame;
        newRect.size.width = widthOfItemLabel;
        cell1.userNameLabel.frame = newRect;
        
        
        
        cell1.premiumImage.frame = CGRectMake(cell1.userNameLabel.frame.origin.x + cell1.userNameLabel.frame.size.width + 6, cell1.userNameLabel.frame.origin.y, cell1.userNameLabel.frame.size.height*0.7, cell1.userNameLabel.frame.size.height);
        
    } else if (ChatWasEndMessage == YES && ChatIsImage == NO) {
        
        //EndTextCell *cell2 = (EndTextCell *)cell;
        
    } else if (ChatIsImage == NO) {
       
        cell.messageBubble.clipsToBounds = YES;
        cell.messageBubble.layer.cornerRadius = 7;
        
        cell.messageBubble.backgroundColor = [UIColor colorWithRed:42.0f/255.0f green:171.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
        cell.messageLabel.textColor = [UIColor whiteColor];
        
        UILongPressGestureRecognizer *gestureRecognizer = [[UILongPressGestureRecognizer alloc] init];
        [gestureRecognizer addTarget:self action:@selector(BlueAndGreyCellLongPress:)];
        gestureRecognizer.delegate = self;
        gestureRecognizer.minimumPressDuration = 0.5;
        cell.messageBubble.userInteractionEnabled = YES;
        [cell.messageBubble addGestureRecognizer:gestureRecognizer];
        
    } else if (ChatWasSentByMe == YES && ChatIsImage == YES) {
        
        ChatFileCell *cell2 = (ChatFileCell *)cell;
        
        cell2.userProfileImage1.hidden = YES;
        cell2.userNameLabel1.hidden = YES;
        
        cell2.userProfileImage.hidden = NO;
        cell2.userNameLabel.hidden = NO;
        
        UILongPressGestureRecognizer *gestureRecognizer = [[UILongPressGestureRecognizer alloc] init];
        
        if ([messageDict[@"MessageVideoURL"][indexPath.row] isEqualToString:@"xxx"]) {
            cell2.imageInGreyView.image = [UIImage imageNamed:@"LiveChatIcons.Camera.png"];
            [gestureRecognizer addTarget:self action:@selector(ImageFileCellLongPress:)];
        } else {
            cell2.imageInGreyView.image = [UIImage imageNamed:@"LiveChatIcons.Video.png"];
            [gestureRecognizer addTarget:self action:@selector(VideoFileCellLongPress:)];
        }
        
        gestureRecognizer.delegate = self;
        gestureRecognizer.minimumPressDuration = 0.5;
        cell2.chatImageView.userInteractionEnabled = YES;
        [cell2.chatImageView addGestureRecognizer:gestureRecognizer];
        
        
        
        CGFloat widthOfItemLabel = [[[GeneralObject alloc] init] WidthOfString:cell2.userNameLabel.text withFont:cell2.userNameLabel.font];
        
        CGRect newRect = cell2.userNameLabel.frame;
        newRect.size.width = widthOfItemLabel;
        cell2.userNameLabel.frame = newRect;
        
        
        
        cell2.premiumImage.frame = CGRectMake(cell2.userNameLabel.frame.origin.x - cell2.userNameLabel.frame.size.height*0.7 - 6, cell2.userNameLabel.frame.origin.y, cell2.userNameLabel.frame.size.height*0.7, cell2.userNameLabel.frame.size.height);

    } else if (ChatWasSentByMe == NO && ChatIsImage == YES) {
        
        ChatFileCell *cell2 = (ChatFileCell *)cell;
       
        cell2.userProfileImage.hidden = YES;
        cell2.userNameLabel.hidden = YES;
        
        cell2.userProfileImage1.hidden = NO;
        cell2.userNameLabel1.hidden = NO;
        
        UILongPressGestureRecognizer *gestureRecognizer = [[UILongPressGestureRecognizer alloc] init];
        
        if ([messageDict[@"MessageVideoURL"][indexPath.row] isEqualToString:@"xxx"]) {
            cell2.imageInGreyView.image = [UIImage imageNamed:@"LiveChatIcons.Camera.png"];
            [gestureRecognizer addTarget:self action:@selector(ImageFileCellLongPress:)];
        } else {
            cell2.imageInGreyView.image = [UIImage imageNamed:@"LiveChatIcons.Video.png"];
            [gestureRecognizer addTarget:self action:@selector(VideoFileCellLongPress:)];
        }
        
        gestureRecognizer.delegate = self;
        gestureRecognizer.minimumPressDuration = 0.5;
        cell2.chatImageView.userInteractionEnabled = YES;
        [cell2.chatImageView addGestureRecognizer:gestureRecognizer];
        
        
        
        CGFloat widthOfItemLabel = [[[GeneralObject alloc] init] WidthOfString:cell2.userNameLabel1.text withFont:cell2.userNameLabel1.font];
        
        CGRect newRect = cell2.userNameLabel1.frame;
        newRect.size.width = widthOfItemLabel;
        cell2.userNameLabel1.frame = newRect;
        
        
        
        cell2.premiumImage.frame = CGRectMake(cell2.userNameLabel1.frame.origin.x + cell2.userNameLabel1.frame.size.width + 6, cell2.userNameLabel1.frame.origin.y, cell2.userNameLabel1.frame.size.height*0.7, cell2.userNameLabel1.frame.size.height);
        
    }
  
    
    
    
    if (ChatWasEndMessage == NO) {
        
        NSUInteger index = _homeMembersDict && _homeMembersDict[@"UserID"] && [_homeMembersDict[@"UserID"] containsObject:self->messageDict[@"MessageSentBy"][indexPath.row]] ? [_homeMembersDict[@"UserID"] indexOfObject:self->messageDict[@"MessageSentBy"][indexPath.row]] : -1;
        
        BOOL PremiumSubscriptionIsActiveForSpecificUserAtIndex = [[[BoolDataObject alloc] init] PremiumSubscriptionIsActiveForSpecificUserAtIndex:_homeMembersDict userID:self->messageDict[@"MessageSentBy"][indexPath.row]];
        
        cell.premiumImage.hidden = PremiumSubscriptionIsActiveForSpecificUserAtIndex && index != -1 ? NO : YES;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Did Select Message"] completionHandler:^(BOOL finished) {
        
    }];
    
    BOOL ChatIsImage = [self->messageDict[@"MessageImageURL"][indexPath.row] isEqualToString:@"xxx"] == NO;
    
    if (ChatIsImage == YES) {
        
        if ([self->messageDict[@"MessageVideoURL"][indexPath.row] isEqualToString:@"xxx"]) {
            
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:messageDict[@"MessageImageURL"][indexPath.row]]]];
            [[[PushObject alloc] init] PushToViewImageViewController:self itemImage:image];
            
        } else {
            
            [[[PushObject alloc] init] PushToViewVideoViewController:self videoURLString:self->messageDict[@"MessageVideoURL"][indexPath.row]];
            
        }
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

-(void)SendButtonAction_SetItemAndHomeActivity {
    
    if (self->_viewingComments) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSString *activityAction = @"Commeting Task";
            NSString *userTitle = [NSString stringWithFormat:@"%@ left a comment", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
            NSString *itemTitle = [NSString stringWithFormat:@"%@ left a comment", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
            NSString *itemDescription = [NSString stringWithFormat:@"A comment was left for \"%@\"", self->_itemName];
            
            NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
            
            NSMutableDictionary *itemActivityDict = [[[SetDataObject alloc] init] GenerateItemActivityDict:self->_itemID itemOccurrenceID:@"" activityUserIDNo1:@"" homeID:homeID activityAction:activityAction userTitle:userTitle userDescription:itemDescription itemType:self->itemType];
            NSMutableDictionary *homeActivityDict = [[[SetDataObject alloc] init] GenerateHomeActivityDict:@"" homeID:homeID activityAction:activityAction itemTitle:itemTitle itemDescription:itemDescription itemType:self->itemType];
            
            [[[SetDataObject alloc] init] SetDataHomeAndItemActivity:itemActivityDict homeActivityDict:homeActivityDict completionHandler:^(BOOL finished) {
                
            }];
            
        });
        
    }
    
}

-(void)SendButtonAction_CompletionBlock:(NSString *)messageText {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (self->_viewingComments) {
            
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemComments" userInfo:nil locations:@[@"ViewTask"]];
            
        } else if (self->_viewingGroupChat) {
            
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"EditLastMessage" userInfo:@{@"ChatID" : self->_chatID, @"MessageText" : messageText} locations:@[@"Chats"]];
            
        }
        
        [self->progressView setHidden:YES];
        
        self->messageImage = nil;
        self->messageVideoData = nil;
        
        [[NSUserDefaults standardUserDefaults] setObject:[[[GeneralObject alloc] init] GenerateCurrentDateString] forKey:@"LastTimeCheckingChat"];
        
        [self.customTableView reloadData];
        
        if ([(NSArray *)self->messageDict[@"MessageID"] count] != 0) {
            
            [self.customTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[(NSArray *)self->messageDict[@"MessageID"] count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
        }
        
    });
    
}

@end
