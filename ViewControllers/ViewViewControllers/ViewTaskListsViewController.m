//
//  ViewTaskListsViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 6/3/22.
//

#import "ViewTaskListsViewController.h"

#import <MRProgressOverlayView.h>

#import "GeneralObject.h"
#import "SetDataObject.h"
#import "PushObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@interface ViewTaskListsViewController () {
    
    MRProgressOverlayView *progressView;
    NSMutableDictionary *folderChosenDict;
    
}

@end

@implementation ViewTaskListsViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self InitMethod];
   
    [self TapGestures];
    
    [self BarButtonItems];
    
    [self NSNotificationObservers];

}

-(void)viewWillLayoutSubviews {
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.navigationController.navigationBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        
        [self preferredStatusBarStyle];
        
    } else {
        
        self.navigationController.navigationBar.backgroundColor = self.view.backgroundColor;
        
    }
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    [self AdjustTextFieldFramesChores:0];
    [self AdjustTextFieldViewsChores];
    
    width = CGRectGetWidth(self.itemListNameView.bounds);
    height = CGRectGetHeight(self.itemListNameView.bounds);
    //342
    
    NSArray *rightArrowFrameArray = @[
        
        @{@"View" : _itemFolderRightArrow}
        
    ];
    
    [self RightArrowFrame:rightArrowFrameArray];
    
    NSArray *labelWithImageArray = @[
        
        @{@"View" : _itemFolderLabel, @"Width" : @"0.25"}
        
    ];
    
    [self LabelWithImage:labelWithImageArray];
    
    NSArray *textFieldWithArrowArray = @[
        
        @{@"View" : _itemFolderTextField, @"Label" : _itemFolderLabel}
        
    ];
    
    [self TextFieldWithArrow:textFieldWithArrowArray];
    
    NSArray *viewBackgroundColorArr = @[
        
        _itemListNameView,
        _itemFolderView
        
    ];
    
    [self ViewBackgroundColor:viewBackgroundColorArr];
    
    NSArray *imageArr = @[
        
        _itemFolderImage,
        
    ];
    
    [self ImageIconViewFrame:imageArr];
    
    NSArray *fontTextFieldArr = @[
        
        _itemListNameTextField,
        _itemFolderTextField
        
    ];
    
    [self TextFieldFontSize:fontTextFieldArr];
    
    NSArray *fontLabelArr = @[
        
        _itemFolderLabel
        
    ];
    
    [self LabelFontSize:fontLabelArr];
    
    width = CGRectGetWidth(_itemListNameView.bounds);
    height = CGRectGetHeight(_itemListNameView.bounds);
    
    _itemListNameTextField.frame = CGRectMake(width*0.04830918, height*0, width*1 - ((width*0.04830918)*2), height);
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        _itemListNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"List Name" attributes:@{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModeTextSecondary]}];
    }
    _itemListNameTextField.textAlignment = NSTextAlignmentLeft;
    
    _itemFolderView.hidden = YES;
    
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [_itemListNameTextField becomeFirstResponder];
    
    folderChosenDict = [NSMutableDictionary dictionary];
   
    if (_itemToEditDict[@"TaskListID"]) {
        
        _itemListNameTextField.text = _itemToEditDict[@"TaskListName"];
        
        for (NSString *folderID in _foldersDict[@"FolderID"]) {
            
            NSUInteger index = [_foldersDict[@"FolderID"] indexOfObject:folderID];
            NSMutableDictionary *folderTaskLists = [_foldersDict[@"FolderTaskLists"][index] mutableCopy];
            
            for (NSString *taskListID in [folderTaskLists allKeys]) {
                
                if ([taskListID isEqualToString:_itemToEditDict[@"TaskListID"]]) {
                    
                    NSString *folderName = _foldersDict[@"FolderName"] && [(NSArray *)_foldersDict[@"FolderName"] count] > index ? _foldersDict[@"FolderName"][index] : @"";
                    
                    _itemFolderTextField.text = folderName;
                    
                    NSArray *keyArray = [[[GeneralObject alloc] init] GenerateFolderKeyArray];
                    
                    for (NSString *key in keyArray) {
                    
                        id object = _foldersDict[key] && [(NSArray *)_foldersDict[key] count] > index ? _foldersDict[key][index] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                        [folderChosenDict setObject:object forKey:key];
                    
                    }
                
                    break;
                    
                }
                
            }
            
        }
        
    }
    
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
    
    if (_itemToEditDict[@"TaskListID"]) {
        
        barButtonItem =
        [[UIBarButtonItem alloc]
         initWithTitle:@"Save"
         style:UIBarButtonItemStyleDone
         target:self
         action:@selector(EditTaskList:)];
        
    } else {
        
        barButtonItem =
        [[UIBarButtonItem alloc]
         initWithTitle:@"Save"
         style:UIBarButtonItemStyleDone
         target:self
         action:@selector(AddTaskList:)];
        
    }
    
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
}

