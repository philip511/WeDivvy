//
//  MultiAddTaskCell.h
//  WeDivvy
//
//  Created by Philip Nagel on 9/7/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MultiAddTaskCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIButton *mainViewOverlayView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UIImageView *selectViewImageView;

@property (weak, nonatomic) IBOutlet UIImageView *rightArrowImage;




//SuggestedTasksViewController
@property (weak, nonatomic) IBOutlet UIView *selectedSuggestedView;
@property (weak, nonatomic) IBOutlet UIImageView *selectedSuggestedViewImage;
@property (weak, nonatomic) IBOutlet UIButton *selectedSuggestedViewButton;

//PastDueTasksViewController
//@property (weak, nonatomic) IBOutlet UIButton *mainViewOverlayView;


//TasksViewController
//@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIButton *checkmarkView;
@property (weak, nonatomic) IBOutlet UIButton *checkmarkViewCover;

@property (weak, nonatomic) IBOutlet UIView *selectedCellView;

//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabelNo1;

@property (weak, nonatomic) IBOutlet UIImageView *itemPriorityImage;
@property (weak, nonatomic) IBOutlet UIImageView *itemRepeatsImage;
@property (weak, nonatomic) IBOutlet UIImageView *itemRepeatsImageNo1;
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





@property (weak, nonatomic) IBOutlet UIView *addTaskOptionsScrollViewView;
@property (weak, nonatomic) IBOutlet UIScrollView *addTaskOptionsScrollView;

@property (weak, nonatomic) IBOutlet UIImageView *addTaskScrollViewExpandIcon;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskScrollViewExpandIconCover;

@property (weak, nonatomic) IBOutlet UIImageView *addTaskScrollViewAmountIcon;
@property (weak, nonatomic) IBOutlet UIButton *addTaskScrollViewAmountIconButton;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskScrollViewListItemsIcon;
@property (weak, nonatomic) IBOutlet UIButton *addTaskScrollViewListItemsIconButton;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskScrollViewTaskListIcon;
@property (weak, nonatomic) IBOutlet UIButton *addTaskScrollViewTaskListIconButton;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskScrollViewRepeatsIcon;
@property (weak, nonatomic) IBOutlet UIButton *addTaskScrollViewRepeatsIconButton;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskScrollViewPriorityIcon;
@property (weak, nonatomic) IBOutlet UIButton *addTaskScrollViewPriorityIconButton;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskScrollViewTakeTurnsIcon;
@property (weak, nonatomic) IBOutlet UIButton *addTaskScrollViewTakeTurnsIconButton;

@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewAmount;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewImageViewAmount;
@property (weak, nonatomic) IBOutlet UILabel *addTaskSelectedViewLabelAmount;
@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewXViewAmount;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewXImageViewAmount;
@property (weak, nonatomic) IBOutlet UIButton *addTaskSelectedViewButtonAmount;

@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewListItems;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewImageViewListItems;
@property (weak, nonatomic) IBOutlet UILabel *addTaskSelectedViewLabelListItems;
@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewXViewListItems;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewXImageViewListItems;
@property (weak, nonatomic) IBOutlet UIButton *addTaskSelectedViewButtonListItems;

@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewTaskList;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewImageViewTaskList;
@property (weak, nonatomic) IBOutlet UILabel *addTaskSelectedViewLabelTaskList;
@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewXViewTaskList;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewXImageViewTaskList;
@property (weak, nonatomic) IBOutlet UIButton *addTaskSelectedViewButtonTaskList;

@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewRepeats;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewImageViewRepeats;
@property (weak, nonatomic) IBOutlet UILabel *addTaskSelectedViewLabelRepeats;
@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewXViewRepeats;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewXImageViewRepeats;
@property (weak, nonatomic) IBOutlet UIButton *addTaskSelectedViewButtonRepeats;

@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewPriority;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewImageViewPriority;
@property (weak, nonatomic) IBOutlet UILabel *addTaskSelectedViewLabelPriority;
@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewXViewPriority;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewXImageViewPriority;
@property (weak, nonatomic) IBOutlet UIButton *addTaskSelectedViewButtonPriority;

@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewTakeTurns;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewImageViewTakeTurns;
@property (weak, nonatomic) IBOutlet UILabel *addTaskSelectedViewLabelTakeTurns;
@property (weak, nonatomic) IBOutlet UIView *addTaskSelectedViewXViewTakeTurns;
@property (weak, nonatomic) IBOutlet UIImageView *addTaskSelectedViewXImageViewTakeTurns;
@property (weak, nonatomic) IBOutlet UIButton *addTaskSelectedViewButtonTakeTurns;

@end

NS_ASSUME_NONNULL_END
