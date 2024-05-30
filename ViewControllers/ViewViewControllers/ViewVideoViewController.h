//
//  ViewVideoViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 10/13/21.
//

#import <AVKit/AVKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewVideoViewController : AVPlayerViewController

@property (strong, nonatomic) NSString *videoURLString;

@end

NS_ASSUME_NONNULL_END