-(void)TapGestures {
    
    UITapGestureRecognizer *tapGesture;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureItemFolder:)];
    [_itemFolderTextField addGestureRecognizer:tapGesture];
    [_itemFolderView addGestureRecognizer:tapGesture];
    _itemFolderTextField.userInteractionEnabled = NO;
    _itemFolderView.userInteractionEnabled = YES;
    
}

-(void)NSNotificationObservers {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_ViewTaskList_AddFolder" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_ViewTaskList_AddFolder:) name:@"NSNotification_ViewTaskList_AddFolder" object:nil];
    
}

#pragma mark - UI Methods

-(void)AdjustTextFieldViewsChores {
    
    CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
    
    [[[GeneralObject alloc] init] RoundingCorners:_itemListNameView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
    [[[GeneralObject alloc] init] RoundingCorners:_itemFolderView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
    
    
    
    NSArray *arrView = @[_itemListNameView, _itemFolderView];
    
    for (UIView *viewNo1 in arrView) {
        
        for (UIView *subViewNo1 in [viewNo1 subviews]) {
            
            if (subViewNo1.tag == 1111) {
                
                [subViewNo1 removeFromSuperview];
                
            }
            
        }
        
    }
    
    for (UIView *viewNo1 in arrView) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(viewNo1.frame.size.width*0.04830918, viewNo1.frame.size.height-1, viewNo1.frame.size.width - (viewNo1.frame.size.width*0.04830918), 1)];
        view.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [[[LightDarkModeObject alloc] init] LightModeSubviewLine];
        view.tag = 1111;
        [viewNo1 addSubview:view];
        
    }
    
}

-(void)AdjustTextFieldFramesChores:(NSTimeInterval)interval {
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    
    CGFloat textFieldSpacing = (height*0.024456);
    
    [UIView animateWithDuration:interval animations:^{
        
        
        
        
        self->_itemListNameView.frame = CGRectMake(textFieldSpacing, navigationBarHeight + textFieldSpacing, (width*1 - (textFieldSpacing*2)), (self.view.frame.size.height*0.07472826 > 55?55:(self.view.frame.size.height*0.07472826)));
        
        
        
        
        self->_itemFolderView.frame = CGRectMake(self->_itemListNameView.frame.origin.x, self->_itemListNameView.frame.origin.y + self->_itemListNameView.frame.size.height  +textFieldSpacing, self->_itemListNameView.frame.size.width, self->_itemListNameView.frame.size.height);
        
        
        
        
    }];
    
}

-(void)LabelWithImage:(NSArray *)viewArray {
    
    CGFloat width = CGRectGetWidth(_itemListNameView.bounds);
    CGFloat height = CGRectGetHeight(_itemListNameView.bounds);
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UIView *viewToUse = dictToUse[@"View"];
        float labelWidth = [dictToUse[@"Width"] floatValue];
        
        viewToUse.frame = CGRectMake(width*0.04830918 + width*0.0275 + height*0.5, height*0, width*labelWidth, height);
        
    }
    
}

-(void)LabelWithoutImage:(NSArray *)viewArray {
    
    CGFloat width = CGRectGetWidth(_itemListNameView.bounds);
    CGFloat height = CGRectGetHeight(_itemListNameView.bounds);
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UIView *viewToUse = dictToUse[@"View"];
        float labelWidth = [dictToUse[@"Width"] floatValue];
        
        viewToUse.frame = CGRectMake(width*0.04830918, height*0, width*labelWidth, height);
        
    }
    
}

-(void)TextFieldWithArrow:(NSArray *)viewArray {
    
    CGFloat width = CGRectGetWidth(_itemListNameView.bounds);
    CGFloat height = CGRectGetHeight(_itemListNameView.bounds);
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UIView *viewToUse = dictToUse[@"View"];
        UILabel *labelToUse = dictToUse[@"Label"];
        
        CGFloat textFieldWidth = (width*1 - (width*0.04830918) - _itemListNameView.frame.origin.x - labelToUse.frame.origin.x - labelToUse.frame.size.width);
        
        viewToUse.frame = CGRectMake(_itemFolderRightArrow.frame.origin.x - textFieldWidth - width*0.025 + width*0.025, height*0, textFieldWidth - width*0.025, height);
        
    }
    
}

