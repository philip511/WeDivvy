//
//  ViewMutableOptionsViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 6/4/22.
//

#import "ViewMutableOptionsViewController.h"

#import <MRProgressOverlayView.h>

#import "OptionsCell.h"

#import "GeneralObject.h"
#import "SetDataObject.h"
#import "DeleteDataObject.h"
#import "PushObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@interface ViewMutableOptionsViewController () {
    
    MRProgressOverlayView *progressView;
  
}

@end

@implementation ViewMutableOptionsViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self InitMethod];
    
    [self BarButtonItems];
    
    [self SetUpKeyBoardToolBar];
    
    [self.customTableView reloadData];
    
}

-(void)viewDidLayoutSubviews {
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    
    _firstFieldView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), navigationBarHeight + 12, (width*0.90338164), (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934));
    _firstFieldView.layer.cornerRadius = 12;
    
    CGRect newRect = self->_customTableView.frame;
    newRect.origin.y = _firstFieldView.frame.origin.y + _firstFieldView.frame.size.height + 12;
    self->_customTableView.frame = newRect;
    
    _customTableView.layer.cornerRadius = 12;
    
    
    
    
    
    width = CGRectGetWidth(_firstFieldView.bounds);
    height = CGRectGetHeight(_firstFieldView.bounds);
    
    _firstFieldTextField.frame = CGRectMake(12, 0, width-24, height);
    
    self->_firstFieldTextField.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02173813 > 16?16:(self.view.frame.size.height*0.02173813)) weight:UIFontWeightRegular];
    
    
    
    
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.navigationController.navigationBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.firstFieldView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.firstFieldTextField.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        
        NSString *firstPlaceholderToUse;
        
        if (_viewingSections) {
            
            firstPlaceholderToUse = @"Section Name";
            
        } else if (_viewingFolders) {
            
            firstPlaceholderToUse = @"Folder Name";
            
        }
        
        self.firstFieldTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:firstPlaceholderToUse attributes:@{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModeTextSecondary]}];
        
        [self preferredStatusBarStyle];
        
    } else {
        
        self.navigationController.navigationBar.backgroundColor = self.view.backgroundColor;
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    //CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat tableViewHeight = [self AdjustTableViewHeight];
    
    CGRect newRect = self->_customTableView.frame;
    newRect.origin.x = width*0.5 - ((width*0.90338164)*0.5);
    newRect.origin.y = _firstFieldView.frame.origin.y + _firstFieldView.frame.size.height + 12;
    newRect.size.width = width*0.90338164;
    newRect.size.height = tableViewHeight;
    
    self->_customTableView.frame = newRect;
    
}

-(void)viewWillDisappear:(BOOL)animated {
  
    if (_viewingFolders) {
   
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddFolder" userInfo:@{@"ItemsDict" : _itemsAlreadyChosenDict} locations:@[@"ViewTaskList"]];
        
    }
 
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_firstFieldTextField resignFirstResponder];
    
    return YES;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [_firstFieldTextField resignFirstResponder];
    
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpAnalytics];
    
    [self SetUpDelegates];

    [self SetUpTextFields];
    
    [self SetUpTableView];
    
}

-(void)BarButtonItems {
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *barButtonItem;
    
    barButtonItem =
    [[UIBarButtonItem alloc]
     initWithTitle:@"Back"
     style:UIBarButtonItemStylePlain
     target:self
     action:@selector(NavigationBackButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
}

#pragma mark - Setup Methods

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"ViewMutableOptionsViewController" completionHandler:^(BOOL finished) {
        
    }];
    
}

-(void)SetUpDelegates {
    
    _firstFieldTextField.delegate = self;
    
}

