//
//  MainCell.h
//  WeDivvy
//
//  Created by Philip Nagel on 11/20/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainCell : UITableViewCell

//SuggestedTasksViewController
@property (weak, nonatomic) IBOutlet UIView *selectedSuggestedView;
@property (weak, nonatomic) IBOutlet UIImageView *selectedSuggestedViewImage;
@property (weak, nonatomic) IBOutlet UIButton *selectedSuggestedViewButton;

//PastDueTasksViewController
@property (weak, nonatomic) IBOutlet UIButton *mainViewOverlayView;


//TasksViewController
@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIButton *checkmarkView;
@property (weak, nonatomic) IBOutlet UIButton *checkmarkViewCover;

@property (weak, nonatomic) IBOutlet UIView *selectedCellView;
@property (weak, nonatomic) IBOutlet UIView *selectedCellViewCover;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;

@property (weak, nonatomic) IBOutlet UIImageView *itemPriorityImage;
@property (weak, nonatomic) IBOutlet UIImageView *itemRepeatsImage;
@property (weak, nonatomic) IBOutlet UIImageView *itemPastDueImage;

@property (weak, nonatomic) IBOutlet UIImageView *itemNoteImage;
@property (weak, nonatomic) IBOutlet UIImageView *mutedImage;
@property (weak, nonatomic) IBOutlet UIImageView *privateImage;
@property (weak, nonatomic) IBOutlet UIImageView *reminderImage;

@property (weak, nonatomic) IBOutlet UIImageView *assignedImage1;
@property (weak, nonatomic) IBOutlet UIImageView *assignedImage2;
@property (weak, nonatomic) IBOutlet UIImageView *assignedImage3;
@property (weak, nonatomic) IBOutlet UIImageView *assignedImage4;
@property (weak, nonatomic) IBOutlet UIImageView *assignedImage5;

@property (weak, nonatomic) IBOutlet UIView *slideView;
@property (weak, nonatomic) IBOutlet UIView *leftSlideCoverView;
@property (weak, nonatomic) IBOutlet UIView *rightSlideCoverView;
@property (weak, nonatomic) IBOutlet UIImageView *leftSlideViewImage;
@property (weak, nonatomic) IBOutlet UIImageView *rightSlideViewImage;

@end

NS_ASSUME_NONNULL_END
