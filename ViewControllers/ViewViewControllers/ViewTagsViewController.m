//
//  ViewTagsViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 5/12/22.
//

#import "ViewTagsViewController.h"

#import "GeneralObject.h"
#import "SetDataObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@interface ViewTagsViewController () {
    
    NSMutableArray *tagsArray;
    NSMutableArray *selectedTagsArray;
    int totalRowsOfTags;
    
}

@end

@implementation ViewTagsViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self InitMethod];
    
    [self BarButtonItem];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self AdjustTextFieldFramesChores:0];
    [self AdjustTextFieldViewsChores];
    
    [self GenerateTagViews];
    
}

-(void)viewWillLayoutSubviews {
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    
    
    width = CGRectGetWidth(self.tagsView.bounds);
    height = CGRectGetHeight(self.tagsView.bounds);
    
    
    NSArray *viewArray = @[
        
    ];
    
    [self ViewWithFourRoundedCorners:viewArray];
    
    NSArray *viewBackgroundColorArr = @[
        
        _tagsView,
        _addTagView,
        
    ];
    
    [self ViewBackgroundColor:viewBackgroundColorArr];
    
    NSArray *fontTextFieldArr = @[
        
        _addTagTextField
        
    ];
    
    [self TextFieldFontSize:fontTextFieldArr];
    
    
    
    _addTagTextField.frame = CGRectMake(width*0.04830918, width*0.04830918, width*1 - ((width*0.04830918)*2), _addTagView.frame.size.height - ((width*0.04830918)*2));
    
    
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.navigationController.navigationBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.addTagTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"New Tag" attributes:@{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModeTextSecondary]}];
        
        [self preferredStatusBarStyle];
        
    } else {
        
        self.navigationController.navigationBar.backgroundColor = self.view.backgroundColor;
        
    }
    
}

#pragma mark - TextField Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self AddTag:nil];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
    
    NSString *acceptableCharaters = @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.";
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:acceptableCharaters] invertedSet];
    
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    return [string isEqualToString:filtered];
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpStartNumberOfRows];
    
    [self SetUpTagsArray];
    
    [self SetUpSelectedTagsArray];
    
    [self SetUpNewTagTextField];
    
}

-(void)BarButtonItem {
    
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(NavigationBackButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = newBackButton;
    
    if (_viewingItemDetails == NO) {
        
        newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(SaveButtonAction:)];
        
        self.navigationItem.rightBarButtonItem = newBackButton;
        
    }
    
}

#pragma mark - SetUp Methods

-(void)SetUpStartNumberOfRows {
    
    totalRowsOfTags = 1;
    
}

-(void)SetUpTagsArray {
    
    tagsArray = _itemsAlreadyChosenArray ? [_itemsAlreadyChosenArray mutableCopy] : [NSMutableArray array];
    
    for (NSString *itemTag in _allItemTagsArrays) {
        
        if ([tagsArray containsObject:itemTag] == NO) {
            
            [tagsArray addObject:itemTag];
            
        }
        
    }
    
}

-(void)SetUpSelectedTagsArray {
    
    selectedTagsArray = _itemsAlreadyChosenArray ? [_itemsAlreadyChosenArray mutableCopy] : [NSMutableArray array];
    
}

-(void)SetUpNewTagTextField {
    
    if (_viewingItemDetails == NO) {
        
        _addTagTextField.delegate = self;
        [_addTagTextField becomeFirstResponder];
        
    } else {
        
        _addTagTextField.userInteractionEnabled = NO;
        
    }
    
}

#pragma mark - UI Methods

-(void)AdjustTextFieldViewsChores {
    
    CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
    
    _tagsView.layer.cornerRadius = cornerRadius;
    
    [[[GeneralObject alloc] init] RoundingCorners:_addTagView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
    
    NSArray *arrView = @[_addTagView];
    
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
        
        self->_tagsView.frame = CGRectMake(textFieldSpacing, navigationBarHeight + textFieldSpacing, (width*1 - (textFieldSpacing*2)), (self.view.frame.size.height*0.07472826 > 55?55:(self.view.frame.size.height*0.07472826)));
        
        self->_addTagView.frame = CGRectMake(self->_tagsView.frame.origin.x, self->_tagsView.frame.origin.y + self->_tagsView.frame.size.height + textFieldSpacing, self->_tagsView.frame.size.width, (self.view.frame.size.height*0.07472826 > 55?55:(self.view.frame.size.height*0.07472826)));
        
    }];
    
}

