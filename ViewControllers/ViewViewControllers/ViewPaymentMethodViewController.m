//
//  ViewPaymentMethodViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 4/15/22.
//

#import "ViewPaymentMethodViewController.h"
#import "GeneralObject.h"
#import "SetDataObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@interface ViewPaymentMethodViewController ()

@end

@implementation ViewPaymentMethodViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self InitMethod];
    
    [self BarButtonItems];
    
    [self TapGestures];
    
}

-(void)viewWillLayoutSubviews {
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    [self AdjustTextFieldFramesChores:0];
    [self AdjustTextFieldViewsChores];
    
    
    
    
    width = CGRectGetWidth(self.nameView.bounds);
    height = CGRectGetHeight(self.nameView.bounds);
    //342
    
    NSArray *viewArray = @[
        
        //        _itemPaymentMethodView,
        //        _itemPaymentMethodUsernameView,
        //        _itemPaymentMethodURLView,
        //        _itemPaymentMethodNotesView,
        
    ];
    
    [self ViewWithFourRoundedCorners:viewArray];
    
    NSArray *viewBackgroundColorArr = @[
        
        _nameView,
        _usernameView,
        _notesView,
        
    ];
    
    [self ViewBackgroundColor:viewBackgroundColorArr];
    
    NSArray *fontTextFieldArr = @[
        
        _nameTextField,
        _usernameTextField
        
    ];
    
    [self TextFieldFontSize:fontTextFieldArr];
    
    
    
    
    _nameTextField.frame = CGRectMake(width*0.04830918, height*0, width*1 - ((width*0.04830918)*2), height);
    _usernameTextField.frame = CGRectMake(width*0.04830918, height*0, width*1 - ((width*0.04830918)*2), height);
    _notesTextField.frame = CGRectMake(width*0.04830918, width*0.04830918, width*1 - ((width*0.04830918)*2), _notesView.frame.size.height - ((width*0.04830918)*2));
    
    _notesTextField.font = _nameTextField.font;
    
    
    
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.navigationController.navigationBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        
        _nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_nameTextField.placeholder attributes:@{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModeTextSecondary]}];
        _usernameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_usernameTextField.placeholder attributes:@{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModeTextSecondary]}];
        
    } else {
        
        self.navigationController.navigationBar.backgroundColor = self.view.backgroundColor;
        
    }
    
}

#pragma mark - Text View Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([_nameTextField isFirstResponder]) {
        [_usernameTextField becomeFirstResponder];
    } else if ([_usernameTextField isFirstResponder]) {
        [_notesTextField becomeFirstResponder];
    } else if ([_notesTextField isFirstResponder]) {
        [_notesTextField resignFirstResponder];
    }
    
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    
    if(_notesTextField.text.length == 0) {
        
        _notesTextField.textColor = [UIColor colorWithRed:181.0f/255.0f green:188.0f/255.0f blue:193.0f/255.0f alpha:1.0f];
        _notesTextField.text = @"Notes";
        [_notesTextField resignFirstResponder];
        
    } else {
        
        _notesTextField.textColor = [UIColor colorWithRed:138.0f/255.0f green:137.0f/255.0f blue:142.0f/255.0f alpha:1.0f];
        
    }
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    
    if (self->_notesTextField.text.length == 0 || [_notesTextField.text isEqualToString:@"Notes"] == YES) {
        
        _notesTextField.text = @"";
        _notesTextField.textColor = [UIColor colorWithRed:138.0f/255.0f green:137.0f/255.0f blue:142.0f/255.0f alpha:1.0f];
        
    }
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if (self->_notesTextField.text.length > 0 && [_notesTextField.text isEqualToString:@"Notes"] == NO) {
        
        _notesTextField.textColor = [UIColor colorWithRed:138.0f/255.0f green:137.0f/255.0f blue:142.0f/255.0f alpha:1.0f];
        
    } else {
        
        _notesTextField.textColor = [UIColor colorWithRed:181.0f/255.0f green:188.0f/255.0f blue:193.0f/255.0f alpha:1.0f];
        
    }
    
    if ([textView.text isEqualToString:@"Notes"]) {
        
        NSString *str = [NSString stringWithFormat:@"%@%@", textView.text, text];
        str = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:str arrayOfSymbols:@[@"Notes"]];
        textView.text = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:textView.text arrayOfSymbols:@[@"Notes"]];
        _notesTextField.textColor = [UIColor colorWithRed:138.0f/255.0f green:137.0f/255.0f blue:142.0f/255.0f alpha:1.0f];
        
    }
    
    return YES;
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpTextFields];
    
}

