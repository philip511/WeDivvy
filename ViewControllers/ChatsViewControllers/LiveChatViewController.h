//
//  LiveChatViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 6/18/21.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveChatViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate>

@property (assign, nonatomic) BOOL viewingLiveSupport;
@property (assign, nonatomic) BOOL viewingComments;
@property (assign, nonatomic) BOOL viewingGroupChat;

@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *homeID;
@property (strong, nonatomic) NSMutableDictionary *homeMembersDict;
@property (strong, nonatomic) NSMutableDictionary *notificationSettingsDict;
@property (strong, nonatomic) NSMutableDictionary *topicDict;

@property (strong, nonatomic) NSString *itemID;
@property (strong, nonatomic) NSString *itemName;
@property (strong, nonatomic) NSString *itemCreatedBy;
@property (strong, nonatomic) NSMutableArray *itemAssignedTo;

@property (strong, nonatomic) NSString *chatID;
@property (strong, nonatomic) NSString *chatName;
@property (strong, nonatomic) NSString *chatCreatedBy;
@property (strong, nonatomic) NSMutableArray *chatAssignedTo;

@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@property (weak, nonatomic) IBOutlet UIImageView *MessageImage;

@property (weak, nonatomic) IBOutlet UILabel *hiddenLabel;
@property (weak, nonatomic) IBOutlet UILabel *encryptionLabel;

@property (weak, nonatomic) IBOutlet UIView *statusBarOverview;

@property (weak, nonatomic) IBOutlet UITableView *customTableView;

@property (weak, nonatomic) IBOutlet UITextField *chatTextField;

@property (weak, nonatomic) IBOutlet UIView *chatView;
@property (weak, nonatomic) IBOutlet UIView *mainImageView;
@property (weak, nonatomic) IBOutlet UIView *sendButtonView;
@property (weak, nonatomic) IBOutlet UIView *sendButtonOverlayView;
@property (weak, nonatomic) IBOutlet UIView *addFileView;
@property (weak, nonatomic) IBOutlet UIView *chatTextFieldView;
@property (weak, nonatomic) IBOutlet UIView *bottomPaddingView;

@property (weak, nonatomic) IBOutlet UIImageView *addFileImage;
@property (weak, nonatomic) IBOutlet UIImageView *chatMembersImage;
@end

NS_ASSUME_NONNULL_END
