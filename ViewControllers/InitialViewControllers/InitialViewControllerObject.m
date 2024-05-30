//
//  InitialViewControllerObject.m
//  WeDivvy
//
//  Created by Philip Nagel on 9/19/21.
//

#import "AppDelegate.h"
#import "InitialViewControllerObject.h"

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "DeleteDataObject.h"
#import "NotificationsObject.h"
#import "PushObject.h"
#import "BoolDataObject.h"

@implementation InitialViewControllerObject

-(void)LogInUser_StandardLogIn:(NSString *)userEmail userPassword:(NSString *)userPassword currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSString *errorString))finishBlock {
   
    //Check if login data does not cause any errors
    [self CheckIfLoginFieldsAreValid_StandardLogIn:userEmail userPassword:userPassword completionHandler:^(BOOL finished, NSString *errorString) {
       
        if (errorString.length == 0) {
           
            //Check if user trying to login exists
            [[[GetDataObject alloc] init] GetDataExistingUserData:userEmail completionHandler:^(BOOL finished, NSString *userID, NSString *currentMixPanelID, BOOL userFound) {
               
                if (userFound == YES) {
                   
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"mixPanelID == %@", currentMixPanelID];
                    [[[DeleteDataObject alloc] init] DeleteDataCoreData:@"Users" predicate:predicate];
                    
                    //User exists, delete the temp MixPanelID given to the unknown user
                    [[[DeleteDataObject alloc] init] DeleteDataOldMixPanelID:currentMixPanelID completionHandler:^(BOOL finished) {
                       
                        if (currentMixPanelID != nil) {
                            
                            [[NSUserDefaults standardUserDefaults] setObject:currentMixPanelID forKey:@"MixPanelID"];
  
                        }
                        
                        //Notify creator that a user has logged in
                        [[[NotificationsObject alloc] init] SendPushNotificationToCreator:[NSString stringWithFormat:@"%@ - Logged In", userID] notificationBody:[NSString stringWithFormat:@"%@ -  6.5.98", userEmail] badgeNumber:(NSInteger *)1 completionHandler:^(BOOL finished) {
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewDidLoadShouldStart"];
                                [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"DisplayRegisterForNotificationsPopup"];
                                
                                NSLog(@"Starting PushToViewController %@", userID);
                                
                                [[[PushObject alloc] init] PushToHomesViewController:YES currentViewController:currentViewController];
                                
                                finishBlock(YES, errorString);
                                
                            });
                            
                        }];
                        
                    }];
                    
                } else {
                 
                    NSString *errorString = @"Email was not found (Reminder: Email is case sensitive)";
                    
                    finishBlock(YES, errorString);

                }
                
            }];
        
        } else {
          
            finishBlock(YES, errorString);
            
        }
        
    }];
    
}

-(void)LogInUser_ThirdPartyLogIn:(NSString *)userEmail GoogleLogIn:(BOOL)GoogleLogIn AppleLogIn:(BOOL)AppleLogIn currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSString *errorString))finishBlock {
 
    userEmail = [[[GeneralObject alloc] init] TrimString:userEmail];
    
    //Check if user trying to login exists
    [[[GetDataObject alloc] init] GetDataExistingUserData:userEmail completionHandler:^(BOOL finished, NSString *userID, NSString *currentMixPanelID, BOOL userFound) {
      
        if (userFound == YES) {
        
            //User exists, delete the temp MixPanelID given unknown user
            [[[DeleteDataObject alloc] init] DeleteDataOldMixPanelID:currentMixPanelID completionHandler:^(BOOL finished) {
              
                if (currentMixPanelID != nil) {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:currentMixPanelID forKey:@"MixPanelID"];
         
                }
              
                //Notify creator that a user has logged in
                [[[NotificationsObject alloc] init] SendPushNotificationToCreator:[NSString stringWithFormat:@"%@ - Logged In - %@", userID, GoogleLogIn == YES ? @"GoogleLogIn" : @"AppleLogIn"] notificationBody:[NSString stringWithFormat:@"%@ -  6.5.98", userEmail] badgeNumber:(NSInteger *)1 completionHandler:^(BOOL finished) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                          
                          //Current User
//                        [[NSUserDefaults standardUserDefaults] setObject:@"2023-10-17 18:11:179809528" forKey:@"UsersUserID"];
//                        [[NSUserDefaults standardUserDefaults] setObject:@"Livking" forKey:@"UsersUsername"];
//                        [[NSUserDefaults standardUserDefaults] setObject:@"6f8jb2wt7h@privaterelay.appleid.com" forKey:@"UsersEmail"];
//                        [[NSUserDefaults standardUserDefaults] setObject:@"2022-07-23 16:57:232610091" forKey:@"MixPanelID"];
                        
                        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewDidLoadShouldStart"];
                        
                        finishBlock(YES, @"");
                        
                    });
                   
                }];
                
            }];
            
        } else {
         
            finishBlock(YES, @"An unkown error has occurred. Please try again.");
            
        }
        
    }];
    
}