-(void)BarButtonItems {
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]
                                      initWithTitle:@"Back"
                                      style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(NavigationBackButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                     style:UIBarButtonItemStyleDone
                                                    target:self
                                                    action:@selector(SaveButtonAction:)];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
}

-(void)TapGestures {
    
    if (_viewingReward == NO) {
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PaymentMethodOptions:)];
        [_nameTextField addGestureRecognizer:tapGesture];
        
    }
    
}

#pragma mark - SetUp Methods

-(void)SetUpTextFields {
    
    _nameTextField.delegate = self;
    _usernameTextField.delegate = self;
    _notesTextField.delegate = self;
    
    _nameTextField.placeholder = _viewingReward ? @"Reward" : @"Payment Method";
    _usernameTextField.placeholder = _viewingReward ? @"Reward Description" : @"Payment Method Description";
    
    NSString *nameKey = _viewingReward ? @"Reward" : @"PaymentMethod";
    NSString *descriptionKey = _viewingReward ? @"RewardDescription" : @"PaymentMethodData";
    NSString *notesKey = _viewingReward ? @"RewardNotes" : @"PaymentMethodNotes";
    
    if (_itemPaymentMethodDict[nameKey] != NULL && [_itemPaymentMethodDict[nameKey] length] > 0) {
        _nameTextField.text = [_itemPaymentMethodDict[nameKey] isEqualToString:@"None"] == NO ? _itemPaymentMethodDict[nameKey] : @"";
    }
    
    if (_itemPaymentMethodDict[descriptionKey] != NULL && [_itemPaymentMethodDict[descriptionKey] length] > 0) {
        _usernameTextField.text = _itemPaymentMethodDict[descriptionKey];
    }
    
    if (_itemPaymentMethodDict[notesKey] != NULL && [_itemPaymentMethodDict[notesKey] length] > 0) {
        _notesTextField.text = _itemPaymentMethodDict[notesKey];
    }
    
    [self textViewDidChange:_notesTextField];
    
    if (_nameTextField.text.length == 0 && _viewingReward) {
        [_nameTextField becomeFirstResponder];
    }
    
}

#pragma mark - UI Methods