-(void)SetUpTextFields {
    
    NSString *firstPlaceholderToUse;
    
    if (_viewingSections) {
        
        firstPlaceholderToUse = @"Section Name";
        
    } else if (_viewingFolders) {
        
        firstPlaceholderToUse = @"Folder Name";
        
    }
    
    _firstFieldTextField.placeholder = firstPlaceholderToUse;
    
    if (_viewingSections) {
        
        if (_itemsAlreadyChosenDict[@"SectionName"]) {
            [_firstFieldTextField becomeFirstResponder];
        }
        
    } else if (_viewingFolders) {
        
        if (_itemsAlreadyChosenDict[@"FolderName"]) {
            [_firstFieldTextField becomeFirstResponder];
        }
        
    }
    
}

-(void)SetUpTableView {
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectZero];
    footer.backgroundColor = self.view.backgroundColor;
    
    _customTableView.tableFooterView = footer;
    _customTableView.delegate = self;
    _customTableView.dataSource = self;
    
}

-(void)SetUpKeyBoardToolBar {
    
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    
    [keyboardToolbar sizeToFit];
    
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    
    NSString *title = @"Add Item";
    
    UIBarButtonItem *addBarButton = [[UIBarButtonItem alloc]
                                     initWithTitle:title style:UIBarButtonItemStyleDone target:self action:@selector(AddItem:)];
    
    keyboardToolbar.items = @[flexBarButton, addBarButton];
    self.firstFieldTextField.inputAccessoryView = keyboardToolbar;
    
}

#pragma mark - IBAction Methods

-(IBAction)AddItem:(id)sender {
    
    if (_viewingSections) {
      
        [self AddSection];
        
    } else if (_viewingFolders) {
       
        [self AddFolder];
        
    }
    
}

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - UI Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

-(CGFloat)AdjustTableViewHeight {
    
    NSMutableArray *arrayToUse;
    
    if (_viewingSections) {
        
        arrayToUse = [_itemsDict[@"SectionID"] mutableCopy];
        
    } else if (_viewingFolders) {
        
        arrayToUse = [_itemsDict[@"FolderID"] mutableCopy];
        
    }
    
    CGFloat tableViewHeight = 0;
    
    if (arrayToUse.count > 0) {
        
        tableViewHeight = (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934)*[arrayToUse count];
        
        CGFloat height = CGRectGetHeight(self.view.bounds);
        
        CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
        
        CGFloat maxiumHeightToCheck = (tableViewHeight > height - (navigationBarHeight + 12 + self->_firstFieldView.frame.size.height + 12 + 12));
        
        CGFloat mexiumHeight = (height - (navigationBarHeight + 12 + self->_firstFieldView.frame.size.height + 12 + 12));
        
        if (maxiumHeightToCheck) {
            tableViewHeight = mexiumHeight;
        }
        
    }
    
    return tableViewHeight;
    
}

