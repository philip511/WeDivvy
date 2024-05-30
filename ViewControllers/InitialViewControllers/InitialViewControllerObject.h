//
//  InitialViewControllerObject.h
//  WeDivvy
//
//  Created by Philip Nagel on 9/19/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InitialViewControllerObject : NSObject

-(void)LogInUser_StandardLogIn:(NSString *)userEmail userPassword:(NSString *)userPassword currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSString *errorString))finishBlock;

-(void)LogInUser_ThirdPartyLogIn:(NSString *)userEmail GoogleLogIn:(BOOL)GoogleLogIn AppleLogIn:(BOOL)AppleLogIn currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSString *errorString))finishBlock;

-(void)SignUpUser_StandardSignUp:(NSString *)userID username:(NSString *)username userEmail:(NSString *)userEmail userPassword:(NSString *)userPassword howYouHeardAboutUs:(NSString *)howYouHeardAboutUs whoIsThisFor:(NSString *)whoIsThisFor receiveEmails:(NSString *)receiveEmails thirdPartySignUp:(BOOL)thirdPartySignUp completionHandler:(void (^)(BOOL finished, NSString *errorString))finishBlock;

-(void)SignUpUser_ThirdPartySignUp:(NSString *)thirdPartyEmail howYouHeardAboutUs:(NSString *)howYouHeardAboutUs whoIsThisFor:(NSString *)whoIsThisFor thirdPartySignUp:(BOOL)thirdPartySignUp currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished))finishBlock;

@end

NS_ASSUME_NONNULL_END
