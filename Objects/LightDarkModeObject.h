//
//  LightDarkModeObject.h
//  WeDivvy
//
//  Created by Philip Nagel on 8/17/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LightDarkModeObject : NSObject

#pragma mark - Dark Mode

- (UIColor *)DarkModePrimary;
- (UIColor *)DarkModeSecondary;
- (UIColor *)DarkModeTertiary;
- (UIColor *)DarkModeShadow;
- (UIColor *)DarkModeTextPrimary;
- (UIColor *)DarkModeTextSecondary;
- (UIColor *)DarkModeLabelBlue;

#pragma mark - Light Mode

- (UIColor *)LightModePrimary;
- (UIColor *)LightModeSecondary;
- (UIColor *)LightModeTertiary;
- (UIColor *)LightModeBackDrop;
- (UIColor *)LightModeSubviewLine;
- (UIColor *)LightModeShadow;
- (UIColor *)LightModeTextPrimary;
- (UIColor *)LightModeTextSecondary;
- (UIColor *)LightModeTextMainImage;
- (UIColor *)LightModeTextHiddenLabel;
- (UIColor *)LightModeTexCompletedLabel;
- (UIColor *)LightModeTexAddTaskTextField;
- (UIColor *)LightModeLabelBlue;

@end

NS_ASSUME_NONNULL_END