#pragma mark - Table View Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    OptionsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OptionsCell"];
    
    NSArray *keysArray;
    NSArray *sortedKeysArray;
    
    if (self->_viewingSections) {
        
        keysArray = _itemsDict[@"SectionName"];
        sortedKeysArray = [keysArray mutableCopy];
        
    } else if (self->_viewingFolders) {
        
        keysArray = _itemsDict[@"FolderName"];
        sortedKeysArray = [keysArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
    }
    
    NSString *itemName = sortedKeysArray[indexPath.row];
    
    cell.itemOptionLeftLabel.text = itemName;
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self->_viewingSections) {
        
        return [(NSArray *)_itemsDict[@"SectionID"] count];
        
    } else if (self->_viewingFolders) {
        
        return [(NSArray *)_itemsDict[@"FolderID"] count];
        
    }
    
    return 0;
    
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(OptionsCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.itemOptionLeftLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02173813 > 16?16:(self.view.frame.size.height*0.02173813)) weight:UIFontWeightRegular];
    
    CGFloat height = CGRectGetHeight(cell.contentView.bounds);
    CGFloat width = CGRectGetWidth(cell.contentView.bounds);
    //374
    
    CGFloat widthToUse = width*0.89304813;
    
    cell.itemOptionLeftLabel.frame = CGRectMake(width*0.0534759, height*0, widthToUse, height);
    cell.checkMarkImage.frame = CGRectMake(width - (height*0.5) - width*0.04830918, height*0.5 - (((height*0.5)*0.5)), height*0.5, height*0.5);
    
    cell.checkMarkImage.image = [UIImage systemImageNamed:@"checkmark"];
    
    NSArray *keysArray;
    NSString *keyToUse;
    NSArray *sortedKeysArray;
    
    if (self->_viewingSections) {
        
        keysArray = _itemsDict[@"SectionName"];
        keyToUse = @"SectionName";
        sortedKeysArray = [keysArray mutableCopy];
        
    } else if (self->_viewingFolders) {
        
        keysArray = _itemsDict[@"FolderName"];
        keyToUse = @"FolderName";
        sortedKeysArray = [keysArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
    }
    
    if (_itemsAlreadyChosenDict[keyToUse] && [_itemsAlreadyChosenDict[keyToUse] isEqualToString:sortedKeysArray[indexPath.row]]) {
       
        cell.checkMarkImage.hidden = NO;
        
    } else {
      
        cell.checkMarkImage.hidden = YES;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_viewingFolders) {
        
        NSArray *keysArray;
        NSString *keyToUse;
        NSArray *sortedKeysArray;
        
        if (self->_viewingSections) {
            
            keysArray = _itemsDict[@"SectionName"];
            keyToUse = @"SectionName";
            sortedKeysArray = [keysArray mutableCopy];
            
        } else if (self->_viewingFolders) {
            
            keysArray = _itemsDict[@"FolderName"];
            keyToUse = @"FolderName";
            sortedKeysArray = [keysArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
            
        }
  
        if (_itemsAlreadyChosenDict[keyToUse] && [_itemsAlreadyChosenDict[keyToUse] isEqualToString:sortedKeysArray[indexPath.row]] == YES) {
            
            NSArray *keyArray;
            NSArray *arrayToUse;
            
            if (self->_viewingSections) {
                
                keyArray = [[[GeneralObject alloc] init] GenerateSectionKeyArray];
                arrayToUse = _itemsDict[@"SectionName"];
                
                [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Did Unselect Section %@", sortedKeysArray[indexPath.row]] completionHandler:^(BOOL finished) {
                    
                }];
                
            } else if (self->_viewingFolders) {
                
                keyArray = [[[GeneralObject alloc] init] GenerateFolderKeyArray];
                arrayToUse = _itemsDict[@"FolderName"];
                
                [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Did Unselect Folder %@", sortedKeysArray[indexPath.row]] completionHandler:^(BOOL finished) {
                    
                }];
                
                _itemsAlreadyChosenDict = [NSMutableDictionary dictionary];
                
            }
            
        } else {
            
            _itemsAlreadyChosenDict = [NSMutableDictionary dictionary];
            
            NSArray *keyArray;
            NSArray *arrayToUse;
            
            if (self->_viewingSections) {
                
                keyArray = [[[GeneralObject alloc] init] GenerateSectionKeyArray];
                arrayToUse = _itemsDict[@"SectionName"];
                
                [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Did Select Section %@", sortedKeysArray[indexPath.row]] completionHandler:^(BOOL finished) {
                    
                }];
                
            } else if (self->_viewingFolders) {
                
                keyArray = [[[GeneralObject alloc] init] GenerateFolderKeyArray];
                arrayToUse = _itemsDict[@"FolderName"];
                
                [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Did Select Folder %@", sortedKeysArray[indexPath.row]] completionHandler:^(BOOL finished) {
                    
                }];
                
            }
            
            NSUInteger index = [arrayToUse indexOfObject:sortedKeysArray[indexPath.row]];
            
            for (NSString *key in keyArray) {
                
                [_itemsAlreadyChosenDict setObject:_itemsDict[key][index] forKey:key];
                
            }
            
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934);
    
}

