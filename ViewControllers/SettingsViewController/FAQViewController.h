//
//  FAQViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 11/19/22.
//

#import <UIKit/UIKit.h>
#import <MRProgressOverlayView.h>
#import <MessageUI/MessageUI.h>

NS_ASSUME_NONNULL_BEGIN

@interface FAQViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *customTableView;

@property (weak, nonatomic) IBOutlet UIView *sendMessageView;
@property (weak, nonatomic) IBOutlet UIView *sendMessageLiveView;
@property (weak, nonatomic) IBOutlet UILabel *sendMessageLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendMessageButton;
@property (weak, nonatomic) IBOutlet UILabel *sendMessageSubmitQuestionLabel;

@end

NS_ASSUME_NONNULL_END