-(void)SignUpUser_StandardSignUp:(NSString *)userID username:(NSString *)username userEmail:(NSString *)userEmail userPassword:(NSString *)userPassword howYouHeardAboutUs:(NSString *)howYouHeardAboutUs whoIsThisFor:(NSString *)whoIsThisFor receiveEmails:(NSString *)receiveEmails thirdPartySignUp:(BOOL)thirdPartySignUp completionHandler:(void (^)(BOOL finished, NSString *errorString))finishBlock {
    
    __block BOOL isUsernameTaken;
    __block BOOL isEmailTaken;
    
    __block int totalQueries = 2;
    __block int completedQueries = 0;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSLog(@"Starting CheckIfUsernameExists");
        
        [[[GetDataObject alloc] init] GetDataCheckIfObjectInFieldExistsInCollection:@"Users" field:@"Username" object:username thirdPartySignUp:thirdPartySignUp completionHandler:^(BOOL finished, BOOL doesObjectExist) {
            
            NSLog(@"Ending CheckIfUsernameExists");
            isUsernameTaken = doesObjectExist;
            
            if (totalQueries == (completedQueries+=1)) {
                
                NSLog(@"Starting CompleteSignUpUser (1)");
                
                [self CompleteSignUpUser_StandardSignUp:userID username:username userEmail:userEmail userPassword:userPassword howYouHeardAboutUs:howYouHeardAboutUs whoIsThisFor:whoIsThisFor receiveEmails:receiveEmails isEmailTaken:isEmailTaken isUsernameTaken:isUsernameTaken thirdPartySignUp:thirdPartySignUp completionHandler:^(BOOL finished, NSString *errorString) {
                   
                    NSLog(@"Ending CompleteSignUpUser (1)");
                    
                    finishBlock(YES, errorString);

                }];
                
            }
            
        }];
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        NSLog(@"Starting CheckIfEmailExists");
        
        [[[GetDataObject alloc] init] GetDataCheckIfObjectInFieldExistsInCollection:@"Users" field:@"Email" object:userEmail thirdPartySignUp:thirdPartySignUp completionHandler:^(BOOL finished, BOOL doesObjectExist) {
            
            NSLog(@"Ending CheckIfEmailExists");
            
            isEmailTaken = doesObjectExist;
              
            if (totalQueries == (completedQueries+=1)) {
                
                NSLog(@"Starting CompleteSignUpUser (2)");
                
                [self CompleteSignUpUser_StandardSignUp:userID username:username userEmail:userEmail userPassword:userPassword howYouHeardAboutUs:howYouHeardAboutUs whoIsThisFor:whoIsThisFor receiveEmails:receiveEmails isEmailTaken:isEmailTaken isUsernameTaken:isUsernameTaken thirdPartySignUp:thirdPartySignUp completionHandler:^(BOOL finished, NSString *errorString) {
       
                    NSLog(@"Ending CompleteSignUpUser (2)");
                    
                    finishBlock(YES, errorString);
  
                }];
                
            }
            
        }];
        
    });
    
}

