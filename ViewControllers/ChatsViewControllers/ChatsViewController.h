//
//  ChatsViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 10/3/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>




@property (strong, nonatomic) NSString *homeIDChosen;
@property (strong, nonatomic) NSString *homeNameChosen;




@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *separatorView;




@property (weak, nonatomic) IBOutlet UIImageView *settingsImage;
@property (weak, nonatomic) IBOutlet UIImageView *notificationImage;
@property (weak, nonatomic) IBOutlet UIImageView *homeMemberImage;




@property (weak, nonatomic) IBOutlet UIView *pendingInvitesView;
@property (weak, nonatomic) IBOutlet UILabel *pendingInvitesLabel;

@property (weak, nonatomic) IBOutlet UIView *notificationsView;
@property (weak, nonatomic) IBOutlet UILabel *notificationsViewLabel;




@property (weak, nonatomic) IBOutlet UITableView *customTableView;




@property (weak, nonatomic) IBOutlet UIButton *addTaskButton;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskButtonImage;




@property (weak, nonatomic) IBOutlet UIView *tabBarView;




@property (weak, nonatomic) IBOutlet UIView *choreIconTapView;
@property (weak, nonatomic) IBOutlet UIImageView *choreIconImage;
@property (weak, nonatomic) IBOutlet UILabel *choreIconLabel;

@property (weak, nonatomic) IBOutlet UIView *expenseIconTapView;
@property (weak, nonatomic) IBOutlet UIImageView *expenseIconImage;
@property (weak, nonatomic) IBOutlet UILabel *expenseLabelImage;

@property (weak, nonatomic) IBOutlet UIView *listsIconTapView;
@property (weak, nonatomic) IBOutlet UIImageView *listsIconImage;
@property (weak, nonatomic) IBOutlet UILabel *listsLabelImage;

@property (weak, nonatomic) IBOutlet UIView *chatsIconTapView;
@property (weak, nonatomic) IBOutlet UIImageView *chatsIconImage;
@property (weak, nonatomic) IBOutlet UILabel *chatsLabelImage;




@property (weak, nonatomic) IBOutlet UIView *emptyTableViewView;
@property (weak, nonatomic) IBOutlet UIImageView *emptyTableViewImage;
@property (weak, nonatomic) IBOutlet UILabel *emptyTableViewTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *emptyTableViewBodyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *emptyTableViewArrowImage;




@end

NS_ASSUME_NONNULL_END
