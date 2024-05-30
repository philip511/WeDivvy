//
//  SettingsObject.m
//  WeDivvy
//
//  Created by Philip Nagel on 9/24/21.
//

#import "AppDelegate.h"
#import "SettingsObject.h"

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "DeleteDataObject.h"
#import "PushObject.h"
#import "BoolDataObject.h"

@implementation SettingsObject

-(void)UpdateEmail:(NSString *)userEmail completionHandler:(void (^)(BOOL finished, NSString *errorString))finishBlock {
    
    __block NSString *errorStringLocal = @"";
    
    [[[GetDataObject alloc] init] GetDataCheckIfObjectInFieldExistsInCollection:@"Users" field:@"Email" object:userEmail thirdPartySignUp:NO completionHandler:^(BOOL finished, BOOL doesObjectExist) {
        
        [self CheckIfEmailFieldIsValid:userEmail isEmailTaken:doesObjectExist completionHandler:^(BOOL finished, NSString *errorString) {
            
            errorStringLocal = errorString;
            
            if (errorStringLocal.length == 0) {
                
                [[FIRAuth auth].currentUser updateEmail:userEmail completion:^(NSError * _Nullable error) {
                    
                    NSDictionary *userDict = @{
                        @"Email" : userEmail
                    };
                    
                    NSString *userIDInner =
                    [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ?
                    [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] :
                    @"";
                    
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID == %@", userIDInner];
                    [[[SetDataObject alloc] init] SetDataEditCoreData:@"Users" predicate:predicate setDataObject:userDict];
                    
                    [[[SetDataObject alloc] init] UpdateDataUserData:userIDInner userDict:userDict completionHandler:^(BOOL finished, NSError *error) {
                        
                        finishBlock(YES, errorStringLocal);
                        
                    }];
                    
                }];
                
            } else {
                
                finishBlock(YES, errorStringLocal);
                
            }
            
        }];
        
    }];
    
}

-(void)DeleteAllUserInfo:(NSString *)userID userEmail:(NSString *)userEmail mixPanelID:(NSString *)mixPanelID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    __block int totalQueries = 2;
    __block int completedQueries = 0;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] SetDataEmailAsMixPanelIDForDeletedAccount:userEmail mixPanelID:mixPanelID completionHandler:^(BOOL finished) {
            
            completedQueries += 1;
            
            if (totalQueries == completedQueries) {
                
                [self FinishOffUser:userID completionHandler:^(BOOL finished) {
                    
                    finishBlock(YES);
                    
                }];
            }
            
        }];
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[DeleteDataObject alloc] init] DeleteDataUserFromHome:userID completionHandler:^(BOOL finished) {
            
            completedQueries += 1;
            
            if (totalQueries == completedQueries) {
                
                [self FinishOffUser:userID completionHandler:^(BOOL finished) {
                    
                    finishBlock(YES);
                    
                }];
            }
            
        }];
        
    });
    
}

-(void)FinishOffUser:(NSString *)userID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    __block int totalQueries = 4;
    __block int completedQueries = 0;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[DeleteDataObject alloc] init] DeleteDataProfileImage:userID completionHandler:^(BOOL finished, NSError * _Nonnull error) {
            
            if (totalQueries == (completedQueries+=1)) {
                
                [self CompleteFinishOffUser:userID completionHandler:^(BOOL finished) {
                    
                    finishBlock(YES);
                    
                }];
                
            }
            
        }];
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID == %@", userID];
        [[[DeleteDataObject alloc] init] DeleteDataCoreData:@"CalendarSettings" predicate:predicate];
        
        [[[DeleteDataObject alloc] init] DeleteDataUserCalendarSettings:userID completionHandler:^(BOOL finished, NSError * _Nonnull error) {
            
            if (totalQueries == (completedQueries+=1)) {
                
                [self CompleteFinishOffUser:userID completionHandler:^(BOOL finished) {
                    
                    finishBlock(YES);
                    
                }];
            }
            
        }];
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID == %@", userID];
        [[[DeleteDataObject alloc] init] DeleteDataCoreData:@"NotificationSettings" predicate:predicate];
        
        [[[DeleteDataObject alloc] init] DeleteDataUserNotificationSettings:userID completionHandler:^(BOOL finished, NSError * _Nonnull error) {
            
            if (totalQueries == (completedQueries+=1)) {
                
                [self CompleteFinishOffUser:userID completionHandler:^(BOOL finished) {
                    
                    finishBlock(YES);
                    
                }];
            }
            
        }];
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID == %@", userID];
        [[[DeleteDataObject alloc] init] DeleteDataCoreData:@"Users" predicate:predicate];
        
        [[[DeleteDataObject alloc] init] DeleteDataUser:userID completionHandler:^(BOOL finished, NSError * _Nonnull error) {
            
            if (totalQueries == (completedQueries+=1)) {
                
                [self CompleteFinishOffUser:userID completionHandler:^(BOOL finished) {
                    
                    finishBlock(YES);
                    
                }];
            }
            
        }];
        
    });
    
}