-(void)SignUpUser_ThirdPartySignUp:(NSString *)thirdPartyEmail howYouHeardAboutUs:(NSString *)howYouHeardAboutUs whoIsThisFor:(NSString *)whoIsThisFor thirdPartySignUp:(BOOL)thirdPartySignUp currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *userID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    NSString *userEmail = [[[GeneralObject alloc] init] TrimString:thirdPartyEmail];
    NSString *username = [self GenerateUsernameBasedOnSignUpEmail_ThirdPartySignUp:userEmail];
    NSString *userPassword = @"password";
    NSString *receiveEmails = @"Yes";
    NSString *mixPanelID = [self GenerateMixPanelID_StandardAndThirdPartySignUp];
    
    if ([[[BoolDataObject alloc] init] NoSignUp]) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]) {
            userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"];
        }
    }
   
    NSDictionary *userDict = @{

        @"UserID": userID ? userID : @"",
        @"Email": userEmail ? userEmail : @"",
        @"Username": username ? username : @"",
        @"ProfileImageURL" : @"https://firebasestorage.googleapis.com/v0/b/wedivvy-afe04.appspot.com/o/DefaultImages%2FdefaultProfileImage.png?alt=media&token=6892f430-8337-4327-89a4-53a403d1186c",
        @"MixPanelID" : mixPanelID ? mixPanelID : @"",
        @"HeardAboutUs" : howYouHeardAboutUs,
        @"WhoIsThisFor" : whoIsThisFor,
        @"Notifications" : @"xxx",
        @"ReceiveUpdateEmails" : receiveEmails ? receiveEmails : @"Yes",
        @"WeDivvyPremium" : [[[GeneralObject alloc] init] GenerateDefaultWeDivvyPremiumPlan],

    };
  
    __block int totalQueries = 3;
    __block int completedQueries = 0;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID == %@", userID];
        [[[SetDataObject alloc] init] SetDataAddCoreData:@"Users" predicate:predicate setDataObject:[userDict mutableCopy]];
        
        [[[SetDataObject alloc] init] SetDataUserData:userID userDict:userDict completionHandler:^(BOOL finished, NSError * _Nonnull error) {
          
            if (totalQueries == (completedQueries+=1)) {
              
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self SetUserDataIntoNSUserDefaults_ThirdPartySignUp:userID username:username userEmail:userEmail receiveEmails:receiveEmails];
                  
                    finishBlock(YES);
                    
                });
                
            }
            
        }];
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
        [[FIRAuth auth] createUserWithEmail:userEmail password:userPassword completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
           
            if (totalQueries == (completedQueries+=1)) {
              
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self SetUserDataIntoNSUserDefaults_ThirdPartySignUp:userID username:username userEmail:userEmail receiveEmails:receiveEmails];
                   
                    finishBlock(YES);
                    
                });
                
            }
            
        }];
    
    });
    
    NSInteger *badgeNumber = (NSInteger *)1;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[NotificationsObject alloc] init] SendPushNotificationToCreator:[NSString stringWithFormat:@"%@ - Signed Up First Time", userID] notificationBody:[NSString stringWithFormat:@"%@ -  6.5.98", userEmail] badgeNumber:badgeNumber completionHandler:^(BOOL finished) {
          
            if (totalQueries == (completedQueries+=1)) {
               
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self SetUserDataIntoNSUserDefaults_ThirdPartySignUp:userID username:username userEmail:userEmail receiveEmails:receiveEmails];
                   
                    finishBlock(YES);
                    
                });
                
            }

        }];
        
    });
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark LogInUser_StandardLogIn

-(void)CheckIfLoginFieldsAreValid_StandardLogIn:(NSString *)userEmail userPassword:(NSString *)userPassword completionHandler:(void (^)(BOOL finished, NSString *errorString))finishBlock {
    
    __block NSString *errorStringLocal = @"";
    
    if ([userEmail isEqualToString:@""] || [userPassword isEqualToString:@""]) {
        
        errorStringLocal = @"One or more fields are empty";
        
        finishBlock(YES, errorStringLocal);
        
    } else if ([[[BoolDataObject alloc] init] EmailFormatValid:userEmail] == NO) {
        
        errorStringLocal = @"Your email is not correctly formatted";
        
        finishBlock(YES, errorStringLocal);
        
    } else {
        
        NSLog(@"Starting signInWithEmail");
        
        [[FIRAuth auth] signInWithEmail:userEmail password:userPassword completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
            
            if (error != nil) {
                
                errorStringLocal = @"This Email/Password combination does not exist";
                
            } else if ([error.description containsString:@"There is no user record corresponding to this identifier. The user may have been deleted."]) {
                
                errorStringLocal = @"A user with that email doesn't exist";
                
            } else if ([error.description containsString:@"The email address is badly formatted"]) {
                
                errorStringLocal = @"That email is incorrectly formatted";
                
            } else if ([error.description containsString:@"The password is invalid or the user does not have a password"]) {
                
                errorStringLocal = @"That email/password combination doesn't exist";
                
            } else if (error.description != nil) {
                
                errorStringLocal = @"An error has occurred please try again";
                
            }
            
            finishBlock(YES, errorStringLocal);
            
        }];
        
    }
    
}