-(void)ViewWithFourRoundedCorners:(NSArray *)viewArray {
    
    CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
    
    for (UIView *view in viewArray) {
        
        view.layer.cornerRadius = cornerRadius;
        
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
    
    CGFloat height = CGRectGetHeight(self.addTagView.bounds);
    
    UIFont *fontSize = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02173813 > 16?16:(self.view.frame.size.height*0.02173813)) weight:UIFontWeightRegular];
    UIColor *textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [[[LightDarkModeObject alloc] init] LightModeTexAddTaskTextField];
    UIColor *backgroundColor = [UIColor clearColor];
    
    for (UITextField *textField in viewArray) {
        
        textField.font = fontSize;
        textField.minimumFontSize = (height*0.25454545 > 14?14:(height*0.25454545));
        textField.adjustsFontSizeToFitWidth = YES;
        textField.textColor = textColor;
        textField.backgroundColor = backgroundColor;
        
    }
    
}

-(void)ViewAlpha:(NSArray *)viewArray {
    
    for (UIView *view in viewArray) {
        
        view.alpha = 1.0f;
        
    }
    
}

#pragma mark - UX Methods

-(void)GenerateTagViews {
    
    CGFloat tagViewStartingHeight = (self.view.frame.size.height*0.04076 > 30?30:(self.view.frame.size.height*0.04076));
    CGFloat textFieldHeight = (self.view.frame.size.height*0.07472826 > 55?55:(self.view.frame.size.height*0.07472826));
    
    CGFloat gapBetweenTagViews = ((self.view.frame.size.height*0.07472826 > 55?55:(self.view.frame.size.height*0.07472826))*0.5) - (tagViewStartingHeight*0.5);
    
    BOOL MoveTagLabelToTheNextRow = false;
    
    
    
    for (NSString *tag in tagsArray) {
        
        BOOL TagAlreadyAdded = [self TagAlreadAdded:tag];
        
        
        
        if (TagAlreadyAdded == NO) {
            
            //Find Last Tag Label Added
            UILabel *lastTagLabelInLastRow = [self GenerateLastTagLabelInLastRow];
            
            
            
            //Generate X Pos Of Tag Label About To Be Added
            
            CGFloat xPosOfTagLabelAboutToBeAdded =
            lastTagLabelInLastRow != nil ?
            lastTagLabelInLastRow.frame.origin.x + lastTagLabelInLastRow.frame.size.width + gapBetweenTagViews :
            gapBetweenTagViews;
            
            //Generate Width Of Tag Label About To Be Added
            
            CGFloat widthOfTagLabelAboutToBeAddedString =
            [[[GeneralObject alloc] init] WidthOfString:[NSString stringWithFormat:@"   #%@   ", tag]
                                               withFont:[UIFont systemFontOfSize:tagViewStartingHeight*0.5 weight:UIFontWeightBold]];
            
            
            //Check If Tag Label About To Be Added Needs To Move To New Row
            
            int xPosAndWidthOfTagLabel = xPosOfTagLabelAboutToBeAdded + widthOfTagLabelAboutToBeAddedString;
            int totalAvailableTagViewWidth = (_tagsView.frame.size.width - (gapBetweenTagViews*2));
            
            BOOL TagLabelCanNotFitIntoLastRow = (xPosAndWidthOfTagLabel > totalAvailableTagViewWidth);
            
            if (TagLabelCanNotFitIntoLastRow == YES) {
                
                xPosOfTagLabelAboutToBeAdded = gapBetweenTagViews;
                MoveTagLabelToTheNextRow = YES;
                totalRowsOfTags += 1;
                
            }
            
            
            
            //Generate Y Pos Of Tag Label About To Be Added
            
            CGFloat yPosOfTagLabelAboutToBeAdded = [self GenerateYPosOfTagLabelAboutToBeAdded:lastTagLabelInLastRow gapBetweenTagViews:gapBetweenTagViews MoveTagLabelToTheNextRow:MoveTagLabelToTheNextRow];
            
            
            
            //Generate Tag Label About To Be Added
            
            UILabel *tagLabelToAdd = [self GenerateTagLabelAboutToBeAdded:tag xPosOfTagLabelAboutToBeAdded:xPosOfTagLabelAboutToBeAdded yPosOfTagLabelAboutToBeAdded:yPosOfTagLabelAboutToBeAdded widthOfTagLabelAboutToBeAddedString:widthOfTagLabelAboutToBeAddedString tagViewStartingHeight:tagViewStartingHeight];
            [_tagsView addSubview:tagLabelToAdd];
            
        }
        
        
        
        //Adjust View Frames
        
        [self AdjustFieldFrames:tagViewStartingHeight gapBetweenTagViews:gapBetweenTagViews textFieldHeight:textFieldHeight];
        MoveTagLabelToTheNextRow = NO;
        
    }
    
}

