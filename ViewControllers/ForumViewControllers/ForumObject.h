//
//  ForumObject.h
//  WeDivvy
//
//  Created by Philip Nagel on 9/25/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ForumObject : NSObject

-(void)AddForumPost:(NSString *)forumID forumTitle:(NSString *)forumTitle forumDetails:(NSString *)forumDetails forumDatePosted:(NSString *)forumDatePosted forumImage:(UIImage *)forumImage forumLikes:(NSArray *)forumLikes forumCompleted:(NSString *)forumCompleted collection:(NSString *)collection EditForum:(BOOL)EditForum completionHandler:(void (^)(BOOL finished))finishBlock;

@end

NS_ASSUME_NONNULL_END
