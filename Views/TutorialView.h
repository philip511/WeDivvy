//
//  TutorialView.h
//  WeDivvy
//
//  Created by Philip Nagel on 5/14/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TutorialView : UIView

- (instancetype)initWithFrame:(CGRect)frame helpViewFrameYPos:(CGFloat)helpViewFrameYPos viewControllerWidth:(CGFloat)viewControllerWidth viewControllerHeight:(CGFloat)viewControllerHeight title:(NSString *)title body:(NSString *)body;

@end

NS_ASSUME_NONNULL_END