#pragma mark - IBAction Methods

-(IBAction)SaveButtonAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Save Button Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableArray *locations = [NSMutableArray array];
    
    if (_comingFromAddTaskViewController == YES) {
        [locations addObject:@"AddTask"];
    }
    if (_comingFromViewTaskViewController == YES) {
        [locations addObject:@"ViewTask"];
    }
    if (_comingFromAddTaskViewController == NO && _comingFromViewTaskViewController == NO) {
        [locations addObject:@"Tasks"];
    }
   
    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemTags" userInfo:@{@"Tags" : selectedTagsArray} locations:locations];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(IBAction)AddTag:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Add Tag Clicked %@ For %@", _addTagTextField.text, [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedString = [_addTagTextField.text stringByTrimmingCharactersInSet:charSet];
    
    if (trimmedString.length > 0) {
        
        if ([tagsArray containsObject:_addTagTextField.text] == NO) { [tagsArray addObject:_addTagTextField.text]; }
        if ([selectedTagsArray containsObject:_addTagTextField.text] == NO) { [selectedTagsArray addObject:_addTagTextField.text]; }
        
        [self GenerateTagViews];
        
        _addTagTextField.text = @"";
        
    }
    
}

-(IBAction)SelectTag:(UITapGestureRecognizer *)sender {
    
    if (_viewingItemDetails == YES) {
        return;
    }
    
    int tag = (int)sender.view.tag;
    NSString *tagStr = tagsArray[tag-1];
    
    if ([selectedTagsArray containsObject:tagStr]) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Deselect Tag Clicked %@ For %@", tagStr, [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        [selectedTagsArray removeObject:tagStr];
        
    } else {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Select Tag Clicked %@ For %@", tagStr, [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        [selectedTagsArray addObject:tagStr];
        
    }
    
    for (UILabel *subView in [_tagsView subviews]) {
        
        if (subView.tag == tag) {
            
            UIColor *unselectedBackgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeSecondary] : [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
            UIColor *unselectedTextColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [UIColor colorWithRed:129.0f/255.0f green:128.0f/255.0f blue:133.0f/255.0f alpha:1.0f];
            
            UIColor *selectedBackgroundColor = [UIColor colorWithRed:0.0f/255.0f green:122.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
            UIColor *selectedTextColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
            
            [UIView animateWithDuration:0.25 animations:^{
                
                subView.backgroundColor = [self->selectedTagsArray containsObject:tagStr] ? selectedBackgroundColor : unselectedBackgroundColor;
                subView.textColor = [self->selectedTagsArray containsObject:tagStr] ? selectedTextColor : unselectedTextColor;
                
            }];
            
        }
        
    }
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark GenerateTagViews Methods

-(BOOL)TagAlreadAdded:(NSString *)tag {
    
    BOOL TagAlreadyAdded = NO;
    
    for (UILabel *subView in [_tagsView subviews]) {
        
        BOOL SubViewIsASeparatorLine = subView.tag == 1111;
        BOOL SubViewHasExistingTagText = [subView.text isEqualToString:[NSString stringWithFormat:@"#%@", tag]];
        
        TagAlreadyAdded =
        SubViewIsASeparatorLine == NO &&
        SubViewHasExistingTagText == YES;
        
        if (TagAlreadyAdded == YES) {
            
            break;
            
        }
        
    }
    
    return TagAlreadyAdded;
}

-(UILabel *)GenerateLastTagLabelInLastRow {
    
    BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:[[_tagsView subviews] lastObject] classArr:@[[UILabel class]]];

    UILabel *lastSubViewInTagsView = ObjectIsKindOfClass == YES ? [[_tagsView subviews] lastObject] : nil;
    BOOL SubViewIsASeparatorLine = lastSubViewInTagsView.tag == 1111;
    
    UILabel *lastTagLabelInLastRow =
    SubViewIsASeparatorLine == NO ?
    lastSubViewInTagsView : nil;
    
    return lastTagLabelInLastRow;
}

