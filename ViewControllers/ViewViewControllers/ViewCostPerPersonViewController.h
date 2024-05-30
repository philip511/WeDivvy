//
//  ViewCostPerPersonViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 7/19/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewCostPerPersonViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIScrollViewDelegate>

@property (assign, nonatomic) BOOL viewingItemDetails;

@property (strong, nonatomic) NSString *itemAmountFromPreviousPage;

@property (strong, nonatomic) NSMutableArray *itemAssignedToArray;
@property (strong, nonatomic) NSMutableArray *itemAssignedToProfileImageArray;
@property (strong, nonatomic) NSMutableArray *itemAssignedToUsernameArray;

@property (strong, nonatomic) NSMutableDictionary *costPerPersonDict;
@property (strong, nonatomic) NSMutableDictionary *itemItemizedItemsDict;

@property (weak, nonatomic) IBOutlet UISegmentedControl *customSegmentControl;
@property (weak, nonatomic) IBOutlet UIScrollView *customScrollView;
@property (weak, nonatomic) IBOutlet UITableView *customTableView;

@property (weak, nonatomic) IBOutlet UIView *amountView;
@property (weak, nonatomic) IBOutlet UILabel *amountViewTotalAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountViewAmountLeftLabel;

@end

NS_ASSUME_NONNULL_END
