//
//  ForumObject.m
//  WeDivvy
//
//  Created by Philip Nagel on 9/25/21.
//

#import "AppDelegate.h"
#import "ForumObject.h"

#import "GeneralObject.h"
#import "SetDataObject.h"
#import "NotificationsObject.h"

@implementation ForumObject

-(void)AddForumPost:(NSString *)forumID forumTitle:(NSString *)forumTitle forumDetails:(NSString *)forumDetails forumDatePosted:(NSString *)forumDatePosted forumImage:(UIImage *)forumImage forumLikes:(NSArray *)forumLikes forumCompleted:(NSString *)forumCompleted collection:(NSString *)collection EditForum:(BOOL)EditForum completionHandler:(void (^)(BOOL finished))finishBlock {
    
    [self UploadForumImage:forumImage forumID:forumID collection:collection completionHandler:^(BOOL finished, NSString *forumImageURL) {
        
        [self UploadForumPost:forumID forumTitle:forumTitle forumDetails:forumDetails forumDatePosted:forumDatePosted forumImageURL:forumImageURL forumLikes:forumLikes forumCompleted:forumCompleted collection:collection EditForum:EditForum completionHandler:^(BOOL finished) {
        
            finishBlock(YES);
            
        }];
        
    }];
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

-(void)UploadForumImage:(UIImage *)forumImage forumID:(NSString *)forumID collection:(NSString *)collection completionHandler:(void (^)(BOOL finished, NSString *forumImageURL))finishBlock {
    
    __block NSString *forumImageURL;
    
    if (forumImage != nil) {
        
        NSData *imgData = UIImageJPEGRepresentation(forumImage, 0.15);
        
        FIRStorage *storage = [FIRStorage storage];
        
        FIRStorageReference *storageRef = [storage reference];
        
        FIRStorageReference *mountainsRef = [[[[[storageRef child:@"ForumImages"] child:collection] child:forumID] child:@"ForumImage"] child:@"ForumImage.jpeg"];
        
        FIRStorageUploadTask *uploadTask;
        
        uploadTask = [mountainsRef putData:imgData
                                  metadata:nil
                                completion:^(FIRStorageMetadata *metadata,
                                             NSError *error) {
            
            if (error == nil) {
                
                [mountainsRef downloadURLWithCompletion:^(NSURL * _Nullable URL, NSError * _Nullable error) {
                    
                    forumImageURL = URL.absoluteString;
                    
                    finishBlock(YES, forumImageURL);
                    
                }];
                
            } else {
                
                forumImageURL = @"xxx";
                
                finishBlock(YES, forumImageURL);
                
            }
            
        }];
        
    } else {
        
        forumImageURL = @"xxx";
        
        finishBlock(YES, forumImageURL);
        
    }
    
}

-(void)UploadForumPost:(NSString *)forumID forumTitle:(NSString *)forumTitle forumDetails:(NSString *)forumDetails forumDatePosted:(NSString *)forumDatePosted forumImageURL:(NSString *)forumImageURL forumLikes:(NSArray *)forumLikes forumCompleted:(NSString *)forumCompleted collection:(NSString *)collection EditForum:(BOOL)EditForum completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSDictionary *dataDict = @{
      
        @"ForumTitle" : forumTitle,
        @"ForumDetails" : forumDetails,
        @"ForumID" : forumID,
        @"ForumDatePosted" : forumDatePosted,
        @"ForumCreatedBy" : [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"],
        @"ForumLikes" : forumLikes,
        @"ForumImageURL" : forumImageURL,
        @"ForumCompleted" : forumCompleted
        
    };
    
    __block int totalQueries = 2;
    __block int completedQueries = 0;
    
    [[[SetDataObject alloc] init] SetDataAddForum:collection forumID:forumID dataDict:dataDict completionHandler:^(BOOL finished) {
        
        if (totalQueries == (completedQueries+=1)) {
            
            [self CallForumNSNotificationObserverMethods:EditForum dataDict:dataDict];

            finishBlock(YES);
            
        }
        
    }];
    
    [[[NotificationsObject alloc] init] SendPushNotificationToCreator:[NSString stringWithFormat:@"%@ - %@", collection, forumTitle] notificationBody:forumDetails badgeNumber:(NSInteger *)1 completionHandler:^(BOOL finished) {
       
        if (totalQueries == (completedQueries+=1)) {
            
            [self CallForumNSNotificationObserverMethods:EditForum dataDict:dataDict];

            finishBlock(YES);
            
        }
        
    }];
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

-(void)CallForumNSNotificationObserverMethods:(BOOL)EditForum dataDict:(NSDictionary *)dataDict {
    
    if (EditForum) {
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"EditForum" userInfo:dataDict locations:@[@"Forum"]];
        
    } else {
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddForum" userInfo:dataDict locations:@[@"Forum"]];
        
    }
   
}

@end
