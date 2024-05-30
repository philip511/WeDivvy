//
//  ViewNoteViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 3/9/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewNoteViewController : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) NSString *itemNotes;

@property (weak, nonatomic) IBOutlet UITextView *customTextView;

@end

NS_ASSUME_NONNULL_END