#pragma mark

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
   return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
    NSArray *keyArray = [[[GeneralObject alloc] init] GenerateSectionKeyArray];
    
    for (NSString *key in keyArray) {
        
        NSMutableArray *array = [_itemsDict[key] mutableCopy];
        
        NSInteger index = sourceIndexPath.row;
        id obj = array[index];
        [array removeObjectAtIndex:index];
        [array insertObject:obj atIndex:destinationIndexPath.row];
        
        [_itemsDict setObject:array forKey:key];
        
    }
    
    [self.customTableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableview shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

-(UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSArray *keysArray;
    NSArray *sortedKeysArray;
    NSString *keyToUse;
    
    if (self->_viewingSections) {
        
        keyToUse = @"SectionName";
        keysArray = _itemsDict[keyToUse];
        sortedKeysArray = [keysArray mutableCopy];
        
    } else if (self->_viewingFolders) {
        
        keyToUse = @"FolderName";
        keysArray = _itemsDict[keyToUse];
        sortedKeysArray = [keysArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
    }
    
    NSUInteger index = [_itemsDict[keyToUse] indexOfObject:sortedKeysArray[indexPath.row]];
    
    NSString *itemType = @"";
    
    if (_viewingSections) {
        itemType = @"Section";
    } else if (_viewingFolders) {
        itemType = @"Folder";
    }
    
    UIContextualAction *EditListAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:nil handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        [self EditSwipeAction:indexPath itemType:itemType keyToUse:keyToUse index:index];
        
    }];
    
    UIContextualAction *DeleteListAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:nil handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        [self DeleteSwipeAction:indexPath itemType:itemType keyToUse:keyToUse index:index];
        
    }];
    
    NSMutableArray *actionsArray = [NSMutableArray array];
    
    EditListAction.image = [UIImage systemImageNamed:@"pencil"];
    EditListAction.backgroundColor = [UIColor systemBlueColor];
    
    DeleteListAction.image = [UIImage systemImageNamed:@"trash.fill"];
    DeleteListAction.backgroundColor = [UIColor systemPinkColor];
    
    [actionsArray addObject:DeleteListAction];
    [actionsArray addObject:EditListAction];
    
    //right to left
    return [UISwipeActionsConfiguration configurationWithActions:actionsArray];
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark AddItem

-(void)AddSection {
    
    NSString *itemType = @"Section";
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Adding %@", itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    
//    [self StartProgressView];
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    NSString *randomID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    NSString *dateCreated = [[[GeneralObject alloc] init] GenerateCurrentDateString];
    NSString *newName = _firstFieldTextField.text;
    
    NSDictionary *setDataDict = @{
        @"SectionID" : randomID,
        @"SectionDateCreated" : dateCreated,
        @"SectionCreatedBy" : userID,
        @"SectionName" : newName,
        @"SectionItems" : [NSMutableDictionary dictionary]
    };
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sectionID == %@", randomID];
    [[[SetDataObject alloc] init] SetDataAddCoreData:@"Sections" predicate:predicate setDataObject:setDataDict];
    
    [self CompleteAddSection:setDataDict];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] SetDataAddSection:setDataDict[@"SectionCreatedBy"] sectionID:setDataDict[@"SectionID"] setDataDict:setDataDict completionHandler:^(BOOL finished) {
            
//            [self CompleteAddSection:setDataDict];
            
        }];
        
    });
    
}

-(void)AddFolder {
    
    NSString *itemType = @"Folder";
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Adding %@", itemType] completionHandler:^(BOOL finished) {
        
    }];
    