-(void)CompleteFinishOffUser:(NSString *)userID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *myUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    if ([userID isEqualToString:myUserID]) {
        
        FIRUser *user = [[FIRAuth auth] currentUser];
        
        [user deleteWithCompletion:^(NSError * _Nullable error) {
            
            NSString *topic = [[[GeneralObject alloc] init] GetTopicFromUserID:userID];
            
            [[[GeneralObject alloc] init] AllGenerateTokenMethod:topic Subscribe:NO GrantedNotifications:NO];
            
            [self ResetDefaultsSettings];
            
            finishBlock(YES);
            
        }];
        
    } else {
        
        finishBlock(YES);
        
    }
    
}

- (void)ResetDefaultsSettings {
    
    NSString *mixPanelID;
    NSString *mixPanelCurrentDate;
    NSString *notificationQuestion;
    NSString *surveyCompleted;
    NSString *timesAskedForReview;
    NSString *registerForNotificationsShown;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelID"]) {
        mixPanelID = [[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelID"];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelCurrentDate"]) {
        mixPanelCurrentDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelCurrentDate"];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"HasTheUserBeenAskedToReceiveNotifications"]) {
        notificationQuestion = [[NSUserDefaults standardUserDefaults] objectForKey:@"HasTheUserBeenAskedToReceiveNotifications"];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedSurvey"]) {
        surveyCompleted = [[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedSurvey"];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"TimesAskedForReview"]) {
        timesAskedForReview = [[NSUserDefaults standardUserDefaults] objectForKey:@"TimesAskedForReview"];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"RegisterForNotificationsHasBeenShown"]) {
        registerForNotificationsShown = [[NSUserDefaults standardUserDefaults] objectForKey:@"RegisterForNotificationsHasBeenShown"];
    }
    
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:mixPanelID forKey:@"MixPanelID"];
    [[NSUserDefaults standardUserDefaults] setObject:mixPanelCurrentDate forKey:@"MixPanelCurrentDate"];
    [[NSUserDefaults standardUserDefaults] setObject:notificationQuestion forKey:@"HasTheUserBeenAskedToReceiveNotifications"];
    [[NSUserDefaults standardUserDefaults] setObject:surveyCompleted forKey:@"CompletedSurvey"];
    [[NSUserDefaults standardUserDefaults] setObject:timesAskedForReview forKey:@"TimesAskedForReview"];
    [[NSUserDefaults standardUserDefaults] setObject:registerForNotificationsShown forKey:@"RegisterForNotificationsHasBeenShown"];
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

-(void)CheckIfEmailFieldIsValid:(NSString *)userEmail isEmailTaken:(BOOL)isEmailTaken completionHandler:(void (^)(BOOL finished, NSString *errorString))finishBlock {
    
    NSString *errorStringLocal = @"";
    
    if ([userEmail isEqualToString:@""]) {
        
        errorStringLocal = @"The email field is empty";
        
    } else if ([[[BoolDataObject alloc] init] EmailFormatValid:userEmail] == NO) {
        
        errorStringLocal = @"Your email is not correctly formatted";
        
    } else if (isEmailTaken == YES) {
        
        errorStringLocal = @"Email is already taken";
        
    }
    
    finishBlock(YES, errorStringLocal);
    
}

@end
