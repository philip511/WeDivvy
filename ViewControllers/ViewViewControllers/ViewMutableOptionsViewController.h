//
//  ViewMutableOptionsViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 6/4/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewMutableOptionsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (assign, nonatomic) BOOL viewingFolders;
@property (assign, nonatomic) BOOL viewingSections;

@property (strong, nonatomic) NSMutableDictionary *itemsDict;
@property (strong, nonatomic) NSMutableDictionary *itemsAlreadyChosenDict;
@property (strong, nonatomic) NSMutableDictionary *foldersDict;

@property (strong, nonatomic) NSMutableArray * _Nullable homeMembersArray;
@property (strong, nonatomic) NSMutableDictionary * _Nullable homeMembersDict;
@property (strong, nonatomic) NSMutableDictionary * _Nullable notificationSettingsDict;
@property (strong, nonatomic) NSMutableDictionary * _Nullable itemToEditDict;
@property (strong, nonatomic) NSMutableDictionary * _Nullable moreOptionsDict;
@property (strong, nonatomic) NSMutableDictionary * _Nullable multiAddDict;
@property (strong, nonatomic) NSMutableDictionary * _Nullable itemOccurrencesDict;
@property (strong, nonatomic) NSMutableArray * _Nullable allItemTagsArrays;

@property (weak, nonatomic) IBOutlet UIView *firstFieldView;

@property (weak, nonatomic) IBOutlet UITextField *firstFieldTextField;

@property (weak, nonatomic) IBOutlet UITableView *customTableView;

@end

NS_ASSUME_NONNULL_END