//    [self StartProgressView];
    
    BOOL FolderAlreadyExists = [_foldersDict[@"FolderName"] containsObject:_firstFieldTextField.text];
    
    if (FolderAlreadyExists == YES) {
        
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
        NSString *randomID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
        NSString *dateCreated = [[[GeneralObject alloc] init] GenerateCurrentDateString];
        NSString *newName = _firstFieldTextField.text;
        
        NSDictionary *setDataDict = @{
            @"FolderID" : randomID,
            @"FolderDateCreated" : dateCreated,
            @"FolderCreatedBy" : userID,
            @"FolderName" : newName,
            @"FolderTaskLists" : [NSMutableDictionary dictionary]
        };
        
        
        for (NSString *key in [setDataDict allKeys]) {
            
            NSMutableArray *arr = _foldersDict[key] ? [_foldersDict[key] mutableCopy] : [NSMutableDictionary dictionary];
            id object = setDataDict[key] ? setDataDict[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            [arr addObject:object];
            [_foldersDict setObject:arr forKey:key];
            
        }
        
        
        
        [self CompleteAddFolder:setDataDict];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[[SetDataObject alloc] init] SetDataAddFolder:setDataDict[@"FolderCreatedBy"] folderID:setDataDict[@"FolderID"] dataDict:setDataDict completionHandler:^(BOOL finished) {
                
                //            [self CompleteAddFolder:setDataDict];
                
            }];
            
        });
        
    } else {
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"It looks this folder already exists" currentViewController:self];
        
    }
    
}

#pragma mark

-(void)CompleteAddSection:(NSDictionary *)setDataDict {
    
    [self->progressView setHidden:YES];
    
    NSArray *keyArray = [[[GeneralObject alloc] init] GenerateFolderKeyArray];
        
    [self->_firstFieldTextField becomeFirstResponder];
    
    for (NSString *key in keyArray) {
        NSMutableArray *arr = self->_itemsDict[key] ? [self->_itemsDict[key] mutableCopy] : [NSMutableArray array];
        [arr addObject:setDataDict[key]];
        [self->_itemsDict setObject:arr forKey:key];
    }
    
    self->_firstFieldTextField.text = @"";
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGFloat width = CGRectGetWidth(self.view.bounds);
        CGFloat tableViewHeight = [self AdjustTableViewHeight];
        
        self->_customTableView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), self->_firstFieldView.frame.origin.y + self->_firstFieldView.frame.size.height + 12, width*0.90338164, tableViewHeight);
        
    } completion:^(BOOL finished) {
        
        [self.customTableView reloadData];
        
    }];
    
    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddOrEditSection" userInfo:self->_itemsDict locations:@[@"Tasks"]];
    
}

-(void)CompleteAddFolder:(NSDictionary *)setDataDict {
    
    [self->progressView setHidden:YES];
    
    NSArray *keyArray = [[[GeneralObject alloc] init] GenerateFolderKeyArray];
       
    [self->_firstFieldTextField becomeFirstResponder];
    
    for (NSString *key in keyArray) {
        NSMutableArray *arr = self->_itemsDict[key] ? [self->_itemsDict[key] mutableCopy] : [NSMutableArray array];
        [arr addObject:setDataDict[key]];
        [self->_itemsDict setObject:arr forKey:key];
    }
    
    self->_firstFieldTextField.text = @"";
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGFloat width = CGRectGetWidth(self.view.bounds);
        CGFloat tableViewHeight = [self AdjustTableViewHeight];
        
        self->_customTableView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), self->_firstFieldView.frame.origin.y + self->_firstFieldView.frame.size.height + 12, width*0.90338164, tableViewHeight);
        
    } completion:^(BOOL finished) {
        
        [self.customTableView reloadData];
        
    }];
    
    for (NSString *folderID in _itemsDict[@"FolderID"]) {
        
        NSUInteger index = [_itemsDict[@"FolderID"] indexOfObject:folderID];
        
        NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:_itemsDict keyArray:[_itemsDict allKeys] indexPath:[NSIndexPath indexPathForRow:index inSection:0]];
       
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddOrEditFolder" userInfo:singleObjectItemDict locations:@[@"Tasks"]];
        
    }
    
}

#pragma mark - trailingSwipeAction

