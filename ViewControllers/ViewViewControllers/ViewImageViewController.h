//
//  ViewImageViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 6/7/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewImageViewController : UIViewController

@property (strong, nonatomic) UIImage *itemImage;

@property (weak, nonatomic) IBOutlet UIImageView *customImageView;

@end

NS_ASSUME_NONNULL_END
