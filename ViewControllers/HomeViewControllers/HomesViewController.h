//
//  HomesViewController.h
//  RoommateApp
//
//  Created by Philip Nagel on 5/23/21.
//

#import <UIKit/UIKit.h>
#import "AnalyticsViewController.h"
#import <StoreKit/StoreKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, SKProductsRequestDelegate>

@property (weak, nonatomic) IBOutlet UIButton *createOrFindHomeButton;

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UIImageView *addImage;

@property (weak, nonatomic) IBOutlet UIView *emptyTableViewView;
@property (weak, nonatomic) IBOutlet UIImageView *emptyTableViewImage;
@property (weak, nonatomic) IBOutlet UILabel *emptyTableViewTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *emptyTableViewBodyLabel;

@property (weak, nonatomic) IBOutlet UITableView *customTableView;

@end

NS_ASSUME_NONNULL_END
