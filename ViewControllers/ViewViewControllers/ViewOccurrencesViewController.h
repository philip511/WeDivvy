//
//  ViewOccurrencesViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 10/23/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewOccurrencesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSString *collection;
@property (strong, nonatomic) NSString *itemID;

@property (weak, nonatomic) IBOutlet UITableView *customTableView;
@property (weak, nonatomic) IBOutlet UILabel *hiddenLabel;

@end

NS_ASSUME_NONNULL_END
