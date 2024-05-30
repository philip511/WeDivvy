//
//  AlertView.h
//  WeDivvy
//
//  Created by Philip Nagel on 5/18/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlertView : UIView

- (instancetype)initWithFrame:(CGRect)frame viewControllerWidth:(CGFloat)viewControllerWidth viewControllerHeight:(CGFloat)viewControllerHeight text:(NSString *)text acceptButtonSelector:(SEL)acceptButtonSelector declineButtonSelector:(SEL)declineButtonSelector viewControllerObject:(id)viewControllerObject;

@end

NS_ASSUME_NONNULL_END
