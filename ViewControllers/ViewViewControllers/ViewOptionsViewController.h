//
//  ViewOptionsViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 6/28/21.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewOptionsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, SKProductsRequestDelegate>

@property (assign, nonatomic) BOOL viewingItemDetails;

@property (strong, nonatomic) NSString *optionSelectedString;
@property (strong, nonatomic) NSString *itemRepeatsFrequency;

@property (strong, nonatomic) NSMutableArray *specificDatesArray;
@property (strong, nonatomic) NSMutableArray *customOptionsArray;
@property (strong, nonatomic) NSMutableArray *itemsSelectedArray;

@property (strong, nonatomic) NSMutableDictionary *homeMembersDict;

@property (weak, nonatomic) IBOutlet UITableView *customTableView;
@property (weak, nonatomic) IBOutlet UITableView *additionalOptionsTableView;

@property (weak, nonatomic) IBOutlet UIView *customView;
@property (weak, nonatomic) IBOutlet UILabel *customLabel;
@property (weak, nonatomic) IBOutlet UITextField *customRepeatingTextField;

@property (weak, nonatomic) IBOutlet UIView *randomizeTurnOrderView;
@property (weak, nonatomic) IBOutlet UILabel *randomizeTurnOrderLabel;
@property (weak, nonatomic) IBOutlet UISwitch *randomizeTurnOrderSwitch;
@property (weak, nonatomic) IBOutlet UIImageView *randomizeTurnOrderInfoImage;

@property (weak, nonatomic) IBOutlet UIView *anyDayView;
@property (weak, nonatomic) IBOutlet UILabel *anyDayLabel;
@property (weak, nonatomic) IBOutlet UISwitch *anyDaySwitch;
@property (weak, nonatomic) IBOutlet UIImageView *anyDayInfoImage;

@end

NS_ASSUME_NONNULL_END