#pragma mark - SignUpUser_StandardSignUp

-(void)CompleteSignUpUser_StandardSignUp:(NSString *)userID username:(NSString *)username userEmail:(NSString *)userEmail userPassword:(NSString *)userPassword howYouHeardAboutUs:(NSString *)howYouHeardAboutUs whoIsThisFor:(NSString *)whoIsThisFor receiveEmails:(NSString *)receiveEmails isEmailTaken:(BOOL)isEmailTaken isUsernameTaken:(BOOL)isUsernameTaken thirdPartySignUp:(BOOL)thirdPartySignUp completionHandler:(void (^)(BOOL finished, NSString *errorString))finishBlock {
    
    [self CheckIfSignUpFieldsAreValid_StandardAndThirdPartySignUp:username userEmail:userEmail userPassword:userPassword howYouHeardAboutUs:howYouHeardAboutUs whoIsThisFor:whoIsThisFor isUsernameTaken:isUsernameTaken isEmailTaken:isEmailTaken completionHandler:^(BOOL finished, NSString *errorString) {
        
        if (errorString.length == 0) {
            
            if (thirdPartySignUp == NO) {
                
                [self CreateNewUserWithEmail_StandardSignUp:userID username:username userEmail:userEmail userPassword:userPassword howYouHeardAboutUs:howYouHeardAboutUs whoIsThisFor:whoIsThisFor receiveEmails:receiveEmails completionHandler:^(BOOL finished, NSString *errorString) {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:userID forKey:@"UsersUserID"];
                    [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"UsersUsername"];
                    [[NSUserDefaults standardUserDefaults] setObject:userEmail forKey:@"UsersEmail"];
                    [[NSUserDefaults standardUserDefaults] setObject:@"https://firebasestorage.googleapis.com/v0/b/wedivvy-afe04.appspot.com/o/DefaultImages%2FdefaultProfileImage.png?alt=media&token=6892f430-8337-4327-89a4-53a403d1186c" forKey:@"UsersProfileImage"];
                    
                    finishBlock(YES, errorString);
                    
                }];
                
            } else {
                
                [self UpdateNewUserWithEmail_ThirdPartySignUp:userID username:username userEmail:userEmail howYouHeardAboutUs:howYouHeardAboutUs whoIsThisFor:whoIsThisFor receiveEmails:receiveEmails completionHandler:^(BOOL finished) {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:userID forKey:@"UsersUserID"];
                    [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"UsersUsername"];
                    [[NSUserDefaults standardUserDefaults] setObject:userEmail forKey:@"UsersEmail"];
                    [[NSUserDefaults standardUserDefaults] setObject:@"https://firebasestorage.googleapis.com/v0/b/wedivvy-afe04.appspot.com/o/DefaultImages%2FdefaultProfileImage.png?alt=media&token=6892f430-8337-4327-89a4-53a403d1186c" forKey:@"UsersProfileImage"];
                    
                    finishBlock(YES, errorString);
                    
                }];
                
            }
            
        } else {
            
            finishBlock(YES, errorString);
            
        }
        
    }];
    
}

#pragma mark - SignUpUser_ThirdPartySignUp

