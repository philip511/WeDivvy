//
//  HomeFeaturesViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 5/21/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeFeaturesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (assign, nonatomic) BOOL comingFromSettings;

@property (weak, nonatomic) IBOutlet UITableView *customTableView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (weak, nonatomic) IBOutlet UIButton *enableNotificationsButton;

@end

NS_ASSUME_NONNULL_END
