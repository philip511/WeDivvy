//
//  ViewActivityViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 12/13/22.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/SDWebImage.h>
#import <MRProgressOverlayView.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewActivityViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (assign, nonatomic) BOOL ViewingHome;
@property (assign, nonatomic) BOOL ViewingItem;

@property (weak, nonatomic) NSString *itemID;

@property (weak, nonatomic) NSMutableArray *homeMembersArray;

@property (weak, nonatomic) NSMutableDictionary *homeMembersDict;
@property (strong, nonatomic) NSMutableDictionary *notificationSettingsDict;
@property (strong, nonatomic) NSMutableDictionary *topicDict;
@property (strong, nonatomic) NSMutableDictionary *itemOccurrencesDict;
@property (strong, nonatomic) NSMutableDictionary *folderDict;
@property (strong, nonatomic) NSMutableDictionary *taskListDict;
@property (strong, nonatomic) NSMutableDictionary *templateDict;
@property (strong, nonatomic) NSMutableDictionary *draftDict;
@property (strong, nonatomic) NSMutableArray * _Nullable itemNamesAlreadyUsed;
@property (strong, nonatomic) NSMutableArray * _Nullable allItemAssignedToArrays;
@property (strong, nonatomic) NSMutableArray * _Nullable allItemTagsArrays;
@property (strong, nonatomic) NSMutableArray * _Nullable allItemIDsArrays;

@property (weak, nonatomic) IBOutlet UITableView *customTableView;

@end

NS_ASSUME_NONNULL_END
