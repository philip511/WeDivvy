//
//  ViewRemindersViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 2/25/23.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewRemindersViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPickerViewDelegate, SKProductsRequestDelegate>

@property (assign, nonatomic) BOOL viewingItemDetails;

@property (strong, nonatomic) NSString *itemRepeats;
@property (strong, nonatomic) NSString *itemTime;
@property (strong, nonatomic) NSMutableArray *itemAssignedTo;
@property (strong, nonatomic) NSMutableDictionary *itemsAlreadyChosenDict;

@property (weak, nonatomic) IBOutlet UIView *firstFieldView;
@property (weak, nonatomic) IBOutlet UITextField *firstFieldTextField;
@property (weak, nonatomic) IBOutlet UITableView *customTableView;


@end

NS_ASSUME_NONNULL_END
