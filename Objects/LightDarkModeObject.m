//
//  LightDarkModeObject.m
//  WeDivvy
//
//  Created by Philip Nagel on 8/17/22.
//

#import "LightDarkModeObject.h"

@implementation LightDarkModeObject

#pragma mark - Dark Mode

- (UIColor *)DarkModePrimary {
    return [UIColor colorWithWhite:0.12 alpha:1.0f];
}

- (UIColor *)DarkModeSecondary {
    return [UIColor colorWithWhite:0.15 alpha:1.0f];
}

- (UIColor *)DarkModeTertiary {
    return [UIColor colorWithWhite:0.11 alpha:1.0f];
}

- (UIColor *)DarkModeShadow{
    return [UIColor colorWithWhite:0.08 alpha:1.0f];
}

- (UIColor *)DarkModeTextPrimary {
    return [UIColor whiteColor];
}

- (UIColor *)DarkModeTextSecondary {
    return [UIColor colorWithWhite:0.47 alpha:1.0f];
}

- (UIColor *)DarkModeLabelBlue {
    return [UIColor colorWithRed:23.0f/255.0f green:118.0f/255.0f blue:216.0f/255.0f alpha:1.0f];
}

#pragma mark - Light Mode

- (UIColor *)LightModePrimary {
    return [UIColor colorWithRed:240.0f/255.0f green:242.0f/255.0f blue:248.0f/255.0f alpha:1.0f];
}

- (UIColor *)LightModeSecondary {
    return [UIColor whiteColor];
}

- (UIColor *)LightModeTertiary {
    return [UIColor colorWithWhite:0.11 alpha:1.0f];
}

- (UIColor *)LightModeBackDrop {
    return [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.25];
}

- (UIColor *)LightModeSubviewLine {
    return [UIColor colorWithRed:231.0f/255.0f green:231.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
}

- (UIColor *)LightModeShadow {
    return [UIColor colorWithRed:237.0f/255.0f green:240.0f/255.0f blue:242.0f/255.0f alpha:1.0f];
}

- (UIColor *)LightModeTextPrimary {
    return [UIColor blackColor];
}

- (UIColor *)LightModeTextSecondary {
    return [UIColor colorWithRed:167.0f/255.0f green:176.0f/255.0f blue:185.0f/255.0f alpha:1.0f];
}

- (UIColor *)LightModeTextMainImage {
    return [UIColor colorWithRed:63.0f/255.0f green:76.0f/255.0f blue:84.0f/255.0f alpha:1.0f];
}

- (UIColor *)LightModeTextHiddenLabel {
    return [UIColor colorWithRed:151.0f/255.0f green:156.0f/255.0f blue:171.0f/255.0f alpha:1.0f];
}

- (UIColor *)LightModeTexCompletedLabel {
    return [UIColor colorWithRed:40.0f/255.0f green:75.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
}

- (UIColor *)LightModeTexAddTaskTextField {
    return [UIColor colorWithRed:138.0f/255.0f green:137.0f/255.0f blue:142.0f/255.0f alpha:1.0f];
}

- (UIColor *)LightModeLabelBlue {
    return [UIColor colorWithRed:23.0f/255.0f green:118.0f/255.0f blue:216.0f/255.0f alpha:1.0f];
}


@end
