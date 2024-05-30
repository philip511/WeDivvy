//
//  ForumViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 8/11/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ForumViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (assign, nonatomic) BOOL viewingFeatureForum;

@property (weak, nonatomic) IBOutlet UITableView *customTableView;

@end

NS_ASSUME_NONNULL_END
