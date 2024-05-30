//
//  LiveChatViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 6/18/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MasterLiveChatViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *customTableView;

@end

NS_ASSUME_NONNULL_END