-(NSString *)GenerateMixPanelID_StandardAndThirdPartySignUp {
    
    
    NSString *mixPanelID = @"";
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelID"]) {
        mixPanelID = [[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelID"];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:[[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString] forKey:@"MixPanelID"];
        mixPanelID = [[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelID"];
    }
    
    return mixPanelID;
}

-(NSString *)GenerateUsernameBasedOnSignUpEmail_ThirdPartySignUp:(NSString *)userEmail {
    
    NSString *username = @"";
    
    if ([[[BoolDataObject alloc] init] NoSignUp] == NO) {
        
        if ([userEmail containsString:@"@privaterelay.apple"]) {
            
            username = [NSString stringWithFormat:@"User%@", [[[GeneralObject alloc] init] GenerateRandomSmallNumberIntoString:0000000000 upperBound:9999999999]];
            
        } else if ([userEmail containsString:@"@"]) {
            
            if ([[userEmail componentsSeparatedByString:@"@"] count] > 0) {
                
                username = [[[GeneralObject alloc] init] RemoveSpecialCharactersFromString:[userEmail componentsSeparatedByString:@"@"][0]];
                
            } else {
                
                username = [NSString stringWithFormat:@"User%@", [[[GeneralObject alloc] init] GenerateRandomSmallNumberIntoString:0000000000 upperBound:9999999999]];
                
            }
            
        } else {
            
            username = [NSString stringWithFormat:@"User%@", [[[GeneralObject alloc] init] GenerateRandomSmallNumberIntoString:0000000000 upperBound:9999999999]];
            
        }
        
    } else if ([[[BoolDataObject alloc] init] NoSignUp]) {
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]) {
            
            username = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"];
            
        }
        
    }
    
    return username;
}

-(void)SetUserDataIntoNSUserDefaults_ThirdPartySignUp:(NSString *)userID username:(NSString *)username userEmail:(NSString *)userEmail receiveEmails:(NSString *)receiveEmails {
    
    [[NSUserDefaults standardUserDefaults] setObject:userID forKey:@"UsersUserID"];
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"UsersUsername"];
    [[NSUserDefaults standardUserDefaults] setObject:userEmail forKey:@"UsersEmail"];
    [[NSUserDefaults standardUserDefaults] setObject:@"https://firebasestorage.googleapis.com/v0/b/wedivvy-afe04.appspot.com/o/DefaultImages%2FdefaultProfileImage.png?alt=media&token=6892f430-8337-4327-89a4-53a403d1186c" forKey:@"UsersProfileImage"];
    [[NSUserDefaults standardUserDefaults] setObject:receiveEmails forKey:@"UserReceiveUpdateEmails"];
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark CompleteSignUpUser

-(void)CheckIfSignUpFieldsAreValid_StandardAndThirdPartySignUp:(NSString *)username userEmail:(NSString *)userEmail userPassword:(NSString *)userPassword howYouHeardAboutUs:(NSString *)howYouHeardAboutUs whoIsThisFor:(NSString *)whoIsThisFor isUsernameTaken:(BOOL)isUsernameTaken isEmailTaken:(BOOL)isEmailTaken completionHandler:(void (^)(BOOL finished, NSString *errorString))finishBlock {
    
    NSString *errorStringLocal = @"";
    
    if ([userEmail isEqualToString:@"xxx"] && [userPassword containsString:@"xxx"]) {
        
        errorStringLocal = @"";
        
    } else if ([userEmail isEqualToString:@""] || [userPassword isEqualToString:@""] || [username isEqualToString:@""] || [howYouHeardAboutUs isEqualToString:@""] || [whoIsThisFor isEqualToString:@""]) {
        
        errorStringLocal = @"One or more fields are empty";
        
    } else if ([[[BoolDataObject alloc] init] EmailFormatValid:userEmail] == NO) {
        
        errorStringLocal = @"Your email is not correctly formatted";
        
    } else if (isUsernameTaken == YES) {
        
        errorStringLocal = @"Username is already taken";
        
    } else if (isEmailTaken == YES) {
        
        errorStringLocal = @"Email is already taken";
        
    } else if (userPassword.length < 6) {
        
        errorStringLocal = @"Your password must be at least 6 characters";
        
    } else if (username.length > 25) {
        
        errorStringLocal = @"Your username must be at most 25 characters";
        
    }
    
    finishBlock(YES, errorStringLocal);
    
}

-(void)CreateNewUserWithEmail_StandardSignUp:(NSString *)userID username:(NSString *)username userEmail:(NSString *)userEmail userPassword:(NSString *)userPassword howYouHeardAboutUs:(NSString *)howYouHeardAboutUs whoIsThisFor:(NSString *)whoIsThisFor receiveEmails:(NSString *)receiveEmails completionHandler:(void (^)(BOOL finished, NSString *errorString))finishBlock {
          
    __block NSString *errorString = @"";
    
    NSString *mixPanelID = [self GenerateMixPanelID_StandardAndThirdPartySignUp];
    
    if ([[[BoolDataObject alloc] init] NoSignUp]) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]) {
            userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"];
        }
    }
    
    NSDictionary *userDict = @{
        
        @"UserID": userID ? userID : @"",
        @"Email": userEmail ? userEmail : @"",
        @"Username": username ? username : @"",
        @"ProfileImageURL" : @"https://firebasestorage.googleapis.com/v0/b/wedivvy-afe04.appspot.com/o/DefaultImages%2FdefaultProfileImage.png?alt=media&token=6892f430-8337-4327-89a4-53a403d1186c",
        @"MixPanelID" : mixPanelID ? mixPanelID : @"",
        @"HeardAboutUs" : howYouHeardAboutUs,
        @"WhoIsThisFor" : whoIsThisFor,
        @"Notifications" : @"xxx",
        @"ReceiveUpdateEmails" : receiveEmails ? receiveEmails : @"Yes",
        @"WeDivvyPremium" : [[[GeneralObject alloc] init] GenerateDefaultWeDivvyPremiumPlan]
        
    };

    [[FIRAuth auth] createUserWithEmail:userEmail password:userPassword completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {

        BOOL NoSignUp = [userEmail isEqualToString:@"xxx"] && [userPassword containsString:@"xxx"];
                             
        if (error != nil && [error.description containsString:@"The email address is already in use by another account"] && NoSignUp == NO) {

            errorString = @"Email is already taken";
            
            finishBlock(YES, errorString);
            
        } else if (error != nil && NoSignUp == NO) {

            errorString = @"An error has occurred please try again";
            
            finishBlock(YES, errorString);
            
        } else {
              
            __block int totalQueries = 2;
            __block int completedQueries = 0;
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID == %@", userID];
                [[[SetDataObject alloc] init] SetDataAddCoreData:@"Users" predicate:predicate setDataObject:[userDict mutableCopy]];
                
                [[[SetDataObject alloc] init] SetDataUserData:userID userDict:userDict completionHandler:^(BOOL finished, NSError * _Nonnull error) {
                   
                    if (totalQueries == (completedQueries+=1)) {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                                
                            finishBlock(YES, errorString);
                        
                        });
                        
                    }
                    
                }];
                
            });
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [[[NotificationsObject alloc] init] SendPushNotificationToCreator:[NSString stringWithFormat:@"%@ - Signed Up First Time", userID] notificationBody:[NSString stringWithFormat:@"%@ -  6.5.98", userEmail] badgeNumber:(NSInteger *)1 completionHandler:^(BOOL finished) {

                    if (totalQueries == (completedQueries+=1)) {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            finishBlock(YES, errorString);
                            
                        });
                        
                    }

                }];

            });
            
        }

    }];

}