-(void)TextFieldWithoutArrow:(NSArray *)viewArray {
    
    CGFloat width = CGRectGetWidth(_itemListNameView.bounds);
    CGFloat height = CGRectGetHeight(_itemListNameView.bounds);
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UITextField *textFieldToUse = dictToUse[@"TextField"];
        UILabel *labelToUse = dictToUse[@"Label"];
        
        CGFloat textFieldWidth = (width*1 - ((width*0.04830918)*0.5) - _itemListNameView.frame.origin.x - labelToUse.frame.origin.x - labelToUse.frame.size.width);
        
        textFieldToUse.frame = CGRectMake(width - textFieldWidth - width*0.04830918, height*0, textFieldWidth, height);
        
    }
    
}

-(void)RightArrowFrame:(NSArray *)viewArray {
    
    CGFloat width = CGRectGetWidth(_itemListNameView.bounds);
    CGFloat height = CGRectGetHeight(_itemListNameView.bounds);
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UIImageView *viewToUse = dictToUse[@"View"];
        
        viewToUse.contentMode = UIViewContentModeScaleAspectFit;
        viewToUse.frame = CGRectMake(width*1 - width*0.02339181 - width*0.04830918, height*0, width*0.02339181, height*1);
        
    }
    
}

-(void)ViewBackgroundColor:(NSArray *)viewArray {
    
    for (UIView *view in viewArray) {
        
        view.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?
        [[[LightDarkModeObject alloc] init] DarkModeTertiary] :
        [[[LightDarkModeObject alloc] init] LightModeSecondary];
        
    }
    
}

-(void)TextFieldFontSize:(NSArray *)viewArray {
    
    CGFloat height = CGRectGetHeight(self.itemListNameView.bounds);
    
    UIFont *fontSize = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02173813 > 16?16:(self.view.frame.size.height*0.02173813)) weight:UIFontWeightRegular];
    UIColor *textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [[[LightDarkModeObject alloc] init] LightModeTexAddTaskTextField];
    UIColor *backgroundColor = [UIColor clearColor];
    
    for (UITextField *textField in viewArray) {
        
        textField.font = fontSize;
        textField.minimumFontSize = (height*0.25454545 > 14?14:(height*0.25454545));
        textField.adjustsFontSizeToFitWidth = YES;
        textField.textColor = textColor;
        textField.backgroundColor = backgroundColor;
        textField.textAlignment = NSTextAlignmentRight;
        
    }
    
}

-(void)ViewAlpha:(NSArray *)viewArray {
    
    for (UIView *view in viewArray) {
        
        view.alpha = 1.0f;
        
    }
    
}

-(void)ImageIconViewFrame:(NSArray *)viewArray {
    
    CGFloat width = CGRectGetWidth(_itemListNameView.bounds);
    CGFloat height = CGRectGetHeight(_itemListNameView.bounds);
    
    CGRect imageFrame = CGRectMake(width*0.04830918, height*0.5 - ((height*0.5)*0.5), height*0.5, height*0.5);
    
    for (UIImageView *image in viewArray) {
        
        image.frame = imageFrame;
        
    }
    
}

-(void)LabelFontSize:(NSArray *)viewArray {
    
    UIFont *fontSize = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02173813 > 16?16:(self.view.frame.size.height*0.02173813)) weight:UIFontWeightRegular];
    
    for (UILabel *label in viewArray) {
        
        label.font = fontSize;
        label.adjustsFontSizeToFitWidth = YES;
        label.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] LightModeTextPrimary];
        
        CGRect newRect = label.frame;
        newRect.size.width = [[[GeneralObject alloc] init] WidthOfString:label.text withFont:label.font];
        label.frame = newRect;
        
    }
    
}

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

#pragma mark - IBAction Methods