-(void)AdjustTextFieldViewsChores {
    
    CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
    
    [[[GeneralObject alloc] init] RoundingCorners:_nameView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
    [[[GeneralObject alloc] init] RoundingCorners:_usernameView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
    
    [[[GeneralObject alloc] init] RoundingCorners:_notesView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
    
    
    
    NSArray *arrView = @[_nameView, _usernameView];
    
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
        
        
        
        
        self->_nameView.frame = CGRectMake(textFieldSpacing, navigationBarHeight + textFieldSpacing, (width*1 - (textFieldSpacing*2)), (self.view.frame.size.height*0.07472826 > 55?55:(self.view.frame.size.height*0.07472826)));
        
        
        
        
        self->_usernameView.frame = CGRectMake(self->_nameView.frame.origin.x, self->_nameView.frame.origin.y + self->_nameView.frame.size.height, self->_nameView.frame.size.width, self->_nameView.frame.size.height);
        
        
        
        
        self->_notesView.frame = CGRectMake(self->_nameView.frame.origin.x, self->_usernameView.frame.origin.y + self->_usernameView.frame.size.height + textFieldSpacing, self->_nameView.frame.size.width, height*0.24456522);
        
        
        
        
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
    
    CGFloat height = CGRectGetHeight(self.nameView.bounds);
    
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

-(BOOL)ThisInformationHasErrors {
    
    NSArray *optionsArr = @[@"Venmo", @"CashApp", @"PayPal", @"Zelle"];
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedStringItemUsername = [_usernameTextField.text stringByTrimmingCharactersInSet:charSet];
    
    if (_viewingReward == YES) {
        
    } else {
        
        if (trimmedStringItemUsername.length == 0 && [optionsArr containsObject:_nameTextField.text]) {
            
            [[[GeneralObject alloc] init] TextFieldIsEmptyColorChange:_usernameView textFieldField:_usernameTextField textFieldShouldDisplay:YES defaultColor:[UIColor whiteColor]];
            
            return true;
        }
        
    }
    
    return false;
}

#pragma mark - IBAction Methods

-(IBAction)SaveButtonAction:(id)sender {
    
    if ([self ThisInformationHasErrors] == NO) {
        
        if (_viewingReward == YES) {
            
            [self SaveReward];
            
        } else {
            
            [self SavePaymentMethod];
            
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}

-(IBAction)PaymentMethodOptions:(id)sender {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Choose a payment method" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSArray *optionsArr = @[@"Venmo", @"CashApp", @"PayPal", @"Zelle", @"Cash", @"Other", @"None"];
    
    for (NSString *option in optionsArr) {
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:option style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if ([option isEqualToString:@"Other"]) {
                
                [self EnterOtherPaymentMethod];
                
            } else if ([option isEqualToString:@"None"]) {
                
                self->_nameTextField.text = option;
                
                self->_usernameTextField.text = @"";
                self->_notesTextField.text = @"";
                
                [self textViewDidChange:self->_notesTextField];
                
            } else {
                
                self->_nameTextField.text = option;
                
                [self AdjustTextFieldFramesChores:0.25];
                [self AdjustTextFieldViewsChores];
                
            }
            
        }];
        
        [actionSheet addAction:action];
        
    }
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

-(IBAction)NavigationBackButtonAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark PaymentMethodOptions

-(void)EnterOtherPaymentMethod {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Enter your preferred payment method" message:nil
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Submit"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
        
        [self SubmitOtherPaymentMethod:controller];
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {}];
    
    [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        textField.delegate = self;
        textField.placeholder = @"Payment Method";
        textField.text = @"";
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        
    }];
    
    [controller addAction:action1];
    [controller addAction:cancel];
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(void)SubmitOtherPaymentMethod:(UIAlertController *)controller {
    
    NSString *userEmail = controller.textFields[0].text;
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedStringItemName = [userEmail stringByTrimmingCharactersInSet:charSet];
    
    if ([trimmedStringItemName isEqualToString:@""]) {
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"Email field is empty" currentViewController:self];
        
    } else {
        
        self->_nameTextField.text = userEmail;
        
    }
    
}

#pragma mark - SaveButtonAction

-(void)SaveReward {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Save Reward For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    NSString *reward = _nameTextField.text;
    NSString *rewardDescription = _usernameTextField.text;
    NSString *rewardNotes = _notesTextField.text;
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedStringItemName = [reward stringByTrimmingCharactersInSet:charSet];
    
    if (trimmedStringItemName.length == 0 || [trimmedStringItemName isEqualToString:@"None"]) {
        
        reward = @"None";
        rewardDescription = @"";
        rewardNotes = @"";
        
    }
    
    if ([rewardNotes isEqualToString:@"Notes"]) {
        rewardNotes = @"";
    }
    
    NSDictionary *rewardDict = @{
        @"Reward" : reward,
        @"RewardDescription" : rewardDescription,
        @"RewardNotes" : rewardNotes
    };
    
    NSArray *locations = _comingFromAddTaskViewController ? @[@"AddTask"] : @[@"ViewTask"];
    
    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemReward" userInfo:@{@"Reward" : rewardDict} locations:locations];
     
}

-(void)SavePaymentMethod {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Save Payment Method For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    NSString *paymentMethod = _nameTextField.text;
    NSString *paymentMethodUsername = _usernameTextField.text;
    NSString *paymentMethodNotes = _notesTextField.text;
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedStringItemName = [paymentMethod stringByTrimmingCharactersInSet:charSet];
    
    if (trimmedStringItemName.length == 0 || [trimmedStringItemName isEqualToString:@"None"]) {
        
        paymentMethod = @"None";
        paymentMethodUsername = @"";
        paymentMethodNotes = @"";
        
    }
    
    if ([paymentMethodNotes isEqualToString:@"Notes"]) {
        paymentMethodNotes = @"";
    }
    
    NSDictionary *paymentMethodDict = @{
        @"PaymentMethod" : paymentMethod,
        @"PaymentMethodData" : paymentMethodUsername,
        @"PaymentMethodNotes" : paymentMethodNotes
    };
    
    NSArray *locations = _comingFromAddTaskViewController ? @[@"AddTask"] : @[@"ViewTask"];
    
    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemPaymentMethod" userInfo:@{@"PaymentMethod" : paymentMethodDict} locations:locations];

}

@end