-(void)UpdateNewUserWithEmail_ThirdPartySignUp:(NSString *)userID username:(NSString *)username userEmail:(NSString *)userEmail howYouHeardAboutUs:(NSString *)howYouHeardAboutUs whoIsThisFor:(NSString *)whoIsThisFor receiveEmails:(NSString *)receiveEmails completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSDictionary *userDict = @{
            @"Username" : username ? username : @"",
            @"HeardAboutUs" : howYouHeardAboutUs ? howYouHeardAboutUs : @"",
            @"WhoIsThisFor" : whoIsThisFor ? whoIsThisFor : @"",
            @"ReceiveUpdateEmails" : receiveEmails ? receiveEmails : @"Yes",
        };
        
        NSString *userIDInner =
        [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ?
        [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] :
        @"";
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID == %@", userID];
        [[[SetDataObject alloc] init] SetDataEditCoreData:@"Users" predicate:predicate setDataObject:userDict];
        
        [[[SetDataObject alloc] init] UpdateDataUserData:userIDInner userDict:userDict completionHandler:^(BOOL finished, NSError * _Nonnull error) {
            
            [[NSUserDefaults standardUserDefaults] setObject:userID forKey:@"UsersUserID"];
            [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"UsersUsername"];
            [[NSUserDefaults standardUserDefaults] setObject:userEmail forKey:@"UsersEmail"];
            [[NSUserDefaults standardUserDefaults] setObject:@"https://firebasestorage.googleapis.com/v0/b/wedivvy-afe04.appspot.com/o/DefaultImages%2FdefaultProfileImage.png?alt=media&token=6892f430-8337-4327-89a4-53a403d1186c" forKey:@"UsersProfileImage"];
            
            finishBlock(YES);
            
        }];
        
    });
   
}

@end