-(IBAction)AddTaskList:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Add Task List"] completionHandler:^(BOOL finished) {
        
    }];
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedString = [_itemListNameTextField.text stringByTrimmingCharactersInSet:charSet];
    
    BOOL TaskListAlreadyExists = [_taskListDict[@"TaskListName"] containsObject:_itemListNameTextField.text];
    
    if (trimmedString.length > 0 && TaskListAlreadyExists == NO) {
      
        [self StartProgressView];
       
        NSMutableDictionary *setDataDict = [self AddTaskList_GenerateSetDataDict];
       
        [self AddTaskList_GenerateUpdatedTaskListDict:setDataDict];
        
        self->folderChosenDict = [self AddTaskList_GenerateUpdatedFolderChosenDict:[self->folderChosenDict mutableCopy] setDataDict:setDataDict];
        
        
        
        __block int completedQueries = 0;
        __block int totalQueries = 2;
        
        
        
         /*
         //
         //
         //Set Task List Data
         //
         //
         */
        [self AddTaskList_SetTaskListData:setDataDict completionHandler:^(BOOL finished) {
          
            [self AddTaskList_CompletionBlock:setDataDict totalQueries:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
                
            }];
        }];
        
        
        /*
         //
         //
         //Update Folder Data
         //
         //
         */
        [self AddTaskList_UpdateFolderData:self->folderChosenDict completionHandler:^(BOOL finished) {
           
            [self AddTaskList_CompletionBlock:setDataDict totalQueries:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
                
            }];
            
        }];
        
    } else if (trimmedString.length == 0) {
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"It looks like you forgot to name your list" currentViewController:self];
        
    } else if (TaskListAlreadyExists == YES) {
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"It looks this task list already exists" currentViewController:self];
        
    }
    
}

-(IBAction)EditTaskList:(id)sender {
   
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Edit Task List"] completionHandler:^(BOOL finished) {
        
    }];
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedString = [_itemListNameTextField.text stringByTrimmingCharactersInSet:charSet];
    
    if (trimmedString.length > 0) {
        
        [self StartProgressView];
        
        NSMutableDictionary *setDataDict = [self EditTaskList_GenerateSetDataDict];
        
        self->folderChosenDict = [self AddTaskList_GenerateUpdatedFolderChosenDict:[self->folderChosenDict mutableCopy] setDataDict:setDataDict];
        
        
        
        __block int completedQueries = 0;
        __block int totalQueries = 3;
        
        
        
        /*
         //
         //
         //Update Task List Data
         //
         //
         */
        [self EditTaskList_UpdateTaskListData:setDataDict completionHandler:^(BOOL finished) {
            
            [self AddTaskList_CompletionBlock:setDataDict totalQueries:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
                
            }];
            
        }];
        
        
        /*
         //
         //
         //Update Folder Data
         //
         //
         */
        [self AddTaskList_UpdateFolderData:self->folderChosenDict completionHandler:^(BOOL finished) {
            
            [self AddTaskList_CompletionBlock:setDataDict totalQueries:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
                
            }];
            
        }];
        
        
        /*
         //
         //
         //Update Old Folder Data
         //
         //
         */
        [self EditTaskList_UpdateOldFolderData:^(BOOL finished) {
            
            [self AddTaskList_CompletionBlock:setDataDict totalQueries:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
                
            }];
            
        }];
        
    } else {
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"It looks like you forgot to name your list" currentViewController:self];
        
    }
    
}

-(IBAction)TapGestureItemFolder:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"View Folders Field Clicked"] completionHandler:^(BOOL finished) {
        
    }];
   
    NSMutableDictionary *itemsAlreadyChosenDict = folderChosenDict ? [folderChosenDict mutableCopy] : [NSMutableDictionary dictionary];

    [[[PushObject alloc] init] PushToViewMutableOptionsViewController:itemsAlreadyChosenDict itemsDict:_foldersDict foldersDict:_foldersDict viewingSections:NO viewingFolders:YES homeMembersArray:nil homeMembersDict:nil itemOccurrencesDict:nil allItemTagsArrays:nil currentViewController:self];
    
}

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked Task List"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - NSNotification Methods