-(void)EditSwipeAction:(NSIndexPath *)indexPath itemType:(NSString *)itemType keyToUse:(NSString *)keyToUse index:(NSInteger)index {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Edit %@ Clicked", itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Enter the new name of your %@", itemType] message:nil
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Update"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Editing %@", itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        NSString *newName = controller.textFields[0].text;
        NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
        NSString *trimmedNewName = [newName stringByTrimmingCharactersInSet:charSet];
        
        NSString *errorString = @"";
        
        if ([self->_itemsDict[keyToUse] containsObject:newName]) {
            
            errorString = [NSString stringWithFormat:@"A list with the name, \"%@\", already exists", newName];
            
        } else if (trimmedNewName.length == 0) {
            
            errorString = [NSString stringWithFormat:@"You need to enter at least 1 character"];
            
        }
        
        if (errorString.length == 0) {
            
//            [self StartProgressView];
            
            if (self->_viewingSections) {
                
                NSMutableArray *arr = [self->_itemsDict[@"SectionName"] mutableCopy];
                if ([arr count] > index) {  [arr replaceObjectAtIndex:index withObject:newName]; }
                [self->_itemsDict setObject:arr forKey:@"SectionName"];
                
                [UIView animateWithDuration:0.25 animations:^{
                    
                    CGFloat width = CGRectGetWidth(self.view.bounds);
                    CGFloat tableViewHeight = [self AdjustTableViewHeight];
                    
                    self->_customTableView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), self->_firstFieldView.frame.origin.y + self->_firstFieldView.frame.size.height + 12, width*0.90338164, tableViewHeight);
                    
                } completion:^(BOOL finished) {
                    
                    [self.customTableView reloadData];
                    [self->progressView setHidden:YES];
                    
                    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddOrEditSection" userInfo:self->_itemsDict locations:@[@"Tasks"]];
                    
                }];
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
               
                    [[[SetDataObject alloc] init] UpdateDataSection:self->_itemsDict[@"SectionCreatedBy"][index] sectionID:self->_itemsDict[@"SectionID"][index] setDataDict:@{@"SectionName" : newName} completionHandler:^(BOOL finished) {
                        
                    }];
                    
                });
                
            } else if (self->_viewingFolders) {
             
                NSMutableArray *arr = [self->_itemsDict[@"FolderName"] mutableCopy];
                if ([arr count] > index) { [arr replaceObjectAtIndex:index withObject:newName]; }
                [self->_itemsDict setObject:arr forKey:@"FolderName"];
                
                if (self->_itemsAlreadyChosenDict && [self->_itemsAlreadyChosenDict[@"FolderID"] isEqualToString:self->_itemsDict[@"FolderID"][index]]) {
                    
                    [self->_itemsAlreadyChosenDict setObject:newName forKey:@"FolderName"];
                    
                }
               
                [UIView animateWithDuration:0.25 animations:^{
                    
                    CGFloat width = CGRectGetWidth(self.view.bounds);
                    CGFloat tableViewHeight = [self AdjustTableViewHeight];
                    
                    self->_customTableView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), self->_firstFieldView.frame.origin.y + self->_firstFieldView.frame.size.height + 12, width*0.90338164, tableViewHeight);
                    
                } completion:^(BOOL finished) {
                    
                    [self.customTableView reloadData];
                    [self->progressView setHidden:YES];
                    
                    NSArray *keyArray = [[[GeneralObject alloc] init] GenerateFolderKeyArray];
                    
                    NSMutableDictionary *singleObjectIndexDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:self->_itemsDict keyArray:keyArray indexPath:[NSIndexPath indexPathForRow:index inSection:0]];
                    
                    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddOrEditFolder" userInfo:singleObjectIndexDict locations:@[@"Tasks"]];
                    
                }];
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    [[[SetDataObject alloc] init] UpdateDataFolder:self->_itemsDict[@"FolderCreatedBy"][index] folderID:self->_itemsDict[@"FolderID"][index] dataDict:@{@"FolderName" : newName} completionHandler:^(BOOL finished) {
                        
                    }];
                    
                });
                
            }
            
        } else {
            
            [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:errorString currentViewController:self];
            
        }
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Edit %@ Cancelled", itemType] completionHandler:^(BOOL finished) {
            
        }];
        
    }];
    
    
    
    [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        textField.delegate = self;
        textField.placeholder = [NSString stringWithFormat:@"New %@", itemType];
        textField.text = @"";
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        
    }];
    
    [controller addAction:action1];
    [controller addAction:cancel];
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(void)DeleteSwipeAction:(NSIndexPath *)indexPath itemType:(NSString *)itemType keyToUse:(NSString *)keyToUse index:(NSInteger)index {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Delete %@ Clicked", itemType] completionHandler:^(BOOL finished) {
        
    }];
    
