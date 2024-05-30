//
//  PopupCompleteView.h
//  WeDivvy
//
//  Created by Philip Nagel on 5/18/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopupCompleteView : UIView

- (instancetype)initWithFrame:(CGRect)frame viewControllerWidth:(CGFloat)viewControllerWidth viewControllerHeight:(CGFloat)viewControllerHeight title:(NSString *)title body:(NSString *)body acceptLabelText:(NSString *)acceptLabelText declineLabelText:(NSString *)declineLabelText acceptLabelColor:(UIColor *)acceptLabelColor declineLabelColor:(UIColor *)declineLabelColor acceptLabelSelector:(SEL)acceptLabelSelector declineLabelSelector:(SEL)declineLabelSelector viewControllerObject:(id)viewControllerObject;

@end

NS_ASSUME_NONNULL_END