-(void)NSNotification_ViewTaskList_AddFolder:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    NSDictionary *itemsDict = userInfo[@"ItemsDict"] ? userInfo[@"ItemsDict"] : [NSDictionary dictionary];
    NSArray *keyArray = [[[GeneralObject alloc] init] GenerateFolderKeyArray];
    
    folderChosenDict = [NSMutableDictionary dictionary];
    
    if (itemsDict[@"FolderID"]) {
        
        for (NSString *key in keyArray) {
            
            id object = itemsDict[key] ? itemsDict[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            [folderChosenDict setObject:object forKey:key];
            
        }
        
        _itemFolderTextField.text = itemsDict[@"FolderName"] ? itemsDict[@"FolderName"] : @"";
        
    } else {
        
        _itemFolderTextField.text = @"";
        
    }
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark AddTaskList

-(NSMutableDictionary *)AddTaskList_GenerateSetDataDict {
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    NSString *randomID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    NSString *dateCreated = [[[GeneralObject alloc] init] GenerateCurrentDateString];
    NSString *newName = self->_itemListNameTextField.text;
    
    NSMutableDictionary *setDataDict = [@{
        @"TaskListID" : randomID,
        @"TaskListDateCreated" : dateCreated,
        @"TaskListCreatedBy" : userID,
        @"TaskListName" : newName,
        @"TaskListSections" : [NSMutableArray array],
        @"TaskListItems" : [NSMutableDictionary dictionary]
    } mutableCopy];
    
    return setDataDict;
}

-(void)AddTaskList_GenerateUpdatedTaskListDict:(NSMutableDictionary *)setDataDict {
   
    for (NSString *key in [setDataDict allKeys]) {
        
        NSMutableArray *arr = _taskListDict[key] ? [_taskListDict[key] mutableCopy] : [NSMutableArray array];
        id object = setDataDict[key] ? setDataDict[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
        [arr addObject:object];
        [_taskListDict setObject:arr forKey:key];
   
    }
    
}

-(NSMutableDictionary *)AddTaskList_GenerateUpdatedFolderChosenDict:(NSMutableDictionary *)folderChosenDict setDataDict:(NSMutableDictionary *)setDataDict {
    
    if (folderChosenDict[@"FolderID"]) {
        
        //Update Folder Task Lists For NSNotificationObserver Method
        NSMutableDictionary *folderChosenDictFolderTaskLists = [folderChosenDict[@"FolderTaskLists"] mutableCopy];
        
        if ([[folderChosenDictFolderTaskLists allKeys] containsObject:setDataDict[@"TaskListID"]] == NO) {
            
            [folderChosenDictFolderTaskLists setObject:@{@"TaskListID" : setDataDict[@"TaskListID"]} forKey:setDataDict[@"TaskListID"]];
            [folderChosenDict setObject:folderChosenDictFolderTaskLists forKey:@"FolderTaskLists"];
            
        }
        
        //Set Old Task List ID To Find Old Task List In NSNotificationObserver Method
        //DO NOT DELETE
        [folderChosenDict setObject:setDataDict[@"TaskListID"] forKey:@"TaskListID"];
        
    }
    
    return folderChosenDict;
}

-(void)AddTaskList_SetTaskListData:(NSMutableDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] SetDataAddTaskList:setDataDict[@"TaskListCreatedBy"] taskListID:setDataDict[@"TaskListID"] dataDict:setDataDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)AddTaskList_UpdateFolderData:(NSMutableDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      
        BOOL FolderFound = setDataDict[@"FolderID"];
        
        if (FolderFound == YES) {
            
            [[[SetDataObject alloc] init] UpdateDataFolder:setDataDict[@"FolderCreatedBy"] folderID:setDataDict[@"FolderID"] dataDict:@{@"FolderTaskLists" : setDataDict[@"FolderTaskLists"]} completionHandler:^(BOOL finished) {
                
                finishBlock(YES);
                
            }];
            
        } else {
            
            finishBlock(YES);
            
        }
        
    });
    
}

-(void)AddTaskList_CompletionBlock:(NSMutableDictionary *)setDataDict totalQueries:(int)totalQueries completedQueries:(int)completedQueries completionHandler:(void (^)(BOOL finished))finishBlock {
 
    if (totalQueries == completedQueries) {
      
        if (self->folderChosenDict[@"FolderID"]) {
           
            NSMutableDictionary *folderChosenDictFolderTaskLists = [self->folderChosenDict[@"FolderTaskLists"] mutableCopy];
            
            if ([[folderChosenDictFolderTaskLists allKeys] containsObject:setDataDict[@"TaskListID"]] == NO) {
                
                [folderChosenDictFolderTaskLists setObject:@{@"TaskListID" : setDataDict[@"TaskListID"]} forKey:setDataDict[@"TaskListID"]];
                [self->folderChosenDict setObject:folderChosenDictFolderTaskLists forKey:@"FolderTaskLists"];
                
            }
            
        }
       
        [self CompleteAddOrEditTaskList:setDataDict];
        
        finishBlock(YES);
        
    }
    
}

#pragma mark - EditTaskList