//    [self StartProgressView];
    
    if (self->_viewingSections) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sectionID == %@", self->_itemsDict[@"SectionID"][index]];
        [[[DeleteDataObject alloc] init] DeleteDataCoreData:@"Sections" predicate:predicate];
        
        for (NSString *key in [self->_itemsDict allKeys]) {
            
            NSMutableArray *arr = [self->_itemsDict[key] mutableCopy];
            [arr removeObjectAtIndex:index];
            [self->_itemsDict setObject:arr forKey:key];
            
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            
            CGFloat width = CGRectGetWidth(self.view.bounds);
            CGFloat tableViewHeight = [self AdjustTableViewHeight];
            
            self->_customTableView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), self->_firstFieldView.frame.origin.y + self->_firstFieldView.frame.size.height + 12, width*0.90338164, tableViewHeight);
            
        } completion:^(BOOL finished) {
            
            [self.customTableView reloadData];
            [self->progressView setHidden:YES];
            
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddOrEditSection" userInfo:self->_itemsDict locations:@[@"Tasks"]];
            
        }];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[[DeleteDataObject alloc] init] DeleteDataSection:self->_itemsDict[@"SectionID"][index] sectionCreatedBy:self->_itemsDict[@"SectionCreatedBy"][index] completionHandler:^(BOOL finished) {
                
            }];
            
        });
        
    } else if (self->_viewingFolders) {
        
        [[[DeleteDataObject alloc] init] DeleteDataFolder:self->_itemsDict[@"FolderID"][index] folderCreatedBy:self->_itemsDict[@"FolderCreatedBy"][index] completionHandler:^(BOOL finished) {
            
        NSArray *keyArray = [[[GeneralObject alloc] init] GenerateFolderKeyArray];
        
        NSMutableDictionary *singleObjectIndexDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:[self->_itemsDict mutableCopy] keyArray:keyArray indexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        
            NSString *folderID = self->_itemsDict[@"FolderID"][index];
        
            for (NSString *key in [self->_itemsDict allKeys]) {
                
                NSMutableArray *arr = [self->_itemsDict[key] mutableCopy];
                [arr removeObjectAtIndex:index];
                [self->_itemsDict setObject:arr forKey:key];
                
            }
            
            if (self->_itemsAlreadyChosenDict && [self->_itemsAlreadyChosenDict[@"FolderID"] isEqualToString:folderID]) {
                
                NSArray *keyArray = [[[GeneralObject alloc] init] GenerateFolderKeyArray];
                
                for (NSString *key in keyArray) {
                    
                    [self->_itemsAlreadyChosenDict removeObjectForKey:key];
                    
                }
                
            }
            
            [UIView animateWithDuration:0.25 animations:^{
                
                CGFloat width = CGRectGetWidth(self.view.bounds);
                CGFloat tableViewHeight = [self AdjustTableViewHeight];
                
                self->_customTableView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), self->_firstFieldView.frame.origin.y + self->_firstFieldView.frame.size.height + 12, width*0.90338164, tableViewHeight);
                
            } completion:^(BOOL finished) {
                
                [self.customTableView reloadData];
                [self->progressView setHidden:YES];
                
              
                
                
                
                [[[GeneralObject alloc] init] CallNSNotificationMethods:@"DeleteFolder" userInfo:singleObjectIndexDict locations:@[@"Tasks"]];
                
            }];
            
        }];
        
    }
    
}

@end
