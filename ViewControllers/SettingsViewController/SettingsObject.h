//
//  SettingsObject.h
//  WeDivvy
//
//  Created by Philip Nagel on 9/24/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingsObject : NSObject

-(void)UpdateEmail:(NSString *)userEmail completionHandler:(void (^)(BOOL finished, NSString *errorString))finishBlock;

-(void)DeleteAllUserInfo:(NSString *)userID userEmail:(NSString *)userEmail mixPanelID:(NSString *)mixPanelID completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)ResetDefaultsSettings;

@end

NS_ASSUME_NONNULL_END
