//
//  ViewCalendarViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 9/25/22.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import <MRProgress/MRProgress.h>
#import <SDWebImage/SDWebImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewCalendarViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource, SKProductsRequestDelegate>

@property (strong, nonatomic) NSMutableArray *homeMembersArray;
@property (strong, nonatomic) NSMutableArray *itemNamesAlreadyUsed;
@property (strong, nonatomic) NSMutableArray *allItemAssignedToArrays;
@property (strong, nonatomic) NSMutableArray *allItemTagsArrays;

@property (strong, nonatomic) NSMutableDictionary *homeMembersDict;
@property (strong, nonatomic) NSMutableDictionary *notificationSettingsDict;
@property (strong, nonatomic) NSMutableDictionary *topicDict;
@property (strong, nonatomic) NSMutableDictionary *folderDict;
@property (strong, nonatomic) NSMutableDictionary *taskListDict;
@property (strong, nonatomic) NSMutableDictionary *sectionDict;
@property (strong, nonatomic) NSMutableDictionary *templateDict;
@property (strong, nonatomic) NSMutableDictionary *draftDict;

@property (strong, nonatomic) NSMutableDictionary *itemsDict;
@property (strong, nonatomic) NSMutableDictionary *itemsDictNo2;
@property (strong, nonatomic) NSMutableDictionary *itemsDictNo3;

@property (strong, nonatomic) NSMutableDictionary *itemsOccurrencesDict;
@property (strong, nonatomic) NSMutableDictionary *itemsOccurrencesDictNo2;
@property (strong, nonatomic) NSMutableDictionary *itemsOccurrencesDictNo3;
@property (strong, nonatomic) NSMutableDictionary *calendarSettings;

@property (weak, nonatomic) IBOutlet UICollectionView *customCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *customTableView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *coverView;

@property (weak, nonatomic) IBOutlet UIView *emptyTableViewView;
@property (weak, nonatomic) IBOutlet UIImageView *emptyTableViewImage;
@property (weak, nonatomic) IBOutlet UILabel *emptyTableViewTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *emptyTableViewBodyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *emptyTableViewArrowImage;

@property (weak, nonatomic) IBOutlet UIButton *addTaskButton;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskButtonImage;
@property (weak, nonatomic) IBOutlet UIButton *addTaskButtonCover;

@property (weak, nonatomic) IBOutlet UIView *notificationReminderView;
@property (weak, nonatomic) IBOutlet UILabel *notificationitemReminderLabel;
@property (weak, nonatomic) IBOutlet UIImageView *notificationitemReminderImage;
@property (weak, nonatomic) IBOutlet UIView *notificationReminderSeparator;

@end

NS_ASSUME_NONNULL_END