-(NSMutableDictionary *)EditTaskList_GenerateSetDataDict {
    
    NSString *newName = self->_itemListNameTextField.text;
    
    NSMutableDictionary *setDataDict = [@{
        @"TaskListID" : _itemToEditDict[@"TaskListID"],
        @"TaskListDateCreated" : _itemToEditDict[@"TaskListDateCreated"],
        @"TaskListCreatedBy" : _itemToEditDict[@"TaskListCreatedBy"],
        @"TaskListName" : newName,
        @"TaskListSections" : _itemToEditDict[@"TaskListSections"],
        @"TaskListItems" : _itemToEditDict[@"TaskListItems"]
    } mutableCopy];
    
    return setDataDict;
}

-(NSMutableDictionary *)EditTaskList_GenerateOldFolderDict {
    
    NSMutableDictionary *oldFolderDict = [NSMutableDictionary dictionary];
    
    BOOL OldFolderFound = NO;
    
    for (NSString *folderID in self->_foldersDict[@"FolderID"]) {
        
        //Find Folder With Task List
        NSUInteger index = [self->_foldersDict[@"FolderID"] indexOfObject:folderID];
        NSMutableDictionary *folderTaskLists = [self->_foldersDict[@"FolderTaskLists"][index] mutableCopy];
      
        for (NSString *taskListID in [folderTaskLists allKeys]) {
           
            if ([taskListID isEqualToString:_itemToEditDict[@"TaskListID"]]) {
               
                OldFolderFound = YES;
                break;
                
            }
            
        }
        
        if (OldFolderFound == YES) {
            
            //Generate Old Folder Dict
            for (NSString *key in [self->_foldersDict allKeys]) {
                
                [oldFolderDict setObject:self->_foldersDict[key][index] forKey:key];
               
            }
            
            //Remove Tsask List From Old Folder
            NSMutableDictionary *folderTaskListCopy = [oldFolderDict[@"FolderTaskLists"] mutableCopy];
            
            if ([[folderTaskListCopy allKeys] containsObject:_itemToEditDict[@"TaskListID"]]) {
                
                [folderTaskListCopy removeObjectForKey:_itemToEditDict[@"TaskListID"]];
                
            }
            
            [oldFolderDict setObject:folderTaskListCopy forKey:@"FolderTaskLists"];
            
            break;
            
        }
      
        if (OldFolderFound == YES) {
            
            break;
            
        }
        
    }
    
    return oldFolderDict;
}

-(void)EditTaskList_UpdateTaskListData:(NSMutableDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataTaskList:setDataDict[@"TaskListCreatedBy"] taskListID:setDataDict[@"TaskListID"] dataDict:setDataDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)EditTaskList_UpdateOldFolderData:(void (^)(BOOL finished))finishBlock {
    
    NSMutableDictionary *oldFolderDict = [self EditTaskList_GenerateOldFolderDict];
    BOOL OldFolderFound = [[oldFolderDict allKeys] count] > 0;
    
    if (OldFolderFound == YES) {
       
        /*
         //
         //
         //Update Folder Data
         //
         //
         */
        [self AddTaskList_UpdateFolderData:oldFolderDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
        
    } else {
        
        finishBlock(YES);
        
    }
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark AddTaskList

-(void)CompleteAddOrEditTaskList:(NSMutableDictionary *)setDataDict {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self->progressView setHidden:YES];
        
        
        
        
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddOrEditTaskList" userInfo:setDataDict locations:@[@"AddTask", @"MultiAddTasks"]];
      
        if (self->_comingFromTasksViewController == YES) { [setDataDict setObject:@"Yes" forKey:@"SelectListInTasksViewController"]; }
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddOrEditTaskList" userInfo:setDataDict locations:@[@"Tasks"]];
        
        if (self->_comingFromViewTaskViewController == YES) { [setDataDict setObject:@"Yes" forKey:@"SelectListInViewTaskViewController"]; }
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddOrEditTaskList" userInfo:setDataDict locations:@[@"ViewTask"]];
        
        
        
        
        
        BOOL FolderWasChosen = (self->folderChosenDict[@"FolderID"] && [self->folderChosenDict[@"FolderID"] length] > 0);
        
        if (FolderWasChosen == YES) {
          
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddOrEditTaskListInFolder" userInfo:self->folderChosenDict locations:@[@"Tasks"]];
       
        } else {
           
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddOrEditTaskListInFolder" userInfo:@{@"TaskListID" : setDataDict[@"TaskListID"]} locations:@[@"Tasks"]];
       
        }
      
        [self dismissViewControllerAnimated:YES completion:nil];
        
    });
    
}

@end