-(UILabel *)GenerateTagLabelAboutToBeAdded:(NSString *)tag xPosOfTagLabelAboutToBeAdded:(CGFloat)xPosOfTagLabelAboutToBeAdded yPosOfTagLabelAboutToBeAdded:(CGFloat)yPosOfTagLabelAboutToBeAdded widthOfTagLabelAboutToBeAddedString:(CGFloat)widthOfTagLabelAboutToBeAddedString tagViewStartingHeight:(CGFloat)tagViewStartingHeight {
    
    UIColor *unselectedBackgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeSecondary] : [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
    UIColor *unselectedTextColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [UIColor colorWithRed:129.0f/255.0f green:128.0f/255.0f blue:133.0f/255.0f alpha:1.0f];
    
    UIColor *selectedBackgroundColor = [UIColor colorWithRed:0.0f/255.0f green:122.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    UIColor *selectedTextColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    
    UILabel *tagLabelToAdd = [[UILabel alloc] initWithFrame:CGRectMake(xPosOfTagLabelAboutToBeAdded, yPosOfTagLabelAboutToBeAdded, widthOfTagLabelAboutToBeAddedString, tagViewStartingHeight)];
    tagLabelToAdd.backgroundColor = [selectedTagsArray containsObject:tag] ? selectedBackgroundColor : unselectedBackgroundColor;
    tagLabelToAdd.layer.cornerRadius = tagLabelToAdd.frame.size.height/3;
    tagLabelToAdd.clipsToBounds = YES;
    tagLabelToAdd.textColor = [selectedTagsArray containsObject:tag] ? selectedTextColor : unselectedTextColor;
    tagLabelToAdd.textAlignment = NSTextAlignmentCenter;
    tagLabelToAdd.text = [NSString stringWithFormat:@"#%@", tag];
    tagLabelToAdd.font = [UIFont systemFontOfSize:tagViewStartingHeight*0.5 weight:UIFontWeightBold];
    tagLabelToAdd.tag = [tagsArray containsObject:tag] ? [tagsArray indexOfObject:tag] + 1 : tagsArray.count;
    [tagLabelToAdd addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SelectTag:)]];
    tagLabelToAdd.userInteractionEnabled = YES;
    
    return tagLabelToAdd;
}

-(CGFloat)GenerateYPosOfTagLabelAboutToBeAdded:(UILabel *)lastTagLabelInLastRow gapBetweenTagViews:(CGFloat)gapBetweenTagViews MoveTagLabelToTheNextRow:(BOOL)MoveTagLabelToTheNextRow {
    
    BOOL TagLabelAboutToBeAddedIsTheFirstTagLabel = lastTagLabelInLastRow.frame.origin.y == 0;
    
    CGFloat yPosOfTagLabelAboutToBeAdded = 0;
    
    if (MoveTagLabelToTheNextRow == YES) {
        
        yPosOfTagLabelAboutToBeAdded = lastTagLabelInLastRow.frame.origin.y + lastTagLabelInLastRow.frame.size.height + gapBetweenTagViews;
        
    } else if (MoveTagLabelToTheNextRow == NO && TagLabelAboutToBeAddedIsTheFirstTagLabel == YES) {
        
        yPosOfTagLabelAboutToBeAdded = gapBetweenTagViews;
        
    } else if (MoveTagLabelToTheNextRow == NO && TagLabelAboutToBeAddedIsTheFirstTagLabel == NO) {
        
        yPosOfTagLabelAboutToBeAdded = lastTagLabelInLastRow.frame.origin.y;
        
    }
    
    return yPosOfTagLabelAboutToBeAdded;
}

-(void)AdjustFieldFrames:(CGFloat)tagViewStartingHeight gapBetweenTagViews:(CGFloat)gapBetweenTagViews textFieldHeight:(CGFloat)textFieldHeight {
    
    CGFloat tagViewHeight =
    totalRowsOfTags > 1 ?
    (tagViewStartingHeight * totalRowsOfTags) + (gapBetweenTagViews * (totalRowsOfTags + 1)) :
    textFieldHeight;
    
    CGRect rect = _tagsView.frame;
    rect.size.height = tagViewHeight;
    _tagsView.frame = rect;
    
    rect = _addTagView.frame;
    rect.origin.y = _tagsView.frame.origin.y + _tagsView.frame.size.height + (self.view.frame.size.height*0.024456);
    _addTagView.frame = rect;
    
}

@end
