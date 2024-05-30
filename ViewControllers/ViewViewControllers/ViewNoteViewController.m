//
//  ViewNoteViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 3/9/23.
//

#import "ViewNoteViewController.h"

#import "GeneralObject.h"
#import "SetDataObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@interface ViewNoteViewController ()

@end

@implementation ViewNoteViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];

    [self InitMethod];
    
    [self BarButtonItems];
    
}

-(void)viewDidLayoutSubviews {
   
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    UIFont *fontSize = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02173813 > 16?16:(self.view.frame.size.height*0.02173813)) weight:UIFontWeightRegular];
    UIColor *textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [[[LightDarkModeObject alloc] init] LightModeTexAddTaskTextField];
    UIColor *backgroundColor = [UIColor clearColor];
    
    CGFloat width = self.view.frame.size.width;
    
    _customTextView.font = fontSize;
    _customTextView.textColor = textColor;
    _customTextView.backgroundColor = backgroundColor;
    
    _customTextView.frame = CGRectMake(width*0.04830918, width*0.04830918, width*1 - ((width*0.04830918)*2), _customTextView.frame.size.height - ((width*0.04830918)*2));
    
    _customTextView.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?
    [[[LightDarkModeObject alloc] init] DarkModeTertiary] :
    [[[LightDarkModeObject alloc] init] LightModeSecondary];
    
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpCustomTextField];
    
}

-(void)BarButtonItems {
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(NavigationBackButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(SaveButtonAction:)];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
}

#pragma mark - SetUp Methods

-(void)SetUpCustomTextField {
    
    [_customTextView becomeFirstResponder];
    _customTextView.text = _itemNotes;
    _customTextView.delegate = self;
    
    [self textViewDidChange:_customTextView];
    
}

#pragma mark - IBAction Methods

-(IBAction)SaveButtonAction:(id)sender {
    
    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemNotes" userInfo:@{@"ItemNotes" : _customTextView.text} locations:@[@"Tasks"]];

    [self DismissViewController:self];
    
}

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    [self DismissViewController:self];
    
}

-(IBAction)DismissViewController:(id)sender {
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ComingFromShortcut"] isEqualToString:@"Yes"]) {
        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

#pragma mark - Text View Methods

-(void)textViewDidChange:(UITextView *)textView
{
    
    if (_customTextView.text.length == 0) {
        
        _customTextView.textColor = [UIColor colorWithRed:181.0f/255.0f green:188.0f/255.0f blue:193.0f/255.0f alpha:1.0f];
        _customTextView.text = @"Notes";
        [_customTextView resignFirstResponder];
        
    }
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView {

    if (_customTextView.text.length == 0 || [_customTextView.text isEqualToString:@"Notes"] == YES) {
        
        _customTextView.text = @"";
        _customTextView.textColor = [UIColor colorWithRed:138.0f/255.0f green:137.0f/255.0f blue:142.0f/255.0f alpha:1.0f];
        
    }
    
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    
    if (_customTextView.text.length == 0) {
        
        _customTextView.textColor = [UIColor colorWithRed:181.0f/255.0f green:188.0f/255.0f blue:193.0f/255.0f alpha:1.0f];
        _customTextView.text = @"Notes";
        [_customTextView resignFirstResponder];
        
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)replacementText {
    
    if (_customTextView.text.length > 0 && [_customTextView.text isEqualToString:@"Notes"] == NO) {
        
        _customTextView.textColor = [UIColor colorWithRed:138.0f/255.0f green:137.0f/255.0f blue:142.0f/255.0f alpha:1.0f];
        
    } else {
        
        _customTextView.textColor = [UIColor colorWithRed:181.0f/255.0f green:188.0f/255.0f blue:193.0f/255.0f alpha:1.0f];
        
    }
    
    if ([textView.text isEqualToString:@"Notes"]) {
        
        NSString *str = [NSString stringWithFormat:@"%@%@", textView.text, replacementText];
        str = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:str arrayOfSymbols:@[@"Notes"]];
        textView.text = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:textView.text arrayOfSymbols:@[@"Notes"]];
        _customTextView.textColor = [UIColor colorWithRed:138.0f/255.0f green:137.0f/255.0f blue:142.0f/255.0f alpha:1.0f];
        
    }
    
    return YES;
}


@end
