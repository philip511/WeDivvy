//
//  ViewListViewItemsViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 9/14/21.
//



NS_ASSUME_NONNULL_BEGIN

@interface ViewAddItemsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPickerViewDelegate>

@property (assign, nonatomic) BOOL viewingItemDetails;

@property (strong, nonatomic) NSString *optionSelectedString;
@property (strong, nonatomic) NSString *itemRepeats;

@property (strong, nonatomic) NSMutableArray *itemsAlreadyChosenArray;
@property (strong, nonatomic) NSMutableDictionary *itemsAlreadyChosenDict;

@property (strong, nonatomic) NSMutableDictionary *userDict;

@property (weak, nonatomic) IBOutlet UITableView *customTableView;

@property (weak, nonatomic) IBOutlet UITextField *firstFieldTextField;
@property (weak, nonatomic) IBOutlet UITextField *secondFieldTextField;

@property (weak, nonatomic) IBOutlet UIView *firstFieldView;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet UIView *amountView;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLeftLabel;

@end

NS_ASSUME_NONNULL_END
