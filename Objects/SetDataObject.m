//
//  SetDataObject.m
//  WeDivvy
//
//  Created by Philip Nagel on 9/14/21.
//

#import "SetDataObject.h"
#import "GeneralObject.h"
#import "GetDataObject.h"
#import "GeneralObject.h"
#import "NotificationsObject.h"
#import "BoolDataObject.h"

#import <sys/utsname.h>

@import InstantSearch;
@import InstantSearchClient;

@implementation SetDataObject

#pragma mark - Activity

-(void)SetDataItemActivity:(NSString *)homeID collection:(NSString *)collection itemID:(NSString *)itemID activityID:(NSString *)activityID setDataDict:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    if ([collection length] == 0) {
        collection = @"xxx";
    }
    
    if ([itemID length] == 0) {
        itemID = @"xxx";
    }
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Homes", collection, @"Activity"] documents:@[homeID, itemID, activityID] type:@"Set;Merge:YES" setData:setDataDict name:@"SetDataItemActivity" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];

    [[[[[[[defaultFirestore collectionWithPath:@"Homes"]
          documentWithPath:homeID]
         collectionWithPath:collection]
        documentWithPath:itemID]
       collectionWithPath:@"Activity"]
      documentWithPath:activityID]
     setData:setDataDict merge:YES completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemActivities" userInfo:setDataDict locations:@[@"ViewTask"]];
        
        finishBlock(YES);
        
    }];
    
}

-(void)SetDataHomeActivity:(NSString *)activityHomeID activityID:(NSString *)activityID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore
         collectionWithPath:@"Homes"]
        documentWithPath:activityHomeID]
       collectionWithPath:@"Activity"]
      documentWithPath:activityID]
     setData:dataDict completion:^(NSError * _Nullable error) {
        
        finishBlock(YES, error);
        
    }];
    
}

-(void)UpdateDataItemActivity:(NSString *)homeID collection:(NSString *)collection itemID:(NSString *)itemID activityID:(NSString *)activityID setDataDict:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[homeID, collection, @"Activity"] documents:@[homeID, itemID, activityID] type:@"UpdateData;" setData:setDataDict name:@"UpdateDataItemActivity" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];

    [[[[[[[defaultFirestore collectionWithPath:@"Homes"]
          documentWithPath:homeID]
         collectionWithPath:collection]
        documentWithPath:itemID]
       collectionWithPath:@"Activity"]
      documentWithPath:activityID]
     updateData:setDataDict completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemActivities" userInfo:setDataDict locations:@[@"ViewTask"]];
        
        finishBlock(YES);
        
    }];
    
}

-(void)UpdateDataHomeActivity:(NSString *)activityHomeID activityID:(NSString *)activityID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Homes", @"Activity"] documents:@[activityHomeID, activityID] type:@"UpdateData;" setData:dataDict name:@"UpdateDataHomeActivity" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore
         collectionWithPath:@"Homes"]
        documentWithPath:activityHomeID]
       collectionWithPath:@"Activity"]
      documentWithPath:activityID]
     updateData:dataDict completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES, error);
        
    }];
    
}

#pragma mark - Compound Methods

-(void)SetDataHomeAndItemActivity:(NSMutableDictionary *)itemActivityDict homeActivityDict:(NSMutableDictionary *)homeActivityDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *collection = [NSString stringWithFormat:@"%@s", itemActivityDict[@"ActivityItemType"]];
    
    __block int completedQueries = 0;
    __block int totalQueries = 2;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] SetDataItemActivity:itemActivityDict[@"ActivityHomeID"] collection:collection itemID:itemActivityDict[@"ActivityItemID"] activityID:itemActivityDict[@"ActivityID"] setDataDict:itemActivityDict completionHandler:^(BOOL finished) {
            
            if (totalQueries == (completedQueries+=1)) {
                
                finishBlock(YES);
                
            }
            
        }];
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] SetDataHomeActivity:homeActivityDict[@"ActivityHomeID"] activityID:homeActivityDict[@"ActivityID"] dataDict:homeActivityDict completionHandler:^(BOOL finished, NSError * _Nonnull error) {
            
            if (totalQueries == (completedQueries+=1)) {
                
                finishBlock(YES);
                
            }
            
        }];
        
    });
    
}

-(void)UpdateDataHomeAndItemActivity:(NSString *)activityID activityRead:(NSMutableArray *)activityRead itemType:(NSString *)itemType homeID:(NSString *)homeID itemID:(NSString *)itemID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *collection = [NSString stringWithFormat:@"%@s", itemType];
    
    __block int completedQueries = 0;
    __block int totalQueries = 2;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableDictionary *activitySetDataDict = [NSMutableDictionary dictionary];
        
        if ([activityRead containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] == NO) {
            [activityRead addObject:@[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]]];
        }
        
        [activitySetDataDict setObject:activityID forKey:@"ActivityID"];
        [activitySetDataDict setObject:activityRead forKey:@"ActivityRead"];
        
        [[[SetDataObject alloc] init] UpdateDataItemActivity:homeID collection:collection itemID:itemID activityID:activityID setDataDict:activitySetDataDict completionHandler:^(BOOL finished) {
            
            if (totalQueries == (completedQueries+=1)) {
                
                finishBlock(YES);
                
            }
            
        }];
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableDictionary *activitySetDataDict = [NSMutableDictionary dictionary];
        if ([activityRead containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] == NO) {
            [activityRead addObject:@[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]]];
        }
        
        [activitySetDataDict setObject:activityID forKey:@"ActivityID"];
        [activitySetDataDict setObject:activityRead forKey:@"ActivityRead"];
        
        [[[SetDataObject alloc] init] UpdateDataHomeActivity:homeID activityID:activitySetDataDict[@"ActivityID"] dataDict:activitySetDataDict completionHandler:^(BOOL finished, NSError * _Nonnull error) {
            
            if (totalQueries == (completedQueries+=1)) {
                
                finishBlock(YES);
                
            }
            
        }];
        
    });
    
}

#pragma mark - Algolia

-(void)SetDataAddAlgoliaObject:(NSString *)itemUniqueID dictToUse:(NSMutableDictionary *)dictToUse completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString * ALGOLIA_APP_ID = @"3VZ11H3TM1";
    NSString * ALGOLIA_USER_INDEX_NAME = @"Tasks";
    NSString * ALGOLIA_ADMIN_API_KEY = @"37558fa21fb4266d0f5213af41a23a7a";
    
    //    if (dictToUse[@"ItemSubTasks"]) {
    //        ALGOLIA_USER_INDEX_NAME = @"Chores";
    //    } else if (dictToUse[@"ItemAmount"]) {
    //        ALGOLIA_USER_INDEX_NAME = @"Expenses";
    //    } else if (dictToUse[@"ItemListItems"]) {
    //        ALGOLIA_USER_INDEX_NAME = @"Lists";
    //    }
    
    Client *apiClient = [[Client alloc] initWithAppID:ALGOLIA_APP_ID apiKey:ALGOLIA_ADMIN_API_KEY];
    
    Index *algoliaIndex = [apiClient indexWithName:ALGOLIA_USER_INDEX_NAME];
    
    [algoliaIndex addObject:dictToUse withID:itemUniqueID completionHandler:^(NSDictionary<NSString *,id> * _Nullable test, NSError * _Nullable error) {
        
        finishBlock(YES);
        
    }];
    
}

-(void)SetDataAddMultipleAlgoliaObjects:(NSMutableArray *)arrayOfObjects completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString * ALGOLIA_APP_ID = @"3VZ11H3TM1";
    NSString * ALGOLIA_USER_INDEX_NAME = @"Tasks";
    NSString * ALGOLIA_ADMIN_API_KEY = @"37558fa21fb4266d0f5213af41a23a7a";
    
    //    for (NSDictionary *dictToUse in arrayOfObjects) {
    //
    //        if (dictToUse[@"ItemSubTasks"]) {
    //            ALGOLIA_USER_INDEX_NAME = @"Chores";
    //            break;
    //        } else if (dictToUse[@"ItemAmount"]) {
    //            ALGOLIA_USER_INDEX_NAME = @"Expenses";
    //            break;
    //        } else if (dictToUse[@"ItemListItems"]) {
    //            ALGOLIA_USER_INDEX_NAME = @"Lists";
    //            break;
    //        }
    //
    //    }
    
    Client *apiClient = [[Client alloc] initWithAppID:ALGOLIA_APP_ID apiKey:ALGOLIA_ADMIN_API_KEY];
    
    Index *algoliaIndex = [apiClient indexWithName:ALGOLIA_USER_INDEX_NAME];
    
    [algoliaIndex addObjects:arrayOfObjects completionHandler:^(NSDictionary<NSString *,id> * _Nullable test, NSError * _Nullable error) {
        
        finishBlock(YES);
        
    }];
    
}

-(void)UpdateDataEditAlgoliaObject:(NSString *)itemUniqueID dictToUse:(NSMutableDictionary *)dictToUse completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString * ALGOLIA_APP_ID = @"3VZ11H3TM1";
    NSString * ALGOLIA_USER_INDEX_NAME = @"Tasks";
    NSString * ALGOLIA_ADMIN_API_KEY = @"37558fa21fb4266d0f5213af41a23a7a";
    
    Client *apiClient = [[Client alloc] initWithAppID:ALGOLIA_APP_ID apiKey:ALGOLIA_ADMIN_API_KEY];
    
    Index *algoliaIndex = [apiClient indexWithName:ALGOLIA_USER_INDEX_NAME];
    
    [algoliaIndex partialUpdateObject:dictToUse withID:itemUniqueID completionHandler:^(NSDictionary<NSString *,id> * _Nullable test, NSError * _Nullable error) {
        
        finishBlock(YES);
        
    }];
}

#pragma mark - Analytics

-(NSString *)generateDeviceName {
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString* code = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];
    
    static NSDictionary* deviceNamesByCode = nil;
    
    if (!deviceNamesByCode) {
        
        deviceNamesByCode = @{@"i386"      : @"Simulator",
                              @"x86_64"    : @"Simulator",
                              @"iPod1,1"   : @"iPod Touch",        // (Original)
                              @"iPod2,1"   : @"iPod Touch",        // (Second Generation)
                              @"iPod3,1"   : @"iPod Touch",        // (Third Generation)
                              @"iPod4,1"   : @"iPod Touch",        // (Fourth Generation)
                              @"iPod7,1"   : @"iPod Touch",        // (6th Generation)
                              @"iPhone1,1" : @"iPhone",            // (Original)
                              @"iPhone1,2" : @"iPhone",            // (3G)
                              @"iPhone2,1" : @"iPhone",            // (3GS)
                              @"iPad1,1"   : @"iPad",              // (Original)
                              @"iPad2,1"   : @"iPad 2",            //
                              @"iPad3,1"   : @"iPad",              // (3rd Generation)
                              @"iPhone3,1" : @"iPhone 4",          // (GSM)
                              @"iPhone3,3" : @"iPhone 4",          // (CDMA/Verizon/Sprint)
                              @"iPhone4,1" : @"iPhone 4S",         //
                              @"iPhone5,1" : @"iPhone 5",          // (model A1428, AT&T/Canada)
                              @"iPhone5,2" : @"iPhone 5",          // (model A1429, everything else)
                              @"iPad3,4"   : @"iPad",              // (4th Generation)
                              @"iPad2,5"   : @"iPad Mini",         // (Original)
                              @"iPhone5,3" : @"iPhone 5c",         // (model A1456, A1532 | GSM)
                              @"iPhone5,4" : @"iPhone 5c",         // (model A1507, A1516, A1526 (China), A1529 | Global)
                              @"iPhone6,1" : @"iPhone 5s",         // (model A1433, A1533 | GSM)
                              @"iPhone6,2" : @"iPhone 5s",         // (model A1457, A1518, A1528 (China), A1530 | Global)
                              @"iPhone7,1" : @"iPhone 6 Plus",     //
                              @"iPhone7,2" : @"iPhone 6",          //
                              @"iPhone8,1" : @"iPhone 6S",         //
                              @"iPhone8,2" : @"iPhone 6S Plus",    //
                              @"iPhone8,4" : @"iPhone SE",         //
                              @"iPhone9,1" : @"iPhone 7",          //
                              @"iPhone9,3" : @"iPhone 7",          //
                              @"iPhone9,2" : @"iPhone 7 Plus",     //
                              @"iPhone9,4" : @"iPhone 7 Plus",     //
                              @"iPhone10,1": @"iPhone 8",          // CDMA
                              @"iPhone10,4": @"iPhone 8",          // GSM
                              @"iPhone10,2": @"iPhone 8 Plus",     // CDMA
                              @"iPhone10,5": @"iPhone 8 Plus",     // GSM
                              @"iPhone10,3": @"iPhone X",          // CDMA
                              @"iPhone10,6": @"iPhone X",          // GSM
                              @"iPhone11,2": @"iPhone XS",         //
                              @"iPhone11,4": @"iPhone XS Max",     //
                              @"iPhone11,6": @"iPhone XS Max",     // China
                              @"iPhone11,8": @"iPhone XR",         //
                              @"iPhone12,1": @"iPhone 11",         //
                              @"iPhone12,3": @"iPhone 11 Pro",     //
                              @"iPhone12,5": @"iPhone 11 Pro Max", //
                              
                              @"iPad4,1"   : @"iPad Air",          // 5th Generation iPad (iPad Air) - Wifi
                              @"iPad4,2"   : @"iPad Air",          // 5th Generation iPad (iPad Air) - Cellular
                              @"iPad4,4"   : @"iPad Mini",         // (2nd Generation iPad Mini - Wifi)
                              @"iPad4,5"   : @"iPad Mini",         // (2nd Generation iPad Mini - Cellular)
                              @"iPad4,7"   : @"iPad Mini",         // (3rd Generation iPad Mini - Wifi (model A1599))
                              @"iPad6,7"   : @"iPad Pro (12.9\")", // iPad Pro 12.9 inches - (model A1584)
                              @"iPad6,8"   : @"iPad Pro (12.9\")", // iPad Pro 12.9 inches - (model A1652)
                              @"iPad6,3"   : @"iPad Pro (9.7\")",  // iPad Pro 9.7 inches - (model A1673)
                              @"iPad6,4"   : @"iPad Pro (9.7\")"   // iPad Pro 9.7 inches - (models A1674 and A1675)
        };
    }
    
    NSString* deviceName = [deviceNamesByCode objectForKey:code];
    
    if (!deviceName) {
        // Not found on database. At least guess main device type from string contents:
        
        if ([code rangeOfString:@"iPod"].location != NSNotFound) {
            deviceName = @"iPod Touch";
        }
        else if([code rangeOfString:@"iPad"].location != NSNotFound) {
            deviceName = @"iPad";
        }
        else if([code rangeOfString:@"iPhone"].location != NSNotFound){
            deviceName = @"iPhone";
        }
        else {
            deviceName = @"Unknown";
        }
    }
    
    return deviceName;
}

-(BOOL)UserisValid:(BOOL)isSimulator {
    
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] isEqualToString:@"2021-08-24 23:51:563280984"] &&
        ![[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] isEqualToString:@"2021-07-09 19:11:493907435"] &&
        ![[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] isEqualToString:@"2021-06-05 15:07:572627942"] &&
        ![[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] isEqualToString:@"2021-08-24 23:47:407268729"] &&
        !isSimulator) {
        return YES;
    }
    
    return NO;
}

-(void)SetDataFIRStoreAnalytics:(void (^)(BOOL finished))finishBlock {

    dispatch_async(dispatch_get_main_queue(), ^{
        
        BOOL isSimulator;
        
#if TARGET_OS_SIMULATOR
        isSimulator = YES;
#else
        isSimulator = NO;
#endif
        
        BOOL UserIsValid = [[[SetDataObject alloc] init] UserisValid:isSimulator];
        
        if (UserIsValid == YES) {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                FIRFirestore *defaultFirestore = [FIRFirestore firestore];
                
                NSString *mixPanelID =
                [[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelID"] ?
                [[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelID"] : @"UnknownMixPanelID";
                
                if (mixPanelID == nil || mixPanelID == NULL || [mixPanelID containsString:@"null"] || mixPanelID.length == 0) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        finishBlock(YES);
                        
                    });
                    
                } else {
                    
                    [[[defaultFirestore collectionWithPath:@"Analytics"] documentWithPath:mixPanelID] setData:@{@"MixPanelID" : mixPanelID} merge:YES completion:^(NSError * _Nullable error) {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            finishBlock(YES);
                            
                        });
                        
                    }];
                    
                }
                
            });
            
        } else {
            
            finishBlock(YES);
            
        }
        
    });
    
}

-(void)SetDataFIRStoreAnalyticsNewViewController:(NSString *)identifier completionHandler:(void (^)(BOOL finished))finishBlock {

    dispatch_async(dispatch_get_main_queue(), ^{
        
        BOOL isSimulator;
        
#if TARGET_OS_SIMULATOR
        isSimulator = YES;
#else
        isSimulator = NO;
#endif
        
        BOOL UserIsValid = [[[SetDataObject alloc] init] UserisValid:isSimulator];
        
        NSMutableDictionary *viewControllerDict =
        [[NSUserDefaults standardUserDefaults] objectForKey:@"ViewControllerDict"] ?
        [[[NSUserDefaults standardUserDefaults] objectForKey:@"ViewControllerDict"] mutableCopy] : [NSMutableDictionary dictionary];
        
        if (UserIsValid == YES) {
            
            __block NSString *restorationIdentifier =
            identifier == NULL || identifier == nil || identifier.length == 0 ?
            @"UnknownIdentifier" : identifier;
            
            [viewControllerDict setObject:@"Yes" forKey:restorationIdentifier];
            [[NSUserDefaults standardUserDefaults] setObject:viewControllerDict forKey:@"ViewControllerDict"];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                FIRFirestore *defaultFirestore = [FIRFirestore firestore];
                
                NSString *mixPanelID = [[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelID"] ?
                [[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelID"] : @"UnknownMixPanelID";
                
                NSString *randomID =
                [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString] ?
                [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString] : @"UnknownRandomID";
                
                NSString *dateTimeOpenned =
                [[[GeneralObject alloc] init] GenerateReadableCurrentESTDate] ?
                [[[GeneralObject alloc] init] GenerateReadableCurrentESTDate] : @"UnknownDateTimeOpenned";
                
                NSString *currentDate;
                
                if (![[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelCurrentDate"]) {
                    
                    currentDate =
                    [[[GeneralObject alloc] init] GenerateReadableCurrentESTDate] ?
                    [[[GeneralObject alloc] init] GenerateReadableCurrentESTDate] : @"UnknownCurrentDate";
                    [[NSUserDefaults standardUserDefaults] setObject:currentDate forKey:@"MixPanelCurrentDate"];
                    
                } else {
                    
                    currentDate =
                    [[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelCurrentDate"] ?
                    [[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelCurrentDate"] : @"UnknownCurrentDate";
                    
                }
                
                if ([[NSUserDefaults standardUserDefaults] objectForKey:@"TempMixPanelCurrentDate"]) {
                    
                    currentDate =
                    [[NSUserDefaults standardUserDefaults] objectForKey:@"TempMixPanelCurrentDate"] ?
                    [[NSUserDefaults standardUserDefaults] objectForKey:@"TempMixPanelCurrentDate"] : @"UnknownCurrentDate";
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TempMixPanelCurrentDate"];
                    
                }
                
                //mixPanelID = @"99999999999";
                //restorationIdentifier = @"CustomAdd";
                
                mixPanelID =
                mixPanelID == NULL || mixPanelID == nil || mixPanelID.length == 0 ?
                @"UnknownMixPanelID" : mixPanelID;
                
                randomID =
                randomID == NULL || randomID == nil || randomID.length == 0 ?
                @"UnknownRandomID" : randomID;
                
                restorationIdentifier =
                restorationIdentifier == NULL || restorationIdentifier == nil || restorationIdentifier.length == 0 ?
                @"UnknownViewController" : restorationIdentifier;
                
                dateTimeOpenned =
                dateTimeOpenned == NULL || dateTimeOpenned == nil || dateTimeOpenned.length == 0 ?
                @"UnknownOpenned" : dateTimeOpenned;
                
                currentDate =
                currentDate == NULL || currentDate == nil || currentDate.length == 0 ?
                @"UnknownCurrentDate" : currentDate;
                
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                [dict setObject:@{randomID :
                                      @{@"ID" : randomID ? randomID : @"UnknownRandomID",
                                        @"TouchEvents" : @[],
                                        @"ViewController" : restorationIdentifier ? restorationIdentifier : @"UnknownViewController",
                                        @"Openned" : dateTimeOpenned ? dateTimeOpenned : @"UnknownOpenned",
                                        @"AppVersion" : @"6.5.98",
                                      }
                                } forKey:currentDate];
                
                [[[defaultFirestore collectionWithPath:@"Analytics"] documentWithPath:mixPanelID] setData:dict merge:YES completion:^(NSError * _Nullable error) {
                    
                    NSArray *invalidViewControllers = @[@"CustomAdd", @"didFinishLaunchingWithOptions", @"applicationDidBecomeActive", @"applicationWillResignActive", @"applicationWillEnterForeground", @"applicationDidEnterBackground", @"willConnectToSession", @"sceneDidBecomeActive", @"sceneWillResignActive", @"sceneWillEnterForeground", @"sceneDidEnterBackground"];
                    
                    if (dict[currentDate] &&
                        dict[currentDate][randomID] &&
                        dict[currentDate][randomID][@"ViewController"] &&
                        invalidViewControllers &&
                        [invalidViewControllers containsObject:dict[currentDate][randomID][@"ViewController"]] == NO) {
                        
                        NSMutableDictionary *dictOfDicts =
                        [[NSUserDefaults standardUserDefaults] objectForKey:@"CrashActions"] ?
                        [[[NSUserDefaults standardUserDefaults] objectForKey:@"CrashActions"] mutableCopy] : [NSMutableDictionary dictionary];
                        
                        if (dict &&
                            dict[currentDate] &&
                            dict[currentDate][randomID] &&
                            dictOfDicts &&
                            randomID) {
                            [dictOfDicts setObject:dict[currentDate][randomID] forKey:randomID];
                        }
                        
                        NSArray *sortedKeysArray = [[dictOfDicts allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
                        
                        if ([[dictOfDicts allKeys] count] > 10) {
                            if ([sortedKeysArray count] > 0) {
                                [dictOfDicts removeObjectForKey:sortedKeysArray[0]];
                            }
                        }
                        
                        if (dictOfDicts) {
                            [[NSUserDefaults standardUserDefaults] setObject:dictOfDicts forKey:@"CrashActions"];
                        }
                        
                    }
                    
                    if (dict) {
                        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"MixPanelTempDict"];
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        finishBlock(YES);
                        
                    });
                    
                }];
                
            });
            
        } else {
            
            finishBlock(YES);
            
        }
        
    });
    
}

-(void)SetDataFIRStoreAnalyticsNewTouchEvent:(UIViewController *)currentViewController touchEvent:(NSString *)touchEvent completionHandler:(void (^)(BOOL finished))finishBlock {

    dispatch_async(dispatch_get_main_queue(), ^{
        
        BOOL isSimulator;
        
#if TARGET_OS_SIMULATOR
        isSimulator = YES;
#else
        isSimulator = NO;
#endif
        
        BOOL UserIsValid = [[[SetDataObject alloc] init] UserisValid:isSimulator];
        
        NSMutableDictionary *touchEventDict =
        [[NSUserDefaults standardUserDefaults] objectForKey:@"TouchEventDict"] ?
        [[[NSUserDefaults standardUserDefaults] objectForKey:@"TouchEventDict"] mutableCopy] : [NSMutableDictionary dictionary];
        
        NSString *currentViewControllerRestorationIdentifier = currentViewController.restorationIdentifier ?
        currentViewController.restorationIdentifier : [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
        
        NSString *touchEventAndViewController =
        [NSString stringWithFormat:@"%@ -- %@", touchEvent, currentViewControllerRestorationIdentifier];
        
        touchEventAndViewController =
        touchEventAndViewController == nil || touchEventAndViewController == NULL || touchEventAndViewController.length == 0 ?
        @"UnknownTouchEventAndViewController" : touchEventAndViewController;
        
        if (UserIsValid == YES && [[touchEventDict allKeys] containsObject:touchEventAndViewController] == NO) {
            
            [touchEventDict setObject:@"Yes" forKey:touchEventAndViewController];
            [[NSUserDefaults standardUserDefaults] setObject:touchEventDict forKey:@"TouchEventDict"];
            
            __block NSString *restorationIdentifier =
            currentViewController.restorationIdentifier ?
            currentViewController.restorationIdentifier : @"UnknownRestorationIdentifier";
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                FIRFirestore *defaultFirestore = [FIRFirestore firestore];
                
                NSString *mixPanelID =
                [[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelID"] ?
                [[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelID"] : @"UnknownMixPanelID";
                
                NSString *currentDate =
                [[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelCurrentDate"] ?
                [[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelCurrentDate"] : [[[GeneralObject alloc] init] GenerateReadableCurrentESTDate];
                
                //mixPanelID = @"99999999999";
                
                NSString *randomID =
                [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString] ?
                [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString] : @"UnknownRandomID";
                
                NSString *dateTimeOpenned =
                [[[GeneralObject alloc] init] GenerateReadableCurrentESTDate] ?
                [[[GeneralObject alloc] init] GenerateReadableCurrentESTDate] : @"UnknownOpenned";
                
                mixPanelID =
                mixPanelID == NULL || mixPanelID == nil || mixPanelID.length == 0 ?
                @"UnknownMixPanelID" : mixPanelID;
                
                randomID =
                randomID == NULL || randomID == nil || randomID.length == 0 ?
                @"UnknownRandomID" : randomID;
                
                NSString *touchEventLocal =
                touchEvent == NULL || touchEvent == nil || touchEvent.length == 0 ?
                @"UnknownTouchEvent" : touchEvent;
                
                restorationIdentifier =
                restorationIdentifier == NULL || restorationIdentifier == nil || restorationIdentifier.length == 0 ?
                @"UnknownViewController" : restorationIdentifier;
                
                dateTimeOpenned =
                dateTimeOpenned == NULL || dateTimeOpenned == nil || dateTimeOpenned.length == 0 ?
                @"UnknownOpenned" : dateTimeOpenned;
                
                currentDate =
                currentDate == NULL || currentDate == nil || currentDate.length == 0 ?
                @"UnknownCurrentDate" : currentDate;
                
                NSMutableDictionary *dict =
                [[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelTempDict"] ?
                [[[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelTempDict"] mutableCopy] : [NSMutableDictionary dictionary];
                
                [dict setObject:@{randomID :
                                      @{@"ID" : randomID ? randomID : @"UnknownRandomID",
                                        @"TouchEvents" : touchEventLocal ? @[touchEventLocal] : @[@"UnknownTouchEvent"],
                                        @"ViewController" : restorationIdentifier ? restorationIdentifier : @"UnknownViewController",
                                        @"Openned" : dateTimeOpenned ? dateTimeOpenned : @"UnknownOpenned",
                                        @"AppVersion" : @"6.5.98",
                                      }
                                } forKey:currentDate];
                
                [[[defaultFirestore collectionWithPath:@"Analytics"] documentWithPath:mixPanelID] setData:dict merge:YES completion:^(NSError * _Nullable error) {
                    
                    NSArray *invalidViewControllers = @[@"CustomAdd", @"didFinishLaunchingWithOptions", @"applicationDidBecomeActive", @"applicationWillResignActive", @"applicationWillEnterForeground", @"applicationDidEnterBackground", @"willConnectToSession", @"sceneDidBecomeActive", @"sceneWillResignActive", @"sceneWillEnterForeground", @"sceneDidEnterBackground"];
                    
                    if (dict[currentDate] &&
                        dict[currentDate][randomID] &&
                        dict[currentDate][randomID][@"ViewController"] &&
                        invalidViewControllers &&
                        [invalidViewControllers containsObject:dict[currentDate][randomID][@"ViewController"]] == NO) {
                        
                        NSMutableDictionary *dictOfDicts =
                        [[NSUserDefaults standardUserDefaults] objectForKey:@"CrashActions"] ?
                        [[[NSUserDefaults standardUserDefaults] objectForKey:@"CrashActions"] mutableCopy] : [NSMutableDictionary dictionary];
                        
                        if (dict &&
                            dict[currentDate] &&
                            dict[currentDate][randomID] &&
                            dictOfDicts &&
                            randomID) {
                            [dictOfDicts setObject:dict[currentDate][randomID] forKey:randomID];
                        }
                        
                        NSArray *sortedKeysArray = [[dictOfDicts allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
                        
                        if ([[dictOfDicts allKeys] count] > 10) {
                            if ([sortedKeysArray count] > 0) {
                                [dictOfDicts removeObjectForKey:sortedKeysArray[0]];
                            }
                        }
                        
                        if (dictOfDicts) {
                            [[NSUserDefaults standardUserDefaults] setObject:dictOfDicts forKey:@"CrashActions"];
                        }
                        
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        finishBlock(YES);
                        
                    });
                    
                }];
                
            });
            
        } else {
            
            finishBlock(YES);
            
        }
        
    });
    
}

-(void)SetDataAnalyticsMixPanelID:(NSString *)mixPanelID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Analytics"] documents:@[mixPanelID] type:@"Set;Merge:YES" setData:@{@"MixPanelID" : mixPanelID} name:@"SetDataAnalyticsMixPanelID" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore collectionWithPath:@"Analytics"] documentWithPath:mixPanelID] setData:@{@"MixPanelID" : mixPanelID} merge:YES completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

-(void)SetDataEmailAsMixPanelIDForDeletedAccount:(NSString *)userEmail mixPanelID:(NSString *)mixPanelID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    finishBlock(YES);
    
//    if ([mixPanelID length] > 0) {
//        
//        NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
//        [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Analytics"] documents:@[mixPanelID] type:@"Set;Merge:YES" setData:@{@"MixPanelID" : userEmail} name:@"SetDataEmailAsMixPanelIDForDeletedAccount" queryID:queryID];
//        
//        FIRFirestore *defaultFirestore = [FIRFirestore firestore];
//        
//        [[[defaultFirestore
//           collectionWithPath:@"Analytics"] documentWithPath:mixPanelID] setData:@{@"MixPanelID" : userEmail} merge:YES completion:^(NSError * _Nullable error) {
//            
//            [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
//            
//            finishBlock(YES);
//            
//        }];
//        
//    } else {
//        
//        finishBlock(YES);
//        
//    }
    
}

#pragma mark - Android

-(void)SetDataAndroid:(void (^)(BOOL finished))finishBlock {
    
    NSString *userID =
    [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ?
    [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    NSString *homeID =
    [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] &&
    [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ?
    [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    NSString *mixPanelID =
    [[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelID"] ?
    [[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelID"] : @"xxx";
    
    NSDictionary *dataDict = @{@"AndroidID" : [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString],
                               @"AndroidHomeID" : homeID,
                               @"AndroidUserID" : userID,
                               @"AndroidMixPanelID" : mixPanelID
    };
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore collectionWithPath:@"Android"] documentWithPath:userID] setData:dataDict completion:^(NSError * _Nullable error) {
        
    }];
    
}

#pragma mark Data

-(void)SetDataAddCoreData:(NSString *)entity predicate:(NSPredicate * _Nullable)predicate setDataObject:(NSDictionary *)setDataObject {
    
    return;
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //
    //        NSManagedObjectContext *managedObjectContext = [[[AppDelegate alloc] init] managedObjectContext];
    //
    //        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entity];
    //        if (predicate != nil) { fetchRequest.predicate = predicate; }
    //
    //        NSError *fetchError = nil;
    //        NSArray *existingObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
    //
    //        if (existingObjects.count == 0) {
    //
    //            NSManagedObject *itemObject = [NSEntityDescription insertNewObjectForEntityForName:entity inManagedObjectContext:managedObjectContext];
    //
    //            for (NSString *key in [setDataObject allKeys]) {
    //
    //                NSString *originalKey = [key mutableCopy];
    //                NSString *lowercaseFirstCharKey = [originalKey stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[originalKey substringToIndex:1] lowercaseString]];
    //                id object = setDataObject[key] ? setDataObject[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
    //                if ([[[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key] isKindOfClass:[NSDictionary class]]) { object = [[[GeneralObject alloc] init] dictionaryToString:object]; }
    //                if ([[[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key] isKindOfClass:[NSArray class]]) { object = [[[GeneralObject alloc] init] arrayToString:object]; }
    //
    //                [itemObject setValue:object forKey:lowercaseFirstCharKey];
    //
    //            }
    //
    //            NSError *error = nil;
    //            if (![managedObjectContext save:&error]) {
    //                NSLog(@"Error saving context: %@", error.localizedDescription);
    //            }
    //
    //        }
    //
    //    });
    //
}

-(void)SetDataAddCoreDataNo1:(NSString *)entity predicate:(NSPredicate * _Nullable)predicate setDataObject:(NSDictionary *)setDataObject managedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    
    return;
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    
    //        NSManagedObjectContext *managedObjectContext = [[[AppDelegate alloc] init] managedObjectContext];
    
    //    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entity];
    //    if (predicate != nil) { fetchRequest.predicate = predicate; }
    //
    //    NSError *fetchError = nil;
    //    NSArray *existingObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
    //
    //    if (existingObjects.count == 0) {
    //
    //        NSManagedObject *itemObject = [NSEntityDescription insertNewObjectForEntityForName:entity inManagedObjectContext:managedObjectContext];
    //
    //        for (NSString *key in [setDataObject allKeys]) {
    //
    //            NSString *originalKey = [key mutableCopy];
    //            NSString *lowercaseFirstCharKey = [originalKey stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[originalKey substringToIndex:1] lowercaseString]];
    //            id object = setDataObject[key] ? setDataObject[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
    //            if ([[[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key] isKindOfClass:[NSDictionary class]]) { object = [[[GeneralObject alloc] init] dictionaryToString:object]; }
    //            if ([[[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key] isKindOfClass:[NSArray class]]) { object = [[[GeneralObject alloc] init] arrayToString:object]; }
    //
    //            [itemObject setValue:object forKey:lowercaseFirstCharKey];
    //
    //        }
    //
    //        NSError *error = nil;
    //        if (![managedObjectContext save:&error]) {
    //            NSLog(@"Error saving context: %@", error.localizedDescription);
    //        } else {
    //            NSLog(@"Successfully edited and saved the object.");
    //
    //            [[[GetDataObject alloc] init] GetDataCoreDataNo1:entity predicate:predicate keyArray:[setDataObject allKeys] managedObjectContext:managedObjectContext completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDataDict) {
    //
    //                NSLog(@"Added Core DataNo1:\n%@", returningDataDict);
    //
    //            }];
    //
    //        }
    //
    //    }
    
    //    });
    
}

-(void)SetDataEditCoreDataNo1:(NSString *)entity predicate:(NSPredicate * _Nullable)predicate setDataObject:(NSDictionary *)setDataObject managedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    
    return;
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    
    //        NSManagedObjectContext *managedObjectContext = [[[AppDelegate alloc] init] managedObjectContext];
    
    //    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entity];
    //    if (predicate != nil) { fetchRequest.predicate = predicate; }
    //
    //    NSError *fetchError = nil;
    //    NSArray *existingObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
    //
    //    if (existingObjects.count > 0) {
    //        // Assuming there's only one existing object; otherwise, you'll need to loop through them
    //
    //        NSManagedObject *itemObject = [existingObjects firstObject];
    //
    //        for (NSString *key in [setDataObject allKeys]) {
    //            NSString *originalKey = [key mutableCopy];
    //            NSString *lowercaseFirstCharKey = [originalKey stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[originalKey substringToIndex:1] lowercaseString]];
    //            id object = setDataObject[key] ? setDataObject[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
    //
    //            if ([[[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key] isKindOfClass:[NSDictionary class]]) {
    //                object = [[[GeneralObject alloc] init] dictionaryToString:object];
    //            }
    //            if ([[[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key] isKindOfClass:[NSArray class]]) {
    //                object = [[[GeneralObject alloc] init] arrayToString:object];
    //            }
    //
    //            [itemObject setValue:object forKey:lowercaseFirstCharKey];
    //
    //        }
    //
    //        NSError *error = nil;
    //        if (![managedObjectContext save:&error]) {
    //            NSLog(@"Error saving context: %@", error.localizedDescription);
    //        } else {
    //            NSLog(@"Successfully edited and saved the object.");
    //
    //            [[[GetDataObject alloc] init] GetDataCoreDataNo1:entity predicate:predicate keyArray:[setDataObject allKeys] managedObjectContext:managedObjectContext completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDataDict) {
    //
    //                NSLog(@"Edited Core DataNo1:\n%@", returningDataDict);
    //
    //            }];
    //
    //        }
    //    } else {
    //        NSLog(@"No existing object found for the given predicate.");
    //    }
    
    //    });
    
}

-(void)SetDataEditCoreData:(NSString *)entity predicate:(NSPredicate * _Nullable)predicate setDataObject:(NSDictionary *)setDataObject {
    
    return;
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //
    //        NSManagedObjectContext *managedObjectContext = [[[AppDelegate alloc] init] managedObjectContext];
    //
    //        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entity];
    //        if (predicate != nil) { fetchRequest.predicate = predicate; }
    //
    //        NSError *fetchError = nil;
    //        NSArray *existingObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
    //
    //        if (existingObjects.count > 0) {
    //
    //            NSManagedObject *itemObject = [NSEntityDescription insertNewObjectForEntityForName:entity inManagedObjectContext:managedObjectContext];
    //
    //            for (NSString *key in [setDataObject allKeys]) {
    //
    //                NSString *originalKey = [key mutableCopy];
    //                NSString *lowercaseFirstCharKey = [originalKey stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[originalKey substringToIndex:1] lowercaseString]];
    //                id object = setDataObject[key] ? setDataObject[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
    //                if ([[[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key] isKindOfClass:[NSDictionary class]]) { object = [[[GeneralObject alloc] init] dictionaryToString:object]; }
    //                if ([[[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key] isKindOfClass:[NSArray class]]) { object = [[[GeneralObject alloc] init] arrayToString:object]; }
    //
    //                [itemObject setValue:object forKey:lowercaseFirstCharKey];
    //
    //            }
    //
    //            NSError *error = nil;
    //            if (![managedObjectContext save:&error]) {
    //                NSLog(@"Error saving context: %@", error.localizedDescription);
    //            } else {
    //
    //                [[[GetDataObject alloc] init] GetDataCoreData:entity predicate:predicate keyArray:[setDataObject allKeys] completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDataDict) {
    //
    //                    NSLog(@"Edited Core Data:\n%@", returningDataDict);
    //
    //                }];
    //
    //            }
    //
    //        }
    //
    //    });
    
}

#pragma mark - Chats

-(void)SetDataAddGroupChat:(NSString *)homeID itemDict:(NSMutableDictionary *)itemDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Homes", @"GroupChats"] documents:@[homeID, itemDict[@"ChatID"]] type:@"Set;Merge:YES" setData:itemDict name:@"GetDataChats" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:@"GroupChats"] documentWithPath:itemDict[@"ChatID"]] setData:itemDict merge:YES completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

-(void)UpdateDataEditChat:(NSDictionary *)setDataDict itemID:(NSString *)itemID collection:(NSString *)collection homeID:(NSString *)homeID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    if ([itemID length] == 0) {
        itemID = @"xxx";
    }
    if ([homeID length] == 0) {
        homeID = @"xxx";
    }
    if ([collection length] == 0) {
        collection = @"xxx";
    }
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Homes", collection] documents:@[homeID, itemID] type:@"UpdateData;" setData:setDataDict name:@"UpdateDataEditChat" queryID:queryID];
    
    [[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:collection] documentWithPath:itemID] updateData:setDataDict completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

-(void)UpdateDataChatAssignedToArrayArray:(NSString *)collection homeID:(NSString *)homeID itemID:(NSString *)itemID itemAssignedTo:(NSMutableArray *)itemAssignedTo completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Homes", collection, @"Chats"] documents:@[homeID, homeID, itemID] type:@"UpdateData;" setData:@{@"ChatAssignedTo" : itemAssignedTo} name:@"UpdateDataChatAssignedToArrayArray" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:collection] documentWithPath:homeID] collectionWithPath:@"Chats"] documentWithPath:itemID] updateData:@{@"ChatAssignedTo" : itemAssignedTo} completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

-(void)UpdateDataUpdateGroupChatsAssignedToNewHomeMembersInSpecificHome:(NSString *)homeID userToAdd:(NSString *)userToAdd completionHandler:(void (^)(BOOL finished))finishBlock {
    
    [[[GetDataObject alloc] init] GetDataChatsAssignedToNewHomeMembersInSpecificHome:@"GroupChats" homeID:homeID completionHandler:^(BOOL finished, FIRQuerySnapshot * _Nonnull snapshot) {
        
        if (snapshot.documents.count == 0) {
            
            finishBlock(YES);
            
        } else {
            
            __block NSMutableArray *objectArr = [NSMutableArray array];
            
            NSMutableArray *snapshotDocuments = [NSMutableArray array];
            
            for (FIRDocumentSnapshot *doc in snapshot.documents) {
                
                //                if ([doc.data[@"ChatAssignedTo"] containsObject:userToAdd] == NO) {
                
                [snapshotDocuments addObject:doc];
                
                //                }
                
            }
            
            if (snapshotDocuments.count == 0) {
                
                finishBlock(YES);
                
            } else {
                
                for (FIRDocumentSnapshot *doc in snapshotDocuments) {
                    
                    __block int totalQueries = 1;
                    __block int completedQueries = 0;
                    
                    NSMutableArray *updatedItemAssignedTo = [[[SetDataObject alloc] init] GenerateUpdatedItemAssignedToArrayForFIRDocument:doc userID:userToAdd assignedToKey:@"ChatAssignedTo"];
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        
                        NSString *itemID = doc.data[@"ChatID"] ? doc.data[@"ChatID"] : @"";
                        
                        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"chatID == %@", itemID];
                        [[[SetDataObject alloc] init] SetDataEditCoreData:@"GroupChats" predicate:predicate setDataObject:@{@"ChatAssignedTo" : updatedItemAssignedTo}];
                        
                        [[[SetDataObject alloc] init] UpdateDataChatAssignedToArrayArray:@"GroupChats" homeID:homeID itemID:itemID itemAssignedTo:updatedItemAssignedTo completionHandler:^(BOOL finished) {
                            
                            if (totalQueries == (completedQueries+=1)) {
                                
                                if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:[snapshotDocuments mutableCopy] objectArr:objectArr]) {
                                    
                                    finishBlock(YES);
                                    
                                }
                                
                            }
                            
                        }];
                        
                    });
                    
                }
                
            }
            
        }
        
    }];
    
}

#pragma mark - Crashes

-(void)SetDataCrash:(void (^)(BOOL finished))finishBlock {
    
    BOOL isSimulator;
    
#if TARGET_OS_SIMULATOR
    isSimulator = YES;
#else
    isSimulator = NO;
#endif
    
    BOOL UserIsValid = [[[SetDataObject alloc] init] UserisValid:isSimulator];
    BOOL AppCrashed = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppCrashedReported"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppCrashedReported"] isEqualToString:@"Yes"] : NO;
    
    if (AppCrashed == YES && UserIsValid == YES) {
        
        NSString *randomID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString] ? [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString] : @"UnknownRandomID";
        
        NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
        
        NSMutableDictionary *crashActions = [[NSUserDefaults standardUserDefaults] objectForKey:@"CrashActions"] ?
        [[[NSUserDefaults standardUserDefaults] objectForKey:@"CrashActions"] mutableCopy] : [NSMutableDictionary dictionary];
        
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]  : @"UnknownUser";
        
        NSString *crashDatePosted = [[[GeneralObject alloc] init] GenerateCurrentDateString] ? [[[GeneralObject alloc] init] GenerateCurrentDateString] : @"UnknownCrashDatePosted";
        
        [dataDict setObject:randomID forKey:@"CrashID"];
        [dataDict setObject:crashActions forKey:@"CrashActions"];
        [dataDict setObject:crashDatePosted forKey:@"CrashDatePosted"];
        [dataDict setObject:userID forKey:@"CrashSubmittedBy"];
        [dataDict setObject:@"6.5.98" forKey:@"CrashAppVersion"];
        
        [[[SetDataObject alloc] init] SetDataCrashData:dataDict completionHandler:^(BOOL finished) {
            
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"AppCrashedReported"];
            
            finishBlock(YES);
            
        }];
        
    } else if (UserIsValid == NO) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"AppCrashed"];
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"AppCrashedReported"];
        
        finishBlock(YES);
        
    }
    
}

-(void)SetDataCrashData:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *crashID = dataDict[@"CrashID"] ? dataDict[@"CrashID"] : @"UnknownCrashID";
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Crashes", @"Crashes"] documents:@[@"Crashes", crashID] type:@"Set;Merge:YES" setData:dataDict name:@"SetDataCrashData" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Crashes"] documentWithPath:@"Crashes"] collectionWithPath:@"Crashes"] documentWithPath:crashID] setData:dataDict merge:YES completion:^(NSError * _Nullable error) {
        
        finishBlock(YES);
        
    }];
    
}

#pragma mark - Drafts

-(void)SetDataAddDraft:(NSString *)draftCreatedBy draftID:(NSString *)draftID setDataDict:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Users", @"Drafts"] documents:@[draftCreatedBy, draftID] type:@"Set;Merge:YES" setData:setDataDict name:@"SetDataAddDraft" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Users"] documentWithPath:draftCreatedBy] collectionWithPath:@"Drafts"] documentWithPath:draftID] setData:setDataDict merge:YES completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

-(void)UpdateDataDraft:(NSString *)draftCreatedBy draftID:(NSString *)draftID setDataDict:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Users", @"Drafts"] documents:@[draftCreatedBy, draftID] type:@"Set;Merge:YES" setData:setDataDict name:@"UpdateDataDraft" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Users"] documentWithPath:draftCreatedBy] collectionWithPath:@"Drafts"] documentWithPath:draftID] updateData:setDataDict completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

#pragma mark - FAQ

-(void)SetDataFAQ:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *FAQID = dataDict[@"FAQID"] ? dataDict[@"FAQID"] : @"UnknownFAQID";
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"FAQ"] documents:@[FAQID] type:@"Set;Merge:YES" setData:dataDict name:@"SetDataFAQ" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore collectionWithPath:@"FAQ"] documentWithPath:FAQID] setData:dataDict merge:YES completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

#pragma mark - Folders

-(void)SetDataAddFolder:(NSString *)folderCreatedBy folderID:(NSString *)folderID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Users", @"Folders"] documents:@[folderCreatedBy, folderID] type:@"Set;Merge:YES" setData:dataDict name:@"SetDataAddFolder" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Users"] documentWithPath:folderCreatedBy] collectionWithPath:@"Folders"] documentWithPath:folderID] setData:dataDict merge:YES completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

-(void)UpdateDataFolder:(NSString *)folderCreatedBy folderID:(NSString *)folderID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Users", @"Folders"] documents:@[folderCreatedBy, folderID] type:@"Set;Merge:YES" setData:dataDict name:@"UpdateDataFolder" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Users"] documentWithPath:folderCreatedBy] collectionWithPath:@"Folders"] documentWithPath:folderID] updateData:dataDict completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

#pragma mark - Forum

-(void)SetDataAddForum:(NSString *)collection forumID:(NSString *)forumID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Forum", collection] documents:@[collection, forumID] type:@"Set;Merge:YES" setData:dataDict name:@"SetDataAddForum" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Forum"] documentWithPath:collection] collectionWithPath:collection] documentWithPath:forumID] setData:dataDict merge:YES completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

-(void)UpdateDataAddForum:(NSString *)collection forumID:(NSString *)forumID dataDict:(NSDictionary *)dataDict {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Forum", collection] documents:@[collection, forumID] type:@"Set;Merge:YES" setData:dataDict name:@"UpdateDataAddForum" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Forum"] documentWithPath:collection] collectionWithPath:collection] documentWithPath:forumID] updateData:dataDict completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
    }];
    
}

#pragma mark - Homes

-(void)SetDataAddHome:(NSString *)homeID homeDict:(NSDictionary *)homeDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Homes"] documents:@[homeID] type:@"Set;Merge:YES" setData:homeDict name:@"SetDataAddHome" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] setData:homeDict merge:YES completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

-(void)SetDataHomeImage:(UIImage *)profileImage homeID:(NSString *)homeID completionHandler:(void (^)(BOOL finished, NSString *homeImageURL))finishBlock {
    
    __block NSString *profileImageURL;
    
    NSData *imgData = UIImageJPEGRepresentation(profileImage, 0.15);
    
    FIRStorage *storage = [FIRStorage storage];
    
    FIRStorageReference *storageRef = [storage reference];
    
    FIRStorageReference *mountainsRef = [[[[storageRef child:@"HomeImages"] child:homeID] child:@"ProfileImage"] child:@"ProfileImage.jpeg"];
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"HomeImages", homeID, @"ProfileImage", @"ProfileImage.jpeg"] documents:@[] type:@"PutData" setData:@{@"Data" : imgData} name:@"SetDataHomeImage" queryID:queryID];
    
    [mountainsRef putData:imgData
                 metadata:nil
               completion:^(FIRStorageMetadata *metadata,
                            NSError *error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        if (error != nil) {
            
            profileImageURL = @"xxx";
            
            finishBlock(YES, profileImageURL);
            
        } else {
            
            [mountainsRef downloadURLWithCompletion:^(NSURL * _Nullable URL, NSError * _Nullable error) {
                
                profileImageURL = URL.absoluteString;
                
                finishBlock(YES, profileImageURL);
                
            }]; //downloadURLWithCompletion
            
        } //else
        
    }]; //FIRStorageUploadTask
    
}

-(void)UpdateDataHome:(NSString *)homeID homeDict:(NSDictionary *)homeDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Homes"] documents:@[homeID] type:@"Set;Merge:YES" setData:homeDict name:@"UpdateDataHome" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] updateData:homeDict completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

#pragma mark - Messages

-(void)SetDataAddMessage:(NSDictionary *)dataDict userID:(NSString *)userID homeID:(NSString *)homeID itemType:(NSString *)itemType itemID:(NSString *)itemID chatID:(NSString *)chatID viewingGroupChat:(BOOL)viewingGroupChat viewingComments:(BOOL)viewingComments viewingLiveSupport:(BOOL)viewingLiveSupport completionHandler:(void (^)(BOOL finished))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    if (viewingComments == YES) {
        
        NSString *collection = [NSString stringWithFormat:@"%@s", itemType];
        
        NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
        
        [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Homes", collection, @"Comments"] documents:@[homeID, itemID, dataDict[@"MessageID"]] type:@"Set;Merge:YES" setData:dataDict name:@"SetDataAddMessage" queryID:queryID];
        
        [[[[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:collection] documentWithPath:itemID] collectionWithPath:@"Comments"] documentWithPath:dataDict[@"MessageID"]] setData:dataDict merge:YES completion:^(NSError * _Nullable error) {
            
            [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
            
            finishBlock(YES);
            
        }];
        
    } else if (viewingGroupChat == YES) {
        
        NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
        
        [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Homes", @"GroupChats", @"Messages"] documents:@[homeID, chatID, dataDict[@"MessageID"]] type:@"Set;Merge:YES" setData:dataDict name:@"SetDataAddMessage" queryID:queryID];
        
        [[[[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:@"GroupChats"] documentWithPath:chatID] collectionWithPath:@"Messages"] documentWithPath:dataDict[@"MessageID"]] setData:dataDict merge:YES completion:^(NSError * _Nullable error) {
            
            [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
            
            finishBlock(YES);
            
        }];
        
    } else if (viewingLiveSupport == YES) {
        
        NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
        
        [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Users", @"LiveSupport"] documents:@[userID, dataDict[@"MessageID"]] type:@"Set;Merge:YES" setData:dataDict name:@"SetDataAddMessage" queryID:queryID];
        
        [[[[[defaultFirestore collectionWithPath:@"Users"] documentWithPath:userID] collectionWithPath:@"LiveSupport"] documentWithPath:dataDict[@"MessageID"]] setData:dataDict merge:YES completion:^(NSError * _Nullable error) {
            
            [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
            
            finishBlock(YES);
            
        }];
        
    }
    
}

-(void)SetDataMessageRead:(NSString *)userID homeID:(NSString *)homeID itemType:(NSString *)itemType itemID:(NSString *)itemID chatID:(NSString *)chatID messageDict:(NSMutableDictionary *)messageDict viewingGroupChat:(BOOL)viewingGroupChat viewingComments:(BOOL)viewingComments viewingLiveSupport:(BOOL)viewingLiveSupport completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningMessageDict))finishBlock {
    
    if ([(NSArray *)messageDict[@"MessageID"] count] == 0) {
        
        finishBlock(YES, messageDict);
        
    } else {
        
        NSMutableArray *objectArr = [NSMutableArray array];
        
        for (NSString *messageID in messageDict[@"MessageID"]) {
            
            NSUInteger index = [messageDict[@"MessageID"] indexOfObject:messageID];
            
            NSMutableArray *oldMmessageReadArray = messageDict[@"MessageRead"] && [(NSArray *)messageDict[@"MessageRead"] count] > index ? [messageDict[@"MessageRead"][index] mutableCopy] : [NSMutableArray array];
            
            BOOL OldMessageReadArrayAlreadyContainsUserID = [oldMmessageReadArray containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
            
            if (OldMessageReadArrayAlreadyContainsUserID == NO) {
                
                messageDict = [[[[SetDataObject alloc] init] GenerateMessageDictWithUpdatedMessageReadArray:[messageDict mutableCopy] messageID:messageID] mutableCopy];
                
            }
            
            NSMutableArray *messageReadArray = messageDict[@"MessageRead"] && [(NSArray *)messageDict[@"MessageRead"] count] > index ? [messageDict[@"MessageRead"][index] mutableCopy] : [NSMutableArray array];
            
            if ((viewingGroupChat == YES || viewingComments == YES) && 
                OldMessageReadArrayAlreadyContainsUserID == NO &&
                (chatID.length > 0 && messageID.length > 0)) {
                
                [[[SetDataObject alloc] init] UpdateDataGroupChatMessageReadArray:homeID itemID:itemID itemType:itemType chatID:chatID messageID:messageID messageReadArray:messageReadArray viewingGroupChat:viewingGroupChat viewingComments:viewingComments viewingLiveSupport:viewingLiveSupport completionHandler:^(BOOL finished) {
                    
                    if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:[messageDict[@"MessageID"] mutableCopy] objectArr:objectArr]) {
                        
                        finishBlock(YES, messageDict);
                        
                    }
                    
                }];
                
            } else if (viewingLiveSupport == YES &&
                       OldMessageReadArrayAlreadyContainsUserID == NO &&
                       messageID.length > 0) {
                
                [[[SetDataObject alloc] init] UpdateDataLiveSupportMessageReadArray:userID messageID:messageID messageReadArray:messageReadArray completionHandler:^(BOOL finished) {
                    
                    if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:[messageDict[@"MessageID"] mutableCopy] objectArr:objectArr]) {
                        
                        finishBlock(YES, messageDict);
                        
                    }
                    
                }];
                
            } else {
                
                if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:[messageDict[@"MessageID"] mutableCopy] objectArr:objectArr]) {
                    
                    finishBlock(YES, messageDict);
                    
                }
                
            }
            
        }
        
    }
    
}

-(void)SetDataMessageImage:(NSString *)homeID messageID:(NSString *)messageID messageImage:(UIImage *)messageImage completionHandler:(void (^)(BOOL finished, NSString *imageURL))finishBlock {
    
    __block NSString *imageURL;
    
    if (messageImage == nil) {
        
        imageURL = @"xxx";
        
        finishBlock(YES, imageURL);
        
    } else {
        
        NSData *imgData = UIImageJPEGRepresentation(messageImage, 0.15);
        
        FIRStorage *storage = [FIRStorage storage];
        
        FIRStorageReference *storageRef = [storage reference];
        
        FIRStorageReference *mountainsRef = [[[[storageRef child:@"MessageImages"] child:homeID] child:messageID] child:@"MessageImage.jpeg"];
        
        NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
        [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"MessageImages", homeID, messageID, @"MessageImage.jpeg"] documents:@[] type:@"PutData" setData:@{@"Data" : imgData} name:@"SetDataMessageImage" queryID:queryID];
        
        [mountainsRef putData:imgData
                     metadata:nil
                   completion:^(FIRStorageMetadata *metadata,
                                NSError *error) {
            
            [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
            
            if (error != nil) {
                
                imageURL = @"xxx";
                
                finishBlock(YES, imageURL);
                
                NSLog(@"updateUserProfileImage - The error is %@", error.localizedDescription);
                
            } else {
                
                [mountainsRef downloadURLWithCompletion:^(NSURL * _Nullable URL, NSError * _Nullable error) {
                    
                    imageURL = URL.absoluteString;
                    
                    finishBlock(YES, imageURL);
                    
                }]; //downloadURLWithCompletion
                
            } //else
            
        }]; //FIRStorageUploadTask
        
    }
    
}

-(void)SetDataMessageVideo:(NSString *)homeID messageID:(NSString *)messageID messageVideoData:(NSData *)messageVideoData completionHandler:(void (^)(BOOL finished, NSString *videoURL, UIImage *videoImage))finishBlock {
    
    __block NSString *videoURL;
    
    if (messageVideoData == nil) {
        
        videoURL = @"xxx";
        
        finishBlock(YES, videoURL, nil);
        
    } else {
        
        FIRStorage *storage = [FIRStorage storage];
        
        FIRStorageReference *storageRef = [storage reference];
        
        FIRStorageReference *mountainsRef = [[[[storageRef child:@"MessageImages"] child:homeID] child:messageID] child:@"MessageVideo.mp4"];
        
        FIRStorageUploadTask *uploadTask;
        
        FIRStorageMetadata *metadata = [[FIRStorageMetadata alloc] init];
        metadata.contentType = @"movie/mp4";
        
        NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
        [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"MessageImages", homeID, messageID, @"MessageVideo.mp4"] documents:@[] type:@"PutData" setData:@{@"Data" : messageVideoData, @"ContentType" : @"movie/mp4"} name:@"SetDataMessageImage" queryID:queryID];
        
        uploadTask = [mountainsRef putData:messageVideoData
                                  metadata:nil
                                completion:^(FIRStorageMetadata *metadata,
                                             NSError *error) {
            
            [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
            
            metadata.contentType = @"movie/mp4";
            
            if (error != nil) {
                
                videoURL = @"xxx";
                
                finishBlock(YES, videoURL, nil);
                
                NSLog(@"updateUserProfileImage - The error is %@", error.localizedDescription);
                
            } else {
                
                [mountainsRef downloadURLWithCompletion:^(NSURL * _Nullable URL, NSError * _Nullable error) {
                    
                    videoURL = URL.absoluteString;
                    
                    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:videoURL] options:nil];
                    AVAssetImageGenerator *imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:asset];
                    UIImage *videoImage = [UIImage imageWithCGImage:[imageGenerator copyCGImageAtTime:CMTimeMake(0, 1) actualTime:nil error:nil]];
                    
                    finishBlock(YES, videoURL, videoImage);
                    
                }]; //downloadURLWithCompletion
                
            } //else
            
        }]; //FIRStorageUploadTask
        
    }
    
}

#pragma mark - Notifications

-(void)SetDataNotification:(NSString *)homeID notificationTitle:(NSString *)notificationTitle notificationBody:(NSString *)notificationBody notificationItemID:(NSString *)notificationItemID notificationItemOccurrenceID:(NSString *)notificationItemOccurrenceID notificationItemCollection:(NSString *)notificationItemCollection homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    NSMutableArray *notificationRead = [NSMutableArray array];
    [notificationRead addObject:userID];
    
    for (NSString *userID in homeMembersDict[@"UserID"]) {
        
        BOOL UserCanReceiveNotification = [[[BoolDataObject alloc] init] UserCanReceiveNotification:notificationSettingsDict userID:userID notificationItemType:notificationItemType notificationType:notificationType];
        
        if (UserCanReceiveNotification == NO) {
            
            [notificationRead addObject:userID];
            
        }
        
    }
    
    NSString *notificationID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    NSString *notificationDateCreated = [[[GeneralObject alloc] init] GenerateCurrentDateString];
    
    NSDictionary *setDataDict = @{
        @"NotificationID" : notificationID,
        @"NotificationDateCreated" : notificationDateCreated,
        @"NotificationCreatedBy" : userID,
        @"NotificationTitle" : notificationTitle,
        @"NotificationBody" : notificationBody,
        @"NotificationRead" : notificationRead,
        @"NotificationHomeID" : homeID,
        @"NotificationItemID" : notificationItemID,
        @"NotificationItemOccurrenceID" : notificationItemOccurrenceID,
        @"NotificationItemCollection" : notificationItemCollection
    };
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Homes", @"Notifications"] documents:@[homeID, notificationID] type:@"Set;Merge:YES" setData:setDataDict name:@"SetDataNotification" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];

    [[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:@"Notifications"] documentWithPath:notificationID] setData:setDataDict merge:YES completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

-(void)UpdateDataNotification:(NSString *)homeID notificationID:(NSString *)notificationID notificationReadArray:(NSMutableArray *)notificationReadArray completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Homes", @"Notifications"] documents:@[homeID, notificationID] type:@"UpdateData;" setData:@{@"NotificationRead" : notificationReadArray} name:@"UpdateDataNotification" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:@"Notifications"] documentWithPath:notificationID] updateData:@{@"NotificationRead" : notificationReadArray} completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

#pragma mark - Promotional Codes

-(void)SetDataPromotionalCode:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"PromotionalCodes"] documents:@[dataDict[@"PromotionalCodeID"]] type:@"Set;Merge:YES" setData:dataDict name:@"SetDataPromotionalCode" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore
       collectionWithPath:@"PromotionalCodes"]
      documentWithPath:dataDict[@"PromotionalCodeID"]]
     setData:dataDict merge:YES completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

-(void)UpdateDataPromotionalCodeUsed:(NSString *)promotionalCodeID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"PromotionalCodes"] documents:@[promotionalCodeID] type:@"UpdateData;" setData:dataDict name:@"UpdateDataPromotionalCodeUsed" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore
       collectionWithPath:@"PromotionalCodes"]
      documentWithPath:promotionalCodeID]
     updateData:dataDict completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

#pragma mark - Reported Crashes

-(void)SetDataReportedCrash:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *reportedCrashID = dataDict[@"ReportedCrashID"];
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Crashes", @"ReportedCrashes"] documents:@[@"ReportedCrashes", reportedCrashID] type:@"Set;Merge:YES" setData:dataDict name:@"SetDataReportedCrash" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Crashes"] documentWithPath:@"ReportedCrashes"] collectionWithPath:@"ReportedCrashes"] documentWithPath:reportedCrashID] setData:dataDict merge:YES completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

#pragma mark - Sections

-(void)SetDataAddSection:(NSString *)sectionCreatedBy sectionID:(NSString *)sectionID setDataDict:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Users", @"Sections"] documents:@[sectionCreatedBy, sectionID] type:@"Set;Merge:YES" setData:setDataDict name:@"SetDataAddSection" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Users"] documentWithPath:sectionCreatedBy] collectionWithPath:@"Sections"] documentWithPath:sectionID] setData:setDataDict merge:YES completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

-(void)UpdateDataSection:(NSString *)sectionCreatedBy sectionID:(NSString *)sectionID setDataDict:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Users", @"Sections"] documents:@[sectionCreatedBy, sectionID] type:@"Set;Merge:YES" setData:setDataDict name:@"SetDataReportedCrash" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Users"] documentWithPath:sectionCreatedBy] collectionWithPath:@"Sections"] documentWithPath:sectionID] updateData:setDataDict completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

#pragma mark - Survey/Feedback/Premium Feedback/Premium Cancelled Feedback

-(void)SetDataSurvey:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    BOOL isSimulator;
    
#if TARGET_OS_SIMULATOR
    isSimulator = YES;
#else
    isSimulator = NO;
#endif
    
    BOOL UserIsValid = [[[SetDataObject alloc] init] UserisValid:isSimulator];
    
    if (UserIsValid == YES) {
        
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
        
        NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
        [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Survey"] documents:@[userID] type:@"Set;Merge:YES" setData:dataDict name:@"SetDataSurvey" queryID:queryID];
        
        FIRFirestore *defaultFirestore = [FIRFirestore firestore];
        
        [[[defaultFirestore collectionWithPath:@"Survey"] documentWithPath:userID] setData:dataDict merge:YES completion:^(NSError * _Nullable error) {
            
            [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
            
            finishBlock(YES);
            
        }];
        
    } else {
        
        finishBlock(YES);
        
    }
    
}

-(void)SetDataFeedback:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *feedbackID = dataDict[@"FeedbackID"];
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Feedback", @"Feedback"] documents:@[@"Feedback", feedbackID] type:@"Set;Merge:YES" setData:dataDict name:@"SetDataFeedback" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Feedback"] documentWithPath:@"Feedback"] collectionWithPath:@"Feedback"] documentWithPath:feedbackID] setData:dataDict merge:YES completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

-(void)SetDataPremiumFeedback:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *feedbackID = dataDict[@"FeedbackID"];
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Feedback", @"PremiumFeedback"] documents:@[@"PremiumFeedback", feedbackID] type:@"Set;Merge:YES" setData:dataDict name:@"SetDataPremiumFeedback" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Feedback"] documentWithPath:@"PremiumFeedback"] collectionWithPath:@"PremiumFeedback"] documentWithPath:feedbackID] setData:dataDict merge:YES completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

-(void)SetDataPremiumCancelledFeedback:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *feedbackID = dataDict[@"FeedbackID"];
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Feedback", @"PremiumCancelledFeedback"] documents:@[@"PremiumCancelledFeedback", feedbackID] type:@"Set;Merge:YES" setData:dataDict name:@"SetDataPremiumCancelledFeedback" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Feedback"] documentWithPath:@"PremiumCancelledFeedback"] collectionWithPath:@"PremiumCancelledFeedback"] documentWithPath:feedbackID] setData:dataDict merge:YES completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

-(void)UpdateDataFeedback:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *feedbackID = dataDict[@"FeedbackID"];
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Feedback", @"Feedback"] documents:@[@"Feedback", feedbackID] type:@"Set;Merge:YES" setData:dataDict name:@"UpdateDataFeedback" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Feedback"] documentWithPath:@"Feedback"] collectionWithPath:@"Feedback"] documentWithPath:feedbackID] updateData:dataDict completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

#pragma mark - Subscriptions

-(void)SetDataSubscription:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore
       collectionWithPath:@"Subscriptions"]
      documentWithPath:dataDict[@"SubscriptionID"]]
     setData:dataDict completion:^(NSError * _Nullable error) {
        
        finishBlock(YES, error);
        
    }];
    
}

-(void)UpdateDataSubscription:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Subscriptions"] documents:@[dataDict[@"SubscriptionID"]] type:@"UpdateData;" setData:dataDict name:@"UpdateDataSubscription" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore
       collectionWithPath:@"Subscriptions"]
      documentWithPath:dataDict[@"SubscriptionID"]]
     updateData:dataDict completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES, error);
        
    }];
    
}

-(void)UpdateDataSubscriptionCancelled:(NSString *)subscriptionCancelled subscriptionDateCancelled:(NSString *)subscriptionDateCancelled purchasingUsersUserID:(NSString *)purchasingUsersUserID homeMembersDict:(NSMutableDictionary *)homeMembersDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *subscriptionID = @"";
    
    BOOL HomeMembersDictIsNotValid = (!homeMembersDict || (homeMembersDict && [(NSArray *)homeMembersDict[@"UserID"] count] == 0));
    
    if (HomeMembersDictIsNotValid) {
        finishBlock(YES);
    } else {
        
        //Find Index Of Old Purchasing User
        NSMutableArray *userIDArray =
        homeMembersDict && homeMembersDict[@"UserID"] ?
        homeMembersDict[@"UserID"] : [NSMutableArray array];
        
        NSUInteger indexOfPurchasingUser =
        [userIDArray containsObject:purchasingUsersUserID] ?
        [userIDArray indexOfObject:purchasingUsersUserID] : 1000;
        
        if (indexOfPurchasingUser == 1000) {
            finishBlock(YES);
        } else {
            
            //Find Old Purchasing Users WeDivvy Premium Subscription ID
            __block NSMutableDictionary *tempHomeMembersDict =
            homeMembersDict ?
            [homeMembersDict mutableCopy] : [NSMutableDictionary dictionary];
            
            NSMutableArray *tempWeDivvyPremiumArray =
            tempHomeMembersDict && tempHomeMembersDict[@"WeDivvyPremium"] ?
            [tempHomeMembersDict[@"WeDivvyPremium"] mutableCopy] : [NSMutableArray array];
            
            subscriptionID =
            tempWeDivvyPremiumArray && [tempWeDivvyPremiumArray count] > indexOfPurchasingUser &&
            tempWeDivvyPremiumArray[indexOfPurchasingUser][@"SubscriptionHistory"] &&
            tempWeDivvyPremiumArray[indexOfPurchasingUser][@"SubscriptionHistory"][@"SubscriptionID"] ?
            [tempWeDivvyPremiumArray[indexOfPurchasingUser][@"SubscriptionHistory"][@"SubscriptionID"] mutableCopy] : @"";
            
        }
        
        if (subscriptionID.length > 0) {
            
            NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
            [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Subscriptions"] documents:@[subscriptionID] type:@"UpdateData;" setData:@{@"SubscriptionCancelled" : subscriptionCancelled, @"SubscriptionDateCancelled" : subscriptionDateCancelled} name:@"UpdateDataSubscriptionCancelled" queryID:queryID];
            
            FIRFirestore *defaultFirestore = [FIRFirestore firestore];
            
            [[[defaultFirestore
               collectionWithPath:@"Subscriptions"]
              documentWithPath:subscriptionID]
             updateData:@{@"SubscriptionCancelled" : subscriptionCancelled, @"SubscriptionDateCancelled" : subscriptionDateCancelled} completion:^(NSError * _Nullable error) {
                
                [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
                
                finishBlock(YES);
                
            }];
            
        } else {
            
            finishBlock(YES);
            
        }
        
    }
    
}

-(void)UpdateDataSubscriptionLastDateOpenned:(NSString *)subscriptionDateLastOpenned purchasingUsersUserID:(NSString *)purchasingUsersUserID homeMembersDict:(NSMutableDictionary *)homeMembersDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *subscriptionID = @"";
    
    BOOL HomeMembersDictIsNotValid = (!homeMembersDict || (homeMembersDict && [(NSArray *)homeMembersDict[@"UserID"] count] == 0));
    
    if (HomeMembersDictIsNotValid) {
        finishBlock(YES);
    } else {
        
        //Find Index Of Old Purchasing User
        NSMutableArray *userIDArray =
        homeMembersDict && homeMembersDict[@"UserID"] ?
        homeMembersDict[@"UserID"] : [NSMutableArray array];
        
        NSUInteger indexOfPurchasingUser =
        [userIDArray containsObject:purchasingUsersUserID] ?
        [userIDArray indexOfObject:purchasingUsersUserID] : 1000;
        
        if (indexOfPurchasingUser == 1000) {
            finishBlock(YES);
        } else {
            
            //Find Old Purchasing Users WeDivvy Premium Subscription ID
            __block NSMutableDictionary *tempHomeMembersDict =
            homeMembersDict ?
            [homeMembersDict mutableCopy] : [NSMutableDictionary dictionary];
            
            NSMutableArray *tempWeDivvyPremiumArray =
            tempHomeMembersDict && tempHomeMembersDict[@"WeDivvyPremium"] ?
            [tempHomeMembersDict[@"WeDivvyPremium"] mutableCopy] : [NSMutableArray array];
            
            subscriptionID =
            tempWeDivvyPremiumArray && [tempWeDivvyPremiumArray count] > indexOfPurchasingUser &&
            tempWeDivvyPremiumArray[indexOfPurchasingUser][@"SubscriptionHistory"] &&
            tempWeDivvyPremiumArray[indexOfPurchasingUser][@"SubscriptionHistory"][@"SubscriptionID"] ?
            [tempWeDivvyPremiumArray[indexOfPurchasingUser][@"SubscriptionHistory"][@"SubscriptionID"] mutableCopy] : @"";
            
        }
        
        if (subscriptionID.length > 0) {
            
            NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
            [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Subscriptions"] documents:@[subscriptionID] type:@"UpdateData;" setData:@{@"SubscriptionDateLastOpenned" : subscriptionDateLastOpenned} name:@"UpdateDataSubscriptionLastDateOpenned" queryID:queryID];
            
            FIRFirestore *defaultFirestore = [FIRFirestore firestore];
            
            [[[defaultFirestore
               collectionWithPath:@"Subscriptions"]
              documentWithPath:subscriptionID]
             updateData:@{@"SubscriptionDateLastOpenned" : subscriptionDateLastOpenned} completion:^(NSError * _Nullable error) {
                
                [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
                
                finishBlock(YES);
                
            }];
            
        } else {
            
            finishBlock(YES);
            
        }
        
    }
    
}

#pragma mark - Task Lists

-(void)SetDataAddTaskList:(NSString *)taskListCreatedBy taskListID:(NSString *)taskListID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    if (taskListCreatedBy.length == 0) {
        taskListCreatedBy = @"xxx";
    }
    if (taskListID.length == 0) {
        taskListID = @"xxx";
    }
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Users", @"TaskLists"] documents:@[taskListCreatedBy, taskListID] type:@"Set;Merge:YES" setData:dataDict name:@"SetDataAddTaskList" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Users"] documentWithPath:taskListCreatedBy] collectionWithPath:@"TaskLists"] documentWithPath:taskListID] setData:dataDict merge:YES completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}
 
-(void)UpdateDataTaskList:(NSString *)taskListCreatedBy taskListID:(NSString *)taskListID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    if (taskListCreatedBy.length == 0) {
        taskListCreatedBy = @"xxx";
    }
    if (taskListID.length == 0) {
        taskListID = @"xxx";
    }
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Users", @"TaskLists"] documents:@[taskListCreatedBy, taskListID] type:@"Set;Merge:YES" setData:dataDict name:@"UpdateDataTaskList" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Users"] documentWithPath:taskListCreatedBy] collectionWithPath:@"TaskLists"] documentWithPath:taskListID] updateData:dataDict completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

#pragma mark - Templates

-(void)SetDataAddTemplate:(NSString *)templateCreatedBy templateID:(NSString *)templateID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Users", @"Templates"] documents:@[templateCreatedBy, templateID] type:@"Set;Merge:YES" setData:dataDict name:@"SetDataAddTemplate" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Users"] documentWithPath:templateCreatedBy] collectionWithPath:@"Templates"] documentWithPath:templateID] setData:dataDict merge:YES completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

-(void)UpdateDataTemplate:(NSString *)templateCreatedBy templateID:(NSString *)templateID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Users", @"Templates"] documents:@[templateCreatedBy, templateID] type:@"Set;Merge:YES" setData:dataDict name:@"UpdateDataTemplate" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Users"] documentWithPath:templateCreatedBy] collectionWithPath:@"Templates"] documentWithPath:templateID] updateData:dataDict completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

#pragma mark - Topics

-(void)SetDataAddTopic:(NSString *)homeID topicID:(NSString *)topicID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    if ([topicID length] == 0) {
        topicID = @"xxx";
    }
    if ([homeID length] == 0) {
        homeID = @"xxx";
    }
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Homes", @"Topics"] documents:@[homeID, topicID] type:@"Set;Merge:YES" setData:dataDict name:@"SetDataAddTopic" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:@"Topics"] documentWithPath:topicID] setData:dataDict merge:YES completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

-(void)UpdateDataTopic:(NSString *)homeID topicID:(NSString *)topicID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    if ([topicID length] == 0) {
        topicID = @"xxx";
    }
    if ([homeID length] == 0) {
        homeID = @"xxx";
    }
   
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Users", @"Templates"] documents:@[homeID, topicID] type:@"Set;Merge:YES" setData:dataDict name:@"UpdateDataTopic" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:@"Topics"] documentWithPath:topicID] setData:dataDict merge:YES completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

#pragma mark - Compound Methods

-(void)SubscribeAndSetDataTopic:(NSString *)homeID topicID:(NSString *)topicID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    [[[GeneralObject alloc] init] AllGenerateTokenMethod:topicID Subscribe:YES GrantedNotifications:NO];
        
        [[[SetDataObject alloc] init] SetDataAddTopic:homeID topicID:topicID dataDict:dataDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
       
}

-(void)SubsribeOrUnsubscribeAndUpdateTopic:(NSString *)homeID topicID:(NSString *)topicID itemOccurrenceID:(NSString *)itemOccurrenceID dataDict:(NSDictionary *)dataDict SubscribeToTopic:(BOOL)SubscribeToTopic UnsubscribeFromTopic:(BOOL)UnsubscribeFromTopic completionHandler:(void (^)(BOOL finished))finishBlock {
    
    BOOL ItemIsAnOccurrence = itemOccurrenceID.length > 0;
    
    if (ItemIsAnOccurrence == NO) {
        
        if (SubscribeToTopic == YES) {
            
            [[[GeneralObject alloc] init] AllGenerateTokenMethod:topicID Subscribe:YES GrantedNotifications:NO];
            
        } else if (UnsubscribeFromTopic == YES) {
            
            [[[GeneralObject alloc] init] AllGenerateTokenMethod:topicID Subscribe:NO GrantedNotifications:NO];
            
        }
        
        [[[SetDataObject alloc] init] UpdateDataTopic:homeID topicID:topicID dataDict:dataDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    } else {
        
        finishBlock(YES);
        
    }
    
}

#pragma mark - Users

-(void)SetDataUserData:(NSString *)userID userDict:(NSDictionary *)userDict completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore
       collectionWithPath:@"Users"]
      documentWithPath:userID]
     setData:userDict merge:YES completion:^(NSError * _Nullable error) {
        
        finishBlock(YES, error);
        
    }];
    
}

-(void)SetDataProfileImage:(UIImage *)profileImage completionHandler:(void (^)(BOOL finished, NSString *profileImageURL))finishBlock {
    
    __block NSString *profileImageURL;
    
    NSData *imgData = UIImageJPEGRepresentation(profileImage, 0.15);
    
    FIRStorage *storage = [FIRStorage storage];
    
    FIRStorageReference *storageRef = [storage reference];
    
    FIRStorageReference *mountainsRef = [[[[storageRef child:@"UserImages"] child:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] child:@"ProfileImage"] child:@"ProfileImage.jpeg"];
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"UserImages", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], @"ProfileImage", @"ProfileImage.jpeg"] documents:@[] type:@"PutData" setData:@{@"Data" : imgData} name:@"SetDataProfileImage" queryID:queryID];
    
    [mountainsRef putData:imgData
                 metadata:nil
               completion:^(FIRStorageMetadata *metadata,
                            NSError *error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        if (error != nil) {
            
            profileImageURL = @"xxx";
            
            finishBlock(YES, profileImageURL);
            
            NSLog(@"updateUserProfileImage - The error is %@", error.localizedDescription);
            
        } else {
            
            [mountainsRef downloadURLWithCompletion:^(NSURL * _Nullable URL, NSError * _Nullable error) {
                
                profileImageURL = URL.absoluteString;
                
                finishBlock(YES, profileImageURL);
                
            }]; //downloadURLWithCompletion
            
        } //else
        
    }]; //FIRStorageUploadTask
    
}

-(void)SetDataNotificationSettings:(NSString *)userID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore
         collectionWithPath:@"Users"]
        documentWithPath:userID]
       collectionWithPath:@"NotificationSettings"]
      documentWithPath:userID]
     setData:dataDict completion:^(NSError * _Nullable error) {
        
        finishBlock(YES, error);
        
    }];
    
}

-(void)SetDataCalendarSettings:(NSString *)userID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore
         collectionWithPath:@"Users"]
        documentWithPath:userID]
       collectionWithPath:@"CalendarSettings"]
      documentWithPath:userID]
     setData:dataDict completion:^(NSError * _Nullable error) {
        
        finishBlock(YES, error);
        
    }];
    
}

-(void)SetDataNotificationOpen:(NSString *)userID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Users", @"NotificationOpens"] documents:@[userID, dataDict[@"NotificationOpenID"]] type:@"Set;Merge:YES" setData:dataDict name:@"UpdateDataNotificationOpen" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Users"]
        documentWithPath:userID]
       collectionWithPath:@"NotificationOpens"]
      documentWithPath:dataDict[@"NotificationOpenID"]]
     setData:dataDict merge:YES completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES, error);
        
    }];
    
}

-(void)UpdateDataUserData:(NSString *)userID userDict:(NSDictionary *)userDict completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Users"] documents:@[userID] type:@"UpdateData;" setData:userDict name:@"UpdateDataUserData" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore collectionWithPath:@"Users"]
      documentWithPath:userID]
     updateData:userDict completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES, error);
        
    }];
    
}

-(void)UpdateDataNotificationSettings:(NSString *)userID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Users", @"NotificationSettings"] documents:@[userID, userID] type:@"UpdateData;" setData:dataDict name:@"UpdateDataNotificationSettings" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore
         collectionWithPath:@"Users"]
        documentWithPath:userID]
       collectionWithPath:@"NotificationSettings"]
      documentWithPath:userID]
     updateData:dataDict completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES, error);
        
    }];
    
}

-(void)UpdateDataCalendarSettings:(NSString *)userID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Users", @"CalendarSettings"] documents:@[userID, userID] type:@"UpdateData;" setData:dataDict name:@"UpdateDataCalendarSettings" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore
         collectionWithPath:@"Users"]
        documentWithPath:userID]
       collectionWithPath:@"CalendarSettings"]
      documentWithPath:userID]
     updateData:dataDict completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES, error);
        
    }];
    
}

#pragma mark Compound Methods

-(void)UpdateDataWeDivvyPremiumUsersSelected:(NSMutableDictionary *)homeMembersDict oldHomeMembersDict:(NSMutableDictionary *)oldHomeMembersDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    BOOL HomeMembersDictIsNotValid = (!homeMembersDict || (homeMembersDict && [(NSArray *)homeMembersDict[@"UserID"] count] == 0));
    
    if (HomeMembersDictIsNotValid) {
        finishBlock(YES);
    } else {
        
        NSMutableArray *objectArr = [NSMutableArray array];
        
        for (NSString *userID in homeMembersDict[@"UserID"]) {
            
            
            
            //Get Index Of Current User
            NSUInteger indexOfCurrentUserID = homeMembersDict && homeMembersDict[@"UserID"] && [homeMembersDict[@"UserID"] containsObject:userID] ? [homeMembersDict[@"UserID"] indexOfObject:userID] : -1;
            
            if (indexOfCurrentUserID != -1 && [userID length] != 0) {
                
                
                
                //Get WeDivvy Premium Dict Of Current User
                NSDictionary *weDivvyPremium = homeMembersDict && homeMembersDict[@"WeDivvyPremium"] && [(NSArray *)homeMembersDict[@"WeDivvyPremium"] count] > indexOfCurrentUserID ? homeMembersDict[@"WeDivvyPremium"][indexOfCurrentUserID] : [[[GeneralObject alloc] init] GenerateDefaultWeDivvyPremiumPlan];
                
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID == %@", userID];
                [[[SetDataObject alloc] init] SetDataAddCoreData:@"Users" predicate:predicate setDataObject:[@{@"WeDivvyPremium" : weDivvyPremium} mutableCopy]];
                
                [[[SetDataObject alloc] init] UpdateDataUserData:userID userDict:@{@"WeDivvyPremium" : weDivvyPremium} completionHandler:^(BOOL finished, NSError * _Nonnull error) {
                    
                    
                    
                    //Get Notification Details For Current User
                    NSString *notificationTitle = @"";
                    NSString *notificationBody = @"";
                    
                    NSUInteger oldIndexOfCurrentUserID = homeMembersDict && homeMembersDict[@"UserID"] && [homeMembersDict[@"UserID"] containsObject:userID] ? [homeMembersDict[@"UserID"] indexOfObject:userID] : -1;
                    NSDictionary *oldWeDivvyPremium = oldHomeMembersDict && oldHomeMembersDict[@"WeDivvyPremium"] && [(NSArray *)oldHomeMembersDict[@"WeDivvyPremium"] count] > oldIndexOfCurrentUserID ? oldHomeMembersDict[@"WeDivvyPremium"][oldIndexOfCurrentUserID] : [[[GeneralObject alloc] init] GenerateDefaultWeDivvyPremiumPlan];
                    
                    BOOL UserDidNotHaveSubscriptionAndNowTheyDo = ([oldWeDivvyPremium[@"SubscriptionPlan"] isEqualToString:@""] && [weDivvyPremium[@"SubscriptionPlan"] isEqualToString:@""] == NO);
                    BOOL UserDidHaveSubscriptionAndNowTheyDont = ([oldWeDivvyPremium[@"SubscriptionPlan"] isEqualToString:@""] == NO && [weDivvyPremium[@"SubscriptionPlan"] isEqualToString:@""]);
                    
                    if (UserDidNotHaveSubscriptionAndNowTheyDo == YES) {
                        
                        notificationTitle = @"⭐️ WeDivvy Premium ⭐️";
                        notificationBody = [NSString stringWithFormat:@"%@ gifted your account a free WeDivvy Premium subscription! ⭐️🎉", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]];
                        
                    } else if (UserDidHaveSubscriptionAndNowTheyDont == YES) {
                        
                        notificationTitle = @"⭐️ WeDivvy Premium ⭐️";
                        notificationBody = [NSString stringWithFormat:@"%@ removed your account's WeDivvy Premium subscription! 😔", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]];
                        
                    }
                    
                    if ([notificationTitle length] > 0) {
                        
                        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Other:[@[userID] mutableCopy] dataDict:[@{} mutableCopy] homeMembersDict:nil notificationSettingsDict:[@{} mutableCopy] notificationItemType:@"" notificationType:@"" pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody RemoveUsersNotInHome:YES completionHandler:^(BOOL finished) {
                            
                            
                            
                            
                            if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:homeMembersDict[@"UserID"] objectArr:objectArr]) {
                                
                                NSDictionary *dataDict = @{@"UserDict" : homeMembersDict};
                                
                                [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemWeDivvyPremiumAccounts" userInfo:dataDict locations:@[@"Tasks", @"AddTask", @"MultiAddTasks", @"ViewTask", @"Settings"]];
                                
                                finishBlock(YES);
                                
                            }
                            
                        }];
                        
                        
                        
                        
                    } else {
                        
                        
                        
                        
                        if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:homeMembersDict[@"UserID"] objectArr:objectArr]) {
                            
                            NSDictionary *dataDict = @{@"UserDict" : homeMembersDict};
                            
                            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemWeDivvyPremiumAccounts" userInfo:dataDict locations:@[@"Tasks", @"AddTask", @"MultiAddTasks", @"ViewTask", @"Settings"]];
                            
                            finishBlock(YES);
                            
                        }
                        
                    }
                    
                }];
                
            } else {
                
                
                
                
                if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:homeMembersDict[@"UserID"] objectArr:objectArr]) {
                    
                    NSDictionary *dataDict = @{@"UserDict" : homeMembersDict};
                    
                    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemWeDivvyPremiumAccounts" userInfo:dataDict locations:@[@"Tasks", @"AddTask", @"MultiAddTasks", @"ViewTask", @"Settings"]];
                    
                    finishBlock(YES);
                    
                }
                
            }
            
        }
        
    }
    
}

-(void)UpdataDataWeDivvyPremiumPurchasingUserHasWeDivvyPremiumButItIsNotShownInDatabase:(NSMutableDictionary *)homeMembersDict purchasingUsersUserID:(NSString *)purchasingUsersUserID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningHomeMembersDict))finishBlock {
    
    BOOL HomeMembersDictIsNotValid = (!homeMembersDict || (homeMembersDict && [(NSArray *)homeMembersDict[@"UserID"] count] == 0));
    
    if (HomeMembersDictIsNotValid) {
        finishBlock(YES, homeMembersDict);
    } else {
        
        //Get Default WeDivvy Premium Dict
        NSMutableDictionary *dataDict = [[[[GeneralObject alloc] init] GenerateDefaultWeDivvyPremiumPlan] mutableCopy];
        
        
        //Find Index Of Old Purchasing User
        NSMutableArray *userIDArray =
        homeMembersDict && homeMembersDict[@"UserID"] ?
        homeMembersDict[@"UserID"] : [NSMutableArray array];
        
        NSUInteger indexOfPurchasingUser =
        [userIDArray containsObject:purchasingUsersUserID] ?
        [userIDArray indexOfObject:purchasingUsersUserID] : 1000;
        
        if (indexOfPurchasingUser == 1000) {
            finishBlock(YES, homeMembersDict);
        } else {
            
            //Find Old Purchasing Users WeDivvy Premium Subscription History
            __block NSMutableDictionary *tempHomeMembersDict =
            homeMembersDict ?
            [homeMembersDict mutableCopy] : [NSMutableDictionary dictionary];
            
            NSMutableArray *tempWeDivvyPremiumArray =
            tempHomeMembersDict && tempHomeMembersDict[@"WeDivvyPremium"] ?
            [tempHomeMembersDict[@"WeDivvyPremium"] mutableCopy] : [NSMutableArray array];
            
            NSMutableDictionary *oldWeDivvyPremiumSubscriptionDict =
            tempWeDivvyPremiumArray && [tempWeDivvyPremiumArray count] > indexOfPurchasingUser ?
            [tempWeDivvyPremiumArray[indexOfPurchasingUser] mutableCopy] : [NSMutableDictionary dictionary];
            
            BOOL SubscriptionIsAlreadyDisplayedInDatabase = [oldWeDivvyPremiumSubscriptionDict[@"SubscriptionPlan"] length] > 0;
            
            if (SubscriptionIsAlreadyDisplayedInDatabase == YES) {
                finishBlock(YES, homeMembersDict);
            } else {
                
                [[[GetDataObject alloc] init] GetDataSubscriptionPurchsedByUser:purchasingUsersUserID completionhandler:^(BOOL finished, NSDictionary * _Nullable subscriptionDict) {
                    
                    BOOL SubscriptionDictIsNotValid = !subscriptionDict || !subscriptionDict[@"SubscriptionPlan"] || !subscriptionDict[@"SubscriptionPurchasedBy"] || [subscriptionDict[@"SubscriptionPurchasedBy"] isEqualToString:purchasingUsersUserID] == NO;
                    
                    if (SubscriptionDictIsNotValid) {
                        finishBlock(YES, homeMembersDict);
                    } else {
                        
                        NSString *subscriptionID = subscriptionDict[@"SubscriptionID"] ? subscriptionDict[@"SubscriptionID"] : @"";
                        NSString *subscriptionDatePurchased = subscriptionDict[@"SubscriptionDatePurchased"] ? subscriptionDict[@"SubscriptionDatePurchased"] : @"";
                        NSString *subscriptionPlan = subscriptionDict[@"SubscriptionPlan"] ? subscriptionDict[@"SubscriptionPlan"] : @"";
                        NSString *subscriptionFrequency = subscriptionDict[@"SubscriptionFrequency"] ? subscriptionDict[@"SubscriptionFrequency"] : @"";
                        
                        //Update Old WeDivvy Premium Dict With Latest Subscription Data For Purchasing User
                        [dataDict setObject:subscriptionDatePurchased forKey:@"SubscriptionDatePurchased"];
                        [dataDict setObject:subscriptionFrequency forKey:@"SubscriptionFrequency"];
                        [dataDict setObject:@"" forKey:@"SubscriptionGivenBy"];
                        [dataDict setObject:@{@"SubscriptionID" : subscriptionID} forKey:@"SubscriptionHistory"];
                        [dataDict setObject:subscriptionPlan forKey:@"SubscriptionPlan"];
                        
                        //Update HomeMembersDict With Old Purchasing Users New DataDict
                        [tempWeDivvyPremiumArray replaceObjectAtIndex:indexOfPurchasingUser withObject:dataDict];
                        [tempHomeMembersDict setObject:tempWeDivvyPremiumArray forKey:@"WeDivvyPremium"];
                        
                        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID == %@", purchasingUsersUserID];
                        [[[SetDataObject alloc] init] SetDataAddCoreData:@"Users" predicate:predicate setDataObject:@{@"WeDivvyPremium" : dataDict}];
                        
                        [[[SetDataObject alloc] init] UpdateDataUserData:purchasingUsersUserID userDict:dataDict completionHandler:^(BOOL finished, NSError * _Nonnull error) {
                            
                            NSDictionary *dataDict = @{@"UserDict" : homeMembersDict};
                            
                            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemWeDivvyPremiumAccounts" userInfo:dataDict locations:@[@"Tasks", @"AddTask", @"MultiAddTasks", @"ViewTask", @"Settings"]];
                            
                            finishBlock(YES, tempHomeMembersDict);
                            
                        }];
                        
                    }
                    
                }];
                
            }
            
        }
        
    }
    
}

-(void)UpdataDataWeDivvyPremiumPurchasingUserNoLongHasWeDivvyPremium:(NSMutableDictionary *)homeMembersDict purchasingUsersUserID:(NSString *)purchasingUsersUserID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningHomeMembersDict))finishBlock {
    
    BOOL HomeMembersDictIsNotValid = (!homeMembersDict || (homeMembersDict && [(NSArray *)homeMembersDict[@"UserID"] count] == 0));
    
    if (HomeMembersDictIsNotValid) {
        finishBlock(YES, homeMembersDict);
    } else {
        
        //Get Default WeDivvy Premium Dict
        NSMutableDictionary *dataDict = [[[[GeneralObject alloc] init] GenerateDefaultWeDivvyPremiumPlan] mutableCopy];
        
        
        //Find Index Of Old Purchasing User
        NSMutableArray *userIDArray =
        homeMembersDict && homeMembersDict[@"UserID"] ?
        homeMembersDict[@"UserID"] : [NSMutableArray array];
        
        NSUInteger indexOfPurchasingUser =
        [userIDArray containsObject:purchasingUsersUserID] ?
        [userIDArray indexOfObject:purchasingUsersUserID] : 1000;
        
        if (indexOfPurchasingUser == 1000) {
            finishBlock(YES, homeMembersDict);
        } else {
            
            //Find Old Purchasing Users WeDivvy Premium Subscription History
            __block NSMutableDictionary *tempHomeMembersDict =
            homeMembersDict ?
            [homeMembersDict mutableCopy] : [NSMutableDictionary dictionary];
            
            NSMutableArray *tempWeDivvyPremiumArray =
            tempHomeMembersDict && tempHomeMembersDict[@"WeDivvyPremium"] ?
            [tempHomeMembersDict[@"WeDivvyPremium"] mutableCopy] : [NSMutableArray array];
            
            NSMutableDictionary *oldWeDivvyPremiumSubscriptionHistoryDict =
            tempWeDivvyPremiumArray && [tempWeDivvyPremiumArray count] > indexOfPurchasingUser && tempWeDivvyPremiumArray[indexOfPurchasingUser][@"SubscriptionHistory"] ?
            [tempWeDivvyPremiumArray[indexOfPurchasingUser][@"SubscriptionHistory"] mutableCopy] : [NSMutableDictionary dictionary];
            
            
            //Merge Default WeDivvy Premium Dict With Old Old Purchasing User Subscription History
            [dataDict setObject:oldWeDivvyPremiumSubscriptionHistoryDict forKey:@"SubscriptionHistory"];
            
            //Update HomeMembersDict With Old Purchasing Users New DataDict
            [tempWeDivvyPremiumArray replaceObjectAtIndex:indexOfPurchasingUser withObject:dataDict];
            [tempHomeMembersDict setObject:tempWeDivvyPremiumArray forKey:@"WeDivvyPremium"];
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID == %@", purchasingUsersUserID];
            [[[SetDataObject alloc] init] SetDataAddCoreData:@"Users" predicate:predicate setDataObject:@{@"WeDivvyPremium" : dataDict}];
            
            [[[SetDataObject alloc] init] UpdateDataUserData:purchasingUsersUserID userDict:dataDict completionHandler:^(BOOL finished, NSError * _Nonnull error) {
                
                NSDictionary *dataDict = @{@"UserDict" : homeMembersDict};
                
                [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemWeDivvyPremiumAccounts" userInfo:dataDict locations:@[@"Tasks", @"AddTask", @"MultiAddTasks", @"ViewTask", @"Settings"]];
                
                finishBlock(YES, tempHomeMembersDict);
                
            }];
            
        }
        
    }
    
}

-(void)UpdateDataWeDivvyPremiumRemoveSubscriptionForGivenByUsers:(NSString *)purchasingUsersUserID homeMembersDict:(NSMutableDictionary *)homeMembersDict completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningHomeMembersDict))finishBlock {
    
    BOOL HomeMembersDictIsNotValid = (!homeMembersDict || (homeMembersDict && [(NSArray *)homeMembersDict[@"UserID"] count] == 0));
    BOOL PurchasingUsersUserIDIsNotValid = purchasingUsersUserID == nil || purchasingUsersUserID == NULL || [purchasingUsersUserID length] == 0;
    
    if (HomeMembersDictIsNotValid || PurchasingUsersUserIDIsNotValid) {
        finishBlock(YES, homeMembersDict);
    } else {
        
        NSMutableArray *objectArr = [NSMutableArray array];
        
        
        
        
        //Check If Purchasing Users Exists and Still Has Subscription
        BOOL PurchasingUserExists = homeMembersDict && homeMembersDict[@"UserID"] ? [homeMembersDict[@"UserID"] containsObject:purchasingUsersUserID] : NO;
        
        NSUInteger purchasingUsersUserIDIndex = PurchasingUserExists ? [homeMembersDict[@"UserID"] indexOfObject:purchasingUsersUserID] : 0;
        NSString *purchasingUsersUserIDUsername = PurchasingUserExists ? homeMembersDict[@"Username"][purchasingUsersUserIDIndex] : @"";
        NSMutableDictionary *purchasingUsersUserIDWeDivvyPremiumDict = PurchasingUserExists ? [homeMembersDict[@"WeDivvyPremium"][purchasingUsersUserIDIndex] mutableCopy] : @{};
        
        BOOL PurchasingUserHasSubscription = (purchasingUsersUserIDWeDivvyPremiumDict && purchasingUsersUserIDWeDivvyPremiumDict[@"SubscriptionDatePurchased"] && [purchasingUsersUserIDWeDivvyPremiumDict[@"SubscriptionDatePurchased"] length] > 0);
        
        
        
        
        BOOL DeleteSubscriptionForGivenByUsers = (PurchasingUserExists == NO || PurchasingUserHasSubscription == NO);
        
        if (DeleteSubscriptionForGivenByUsers == YES) {
            
            
            
            
            for (NSString *userID in homeMembersDict[@"UserID"]) {
                
                NSUInteger indexOfCurrentUserID = [homeMembersDict[@"UserID"] indexOfObject:userID];
                NSMutableDictionary *weDivvyPremiumDict = homeMembersDict && homeMembersDict[@"WeDivvyPremium"] && [(NSArray *)homeMembersDict[@"WeDivvyPremium"] count] > indexOfCurrentUserID ? homeMembersDict[@"WeDivvyPremium"][indexOfCurrentUserID] : [[[GeneralObject alloc] init] GenerateDefaultWeDivvyPremiumPlan];
                
                
                
                
                BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:weDivvyPremiumDict classArr:@[[NSDictionary class], [NSMutableDictionary class]]];
                
                BOOL SubscriptionGivenByUserToRemove =
                ObjectIsKindOfClass == YES &&
                ([weDivvyPremiumDict[@"SubscriptionGivenBy"] isEqualToString:purchasingUsersUserID]);
                
                if (SubscriptionGivenByUserToRemove == YES) {
                    
                    //Remove Subscription Of Given By User
                    NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateDefaultWeDivvyPremiumPlan];
                    
                    NSMutableDictionary *tempHomeMembersDict = homeMembersDict ? [homeMembersDict mutableCopy] : [NSMutableDictionary dictionary];
                    NSMutableArray *tempWeDivvyPremiumArray = tempHomeMembersDict[@"WeDivvyPremium"] ? [tempHomeMembersDict[@"WeDivvyPremium"] mutableCopy] : [NSMutableArray array];
                    [tempWeDivvyPremiumArray replaceObjectAtIndex:indexOfCurrentUserID withObject:dataDict];
                    [tempHomeMembersDict setObject:tempWeDivvyPremiumArray forKey:@"WeDivvyPremium"];
                    homeMembersDict = [tempHomeMembersDict mutableCopy];
                    
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID == %@", userID];
                    [[[SetDataObject alloc] init] SetDataAddCoreData:@"Users" predicate:predicate setDataObject:@{@"WeDivvyPremium" : dataDict}];
                    
                    [[[SetDataObject alloc] init] UpdateDataUserData:userID userDict:dataDict completionHandler:^(BOOL finished, NSError * _Nonnull error) {
                        
                        
                        
                        
                        //Send Notification To Given By User
                        NSString *notificationTitle = @"⭐️ WeDivvy Premium ⭐️";
                        NSString *notificationBody =
                        [purchasingUsersUserIDUsername length] > 0 ?
                        [NSString stringWithFormat:@"Your subscription has been cancelled by %@. Click here to purchase your own subscription", purchasingUsersUserIDUsername] :
                        [NSString stringWithFormat:@"Your subscription has been cancelled. Click here to purchase your own subscription"];
                        
                        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Other:[@[userID] mutableCopy] dataDict:[@{@"WeDivvyPremium" : @"Yes"} mutableCopy] homeMembersDict:nil notificationSettingsDict:[@{} mutableCopy] notificationItemType:@"" notificationType:@"" pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody RemoveUsersNotInHome:YES completionHandler:^(BOOL finished) {
                            
                            
                            
                            
                            if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:homeMembersDict[@"UserID"] objectArr:objectArr]) {
                                
                                NSDictionary *dataDict = @{@"UserDict" : homeMembersDict};
                                
                                [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemWeDivvyPremiumAccounts" userInfo:dataDict locations:@[@"Tasks", @"AddTask", @"MultiAddTasks", @"ViewTask", @"Settings"]];
                                
                                finishBlock(YES, homeMembersDict);
                                
                            }
                            
                        }];
                        
                    }];
                    
                    
                    
                    
                } else if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:homeMembersDict[@"UserID"] objectArr:objectArr]) {
                    
                    NSDictionary *dataDict = @{@"UserDict" : homeMembersDict};
                    
                    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemWeDivvyPremiumAccounts" userInfo:dataDict locations:@[@"Tasks", @"AddTask", @"MultiAddTasks", @"ViewTask", @"Settings"]];
                    
                    finishBlock(YES, homeMembersDict);
                    
                }
                
            }
            
        } else {
            
            NSDictionary *dataDict = @{@"UserDict" : homeMembersDict};
            
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemWeDivvyPremiumAccounts" userInfo:dataDict locations:@[@"Tasks", @"AddTask", @"MultiAddTasks", @"ViewTask", @"Settings"]];
            
            finishBlock(YES, homeMembersDict);
            
        }
        
    }
    
}

#pragma mark - Items

-(void)SetDataAddItem:(NSDictionary *)setDataDict collection:(NSString *)collection homeID:(NSString *)homeID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemID = setDataDict[@"ItemID"] ? setDataDict[@"ItemID"] : @"xxx";
    NSString *itemOccurrenceID = setDataDict[@"ItemOccurrenceID"] ? setDataDict[@"ItemOccurrenceID"] : @"xxx";
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    
    
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    FIRDocumentReference *queryToUse = nil;
    
  
    
    if ([itemOccurrenceID length] > 0 && [itemOccurrenceID isEqualToString:@"xxx"] == NO) {
        
        collection = [collection substringToIndex:[collection length] - 1];
        
        queryToUse = [[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:[NSString stringWithFormat:@"%@Occurrences", collection]]
                      documentWithPath:itemOccurrenceID];
        
        [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Homes", [NSString stringWithFormat:@"%@Occurrences", collection]] documents:@[homeID, itemOccurrenceID] type:@"UpdateData;" setData:setDataDict name:@"SetDataAddItem" queryID:queryID];
        
    } else {
        
        queryToUse = [[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:collection]
                      documentWithPath:itemID];
        
        [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Homes", collection] documents:@[homeID, itemID] type:@"Set;Merge:YES" setData:setDataDict name:@"SetDataAddItem" queryID:queryID];
        
    }
    
    [queryToUse setData:setDataDict merge:YES completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

-(void)SetDataItemImage:(NSString *)itemUniqueID itemType:(NSString *)itemType imgData:(NSData *)imgData completionHandler:(void (^)(BOOL finished))finishBlock {
    
    if (imgData == nil) {
        
        finishBlock(YES);
        
    } else {
        
        NSString *firstChild = [NSString stringWithFormat:@"%@Images", itemType];
        NSString *secondChild = [NSString stringWithFormat:@"%@Image", itemType];
        
        FIRStorage *storage = [FIRStorage storage];
        
        FIRStorageReference *storageRef = [storage reference];
        
        //ChoreImages/123/ChoreImage/123.jpeg/
        FIRStorageReference *mountainsRef = [[[[storageRef child:firstChild] child:itemUniqueID] child:secondChild] child:[NSString stringWithFormat:@"%@.jpeg", itemUniqueID]];
        
        NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
        [[[GeneralObject alloc] init] AddQueryToDefaults:@[firstChild, itemUniqueID, secondChild, [NSString stringWithFormat:@"%@.jpeg", itemUniqueID]] documents:@[] type:@"PutData" setData:@{@"Data" : imgData} name:@"SetDataItemImage" queryID:queryID];
        
        [mountainsRef putData:imgData
                     metadata:nil
                   completion:^(FIRStorageMetadata *metadata,
                                NSError *error) {
            
            [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
            
            if (error == nil) {
                
                [mountainsRef downloadURLWithCompletion:^(NSURL * _Nullable URL, NSError * _Nullable error) {
                    
                    finishBlock(YES);
                    
                }];
                
            } //error
            
        }]; //downloadURLWithCompletion
        
    }
    
}

-(void)SetDataItemPhotoConfirmationImage:(NSString *)itemUniqueID itemType:(NSString *)itemType markedObject:(NSString *)markedObject imgData:(NSData *)imgData completionHandler:(void (^)(BOOL finished, NSString *imageURL))finishBlock {
    
    if (imgData == nil) {
        
        finishBlock(YES, @"xxx");
        
    } else {
        
        NSString *firstChild = [NSString stringWithFormat:@"%@Images", itemType];
        NSString *secondChild = [NSString stringWithFormat:@"%@Image", itemType];
        
        FIRStorage *storage = [FIRStorage storage];
        
        FIRStorageReference *storageRef = [storage reference];
        
        //ChoreImages/123/ChoreImage/PhotoConfirmations/123.jpeg/
        FIRStorageReference *mountainsRef = [[[[[storageRef child:firstChild] child:itemUniqueID] child:secondChild] child:@"PhotoConfirmations"] child:[NSString stringWithFormat:@"%@.jpeg", markedObject]];
        
        NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
        [[[GeneralObject alloc] init] AddQueryToDefaults:@[firstChild, itemUniqueID, secondChild, @"PhotoConfirmations", [NSString stringWithFormat:@"%@.jpeg", markedObject]] documents:@[] type:@"PutData" setData:@{@"Data" : imgData} name:@"SetDataItemPhotoConfirmationImage" queryID:queryID];
        
        [mountainsRef putData:imgData
                     metadata:nil
                   completion:^(FIRStorageMetadata *metadata,
                                NSError *error) {
            
            [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
            
            if (error != nil) {
                
                NSLog(@"updateUserProfileImage - The error is %@", error.localizedDescription);
                
                finishBlock(YES, @"xxx");
                
            } else {
                
                [mountainsRef downloadURLWithCompletion:^(NSURL * _Nullable URL, NSError * _Nullable error) {
                    
                    finishBlock(YES, URL.absoluteString);
                    
                }]; //downloadURLWithCompletion
                
            } //else
            
        }]; //FIRStorageUploadTask
        
    }
    
}

-(void)UpdateDataEditItem:(NSDictionary *)setDataDict itemID:(NSString *)itemID itemOccurrenceID:(NSString *)itemOccurrenceID collection:(NSString *)collection homeID:(NSString *)homeID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    FIRDocumentReference *queryToUse;
    
    if ([itemID length] == 0) {
        itemID = @"xxx";
    }
    if ([itemOccurrenceID length] == 0) {
        itemOccurrenceID = @"xxx";
    }
    if ([homeID length] == 0) {
        homeID = @"xxx";
    }
    if ([collection length] == 0) {
        collection = @"xxx";
    }
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    
    if (itemOccurrenceID.length > 0 && [itemOccurrenceID isEqualToString:@"xxx"] == NO) {
        
        collection = [collection substringToIndex:[collection length] - 1];
        
        queryToUse = [[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:[NSString stringWithFormat:@"%@Occurrences", collection]]
                      documentWithPath:itemOccurrenceID];
        
        [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Homes", [NSString stringWithFormat:@"%@Occurrences", collection]] documents:@[homeID, itemOccurrenceID] type:@"UpdateData;" setData:setDataDict name:@"UpdateDataEditItem" queryID:queryID];
        
    } else {
        
        queryToUse = [[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:collection]
                      documentWithPath:itemID];
        
        [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Homes", collection] documents:@[homeID, itemID] type:@"UpdateData;" setData:setDataDict name:@"UpdateDataEditItem" queryID:queryID];
        
    }
    
    [queryToUse updateData:setDataDict completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

-(void)UpdateDataItemImage:(NSString *)itemUniqueID itemType:(NSString *)itemType imgData:(NSData *)imgData completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *firstChild = [NSString stringWithFormat:@"%@Images", itemType];
    NSString *secondChild = [NSString stringWithFormat:@"%@Image", itemType];
    
    FIRStorage *storage = [FIRStorage storage];
    
    FIRStorageReference *storageRef = [storage reference];
    
    //ChoreImages/123/ChoreImage/123.jpeg/
    FIRStorageReference *mountainsRef = [[[[storageRef child:firstChild] child:itemUniqueID] child:secondChild] child:[NSString stringWithFormat:@"%@.jpeg", itemUniqueID]];
    
    if (imgData != nil) {
        
        [mountainsRef putData:imgData metadata:nil completion:^(FIRStorageMetadata * _Nullable metadata, NSError * _Nullable error) {
            
            [mountainsRef updateMetadata:metadata completion:^(FIRStorageMetadata * _Nullable metadata, NSError * _Nullable error) {
                
                finishBlock(YES);
                
            }];
            
        }];
        
    } else {
        
        [mountainsRef deleteWithCompletion:^(NSError * _Nullable error) {
            
            finishBlock(YES);
            
        }];
        
    }
    
}

-(void)UpdateDataItemPhotoConfirmationImage:(NSString *)itemUniqueID itemType:(NSString *)itemType markedObject:(NSString *)markedObject imgData:(NSData *)imgData completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *firstChild = [NSString stringWithFormat:@"%@Images", itemType];
    NSString *secondChild = [NSString stringWithFormat:@"%@Image", itemType];
    
    FIRStorage *storage = [FIRStorage storage];
    
    FIRStorageReference *storageRef = [storage reference];
    
    //ChoreImages/123/ChoreImage/PhotoConfirmations/123.jpeg/
    FIRStorageReference *mountainsRef = [[[[[storageRef child:firstChild] child:itemUniqueID] child:secondChild] child:@"PhotoConfirmations"] child:[NSString stringWithFormat:@"%@.jpeg", markedObject]];
    
    if (imgData != nil) {
        
        [mountainsRef putData:imgData metadata:nil completion:^(FIRStorageMetadata * _Nullable metadata, NSError * _Nullable error) {
            
            [mountainsRef updateMetadata:metadata completion:^(FIRStorageMetadata * _Nullable metadata, NSError * _Nullable error) {
                
                finishBlock(YES);
                
            }];
            
        }];
        
    } else {
        
        [mountainsRef deleteWithCompletion:^(NSError * _Nullable error) {
            
            finishBlock(YES);
            
        }];
        
    }
    
}

#pragma mark - Compound Methods

-(void)UpdateDataForNewHomeMember:(NSString *)homeID collection:(NSString *)collection userToAdd:(NSString *)userToAdd homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays QueryAssignedToNewHomeMember:(BOOL)QueryAssignedToNewHomeMember QueryAssignedTo:(BOOL)QueryAssignedTo queryAssignedToUserID:(NSString *)queryAssignedToUserID ResetNotifications:(BOOL)ResetNotifications completionHandler:(void (^)(BOOL finished))finishBlock {
    
    //Get All Items From Home, Update Info If ItemAssignedToNewHomeMembers == YES. Update Notifications For All Tasks That User Is Assigned To Even If ItemAssignedToNewHomeMembers == NO
   
    [[[GetDataObject alloc] init] GetDataItemsInSpecificHomeWithSpecificQuery:homeID collection:collection QueryAssignedToNewHomeMember:QueryAssignedToNewHomeMember QueryAssignedTo:QueryAssignedTo queryAssignedToUserID:queryAssignedToUserID completionHandler:^(BOOL finished, FIRQuerySnapshot * _Nonnull snapshot) {
        
        __block NSMutableArray *objectArr = [NSMutableArray array];
        NSMutableArray *snapshotDocuments = [[[SetDataObject alloc] init] GenerateSnapshotDocumentsArray:snapshot.documents];
      
        if (snapshot.documents.count > 0) {
            
            NSArray *keyArray = [[[GeneralObject alloc] init] GenerateKeyArrayManually:[collection isEqualToString:@"Chores"]
                                                                               Expense:[collection isEqualToString:@"Expenses"]
                                                                                  List:[collection isEqualToString:@"Lists"]
                                                                                  Home:NO];
            
            //Batch
           
            for (FIRDocumentSnapshot *doc in snapshotDocuments) {
                
                NSMutableArray *updatedItemAssignedTo = [[[SetDataObject alloc] init] GenerateUpdatedItemAssignedToArrayForFIRDocument:doc userID:userToAdd assignedToKey:@"ItemAssignedTo"];
                NSMutableDictionary *dictToUse = [[[[SetDataObject alloc] init] GenerateDictToUseForFIRDocument:keyArray doc:doc updatedItemAssignedTo:updatedItemAssignedTo] mutableCopy];
                
                //Get All Items Where ItemAssignedToNewHomeMembers == YES, Add New Home Member, Update Data And Topics
                if (QueryAssignedToNewHomeMember == YES) {
                   
                    __block int totalQueries = 2;
                    __block int completedQueries = 0;
                    
                    /*
                     //
                     //
                     //Update Item Data
                     //
                     //
                     */
                    [[[SetDataObject alloc] init] UpdateDataForNewHomeMember_UpdateItemData:doc collection:collection homeID:homeID updatedItemAssignedTo:updatedItemAssignedTo userToAdd:userToAdd completionHandler:^(BOOL finished) {
                       
                        [[[SetDataObject alloc] init] UpdateDataForNewHomeMember_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) snapshotDocuments:snapshotDocuments objectArr:objectArr completionHandler:^(BOOL finished) {
                            
                            finishBlock(YES);
                            
                        }];
                        
                    }];
                    
                    
                    /*
                     //
                     //
                     //Update Topic Data
                     //
                     //
                     */
                    [[[SetDataObject alloc] init] UpdateDataForNewHomeMember_UpdateTopicData:doc homeID:homeID updatedItemAssignedTo:updatedItemAssignedTo completionHandler:^(BOOL finished) {
                       
                        [[[SetDataObject alloc] init] UpdateDataForNewHomeMember_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) snapshotDocuments:snapshotDocuments objectArr:objectArr completionHandler:^(BOOL finished) {
                            
                            finishBlock(YES);
                            
                        }];
                        
                    }];
                    
                    
                    //Get All Items Where ItemAssignedTo Contains Home Member, Reset Item Notifications Where Assigned
                    
                } else if (QueryAssignedTo == YES && ResetNotifications == YES) {
                    
                   
                    /*
                     //
                     //
                     //Reset Notifications
                     //
                     //
                     */
                    [[[SetDataObject alloc] init] UpdateDataForNewHomeMember_ResetNotifications:dictToUse homeMembersDict:homeMembersDict ResetNotifications:ResetNotifications notificationSettingsDict:notificationSettingsDict topicDict:topicDict allItemTagsArrays:allItemTagsArrays collection:collection keyArray:keyArray completionHandler:^(BOOL finished) {
                       
                        [[[SetDataObject alloc] init] UpdateDataForNewHomeMember_CompletionBlock:1 completedQueries:1 snapshotDocuments:snapshotDocuments objectArr:objectArr completionHandler:^(BOOL finished) {
                            
                            finishBlock(YES);
                            
                        }];
                        
                    }];
                    
                }
                
            }
            
        } else {
            
            finishBlock(YES);
            
        }
        
    }];
    
}

-(void)UpdateDataNextUsersTurnForDeletedHomeMember:(NSString *)homeID homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays homeMembersArray:(NSMutableArray *)homeMembersArray userID:(NSString *)userID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    __block int totalQueries = 3;
    __block int completedQueries = 0;
    
    
    
    [[[SetDataObject alloc] init] UpdateDataNextUsersTurnForDeletedHomeMember_UpdateDataSkipUsersTurn:@"Chore" itemTypeCollection:@"Chores" homeID:homeID homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:@"Chore" topicDict:topicDict allItemTagsArrays:allItemTagsArrays homeMembersArray:homeMembersArray userID:userID completionHandler:^(BOOL finished) {
        
        [[[SetDataObject alloc] init] UpdateDataNextUsersTurnForDeletedHomeMember_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    }];
    
    [[[SetDataObject alloc] init] UpdateDataNextUsersTurnForDeletedHomeMember_UpdateDataSkipUsersTurn:@"Expense" itemTypeCollection:@"Expenses" homeID:homeID homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:@"Expense" topicDict:topicDict allItemTagsArrays:allItemTagsArrays homeMembersArray:homeMembersArray userID:userID completionHandler:^(BOOL finished) {
        
        [[[SetDataObject alloc] init] UpdateDataNextUsersTurnForDeletedHomeMember_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
           
            finishBlock(YES);
            
        }];
        
    }];
    
    [[[SetDataObject alloc] init] UpdateDataNextUsersTurnForDeletedHomeMember_UpdateDataSkipUsersTurn:@"List" itemTypeCollection:@"Lists" homeID:homeID homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:@"List" topicDict:topicDict allItemTagsArrays:allItemTagsArrays homeMembersArray:homeMembersArray userID:userID completionHandler:^(BOOL finished) {
        
        [[[SetDataObject alloc] init] UpdateDataNextUsersTurnForDeletedHomeMember_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    }];
    
}

-(void)UpdateDataSkipUsersTurn:(NSString *)itemType itemTypeCollection:(NSString *)itemTypeCollection homeID:(NSString *)homeID keyArray:(NSArray *)keyArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays homeMembersArray:(NSMutableArray *)homeMembersArray dictToUse:(NSMutableDictionary *)dictToUse userID:(NSString *)userID SkippingTurn:(BOOL)SkippingTurn DeletingHomeMember:(BOOL)DeletingHomeMember completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse))finishBlock {
    
    dictToUse = [[[[SetDataObject alloc] init] UpdateDataSkipUsersTurn_GenerateSkipUserTurnDict:dictToUse homeMembersDict:homeMembersDict itemType:itemType] copy];
   
    
    
    __block int totalQueries = 3;
    __block int completedQueries = 0;
    
    
    
    /*
     //
     //
     //Send Push Notifications
     //
     //
     */
    [[[SetDataObject alloc] init] UpdateDataSkipUsersTurn_SendPushNotifications:dictToUse itemType:itemType homeID:homeID homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType topicDict:topicDict allItemTagsArrays:allItemTagsArrays userID:userID SkippingTurn:SkippingTurn DeletingHomeMember:DeletingHomeMember completionHandler:^(BOOL finished) {
        
        [[[SetDataObject alloc] init] UpdateDataSkipUsersTurn_CompletionBlock:dictToUse totalQueries:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
            
            finishBlock(YES, dictToUse);
            
        }];
        
    }];

    
    /*
     //
     //
     //Reset Item Notifications
     //
     //
     */
    [[[SetDataObject alloc] init] UpdateDataSkipUsersTurn_ResetItemNotifications:dictToUse itemType:itemType keyArray:keyArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict topicDict:topicDict allItemTagsArrays:allItemTagsArrays completionHandler:^(BOOL finished) {
        
        [[[SetDataObject alloc] init] UpdateDataSkipUsersTurn_CompletionBlock:dictToUse totalQueries:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
            
            finishBlock(YES, dictToUse);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Item Data
     //
     //
     */
    [[[SetDataObject alloc] init] UpdateDataSkipUsersTurn_UpdateItemData:dictToUse collection:itemTypeCollection homeID:homeID completionHandler:^(BOOL finished) {
        
        [[[SetDataObject alloc] init] UpdateDataSkipUsersTurn_CompletionBlock:dictToUse totalQueries:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
           
            finishBlock(YES, dictToUse);
            
        }];
        
    }];
    
}

-(void)UpdateDataResetRepeatingTask:(NSMutableDictionary *)itemDict itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict homeID:(NSString *)homeID itemType:(NSString *)itemType keyArray:(NSArray *)keyArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict taskListDict:(NSMutableDictionary *)taskListDict allItemAssignedToArrays:(NSMutableArray * _Nullable)allItemAssignedToArrays allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays SkipOccurrence:(BOOL)SkipOccurrence completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningItemDict, NSMutableDictionary *returningItemOccurrencesDict, NSMutableDictionary *returningUpdatedTaskListDict))finishBlock {
    
    
  
    
    
    NSString *collection = [NSString stringWithFormat:@"%@s", itemType];
    __block NSMutableDictionary *itemDictToBeUpdated = itemDict ? [itemDict mutableCopy] : [NSMutableDictionary dictionary];
    __block NSMutableDictionary *returningUpdatedTaskListDictLocal = [NSMutableDictionary dictionary];
    __block NSMutableDictionary *itemUniqueIDDict = [NSMutableDictionary dictionary];
    
    
    
    
    
    NSMutableArray *itemUniqueIDArray = itemDict[@"ItemUniqueID"] ? [itemDict[@"ItemUniqueID"] mutableCopy] : [NSMutableArray array];
    
    BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemUniqueIDArray classArr:@[[NSString class]]];
    
    if (ObjectIsKindOfClass == YES) {
        itemUniqueIDArray = itemDict[@"ItemUniqueID"] ? [@[itemDict[@"ItemUniqueID"]] mutableCopy] : [NSMutableArray array];
    }
    
    NSMutableArray *objectArr = [NSMutableArray array];
    
    
    
    
    
    if (itemUniqueIDArray.count > 0) {
        
        
        
        
        
        for (NSString *itemUniqueID in itemUniqueIDArray) {
            
            
            
            
            
            NSUInteger indexOfUniqueID = [itemUniqueIDArray indexOfObject:itemUniqueID];
            
            
            
            
            
            __block NSMutableDictionary *specificItemDataDict = [NSMutableDictionary dictionary];
            
            for (NSString *key in keyArray) {
                
                id object = itemDict[key] && [(NSArray *)itemDict[key] count] > indexOfUniqueID ? itemDict[key][indexOfUniqueID] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                [specificItemDataDict setObject:object forKey:key];
                
            }
            
            
          
            
            
            NSMutableDictionary *specificItemDataDictCopyForOccurrences = [specificItemDataDict mutableCopy];
            
            [specificItemDataDictCopyForOccurrences setObject:[[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString] forKey:@"ItemOccurrenceID"];
            [specificItemDataDictCopyForOccurrences setObject:[[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString] forKey:@"ItemUniqueID"];
            
            
            
            
           
            NSString *itemDueDateOriginal = specificItemDataDict[@"ItemDueDate"];
            NSString *itemTurnUserIDOriginal = [[[[GeneralObject alloc] init] GenerateCurrentUserTurnFromDict:[specificItemDataDict mutableCopy] homeMembersDict:homeMembersDict itemType:itemType] mutableCopy];
            
            
            
            
            
            BOOL TaskIsFullyCompleted = [[[BoolDataObject alloc] init] TaskIsFullyCompleted:specificItemDataDict itemType:itemType homeMembersDict:homeMembersDict];
            BOOL TaskIsOccurrence = [[[BoolDataObject alloc] init] TaskIsOccurrence:specificItemDataDict itemType:itemType];
            BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:specificItemDataDict itemType:itemType];
            
            BOOL ItemNeedsToBeReset = [[[SetDataObject alloc] init] UpdateDataResetRepeatingTask_ItemNeedsToBeReset:specificItemDataDict itemDict:itemDict itemOccurrencesDict:itemOccurrencesDict itemType:itemType homeMembersDict:homeMembersDict SkipOccurrence:SkipOccurrence TaskIsFullyCompleted:TaskIsFullyCompleted];
           
            itemDueDateOriginal = [[[SetDataObject alloc] init] UpdateDataResetRepeatingTask_GenerateMultipleDueDatesNextDueDate:specificItemDataDict itemDict:itemDict itemOccurrencesDict:itemOccurrencesDict itemType:itemType homeMembersDict:homeMembersDict];
            
            
          
            
            
            if ((ItemNeedsToBeReset == YES || SkipOccurrence == YES)) {
                
                
               
                
                
                itemOccurrencesDict = [[[SetDataObject alloc] init] UpdateDataResetRepeatingTask_GenerateUpdatedItemOccurrencesDict:specificItemDataDict itemOccurrencesDict:itemOccurrencesDict TaskIsFullyCompleted:TaskIsFullyCompleted SkipOccurrence:SkipOccurrence];
                
              
               
                
                
                __block int totalQueries = 5;
                __block int completedQueries = 0;
                
                
                
                
                
                NSMutableDictionary *dataDictWithSpecificUpdatedValues = [[[SetDataObject alloc] init] UpdateDataResetRepeatingTask_GenerateDictWithSpecificUpdatedValues:specificItemDataDict itemOccurrencesDict:itemOccurrencesDict collection:collection itemType:itemType homeID:homeID keyArray:keyArray homeMembersDict:homeMembersDict allItemAssignedToArrays:allItemAssignedToArrays indexOfUniqueID:indexOfUniqueID SkipOccurrence:SkipOccurrence];
                
                
               
                
                
                //Update Specific Item Data With Reset, Updated Values
                specificItemDataDict = [[[SetDataObject alloc] init] ResetRepeatingTask_GenerateUpdatedSpecificItemDict:specificItemDataDict returningDataDictWithSpecificUpdatedValues:dataDictWithSpecificUpdatedValues];
                
                
                
                
                
                //Update Item Dict With Updated Specific Item Data
                itemDictToBeUpdated = [[[SetDataObject alloc] init] ResetRepeatingTask_GenerateUpdatedItemDict:itemDictToBeUpdated specificItemDataDict:specificItemDataDict indexOfUniqueID:indexOfUniqueID];
                
                
              
                
                
                BOOL ResetTaskDueDateHasBeenUpdated_Or_TaskIsRepeatingWhenCompletedAndIsFullyCompleted_Or_TaskIsRepeatingIfCompletedEarlyAndIsFullyCompleted = [[[SetDataObject alloc] init] ResetRepeatingTask_ResetTaskDueDateHasBeenUpdated_Or_TaskIsRepeatingWhenCompletedAndIsFullyCompleted_Or_TaskIsRepeatingIfCompletedEarlyAndIsFullyCompleted:specificItemDataDict itemDueDate:itemDueDateOriginal itemType:itemType TaskIsFullyCompleted:TaskIsFullyCompleted];
               
                if (ResetTaskDueDateHasBeenUpdated_Or_TaskIsRepeatingWhenCompletedAndIsFullyCompleted_Or_TaskIsRepeatingIfCompletedEarlyAndIsFullyCompleted == YES) {
                   
                    [itemUniqueIDDict setObject:@{@"SpecificItemUniqueID" : itemUniqueID} forKey:specificItemDataDictCopyForOccurrences[@"ItemUniqueID"]];
                    
                    
                    
                    
                    
                    /*
                     //
                     //
                     //Send Push Notifications (If ItemTurnUserID Changes)
                     //
                     //
                     */
                    [[[SetDataObject alloc] init] ResetRepeatingTask_SendPushNotifications:specificItemDataDict itemTurnUserIDOriginal:itemTurnUserIDOriginal itemType:itemType homeID:homeID allItemTagsArrays:allItemTagsArrays TaskIsOccurrence:TaskIsOccurrence TaskIsTakingTurns:TaskIsTakingTurns completionHandler:^(BOOL finished) {
                        
                        [[[SetDataObject alloc] init] ResetRepeatingTask_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) itemUniqueIDArray:itemUniqueIDArray objectArr:objectArr taskListDict:taskListDict itemUniqueIDDict:itemUniqueIDDict SkipOccurrence:SkipOccurrence TaskIsOccurrence:TaskIsOccurrence completionHandler:^(BOOL finished, NSMutableDictionary *returningUpdatedTaskListDictLocal) {
                            
                            finishBlock(YES, itemDictToBeUpdated, itemOccurrencesDict, returningUpdatedTaskListDictLocal);
                            
                        }];
                        
                    }];
                    
                    
                    
                    
                    
                    /*
                     //
                     //
                     //Reset Item Notifications (If Item Is Not Occurrence)
                     //
                     //
                     */
                    [[[SetDataObject alloc] init] ResetRepeatingTask_ResetItemNotifications:specificItemDataDict itemType:itemType allItemTagsArrays:allItemTagsArrays notificationSettingsDict:notificationSettingsDict topicDict:topicDict homeMembersDict:homeMembersDict keyArray:keyArray TaskIsOccurrence:TaskIsOccurrence completionHandler:^(BOOL finished) {
                        
                        [[[SetDataObject alloc] init] ResetRepeatingTask_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) itemUniqueIDArray:itemUniqueIDArray objectArr:objectArr taskListDict:taskListDict itemUniqueIDDict:itemUniqueIDDict SkipOccurrence:SkipOccurrence TaskIsOccurrence:TaskIsOccurrence completionHandler:^(BOOL finished, NSMutableDictionary *returningUpdatedTaskListDictLocal) {
                          
                            finishBlock(YES, itemDictToBeUpdated, itemOccurrencesDict, returningUpdatedTaskListDictLocal);
                            
                        }];
                        
                    }];
                    
                    
                   
                  
                    
                    /*
                     //
                     //
                     //Update Item Data (If Item Is Not Occurrence)
                     //
                     //
                     */
                    [[[SetDataObject alloc] init] ResetRepeatingTask_UpdateItemData:specificItemDataDict dataDictWithSpecificUpdatedValues:dataDictWithSpecificUpdatedValues homeID:homeID collection:collection TaskIsFullyCompleted:TaskIsFullyCompleted TaskIsOccurrence:TaskIsOccurrence completionHandler:^(BOOL finished) {
                        
                        [[[SetDataObject alloc] init] ResetRepeatingTask_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) itemUniqueIDArray:itemUniqueIDArray objectArr:objectArr taskListDict:taskListDict itemUniqueIDDict:itemUniqueIDDict SkipOccurrence:SkipOccurrence TaskIsOccurrence:TaskIsOccurrence completionHandler:^(BOOL finished, NSMutableDictionary *returningUpdatedTaskListDictLocal) {
                         
                            finishBlock(YES, itemDictToBeUpdated, itemOccurrencesDict, returningUpdatedTaskListDictLocal);
                            
                        }];
                        
                    }];
                    
                    
                  
                    
                    
                    /*
                     //
                     //
                     //Set Item Occurrence Data (If Item Is Not Occurrence And You Are Not Skipping Occurrence Or You Are Skipping Occurrence)
                     //
                     //
                     */
                    [[[SetDataObject alloc] init] ResetRepeatingTask_SetItemOccurrenceData:specificItemDataDict itemDictToBeUpdated:itemDictToBeUpdated specificItemDataDictCopyForOccurrences:specificItemDataDictCopyForOccurrences collection:collection homeID:homeID index:indexOfUniqueID SkipOccurrence:SkipOccurrence TaskIsOccurrence:TaskIsOccurrence TaskIsFullyCompleted:TaskIsFullyCompleted completionHandler:^(BOOL finished, NSMutableDictionary *returningItemDictToBeUpdated) {
                        
                        itemDictToBeUpdated = [returningItemDictToBeUpdated mutableCopy];
                       
                        [[[SetDataObject alloc] init] ResetRepeatingTask_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) itemUniqueIDArray:itemUniqueIDArray objectArr:objectArr taskListDict:taskListDict itemUniqueIDDict:itemUniqueIDDict SkipOccurrence:SkipOccurrence TaskIsOccurrence:TaskIsOccurrence completionHandler:^(BOOL finished, NSMutableDictionary *returningUpdatedTaskListDictLocal) {
                            
                            finishBlock(YES, itemDictToBeUpdated, itemOccurrencesDict, returningUpdatedTaskListDictLocal);
                            
                        }];
                        
                    }];
                    
                    
                    
                    
                    
                    /*
                     //
                     //
                     //Set Item And Home Activity
                     //
                     //
                     */
                    [[[SetDataObject alloc] init] ResetRepeatingTask_SetItemAndHomeActivity:specificItemDataDict itemType:itemType homeID:homeID SkipOccurrence:SkipOccurrence TaskIsOccurrence:TaskIsOccurrence completionHandler:^(BOOL finished) {
                        
                        [[[SetDataObject alloc] init] ResetRepeatingTask_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) itemUniqueIDArray:itemUniqueIDArray objectArr:objectArr taskListDict:taskListDict itemUniqueIDDict:itemUniqueIDDict SkipOccurrence:SkipOccurrence TaskIsOccurrence:TaskIsOccurrence completionHandler:^(BOOL finished, NSMutableDictionary *returningUpdatedTaskListDictLocal) {
                           
                            finishBlock(YES, itemDictToBeUpdated, itemOccurrencesDict, returningUpdatedTaskListDictLocal);
                            
                        }];
                        
                    }];
                    
                    
                    
                    
                    
                } else {
                    
                    [[[SetDataObject alloc] init] ResetRepeatingTask_CompletionBlock:1 completedQueries:1 itemUniqueIDArray:itemUniqueIDArray objectArr:objectArr taskListDict:taskListDict itemUniqueIDDict:itemUniqueIDDict SkipOccurrence:SkipOccurrence TaskIsOccurrence:TaskIsOccurrence completionHandler:^(BOOL finished, NSMutableDictionary *returningUpdatedTaskListDictLocal) {
                        
                        finishBlock(YES, itemDictToBeUpdated, itemOccurrencesDict, returningUpdatedTaskListDictLocal);
                        
                    }];
                    
                }
                
                
                
                
                
            } else {
                
                [[[SetDataObject alloc] init] ResetRepeatingTask_CompletionBlock:1 completedQueries:1 itemUniqueIDArray:itemUniqueIDArray objectArr:objectArr taskListDict:taskListDict itemUniqueIDDict:itemUniqueIDDict SkipOccurrence:SkipOccurrence TaskIsOccurrence:TaskIsOccurrence completionHandler:^(BOOL finished, NSMutableDictionary *returningUpdatedTaskListDictLocal) {
                    
                    finishBlock(YES, itemDictToBeUpdated, itemOccurrencesDict, returningUpdatedTaskListDictLocal);
                    
                }];
                
            }
            
        }
        
        
        
        
        
    } else {
        
        finishBlock(YES, itemDictToBeUpdated, itemOccurrencesDict, returningUpdatedTaskListDictLocal);
        
    }
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark Chats

-(void)UpdateDataGroupChatMessageReadArray:(NSString *)homeID itemID:(NSString *)itemID itemType:(NSString *)itemType chatID:(NSString *)chatID messageID:(NSString *)messageID messageReadArray:(NSMutableArray *)messageReadArray viewingGroupChat:(BOOL)viewingGroupChat viewingComments:(BOOL)viewingComments viewingLiveSupport:(BOOL)viewingLiveSupport completionHandler:(void (^)(BOOL finished))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    FIRDocumentReference *queryToUse;
    
    if (viewingComments) {
        
        NSString *collection = [NSString stringWithFormat:@"%@s", itemType];
        
        queryToUse = [[[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:collection] documentWithPath:itemID] collectionWithPath:@"Comments"] documentWithPath:messageID];
        
        NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
        [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Homes", collection, @"Comments"] documents:@[homeID, itemID, messageID] type:@"UpdateData;" setData:@{@"MessageRead" : messageReadArray} name:@"UpdateDataGroupChatMessageReadArray" queryID:queryID];
        
        [queryToUse updateData:@{@"MessageRead" : messageReadArray} completion:^(NSError * _Nullable error) {
            
            [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
            
            finishBlock(YES);
            
        }];
        
    } else {
        
        queryToUse = [[[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:@"GroupChats"] documentWithPath:chatID] collectionWithPath:@"Messages"] documentWithPath:messageID];
        
        NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
        [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Homes", @"GroupChats", @"Messages"] documents:@[homeID, chatID, messageID] type:@"UpdateData;" setData:@{@"MessageRead" : messageReadArray} name:@"UpdateDataGroupChatMessageReadArray" queryID:queryID];
        
        [queryToUse updateData:@{@"MessageRead" : messageReadArray} completion:^(NSError * _Nullable error) {
            
            [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
            
            finishBlock(YES);
            
        }];
        
    }
    
}

-(void)UpdateDataLiveSupportMessageReadArray:(NSString *)userID messageID:(NSString *)messageID messageReadArray:(NSMutableArray *)messageReadArray completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Users", @"LiveSupport"] documents:@[userID, messageID] type:@"UpdateData;" setData:@{@"MessageRead" : messageReadArray} name:@"UpdateDataLiveSupportMessageReadArray" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Users"] documentWithPath:userID] collectionWithPath:@"LiveSupport"] documentWithPath:messageID] updateData:@{@"MessageRead" : messageReadArray} completion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

-(NSMutableDictionary *)GenerateMessageDictWithUpdatedMessageReadArray:(NSMutableDictionary *)messageDict messageID:(NSString *)messageID {
    
    NSUInteger index = [messageDict[@"MessageID"] indexOfObject:messageID];
    NSMutableArray *messageReadArray = [messageDict[@"MessageRead"][index] mutableCopy];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] &&
        [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] != nil &&
        [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] != NULL &&
        [messageReadArray containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] == NO) {
        [messageReadArray addObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    }
    
    NSMutableArray *arrayOfMessageReadArrays = messageDict[@"MessageRead"];
    if ([arrayOfMessageReadArrays count] > index) { [arrayOfMessageReadArrays replaceObjectAtIndex:index withObject:messageReadArray]; }
    
    [messageDict setObject:arrayOfMessageReadArrays forKey:@"MessageRead"];
    
    return messageDict;
}

#pragma mark Users

-(NSMutableDictionary *)GenerateItemActivityDict:(NSString *)itemID itemOccurrenceID:(NSString *)itemOccurrenceID activityUserIDNo1:(NSString *)activityUserIDNo1 homeID:(NSString *)homeID activityAction:(NSString *)activityAction userTitle:(NSString *)userTitle userDescription:(NSString *)userDescription itemType:(NSString *)itemType {
    
    NSMutableDictionary *activitySetDataDict = [NSMutableDictionary dictionary];
    [activitySetDataDict setObject:[[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString] forKey:@"ActivityID"];
    [activitySetDataDict setObject:itemID forKey:@"ActivityItemID"];
    [activitySetDataDict setObject:itemOccurrenceID forKey:@"ActivityItemOccurrenceID"];
    [activitySetDataDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] forKey:@"ActivityUserID"];
    [activitySetDataDict setObject:activityUserIDNo1 forKey:@"ActivityUserIDNo1"];
    [activitySetDataDict setObject:homeID forKey:@"ActivityHomeID"];
    [activitySetDataDict setObject:[[[GeneralObject alloc] init] GenerateCurrentDateString] forKey:@"ActivityDatePosted"];
    [activitySetDataDict setObject:activityAction forKey:@"ActivityAction"];
    [activitySetDataDict setObject:userTitle forKey:@"ActivityTitle"];
    [activitySetDataDict setObject:userDescription forKey:@"ActivityDescription"];
    [activitySetDataDict setObject:@[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] forKey:@"ActivityRead"];
    [activitySetDataDict setObject:itemType forKey:@"ActivityItemType"];
    [activitySetDataDict setObject:@"No" forKey:@"ActivityForHome"];
    
    return activitySetDataDict;
}

-(NSMutableDictionary *)GenerateHomeActivityDict:(NSString *)activityUserIDNo1 homeID:(NSString *)homeID activityAction:(NSString *)activityAction itemTitle:(NSString *)itemTitle itemDescription:(NSString *)itemDescription itemType:(NSString *)itemType {
    
    NSMutableDictionary *activitySetDataDict = [NSMutableDictionary dictionary];
    [activitySetDataDict setObject:[[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString] forKey:@"ActivityID"];
    [activitySetDataDict setObject:@"" forKey:@"ActivityItemID"];
    [activitySetDataDict setObject:@"" forKey:@"ActivityItemOccurrenceID"];
    [activitySetDataDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] forKey:@"ActivityUserID"];
    [activitySetDataDict setObject:activityUserIDNo1 forKey:@"ActivityUserIDNo1"];
    [activitySetDataDict setObject:homeID forKey:@"ActivityHomeID"];
    [activitySetDataDict setObject:[[[GeneralObject alloc] init] GenerateCurrentDateString] forKey:@"ActivityDatePosted"];
    [activitySetDataDict setObject:activityAction forKey:@"ActivityAction"];
    [activitySetDataDict setObject:itemTitle forKey:@"ActivityTitle"];
    [activitySetDataDict setObject:itemDescription forKey:@"ActivityDescription"];
    [activitySetDataDict setObject:@[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] forKey:@"ActivityRead"];
    [activitySetDataDict setObject:itemType forKey:@"ActivityItemType"];
    [activitySetDataDict setObject:@"Yes" forKey:@"ActivityForHome"];
    
    return activitySetDataDict;
}

#pragma mark Items

#pragma mark UpdateDataForNewHomeMember

-(void)UpdateDataForNewHomeMember_ResetNotifications:(NSMutableDictionary *)dictToUse homeMembersDict:(NSMutableDictionary *)homeMembersDict ResetNotifications:(BOOL)ResetNotifications notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays collection:(NSString *)collection keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        if (ResetNotifications == YES) {
            
            NSString *itemCreatedBy = dictToUse[@"ItemCreatedBy"] ? dictToUse[@"ItemCreatedBy"] : @"";
            NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? dictToUse[@"ItemAssignedTo"] : [NSMutableArray array];
            
            NSString *itemType = [collection substringToIndex:[collection length] - 1];
            
            NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                           SkippingTurn:NO RemovingUser:NO
                                                                                                         FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                                DueDate:NO Reminder:NO
                                                                                                         SubtaskEditing:NO SubtaskDeleting:NO
                                                                                                       SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                         AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                                    EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                                      GroupChatMessages:NO LiveSupportMessages:NO
                                                                                                     SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                                    FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                               itemType:@""];
            
            NSMutableArray *userIDArray = [itemAssignedTo mutableCopy];
            NSMutableArray *userIDToRemoveArray = [NSMutableArray array];
            
            [userIDArray addObject:itemCreatedBy];
            
            [[[NotificationsObject alloc] init] ResetLocalNotificationReminderNotification:dictToUse homeMembersDict:homeMembersDict userIDArray:userIDArray userIDToRemoveArray:userIDToRemoveArray notificationSettingsDict:notificationSettingsDict allItemTagsArrays:allItemTagsArrays itemType:itemType notificationType:notificationType topicDict:topicDict completionHandler:^(BOOL finished) {
                
                finishBlock(YES);
                
            }];
            
        } else {
            
            finishBlock(YES);
            
        }
        
    });
    
}

-(void)UpdateDataForNewHomeMember_UpdateItemData:(FIRDocumentSnapshot *)doc collection:(NSString *)collection homeID:(NSString *)homeID updatedItemAssignedTo:(NSMutableArray *)updatedItemAssignedTo userToAdd:(NSString *)userToAdd completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *itemType = [collection substringToIndex:[collection length] - 1];
        
        NSString *itemID = doc.data[@"ItemID"] ? doc.data[@"ItemID"] : @"";
        NSString *itemOccurrenceID = doc.data[@"ItemOccurrenceID"] ? doc.data[@"ItemOccurrenceID"] : @"";
      
        NSString *itemAmount = [itemType isEqualToString:@"Expense"] ? [[[SetDataObject alloc] init] GenerateUpdatedItemAmount:doc userID:userToAdd] : @"";
        NSMutableDictionary *itemCostPerPerson = [itemType isEqualToString:@"Expense"] ? [[[SetDataObject alloc] init] GenerateUpdatedItemCostPerPersonDict:doc userID:userToAdd] : [@{} mutableCopy];
        
        NSDictionary *dataDict =
        [itemType isEqualToString:@"Expense"] ?
        @{@"ItemAssignedTo" : updatedItemAssignedTo, @"ItemAmount" : itemAmount, @"ItemCostPerPerson" : itemCostPerPerson} :
        @{@"ItemAssignedTo" : updatedItemAssignedTo};
        
        [[[SetDataObject alloc] init] UpdateDataEditItem:dataDict itemID:itemID itemOccurrenceID:itemOccurrenceID collection:collection homeID:homeID completionHandler:^(BOOL finished) {
      
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)UpdateDataForNewHomeMember_UpdateTopicData:(FIRDocumentSnapshot *)doc homeID:(NSString *)homeID updatedItemAssignedTo:(NSMutableArray *)updatedItemAssignedTo completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *itemID = doc.data[@"ItemID"] ? doc.data[@"ItemID"] : @"";
        NSString *itemOccurrenceID = doc.data[@"ItemOccurrenceID"] ? doc.data[@"ItemOccurrenceID"] : @"";
        
        [[[SetDataObject alloc] init] SubsribeOrUnsubscribeAndUpdateTopic:homeID topicID:itemID itemOccurrenceID:itemOccurrenceID dataDict:@{@"TopicAssignedTo" : updatedItemAssignedTo} SubscribeToTopic:YES UnsubscribeFromTopic:NO completionHandler:^(BOOL finished) {
          
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)UpdateDataForNewHomeMember_CompletionBlock:(int)totalQueries completedQueries:(int)completedQueries snapshotDocuments:(NSMutableArray *)snapshotDocuments objectArr:(NSMutableArray *)objectArr completionHandler:(void (^)(BOOL finished))finishBlock {
    
    if (totalQueries == completedQueries) {
 
        if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:[snapshotDocuments mutableCopy] objectArr:objectArr]) {
           
            finishBlock(YES);
            
        }
        
    }
    
}

#pragma mark

-(NSMutableArray *)GenerateSnapshotDocumentsArray:(NSArray <FIRDocumentSnapshot *> * _Nonnull)documents {
    
    NSMutableArray *snapshotDocuments = [NSMutableArray array];
    
    for (FIRDocumentSnapshot *doc in documents) {
        [snapshotDocuments addObject:doc];
    }
    
    return snapshotDocuments;
}

-(NSMutableDictionary *)GenerateDictToUseForFIRDocument:(NSArray *)keyArray doc:(FIRDocumentSnapshot *)doc updatedItemAssignedTo:(NSMutableArray *)updatedItemAssignedTo {
    
    NSMutableDictionary *dictToUse = [NSMutableDictionary dictionary];
    
    for (NSString *key in keyArray) {
        
        id object = doc.data[key] ? doc.data[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
        [dictToUse setObject:object forKey:key];
        
    }
    
    [dictToUse setObject:updatedItemAssignedTo forKey:@"ItemAssignedTo"];
    
    return dictToUse;
    
}

-(NSMutableArray *)GenerateUpdatedItemAssignedToArrayForFIRDocument:(FIRDocumentSnapshot *)doc userID:(NSString *)userID assignedToKey:(NSString *)assignedToKey {
    
    NSString *itemAssignedToNewHomeMembers = doc.data[@"ItemAssignedToNewHomeMembers"] ? doc.data[@"ItemAssignedToNewHomeMembers"] : @"No";
    
    NSMutableArray *itemAssignedTo = doc.data[assignedToKey] ? [doc.data[assignedToKey] mutableCopy] : [NSMutableArray array];
    
    if ([itemAssignedTo containsObject:userID] == NO &&
        [itemAssignedToNewHomeMembers isEqualToString:@"Yes"]) {
        
        [itemAssignedTo addObject:userID];
        
    }
    
    return itemAssignedTo;
    
}

#pragma mark UpdateDataNextUsersTurnForDeletedHomeMember

-(void)UpdateDataNextUsersTurnForDeletedHomeMember_UpdateDataSkipUsersTurn:(NSString *)itemType itemTypeCollection:(NSString *)itemTypeCollection homeID:(NSString *)homeID homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays homeMembersArray:(NSMutableArray *)homeMembersArray userID:(NSString *)userID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSArray *keyArray = [[[GeneralObject alloc] init] GenerateKeyArrayManually:[itemType containsString:@"Chore"] Expense:[itemType containsString:@"Expense"] List:[itemType containsString:@"List"] Home:NO];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[GetDataObject alloc] init] GetDataGetItemsTurnUserID:homeID collection:itemTypeCollection userID:userID keyArray:keyArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningItemsDict) {
            
            NSMutableArray *objectArr = [NSMutableArray array];
            
            if ([(NSArray *)returningItemsDict[@"ItemUniqueID"] count] == 0) {
                
                finishBlock(YES);
                
            }
            
            for (NSString *itemUniqueID in returningItemsDict[@"ItemUniqueID"]) {
                
                NSUInteger index = [returningItemsDict[@"ItemUniqueID"] indexOfObject:itemUniqueID];
                
                NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:returningItemsDict keyArray:[returningItemsDict allKeys] indexPath:[NSIndexPath indexPathForRow:index inSection:0]];
                
                [[[SetDataObject alloc] init] UpdateDataSkipUsersTurn:itemType itemTypeCollection:itemTypeCollection homeID:homeID keyArray:keyArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType topicDict:topicDict allItemTagsArrays:allItemTagsArrays homeMembersArray:homeMembersArray dictToUse:singleObjectItemDict userID:userID SkippingTurn:NO DeletingHomeMember:YES completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDictToUse) {
                    
                    if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:returningItemsDict[@"ItemUniqueID"] objectArr:objectArr]) {
                        
                        finishBlock(YES);
                        
                    }
                    
                }];
                
            }
            
        }];
        
    });
    
}

-(void)UpdateDataNextUsersTurnForDeletedHomeMember_CompletionBlock:(int)totalQueries completedQueries:(int)completedQueries completionHandler:(void (^)(BOOL finished))finishBlock {
    
    if (totalQueries == completedQueries) {
        
        finishBlock(YES);
        
    }
    
}

#pragma mark UpdateDataSkipUsersTurn

-(NSDictionary *)UpdateDataSkipUsersTurn_GenerateSkipUserTurnDict:(NSMutableDictionary *)dictToUse homeMembersDict:(NSMutableDictionary *)homeMembersDict itemType:(NSString *)itemType {
    
    NSString *itemTakeTurns = dictToUse[@"ItemTakeTurns"] ? dictToUse[@"ItemTakeTurns"] : @"";
    __block NSString *itemTurnUserID = dictToUse[@"ItemTurnUserID"] ? dictToUse[@"ItemTurnUserID"] : @"";
    __block NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? [dictToUse[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    __block NSMutableArray *itemAssignedToOriginal = dictToUse[@"ItemAssignedTo"] ? [dictToUse[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    NSMutableDictionary *itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? dictToUse[@"ItemCompletedDict"] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemInProgressDict = dictToUse[@"ItemInProgressDict"] ? [dictToUse[@"ItemInProgressDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemWontDo = dictToUse[@"ItemWontDo"] ? [dictToUse[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemSubTasks = dictToUse[@"ItemSubTasks"] ? [dictToUse[@"ItemSubTasks"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemApprovalRequests = dictToUse[@"ItemApprovalRequests"] ? [dictToUse[@"ItemApprovalRequests"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSString *itemDueDate = dictToUse[@"ItemDueDate"] ? dictToUse[@"ItemDueDate"] : @"";
    NSString *itemRepeats = dictToUse[@"ItemRepeats"] ? dictToUse[@"ItemRepeats"] : @"";
    NSString *itemRepeatIfCompletedEarly = dictToUse[@"ItemRepeatIfCompletedEarly"] ? dictToUse[@"ItemRepeatIfCompletedEarly"] : @"";
    NSString *itemCompleteAsNeeded = dictToUse[@"ItemCompleteAsNeeded"] ? dictToUse[@"ItemCompleteAsNeeded"] : @"";
    
    
    
    if ([itemCompleteAsNeeded isEqualToString:@"No"]) {
        
        itemCompletedDict = [NSMutableDictionary dictionary];
        itemInProgressDict = [NSMutableDictionary dictionary];
        itemWontDo = [NSMutableDictionary dictionary];
        itemApprovalRequests = [NSMutableDictionary dictionary];
        
        NSMutableDictionary *itemSubTasksDict = [itemSubTasks mutableCopy];
        
        for (NSString *subtask in [itemSubTasksDict allKeys]) {
            
            NSMutableDictionary *subtaskCompletedDict = itemSubTasksDict[subtask][@"Completed Dict"] ? [itemSubTasksDict[subtask][@"Completed Dict"] mutableCopy] : [NSMutableDictionary dictionary];
            NSMutableDictionary *subtaskInProgressDict = itemSubTasksDict[subtask][@"In Progress Dict"] ? [itemSubTasksDict[subtask][@"In Progress Dict"] mutableCopy] : [NSMutableDictionary dictionary];
            NSMutableDictionary *subtaskWontDoDict = itemSubTasksDict[subtask][@"Wont Do"] ? [itemSubTasksDict[subtask][@"Wont Do"] mutableCopy] : [NSMutableDictionary dictionary];
            
            subtaskCompletedDict = [NSMutableDictionary dictionary];
            subtaskInProgressDict = [NSMutableDictionary dictionary];
            subtaskWontDoDict = [NSMutableDictionary dictionary];
            
            NSMutableDictionary *tempDict = [itemSubTasksDict[subtask] mutableCopy];
            [tempDict setObject:subtaskCompletedDict forKey:@"Completed Dict"];
            itemSubTasksDict[subtask] = [tempDict mutableCopy];
            
            tempDict = [itemSubTasksDict[subtask] mutableCopy];
            [tempDict setObject:subtaskInProgressDict forKey:@"In Progress Dict"];
            itemSubTasksDict[subtask] = [tempDict mutableCopy];
            
            tempDict = [itemSubTasksDict[subtask] mutableCopy];
            [tempDict setObject:subtaskWontDoDict forKey:@"Wont Do"];
            itemSubTasksDict[subtask] = [tempDict mutableCopy];
            
        }
        
        itemSubTasks = [itemSubTasksDict mutableCopy];
        
        
        
        [dictToUse setObject:itemAssignedTo forKey:@"ItemAssignedTo"];
        [dictToUse setObject:itemCompletedDict forKey:@"ItemCompletedDict"];
        [dictToUse setObject:itemInProgressDict forKey:@"ItemInProgressDict"];
        [dictToUse setObject:itemSubTasks forKey:@"ItemSubTasks"];
        [dictToUse setObject:itemApprovalRequests forKey:@"ItemApprovalRequests"];
   
    }
    
    
    
    itemTurnUserID = [[[GeneralObject alloc] init] GenerateNextUsersTurn:itemAssignedTo itemAssignedToOriginal:itemAssignedToOriginal homeMembersDict:homeMembersDict itemTakeTurns:itemTakeTurns itemTurnUserID:itemTurnUserID];
    
    if (itemTurnUserID.length == 0 && [itemTakeTurns isEqualToString:@"Yes"]) {
        
        itemTurnUserID = [[[GeneralObject alloc] init] GenerateCurrentUsersTurn:itemDueDate itemRepeats:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly itemCompleteAsNeeded:itemCompleteAsNeeded itemTakeTurns:itemTakeTurns itemCompletedDict:itemCompletedDict itemAssignedToArray:itemAssignedTo itemType:itemType itemTurnUserID:itemTurnUserID homeMembersDict:homeMembersDict];
        
    }
    
    [dictToUse setObject:itemTurnUserID forKey:@"ItemTurnUserID"];
   
    
    
    return dictToUse;
}

-(void)UpdateDataSkipUsersTurn_SendPushNotifications:(NSMutableDictionary *)dictToUse itemType:(NSString *)itemType homeID:(NSString *)homeID homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays userID:(NSString *)userID SkippingTurn:(BOOL)SkippingTurn DeletingHomeMember:(BOOL)DeletingHomeMember completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemCreatedBy = dictToUse[@"ItemCreatedBy"] ? dictToUse[@"ItemCreatedBy"] : @"";
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    __block NSString *itemTurnUserID = dictToUse[@"ItemTurnUserID"] ? dictToUse[@"ItemTurnUserID"] : @"";
    __block NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? [dictToUse[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    
    
    
    NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userID homeMembersDict:homeMembersDict];
    NSString *username = dataDict[@"Username"];
    
    
    
    NSString *myUsername = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] : @"";
    NSString *userTurn = [username isEqualToString:myUsername] ? @"their" : [NSString stringWithFormat:@"%@'s", username];
    
    dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:itemTurnUserID homeMembersDict:homeMembersDict];
    NSString *nextUsersUsername = dataDict[@"Username"] && [dataDict[@"Username"] length] > 0 ? dataDict[@"Username"] : @"the next person";
    
    
    NSString *firstPartOfBody = SkippingTurn == YES ? [NSString stringWithFormat:@"%@ has skipped %@ turn. ", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"], userTurn] : @"";
    
    NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", itemName];
    NSString *notificationBody = [NSString stringWithFormat:@"%@It is now %@'s turn to complete this %@. 🙂", firstPartOfBody, nextUsersUsername, [itemType lowercaseString]];
    
    
    
    NSMutableArray *usersToSendNotificationTo = [itemAssignedTo mutableCopy];
    
    NSArray *addTheseUsers = @[itemCreatedBy];
    NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    
    usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                       SkippingTurn:YES RemovingUser:NO
                                                                                                     FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                            DueDate:NO Reminder:NO
                                                                                                     SubtaskEditing:NO SubtaskDeleting:NO
                                                                                                   SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                     AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                                EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                                  GroupChatMessages:NO LiveSupportMessages:NO
                                                                                                 SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                                FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                           itemType:itemType];
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                           dictToUse:dictToUse
                                                                              homeID:homeID homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict
                                                            notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType
                                                                           topicDict:topicDict
                                                                allItemTagsArrays:allItemTagsArrays
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)UpdateDataSkipUsersTurn_ResetItemNotifications:(NSMutableDictionary *)dictToUse itemType:(NSString *)itemType keyArray:(NSArray *)keyArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemCreatedBy = dictToUse[@"ItemCreatedBy"] ? dictToUse[@"ItemCreatedBy"] : @"";
    __block NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? [dictToUse[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    
    NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                   SkippingTurn:YES RemovingUser:NO
                                                                                                 FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                        DueDate:NO Reminder:NO
                                                                                                 SubtaskEditing:NO SubtaskDeleting:NO
                                                                                               SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                 AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                            EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                              GroupChatMessages:NO LiveSupportMessages:NO
                                                                                             SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                            FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                       itemType:itemType];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableArray *userIDArray = [itemAssignedTo mutableCopy];
        NSMutableArray *userIDToRemoveArray = [NSMutableArray array];
        
        [userIDArray addObject:itemCreatedBy];
        
        [[[NotificationsObject alloc] init] ResetLocalNotificationReminderNotification:dictToUse homeMembersDict:homeMembersDict userIDArray:userIDArray userIDToRemoveArray:userIDToRemoveArray notificationSettingsDict:notificationSettingsDict allItemTagsArrays:allItemTagsArrays itemType:itemType notificationType:notificationType topicDict:topicDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)UpdateDataSkipUsersTurn_UpdateItemData:(NSMutableDictionary *)dictToUse collection:(NSString *)collection homeID:(NSString *)homeID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
    NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"";
    
    __block NSString *itemTurnUserID = dictToUse[@"ItemTurnUserID"] ? dictToUse[@"ItemTurnUserID"] : @"";
    NSMutableDictionary *itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? dictToUse[@"ItemCompletedDict"] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemInProgressDict = dictToUse[@"ItemInProgressDict"] ? [dictToUse[@"ItemInProgressDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemWontDo = dictToUse[@"ItemWontDo"] ? [dictToUse[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemSubTasks = dictToUse[@"ItemSubTasks"] ? [dictToUse[@"ItemSubTasks"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemApprovalRequests = dictToUse[@"ItemApprovalRequests"] ? [dictToUse[@"ItemApprovalRequests"] mutableCopy] : [NSMutableDictionary dictionary];
    
    itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? dictToUse[@"ItemCompletedDict"] : itemCompletedDict;
    itemInProgressDict = dictToUse[@"ItemInProgressDict"] ? dictToUse[@"ItemInProgressDict"] : itemInProgressDict;
    itemWontDo = dictToUse[@"ItemWontDo"] ? dictToUse[@"ItemWontDo"] : itemWontDo;
    itemSubTasks = dictToUse[@"ItemSubTasks"] ? dictToUse[@"ItemSubTasks"] : itemSubTasks;
    itemApprovalRequests = dictToUse[@"ItemApprovalRequests"] ? dictToUse[@"ItemApprovalRequests"] : itemApprovalRequests;
    itemTurnUserID = dictToUse[@"ItemTurnUserID"] ? dictToUse[@"ItemTurnUserID"] : itemTurnUserID;
    
    NSDictionary* dataDict = @{
        @"ItemCompletedDict" : itemCompletedDict ? itemCompletedDict : [NSMutableDictionary dictionary],
        @"ItemInProgressDict" : itemInProgressDict ? itemInProgressDict : [NSMutableDictionary dictionary],
        @"ItemWontDo" : itemWontDo ? itemWontDo : [NSMutableDictionary dictionary],
        @"ItemSubTasks" : itemSubTasks ? itemSubTasks : [NSMutableDictionary dictionary],
        @"ItemApprovalRequests" : itemApprovalRequests ? itemApprovalRequests : [NSMutableDictionary dictionary],
        @"ItemTurnUserID" : itemTurnUserID};
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataEditItem:dataDict itemID:itemID itemOccurrenceID:itemOccurrenceID collection:collection homeID:homeID completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)UpdateDataSkipUsersTurn_CompletionBlock:(NSMutableDictionary *)dictToUse totalQueries:(int)totalQueries completedQueries:(int)completedQueries completionHandler:(void (^)(BOOL finished))finishBlock {
    
    if (totalQueries == completedQueries) {
        
        finishBlock(YES);
        
    }
    
}

#pragma mark UpdateDataResetRepeatingTask

-(BOOL)UpdateDataResetRepeatingTask_ItemNeedsToBeReset:(NSMutableDictionary *)specificItemDataDict itemDict:(NSMutableDictionary *)itemDict itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict SkipOccurrence:(BOOL)SkipOccurrence TaskIsFullyCompleted:(BOOL)TaskIsFullyCompleted {
    
    NSString *itemOccurrenceID = specificItemDataDict[@"ItemOccurrenceID"];
    NSString *itemStatus = specificItemDataDict[@"ItemStatus"];
    NSString *itemTrash = specificItemDataDict[@"ItemTrash"];
    
    
    
    BOOL ItemRepeatsAndCurrentDueDateHasPassed = [[[SetDataObject alloc] init] UpdateDataResetRepeatingTask_ItemRepeatsAndCurrentDueDateHasPassed:specificItemDataDict itemDict:itemDict itemOccurrencesDict:itemOccurrencesDict itemType:itemType homeMembersDict:homeMembersDict TaskIsFullyCompleted:TaskIsFullyCompleted];
    BOOL ItemDoesNotRepeatAndMultipleSpecificDueDatesFoundAndFutureDateFoundAndCurrentDueDateHasPassed = [[[SetDataObject alloc] init] UpdateDataResetRepeatingTask_ItemDoesNotRepeatAndMultipleSpecificDueDatesFoundAndFutureDateFoundAndCurrentDueDateHasPassed:specificItemDataDict itemDict:itemDict itemOccurrencesDict:itemOccurrencesDict itemType:itemType homeMembersDict:homeMembersDict];
    BOOL ItemRepeatsAndDueDateIsNil = [[[SetDataObject alloc] init] UpdateDataResetRepeatingTask_ItemRepeatsAndDueDateIsNil:specificItemDataDict itemDict:itemDict itemOccurrencesDict:itemOccurrencesDict itemType:itemType homeMembersDict:homeMembersDict];
    BOOL ItemRepeatsOnlyWhenCompletedAndIsFullyCompleted = [[[SetDataObject alloc] init] UpdateDataResetRepeatingTask_ItemRepeatsOnlyWhenCompletedAndIsFullyCompleted:specificItemDataDict itemType:itemType TaskIsFullyCompleted:TaskIsFullyCompleted];
    
          
    
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:specificItemDataDict itemType:itemType];
    
    BOOL TaskIsPaused = [itemStatus isEqualToString:@"Paused"];
    BOOL TaskIsInTrash = [itemTrash isEqualToString:@"Yes"];
    BOOL TaskIsOccurrence = itemOccurrenceID.length > 0 && [itemOccurrenceID isEqualToString:@"xxx"] == NO;
    
    
    
    BOOL ItemNeedsToBeReset =
    
    (ItemRepeatsAndCurrentDueDateHasPassed == YES ||
     ItemDoesNotRepeatAndMultipleSpecificDueDatesFoundAndFutureDateFoundAndCurrentDueDateHasPassed == YES ||
     ItemRepeatsAndDueDateIsNil == YES ||
     ItemRepeatsOnlyWhenCompletedAndIsFullyCompleted == YES) &&
    
    TaskIsCompleteAsNeeded == NO && TaskIsPaused == NO && TaskIsInTrash == NO && 
    (TaskIsOccurrence == NO || SkipOccurrence == YES);
    
    
    
    return ItemNeedsToBeReset;
}

-(NSString *)UpdateDataResetRepeatingTask_GenerateMultipleDueDatesNextDueDate:(NSMutableDictionary *)specificItemDataDict itemDict:(NSMutableDictionary *)itemDict itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    NSString *itemDueDate = specificItemDataDict[@"ItemDueDate"] ? specificItemDataDict[@"ItemDueDate"] : @"";
    NSMutableArray *itemSpecificDueDates = specificItemDataDict[@"ItemSpecificDueDates"] ? [specificItemDataDict[@"ItemSpecificDueDates"] mutableCopy] : [NSMutableArray array];
    
    BOOL ItemDoesNotRepeatAndMultipleSpecificDueDatesFoundAndFutureDateFoundAndCurrentDueDateHasPassed = [[[SetDataObject alloc] init] UpdateDataResetRepeatingTask_ItemDoesNotRepeatAndMultipleSpecificDueDatesFoundAndFutureDateFoundAndCurrentDueDateHasPassed:specificItemDataDict itemDict:itemDict itemOccurrencesDict:itemOccurrencesDict itemType:itemType homeMembersDict:homeMembersDict];
    
    if (ItemDoesNotRepeatAndMultipleSpecificDueDatesFoundAndFutureDateFoundAndCurrentDueDateHasPassed == YES) {
        
        NSDictionary *dict = [[[SetDataObject alloc] init] UpdateDataResetRepeatingTask_GenerateMultipleDueDatesNextDueDateNo1:itemSpecificDueDates];
        NSString *possibleNewDueDate = [dict[@"PossibleNewDueDate"] isEqualToString:@""] ? itemDueDate : dict[@"PossibleNewDueDate"];
        
        itemDueDate = possibleNewDueDate;
        
    }
    
    return itemDueDate;
}

-(NSMutableDictionary *)UpdateDataResetRepeatingTask_GenerateUpdatedItemOccurrencesDict:(NSMutableDictionary *)specificItemDataDict itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict TaskIsFullyCompleted:(BOOL)TaskIsFullyCompleted SkipOccurrence:(BOOL)SkipOccurrence {
    
    NSString *itemID = specificItemDataDict[@"ItemID"] ? specificItemDataDict[@"ItemID"] : @"";
    
    NSArray *arr = TaskIsFullyCompleted == YES && SkipOccurrence == NO ? @[@"Completions_AlternatingTurns", @"Occurrences_AlternatingTurns", @"Occurrences_EndNumberOfTimes"] : @[@"Occurrences_AlternatingTurns", @"Occurrences_EndNumberOfTimes"];
    
    for (NSString *key in arr) {
        
        if (itemOccurrencesDict[key] && itemOccurrencesDict[key][itemID]) {
            
            int numOfOccurrences = itemOccurrencesDict[key] && itemOccurrencesDict[key][itemID] ? [(NSString *)itemOccurrencesDict[key][itemID] intValue] : 0;
            
            NSMutableDictionary *itemOccurrencesDictCopy = [itemOccurrencesDict mutableCopy];
            NSMutableDictionary *innerDictCopy = [itemOccurrencesDictCopy[key] mutableCopy];
            [innerDictCopy setObject:[NSString stringWithFormat:@"%d", numOfOccurrences+1] forKey:itemID];
            [itemOccurrencesDictCopy setObject:innerDictCopy forKey:key];
            itemOccurrencesDict = [itemOccurrencesDictCopy mutableCopy];
            
        } else if ([key isEqualToString:@"Completions_AlternatingTurns"]) {
            
            NSString *itemOccurrenceID = specificItemDataDict[@"ItemOccurrenceID"];
            NSString *itemAlternateTurns = specificItemDataDict[@"ItemAlternateTurns"];
            
            if ([itemAlternateTurns length] > 0 && itemOccurrenceID.length == 0 && [itemAlternateTurns containsString:@" Completion"]) {
                
                NSMutableDictionary *itemOccurrencesDictCopy = [itemOccurrencesDict mutableCopy];
                NSMutableDictionary *innerDictCopy = [itemOccurrencesDictCopy[key] mutableCopy];
                [innerDictCopy setObject:[NSString stringWithFormat:@"%d", 1] forKey:itemID];
                [itemOccurrencesDictCopy setObject:innerDictCopy forKey:key];
                itemOccurrencesDict = [itemOccurrencesDictCopy mutableCopy];
                
            }
            
        } else if ([key isEqualToString:@"Occurrences_AlternatingTurns"]) {
            
            NSString *itemOccurrenceID = specificItemDataDict[@"ItemOccurrenceID"];
            NSString *itemAlternateTurns = specificItemDataDict[@"ItemAlternateTurns"];
            
            if ([itemAlternateTurns length] > 0 && itemOccurrenceID.length == 0 && [itemAlternateTurns containsString:@" Occurrence"]) {
                
                NSMutableDictionary *itemOccurrencesDictCopy = [itemOccurrencesDict mutableCopy];
                NSMutableDictionary *innerDictCopy = [itemOccurrencesDictCopy[key] mutableCopy];
                [innerDictCopy setObject:[NSString stringWithFormat:@"%d", 1] forKey:itemID];
                [itemOccurrencesDictCopy setObject:innerDictCopy forKey:key];
                itemOccurrencesDict = [itemOccurrencesDictCopy mutableCopy];
                
            }
            
        } else if ([key isEqualToString:@"Occurrences_EndNumberOfTimes"]) {
            
            NSString *itemOccurrenceID = specificItemDataDict[@"ItemOccurrenceID"];
            NSString *itemEndNumberOfTimes = specificItemDataDict[@"ItemEndNumberOfTimes"];
            
            if ([itemEndNumberOfTimes isEqualToString:@"Yes"] && itemOccurrenceID.length == 0) {
                
                NSMutableDictionary *itemOccurrencesDictCopy = [itemOccurrencesDict mutableCopy];
                NSMutableDictionary *innerDictCopy = [itemOccurrencesDictCopy[key] mutableCopy];
                [innerDictCopy setObject:[NSString stringWithFormat:@"%d", 1] forKey:itemID];
                [itemOccurrencesDictCopy setObject:innerDictCopy forKey:key];
                itemOccurrencesDict = [itemOccurrencesDictCopy mutableCopy];
                
            }
            
        }
        
    }
    
    return itemOccurrencesDict;
}

-(NSMutableDictionary *)UpdateDataResetRepeatingTask_GenerateDictWithSpecificUpdatedValues:(NSMutableDictionary *)specificItemDataDict itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict collection:(NSString *)collection itemType:(NSString *)itemType homeID:(NSString *)homeID keyArray:(NSArray *)keyArray homeMembersDict:(NSMutableDictionary *)homeMembersDict allItemAssignedToArrays:(NSMutableArray *)allItemAssignedToArrays indexOfUniqueID:(NSUInteger)indexOfUniqueID SkipOccurrence:(BOOL)SkipOccurrence {
    
    NSMutableDictionary *itemSubTasks = [itemType isEqualToString:@"Chore"] ? [specificItemDataDict[@"ItemSubTasks"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemItemizedItems = [itemType isEqualToString:@"Expense"] ? [specificItemDataDict[@"ItemItemizedItems"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemListItems = [itemType isEqualToString:@"List"] ? [specificItemDataDict[@"ItemListItems"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSMutableDictionary *itemCompletedDict = [specificItemDataDict[@"ItemCompletedDict"] mutableCopy];
    NSMutableDictionary *itemInProgressDict = [specificItemDataDict[@"ItemInProgressDict"] mutableCopy];
    NSMutableDictionary *itemWontDo = [specificItemDataDict[@"ItemWontDo"] mutableCopy];
    NSMutableDictionary *itemPhotoConfirmation = [specificItemDataDict[@"ItemPhotoConfirmationDict"] mutableCopy];
    NSMutableDictionary *itemOccurrencesPastDue = [specificItemDataDict[@"ItemOccurrencePastDue"] mutableCopy];
    NSMutableArray *itemAssignedTo = [specificItemDataDict[@"ItemAssignedTo"] mutableCopy];
    NSMutableArray *itemSpecificDueDates = [specificItemDataDict[@"ItemSpecificDueDates"] mutableCopy];
    NSMutableArray *itemDueDatesSkipped = [specificItemDataDict[@"ItemDueDatesSkipped"] mutableCopy];
    NSString *itemID = specificItemDataDict[@"ItemID"];
    NSString *itemOccurrenceID = specificItemDataDict[@"ItemOccurrenceID"];
    NSString *itemCompleteAsNeeded = specificItemDataDict[@"ItemCompleteAsNeeded"];
    NSString *itemDatePosted = specificItemDataDict[@"ItemDatePosted"];
    NSString *itemStartDate = specificItemDataDict[@"ItemStartDate"];
    NSString *itemEndDate = specificItemDataDict[@"ItemEndDate"];
    NSString *itemRepeats = specificItemDataDict[@"ItemRepeats"];
    NSString *itemRepeatIfCompletedEarly = specificItemDataDict[@"ItemRepeatIfCompletedEarly"];
    NSString *itemTakeTurns = specificItemDataDict[@"ItemTakeTurns"];
    NSString *itemDateLastAlternatedTurns = specificItemDataDict[@"ItemDateLastAlternatedTurns"];
    NSString *itemDateLastReset = specificItemDataDict[@"ItemDateLastReset"];
    NSString *itemDays = specificItemDataDict[@"ItemDays"];
    NSString *itemTime = specificItemDataDict[@"ItemTime"];
    NSString *itemDueDate = specificItemDataDict[@"ItemDueDate"];
    NSString *itemRandomizeTurnOrder = specificItemDataDict[@"ItemRandomizeTurnOrder"];
    __block NSString *itemTurnUserID = [[[GeneralObject alloc] init] GenerateCurrentUserTurnFromDict:[specificItemDataDict mutableCopy] homeMembersDict:homeMembersDict itemType:itemType];
    
    if ([itemTime isEqualToString:@"Any Time"]) {
        itemTime = @"11:59 PM";
    }
    
    
    
    
    NSMutableDictionary *newItemCompletedDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *newItemInProgressDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *newItemWontDoDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *newSubTaskDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *newItemListItems = [NSMutableDictionary dictionary];
    NSMutableDictionary *newItemItemizedItems = [NSMutableDictionary dictionary];
    NSMutableDictionary *newItemPhotoConfirmationDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *newItemOccurrencesPastDueDict = [NSMutableDictionary dictionary];
    NSMutableArray *newItemAssignedToArray = [itemAssignedTo mutableCopy];
    NSString *newItemTurnUserID = [itemTurnUserID mutableCopy];
    NSString *newItemDateLastAlternatedTurns = [itemDateLastAlternatedTurns mutableCopy];
    NSString *newItemDateLastReset = [itemDateLastReset mutableCopy];
    
    
    
    
    newItemAssignedToArray = [[[GeneralObject alloc] init] GenerateObjectWithNonHomeMembersRemoved:[newItemAssignedToArray mutableCopy] homeMembersDict:homeMembersDict];
    newItemCompletedDict = [[[GeneralObject alloc] init] GenerateObjectWithNonHomeMembersRemoved:[newItemCompletedDict mutableCopy] homeMembersDict:homeMembersDict];
    newItemInProgressDict = [[[GeneralObject alloc] init] GenerateObjectWithNonHomeMembersRemoved:[newItemInProgressDict mutableCopy] homeMembersDict:homeMembersDict];
    newItemWontDoDict = [[[GeneralObject alloc] init] GenerateObjectWithNonHomeMembersRemoved:[newItemWontDoDict mutableCopy] homeMembersDict:homeMembersDict];
    
    
  
    
    if ([homeMembersDict[@"UserID"] containsObject:newItemTurnUserID] == NO && [newItemTurnUserID length] > 0) {
        newItemTurnUserID = [[[GeneralObject alloc] init] GenerateNextUsersTurn:newItemAssignedToArray itemAssignedToOriginal:newItemAssignedToArray homeMembersDict:homeMembersDict itemTakeTurns:itemTakeTurns itemTurnUserID:newItemTurnUserID];
    }
    
    
    
    
    if ([itemRandomizeTurnOrder isEqualToString:@"Yes"]) {
        
        NSDictionary *dict = [[[SetDataObject alloc] init] UpdateDataResetItemFields_GenerateComplicatedRandomArray:newItemAssignedToArray homeMembersDict:homeMembersDict allItemAssignedToArrays:allItemAssignedToArrays];
        newItemAssignedToArray = dict[@"UserIDArray"] ? [dict[@"UserIDArray"] mutableCopy] : [NSMutableArray array];
        
    }
    
    
    
    
    NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
    if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:itemDatePosted returnAs:[NSDate class]] == nil) {
        itemDatePosted = [[[GeneralObject alloc] init] GenerateDateWithConvertedFormatWithFormat:@"yyyy-MM-dd HH:mm:ss" dateToConvert:itemDatePosted newFormat:@"MMMM dd, yyyy hh:mm a" returnAs:[NSString class]];
    }
    
    
    
    
    newItemDateLastReset = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat: @"MMMM dd, yyyy hh:mm a" returnAs:[NSString class]];
    
    
    
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedItemTimeString = [itemTime stringByTrimmingCharactersInSet:charSet];
    
    if ([trimmedItemTimeString isEqualToString:@""]) {
        itemTime = @"11:59 PM";
    }
    
    
    
    
    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ResetingTask"];
    
    
    
    
    
    NSLog(@"testing Reseting1 oldDueDate:%@", itemDueDate);
    NSString *newItemDueDate = itemSpecificDueDates.count > 0 ?
    itemDueDate :
    //First Iteration Should Always Be Equal To NO Here Because It Will Look For The First Future Due Date And Ignore The Current Item Due Date
    [[[NotificationsObject alloc] init] GenerateArrayOfRepeatingDueDates:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly itemCompleteAsNeeded:itemCompleteAsNeeded totalAmountOfFutureDates:2 maxAmountOfDueDatesToLoopThrough:1000 itemDatePosted:itemDatePosted itemDueDate:itemDueDate itemStartDate:itemStartDate itemEndDate:itemEndDate itemTime:itemTime itemDays:itemDays itemDueDatesSkipped:itemDueDatesSkipped itemDateLastReset:itemDateLastReset SkipStartDate:SkipOccurrence][0];
    NSLog(@"testing Reseting2 newDueDate:%@", newItemDueDate);
    
    
    
    
    if ([newItemDueDate isEqualToString:itemDatePosted] &&
        itemDueDate.length > 0 && itemDueDate != nil &&
        [itemDueDate containsString:@"(null)"] == NO) {
       
        newItemDueDate = itemDueDate;
        
    }
    
    
    
    
    newItemDueDate = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:newItemDueDate stringToReplace:@"Any Time" replacementString:@"11:59 PM"];
    
    
   
    
    BOOL TaskIsFullyCompleted = [[[BoolDataObject alloc] init] TaskIsFullyCompleted:specificItemDataDict itemType:itemType homeMembersDict:homeMembersDict];
    BOOL TaskIsTakingTurns = [itemTakeTurns isEqualToString:@"Yes"];
    BOOL TaskIsAnOccurrence = (itemOccurrenceID.length > 0 && [itemOccurrenceID isEqualToString:@"xxx"] == NO);
    BOOL TimeToAlternateTurns = [[[BoolDataObject alloc] init] TimeToAlternateTurns:specificItemDataDict itemOccurrencesDict:itemOccurrencesDict itemType:itemType keyArray:keyArray homeMembersDict:homeMembersDict];
    
    
    
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:[@{@"ItemCompleteAsNeeded" : itemCompleteAsNeeded} mutableCopy] itemType:itemType];
    
  
    
    
    if (TimeToAlternateTurns == YES && TaskIsTakingTurns == YES && TaskIsAnOccurrence == NO && TaskIsCompleteAsNeeded == NO) {
        
        newItemTurnUserID = [[[GeneralObject alloc] init] GenerateNextUsersTurn:itemAssignedTo itemAssignedToOriginal:itemAssignedTo homeMembersDict:homeMembersDict itemTakeTurns:itemTakeTurns itemTurnUserID:itemTurnUserID];
        newItemDateLastAlternatedTurns = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy hh:mm a" returnAs:[NSString class]];
   
    } else if (TaskIsAnOccurrence == YES || (TaskIsCompleteAsNeeded == YES && TaskIsTakingTurns == NO)) {
        
        //Keep this data the same
        newItemCompletedDict = itemCompletedDict;
        newItemInProgressDict = itemInProgressDict;
        newItemWontDoDict = itemWontDo;
        newSubTaskDict = itemSubTasks;
        newItemListItems = itemListItems;
        newItemItemizedItems = itemItemizedItems;
        newItemPhotoConfirmationDict = itemPhotoConfirmation;
        newItemOccurrencesPastDueDict = itemOccurrencesPastDue;
        newItemDateLastReset = itemDateLastReset;
        
    }
    
    
    
    
    NSMutableDictionary *dataDictWithSpecificUpdatedValues = [@{
        
        @"ItemID" : itemID ? itemID : @"",
        @"ItemOccurrenceID" : itemOccurrenceID ? itemOccurrenceID : @"",
        @"ItemCompletedDict" : newItemCompletedDict ? newItemCompletedDict : [NSMutableDictionary dictionary],
        @"ItemInProgressDict" : newItemInProgressDict ? newItemInProgressDict : [NSMutableDictionary dictionary],
        @"ItemWontDo" : newItemWontDoDict ? newItemWontDoDict : [NSMutableDictionary dictionary],
        @"ItemPhotoConfirmationDict" : newItemPhotoConfirmationDict ? newItemPhotoConfirmationDict : [NSMutableDictionary dictionary],
        @"ItemDueDate" : newItemDueDate ? newItemDueDate : @"",
        @"ItemTurnUserID" : newItemTurnUserID ? newItemTurnUserID : @"",
        @"ItemAssignedTo" : newItemAssignedToArray ? newItemAssignedToArray : itemAssignedTo,
        @"ItemOccurrencePastDue" : newItemOccurrencesPastDueDict ? newItemOccurrencesPastDueDict : @{},
        @"ItemDateLastReset" : newItemDateLastReset ? newItemDateLastReset : @"",
        
    } mutableCopy];
    
    
    
    
    if ([itemType isEqualToString:@"Chore"]) {
        
        newSubTaskDict = [[[SetDataObject alloc] init] UpdateDataResetItemFields_GenerateSubTasksDict:itemSubTasks];
        
        if (TaskIsFullyCompleted == NO && [itemTakeTurns isEqualToString:@"Yes"]) {
            
            newSubTaskDict = itemSubTasks;
            
        }
        
        NSMutableDictionary *dataDictWithSpecificUpdatedValuesCopy = dataDictWithSpecificUpdatedValues ? [dataDictWithSpecificUpdatedValues mutableCopy] : [NSMutableDictionary dictionary];
        
        [dataDictWithSpecificUpdatedValuesCopy setObject:newSubTaskDict ? newSubTaskDict : [NSMutableDictionary dictionary] forKey:@"ItemSubTasks"];
        
        dataDictWithSpecificUpdatedValues = [dataDictWithSpecificUpdatedValuesCopy mutableCopy];
        
    }
    
    if ([itemType isEqualToString:@"Expense"]) {
        
        newItemItemizedItems = [[[SetDataObject alloc] init] UpdateDataResetItemFields_GenerateItemItemizedItems:itemItemizedItems];
        
        if (TaskIsFullyCompleted == NO && [itemTakeTurns isEqualToString:@"Yes"]) {
            
            newItemItemizedItems = itemItemizedItems;
            
        }
        
        NSMutableDictionary *dataDictWithSpecificUpdatedValuesCopy = dataDictWithSpecificUpdatedValues ? [dataDictWithSpecificUpdatedValues mutableCopy] : [NSMutableDictionary dictionary];
        
        [dataDictWithSpecificUpdatedValuesCopy setObject:newItemItemizedItems ? newItemItemizedItems : [NSMutableDictionary dictionary] forKey:@"ItemItemizedItems"];
        
        dataDictWithSpecificUpdatedValues = [dataDictWithSpecificUpdatedValuesCopy mutableCopy];
        
    }
   
    if ([itemType isEqualToString:@"List"]) {
        
        newItemListItems = [[[SetDataObject alloc] init] UpdateDataResetItemFields_GenerateItemListItems:itemListItems];
        
        if (TaskIsFullyCompleted == NO && [itemTakeTurns isEqualToString:@"Yes"]) {
            
            newItemListItems = itemListItems;
            
        }
        
        NSMutableDictionary *dataDictWithSpecificUpdatedValuesCopy = dataDictWithSpecificUpdatedValues ? [dataDictWithSpecificUpdatedValues mutableCopy] : [NSMutableDictionary dictionary];
       
        [dataDictWithSpecificUpdatedValuesCopy setObject:newItemListItems ? newItemListItems : [NSMutableDictionary dictionary] forKey:@"ItemListItems"];
        
        dataDictWithSpecificUpdatedValues = [dataDictWithSpecificUpdatedValuesCopy mutableCopy];
   
    }
    
    
   
    
    return dataDictWithSpecificUpdatedValues;
    
}

#pragma mark

-(NSMutableDictionary *)ResetRepeatingTask_GenerateUpdatedSpecificItemDict:(NSMutableDictionary *)specificItemDataDict returningDataDictWithSpecificUpdatedValues:(NSMutableDictionary *)returningDataDictWithSpecificUpdatedValues {
    
    for (NSString *key in [returningDataDictWithSpecificUpdatedValues allKeys]) {
        
        id object = returningDataDictWithSpecificUpdatedValues[key] ? returningDataDictWithSpecificUpdatedValues[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
        [specificItemDataDict setObject:object forKey:key];
        
    }
    
    return specificItemDataDict;
}

-(NSMutableDictionary *)ResetRepeatingTask_GenerateUpdatedItemDict:(NSMutableDictionary *)itemDictToBeUpdated specificItemDataDict:(NSMutableDictionary *)specificItemDataDict indexOfUniqueID:(NSUInteger)indexOfUniqueID {
    
    for (NSString *key in [specificItemDataDict allKeys]) {
        
        NSMutableArray *arr = itemDictToBeUpdated[key] ? [itemDictToBeUpdated[key] mutableCopy] : [NSMutableArray array];
        id object = specificItemDataDict[key] ? specificItemDataDict[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
        if ([arr count] > indexOfUniqueID) { [arr replaceObjectAtIndex:indexOfUniqueID withObject:object]; }
        [itemDictToBeUpdated setObject:arr forKey:key];
        
    }
    
    return itemDictToBeUpdated;
}

-(BOOL)ResetRepeatingTask_ResetTaskDueDateHasBeenUpdated_Or_TaskIsRepeatingWhenCompletedAndIsFullyCompleted_Or_TaskIsRepeatingIfCompletedEarlyAndIsFullyCompleted:(NSMutableDictionary *)specificItemDataDict itemDueDate:(NSString *)itemDueDate itemType:(NSString *)itemType TaskIsFullyCompleted:(BOOL)TaskIsFullyCompleted {
    
    BOOL TaskIsRepeatingAndRepeatingIfCompletedEarly = [[[BoolDataObject alloc] init] TaskIsRepeatingAndRepeatingIfCompletedEarly:specificItemDataDict itemType:itemType];
    
    BOOL ItemRepeatsOnlyWhenCompletedAndIsFullyCompleted = [[[SetDataObject alloc] init] UpdateDataResetRepeatingTask_ItemRepeatsOnlyWhenCompletedAndIsFullyCompleted:specificItemDataDict itemType:itemType TaskIsFullyCompleted:TaskIsFullyCompleted];
    
    BOOL ResetTaskDueDateHasBeenUpdated_Or_TaskIsRepeatingWhenCompletedAndIsFullyCompleted_Or_TaskIsRepeatingIfCompletedEarlyAndIsFullyCompleted = ((TaskIsRepeatingAndRepeatingIfCompletedEarly == YES && TaskIsFullyCompleted == YES) ||
                                                                                              ItemRepeatsOnlyWhenCompletedAndIsFullyCompleted == YES ||
                                                                                              [itemDueDate isEqualToString:specificItemDataDict[@"ItemDueDate"]] == NO);
    
    return ResetTaskDueDateHasBeenUpdated_Or_TaskIsRepeatingWhenCompletedAndIsFullyCompleted_Or_TaskIsRepeatingIfCompletedEarlyAndIsFullyCompleted;
}

-(void)ResetRepeatingTask_SendPushNotifications:(NSMutableDictionary *)specificItemDataDict itemTurnUserIDOriginal:(NSString *)itemTurnUserIDOriginal itemType:(NSString *)itemType homeID:(NSString *)homeID allItemTagsArrays:(NSMutableArray *)allItemTagsArrays TaskIsOccurrence:(BOOL)TaskIsOccurrence TaskIsTakingTurns:(BOOL)TaskIsTakingTurns completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSMutableArray *itemAssignedTo = [specificItemDataDict[@"ItemAssignedTo"] mutableCopy];
    NSString *itemCreatedBy = specificItemDataDict[@"ItemCreatedBy"];
    NSString *itemName = specificItemDataDict[@"ItemName"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BOOL TaskHasTheSameTurnUserID = [specificItemDataDict[@"ItemTurnUserID"] isEqualToString:itemTurnUserIDOriginal];
        
        if (TaskIsOccurrence == NO && TaskIsTakingTurns == YES && TaskHasTheSameTurnUserID == NO) {
            
            
            
            
            NSMutableArray *usersToSendNotificationTo = [itemAssignedTo mutableCopy];
            
            NSArray *addTheseUsers = @[itemCreatedBy];
            NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
            
            usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
            
            
            
            
            NSMutableArray *homeMembersArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersArray"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersArray"] mutableCopy] : [NSMutableArray array];
            NSMutableDictionary *homeMembersDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersDict"] mutableCopy] : [NSMutableDictionary dictionary];
            
            NSMutableDictionary *notificationSettingsDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"NotificationSettingsDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"NotificationSettingsDict"] mutableCopy] : [NSMutableDictionary dictionary];
            NSMutableDictionary *topicDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"TopicDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"TopicDict"] mutableCopy] : [NSMutableDictionary dictionary];
            
            
            
            
            NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:specificItemDataDict[@"ItemTurnUserID"] homeMembersDict:homeMembersDict];
            NSString *itemTurnUsername = dataDict[@"Username"];
            
            
            
            
            NSString *pushNotificationTitle = [NSString stringWithFormat:@"\"%@\"", itemName];
            NSString *pushNotificationBody = [NSString stringWithFormat:@"It is now %@'s turn to complete this %@. 😎", itemTurnUsername, [itemType lowercaseString]];
            
            
            
            
            [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                               dictToUse:[specificItemDataDict mutableCopy]
                                                                                  homeID:homeID homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict
                                                                notificationSettingsDict:notificationSettingsDict notificationItemType:itemType notificationType:@""
                                                                               topicDict:topicDict
                                                                     allItemTagsArrays:allItemTagsArrays
                                                                   pushNotificationTitle:pushNotificationTitle pushNotificationBody:pushNotificationBody
                                                                       notificationTitle:@"" notificationBody:@""
                                                                 SetDataHomeNotification:YES
                                                                    RemoveUsersNotInHome:YES
                                                                       completionHandler:^(BOOL finished) {
                
                finishBlock(YES);
                
            }];
            
        } else {
            
            finishBlock(YES);
            
        }
        
    });
    
}

-(void)ResetRepeatingTask_ResetItemNotifications:(NSMutableDictionary *)specificItemDataDict itemType:(NSString *)itemType allItemTagsArrays:(NSMutableArray *)allItemTagsArrays notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict homeMembersDict:(NSMutableDictionary *)homeMembersDict keyArray:(NSArray *)keyArray TaskIsOccurrence:(BOOL)TaskIsOccurrence completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        if (TaskIsOccurrence == NO) {
            
            NSString *itemCreatedBy = specificItemDataDict[@"ItemCreatedBy"] ? specificItemDataDict[@"ItemCreatedBy"] : @"";
            NSMutableArray *itemAssignedTo = specificItemDataDict[@"ItemAssignedTo"] ? specificItemDataDict[@"ItemAssignedTo"] : [NSMutableArray array];
            
            NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                           SkippingTurn:NO RemovingUser:NO
                                                                                                         FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                                DueDate:NO Reminder:NO
                                                                                                         SubtaskEditing:NO SubtaskDeleting:NO
                                                                                                       SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                         AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                                    EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                                      GroupChatMessages:NO LiveSupportMessages:NO
                                                                                                     SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                                    FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                               itemType:@""];
            
            NSMutableArray *userIDArray = [itemAssignedTo mutableCopy];
            NSMutableArray *userIDToRemoveArray = [NSMutableArray array];
            
            [userIDArray addObject:itemCreatedBy];
            
            [[[NotificationsObject alloc] init] ResetLocalNotificationReminderNotification:specificItemDataDict homeMembersDict:homeMembersDict userIDArray:userIDArray userIDToRemoveArray:userIDToRemoveArray notificationSettingsDict:notificationSettingsDict allItemTagsArrays:allItemTagsArrays itemType:itemType notificationType:notificationType topicDict:topicDict completionHandler:^(BOOL finished) {
                
                finishBlock(YES);
                
            }];
            
        } else {
            
            finishBlock(YES);
            
        }
        
    });
    
}

-(void)ResetRepeatingTask_UpdateItemData:(NSMutableDictionary *)specificItemDataDict dataDictWithSpecificUpdatedValues:(NSMutableDictionary *)dataDictWithSpecificUpdatedValues homeID:(NSString *)homeID collection:(NSString *)collection TaskIsFullyCompleted:(BOOL)TaskIsFullyCompleted TaskIsOccurrence:(BOOL)TaskIsOccurrence completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        if (TaskIsOccurrence == NO) {
         
            NSString *itemID = specificItemDataDict[@"ItemID"];
            NSString *itemOccurrenceID = specificItemDataDict[@"ItemOccurrenceID"];
           
            [[[SetDataObject alloc] init] UpdateDataEditItem:dataDictWithSpecificUpdatedValues itemID:itemID itemOccurrenceID:itemOccurrenceID collection:collection homeID:homeID completionHandler:^(BOOL finished) {
                
                finishBlock(YES);
                
            }];
            
        } else {
            
            finishBlock(YES);
            
        }
        
    });
    
}

-(void)ResetRepeatingTask_SetItemOccurrenceData:(NSMutableDictionary *)specificItemDataDict itemDictToBeUpdated:(NSMutableDictionary *)itemDictToBeUpdated specificItemDataDictCopyForOccurrences:(NSMutableDictionary *)specificItemDataDictCopyForOccurrences collection:(NSString *)collection homeID:(NSString *)homeID index:(NSUInteger)indexOfUniqueID SkipOccurrence:(BOOL)SkipOccurrence TaskIsOccurrence:(BOOL)TaskIsOccurrence TaskIsFullyCompleted:(BOOL)TaskIsFullyCompleted completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningItemDictToBeUpdated))finishBlock {
    
    NSString *itemTakeTurns = specificItemDataDict[@"ItemTakeTurns"];
    
    specificItemDataDictCopyForOccurrences = [[[SetDataObject alloc] init] ResetRepeatingTask_SetDataForResetTaskOccurrence_GenerateUpdatedSpecificItemOccurrenceDict:specificItemDataDictCopyForOccurrences itemTakeTurns:itemTakeTurns SkipOccurrence:SkipOccurrence TaskIsOccurrence:TaskIsOccurrence TaskIsFullyCompleted:TaskIsFullyCompleted];
    itemDictToBeUpdated = [[[SetDataObject alloc] init] ResetRepeatingTask_SetDataForResetTaskOccurrence_GenerateUpdatedSpecificItemDict:itemDictToBeUpdated specificItemDataDictCopyForOccurrences:specificItemDataDictCopyForOccurrences itemTakeTurns:itemTakeTurns indexOfUniqueID:indexOfUniqueID SkipOccurrence:SkipOccurrence TaskIsOccurrence:TaskIsOccurrence TaskIsFullyCompleted:TaskIsFullyCompleted];
   
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      
        if (SkipOccurrence == NO && TaskIsOccurrence == NO) {
           
            [[[SetDataObject alloc] init] SetDataAddItem:specificItemDataDictCopyForOccurrences collection:collection homeID:homeID completionHandler:^(BOOL finished) {
                
                finishBlock(YES, itemDictToBeUpdated);
                
            }];
            
        } else if (SkipOccurrence == NO && TaskIsOccurrence == YES) {
            
            [[[SetDataObject alloc] init] UpdateDataEditItem:specificItemDataDictCopyForOccurrences itemID:specificItemDataDictCopyForOccurrences[@"ItemID"] itemOccurrenceID:specificItemDataDictCopyForOccurrences[@"ItemOccurrenceID"] collection:collection homeID:homeID completionHandler:^(BOOL finished) {
                
                finishBlock(YES, itemDictToBeUpdated);
                
            }];
            
        } else {
            
            finishBlock(YES, itemDictToBeUpdated);
            
        }
        
    });
    
}

-(void)ResetRepeatingTask_SetItemAndHomeActivity:(NSMutableDictionary *)specificItemDataDict itemType:(NSString *)itemType homeID:(NSString *)homeID SkipOccurrence:(BOOL)SkipOccurrence TaskIsOccurrence:(BOOL)TaskIsOccurrence completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemName = specificItemDataDict[@"ItemName"];
    NSString *itemID = specificItemDataDict[@"ItemID"];
    NSString *itemOccurrenceID = specificItemDataDict[@"ItemOccurrenceID"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        if (SkipOccurrence == NO && TaskIsOccurrence == NO) {
            
            NSString *activityAction = @"Reseting Task";
            NSString *userTitle = [NSString stringWithFormat:@"\"%@\" has reset", itemName];
            NSString *itemTitle = [NSString stringWithFormat:@"\"%@\" has reset", itemName];
            NSString *itemDescription = [NSString stringWithFormat:@"\"%@\" has reset", itemName];
            
            NSMutableDictionary *itemActivityDict = [[[SetDataObject alloc] init] GenerateItemActivityDict:itemID itemOccurrenceID:itemOccurrenceID activityUserIDNo1:@"" homeID:homeID activityAction:activityAction userTitle:userTitle userDescription:itemDescription itemType:itemType];
            NSMutableDictionary *homeActivityDict = [[[SetDataObject alloc] init] GenerateHomeActivityDict:@"" homeID:homeID activityAction:activityAction itemTitle:itemTitle itemDescription:itemDescription itemType:itemType];
            
            [[[SetDataObject alloc] init] SetDataHomeAndItemActivity:itemActivityDict homeActivityDict:homeActivityDict completionHandler:^(BOOL finished) {
                
                finishBlock(YES);
                
            }];
            
        } else {
            
            finishBlock(YES);
            
        }
        
    });
    
}

-(void)ResetRepeatingTask_UpdateTaskListData:(NSMutableDictionary *)taskListDict itemUniqueIDDict:(NSDictionary *)itemUniqueIDDict SkipOccurrence:(BOOL)SkipOccurrence TaskIsOccurrence:(BOOL)TaskIsOccurrence completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningUpdatedTaskListDict))finishBlock {
    
    NSMutableDictionary *returningUpdatedTaskListDict = [NSMutableDictionary dictionary];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        if (SkipOccurrence == NO && TaskIsOccurrence == NO) {
           
            [[[GeneralObject alloc] init] AddOrRemoveTaskToAllTaskListsThatContainSpecificItem:taskListDict newTaskListName:@"" itemUniqueIDDict:itemUniqueIDDict AddTask:YES completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningUpdatedTaskListDict) {
                
                finishBlock(YES, returningUpdatedTaskListDict);
                
            }];
            
        } else {
            
            finishBlock(YES, returningUpdatedTaskListDict);
            
        }
        
    });
    
}

-(void)ResetRepeatingTask_CompletionBlock:(int)totalQueries completedQueries:(int)completedQueries itemUniqueIDArray:(NSMutableArray *)itemUniqueIDArray objectArr:(NSMutableArray *)objectArr taskListDict:(NSMutableDictionary *)taskListDict itemUniqueIDDict:(NSDictionary *)itemUniqueIDDict SkipOccurrence:(BOOL)SkipOccurrence TaskIsOccurrence:(BOOL)TaskIsOccurrence completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningUpdatedTaskListDictLocal))finishBlock {
    
    if (totalQueries == completedQueries) {
        ///*itemUniqueID:specificItemDataDictCopyForOccurrences[@"ItemUniqueID"] originalItemUniqueID:specificItemDataDict[@"ItemUniqueID"]*/
            
        if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:itemUniqueIDArray objectArr:objectArr]) {
            
            /*
             //
             //
             //Update Task List Data
             //
             //
             */
            [[[SetDataObject alloc] init] ResetRepeatingTask_UpdateTaskListData:taskListDict itemUniqueIDDict:itemUniqueIDDict SkipOccurrence:SkipOccurrence TaskIsOccurrence:TaskIsOccurrence completionHandler:^(BOOL finished, NSMutableDictionary *returningUpdatedTaskListDict) {
                
                NSMutableDictionary *returningUpdatedTaskListDictLocal = [returningUpdatedTaskListDict mutableCopy];
                
                finishBlock(YES, returningUpdatedTaskListDictLocal);
                
            }];
            
        }
        
    }
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark Items

#pragma mark UpdateDataForNewHomeMember

-(NSMutableDictionary *)GenerateUpdatedItemCostPerPersonDict:(FIRDocumentSnapshot *)doc userID:(NSString *)userID {
    
    NSString *itemAssignedToNewHomeMembers = doc.data[@"ItemAssignedToNewHomeMembers"] ? doc.data[@"ItemAssignedToNewHomeMembers"] : @"No";
    
    NSMutableDictionary *itemCostPerPerson = doc.data[@"ItemCostPerPerson"] ? [doc.data[@"ItemCostPerPerson"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if ([[itemCostPerPerson allKeys] containsObject:userID] == YES ||
        [itemAssignedToNewHomeMembers isEqualToString:@"Yes"] == NO) {
        
        return itemCostPerPerson;
        
    } else {
        
        float largestAmount = 0.0;
        
        for (NSString *key in [itemCostPerPerson allKeys]) {
            
            if (largestAmount < [itemCostPerPerson[key] floatValue]) {
                largestAmount = [itemCostPerPerson[key] floatValue];
            }
            
        }
        
        if (largestAmount == 0.0 && [[itemCostPerPerson allKeys] count] > 0) {
            largestAmount = [[itemCostPerPerson allKeys][0] floatValue];
        }
        
        NSMutableDictionary *dict = [itemCostPerPerson mutableCopy];
        [dict setObject:[NSString stringWithFormat:@"%.02f", largestAmount] forKey:userID];
        
        return dict;
        
    }
    
}

-(NSString *)GenerateUpdatedItemAmount:(FIRDocumentSnapshot *)doc userID:(NSString *)userID {
    
    NSString *itemAssignedToNewHomeMembers = doc.data[@"ItemAssignedToNewHomeMembers"] ? doc.data[@"ItemAssignedToNewHomeMembers"] : @"No";
    
    NSMutableDictionary *itemCostPerPerson = doc.data[@"ItemCostPerPerson"] ? [doc.data[@"ItemCostPerPerson"] mutableCopy] : [NSMutableDictionary dictionary];
    NSString *itemAmount = doc.data[@"ItemAmount"] ? doc.data[@"ItemAmount"] : @"";
    
    if ([[itemCostPerPerson allKeys] containsObject:userID] == YES ||
        [itemAssignedToNewHomeMembers isEqualToString:@"Yes"] == NO) {
        
        return itemAmount;
        
    } else {
        
        float largestAmount = 0.0;
        
        for (NSString *key in [itemCostPerPerson allKeys]) {
            
            if (largestAmount < [itemCostPerPerson[key] floatValue]) {
                largestAmount = [itemCostPerPerson[key] floatValue];
            }
            
        }
        
        if (largestAmount == 0.0 && [[itemCostPerPerson allKeys] count] > 0) {
            largestAmount = [[itemCostPerPerson allKeys] count] > 0 ? [[itemCostPerPerson allKeys][0] floatValue] : 0;
        }
        
        float itemAmountFloat = [itemAmount floatValue];
        itemAmountFloat += largestAmount;
        
        NSString *itemAmountString = [NSString stringWithFormat:@"%.02f", itemAmountFloat];
        
        return itemAmountString;
        
    }
    
}

#pragma mark UpdateDataResetRepeatingTask

-(BOOL)UpdateDataResetRepeatingTask_ItemRepeatsAndCurrentDueDateHasPassed:(NSMutableDictionary *)specificItemDataDict itemDict:(NSMutableDictionary *)itemDict itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict TaskIsFullyCompleted:(BOOL)TaskIsFullyCompleted {
    
    NSString *itemID = specificItemDataDict[@"ItemID"];
    NSString *itemStartDate = specificItemDataDict[@"ItemStartDate"];
    NSString *itemEndDate = specificItemDataDict[@"ItemEndDate"];
    NSString *itemRepeats = specificItemDataDict[@"ItemRepeats"];
    
    
    
    BOOL TaskIsRepeatingWhenCompleted = [[[BoolDataObject alloc] init] TaskIsRepeatingWhenCompleted:specificItemDataDict itemType:itemType];
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:specificItemDataDict itemType:itemType];
    BOOL TaskIsRepeatingAndRepeatingIfCompletedEarly = [[[BoolDataObject alloc] init] TaskIsRepeatingAndRepeatingIfCompletedEarly:specificItemDataDict itemType:itemType];
    BOOL DueDateHasPassedAndMustBeReset = [[[SetDataObject alloc] init] UpdateDataResetRepeatingTask_ItemDueDateHasPassedAndNeedsToBeReset:specificItemDataDict homeMembersDict:homeMembersDict itemDict:itemDict itemType:itemType];
    
    NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
    NSString *currentDate = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
    
    BOOL ItemStartDateSelected = [[[BoolDataObject alloc] init] ItemStartDateSelected:[@{@"ItemStartDate" : itemStartDate, @"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    BOOL ItemStartDateIsLaterThanCurrentDate = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:currentDate dateString2:itemStartDate dateFormat:dateFormat] > 0;
    
    BOOL ItemEndDateSelected = [[[BoolDataObject alloc] init] ItemEndDateSelected:[@{@"ItemEndDate" : itemEndDate, @"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    BOOL ItemEndDateIsLaterThanCurrentDate = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:currentDate dateString2:itemEndDate dateFormat:dateFormat] > 0;
    BOOL TaskEndIsNumberOfTimes = [[[BoolDataObject alloc] init] TaskEndIsNumberOfTimes:[@{@"ItemEndDate" : itemEndDate, @"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    BOOL ItemEndDateNumOfTimesHasPassed = NO;
    
    
    
    int numberOfTaskOccurrences = itemOccurrencesDict[@"Occurrences_EndNumberOfTimes"] && itemOccurrencesDict[@"Occurrences_EndNumberOfTimes"][itemID] ? [(NSString *)itemOccurrencesDict[@"Occurrences_EndNumberOfTimes"][itemID] intValue] : 0;
    
    if (ItemEndDateSelected == YES && TaskEndIsNumberOfTimes == YES) {
        ItemEndDateNumOfTimesHasPassed = [[[BoolDataObject alloc] init] TaskEndHasPassed:[@{@"ItemEndDate" : itemEndDate, @"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType] numberOfTaskOccurrences:numberOfTaskOccurrences+1];
        
    }
    
 
    
    BOOL ItemStartDateIsValid = (ItemStartDateSelected == YES && ItemStartDateIsLaterThanCurrentDate == NO) || ItemStartDateSelected == NO || (TaskIsRepeatingAndRepeatingIfCompletedEarly == YES && TaskIsFullyCompleted == YES);
    BOOL ItemEndDateIsValid = (ItemEndDateSelected == YES && TaskEndIsNumberOfTimes == NO && ItemEndDateIsLaterThanCurrentDate == YES) || (ItemEndDateSelected == YES && TaskEndIsNumberOfTimes == YES && ItemEndDateNumOfTimesHasPassed == NO) || ItemEndDateSelected == NO;
    
 
    
    BOOL ItemRepeatsAndCurrentDueDateHasPassed = (TaskIsRepeating == YES && DueDateHasPassedAndMustBeReset == YES && ItemStartDateIsValid == YES && ItemEndDateIsValid == YES && TaskIsRepeatingWhenCompleted == NO);
    
    
    
    return ItemRepeatsAndCurrentDueDateHasPassed;
}

-(BOOL)UpdateDataResetRepeatingTask_ItemDoesNotRepeatAndMultipleSpecificDueDatesFoundAndFutureDateFoundAndCurrentDueDateHasPassed:(NSMutableDictionary *)specificItemDataDict itemDict:(NSMutableDictionary *)itemDict itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    NSMutableArray *itemSpecificDueDates = [specificItemDataDict[@"ItemSpecificDueDates"] mutableCopy];
    
    NSDictionary *dict = [[[SetDataObject alloc] init] UpdateDataResetRepeatingTask_GenerateMultipleDueDatesNextDueDateNo1:itemSpecificDueDates];
    BOOL FutureDateFound = [dict[@"FutureDateFound"] isEqualToString:@"Yes"] ? YES : NO;
    
    BOOL TaskIsRepeatingWhenCompleted = [[[BoolDataObject alloc] init] TaskIsRepeatingWhenCompleted:specificItemDataDict itemType:itemType];
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:specificItemDataDict itemType:itemType];
    BOOL DueDateHasPassedAndMustBeReset = [[[SetDataObject alloc] init] UpdateDataResetRepeatingTask_ItemDueDateHasPassedAndNeedsToBeReset:specificItemDataDict homeMembersDict:homeMembersDict itemDict:itemDict itemType:itemType];
    BOOL MultipleSpecificDueDatesFound = itemSpecificDueDates.count > 0;
    
    
    
    BOOL ItemDoesNotRepeatAndMultipleSpecificDueDatesFoundAndFutureDateFoundAndCurrentDueDateHasPassed = (TaskIsRepeating == NO && MultipleSpecificDueDatesFound == YES && FutureDateFound == YES && DueDateHasPassedAndMustBeReset == YES && TaskIsRepeatingWhenCompleted == NO);
    
    
    
    return ItemDoesNotRepeatAndMultipleSpecificDueDatesFoundAndFutureDateFoundAndCurrentDueDateHasPassed;
}

-(BOOL)UpdateDataResetRepeatingTask_ItemRepeatsAndDueDateIsNil:(NSMutableDictionary *)specificItemDataDict itemDict:(NSMutableDictionary *)itemDict itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    NSString *itemDueDate = specificItemDataDict[@"ItemDueDate"];
    
    BOOL TaskIsRepeatingWhenCompleted = [[[BoolDataObject alloc] init] TaskIsRepeatingWhenCompleted:specificItemDataDict itemType:itemType];
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:specificItemDataDict itemType:itemType];
    
    BOOL ItemRepeatsAndDueDateIsNil = (TaskIsRepeating == YES && TaskIsRepeatingWhenCompleted == NO && [itemDueDate length] == 0);
    
    
    
    return ItemRepeatsAndDueDateIsNil;
}

-(BOOL)UpdateDataResetRepeatingTask_ItemRepeatsOnlyWhenCompletedAndIsFullyCompleted:(NSMutableDictionary *)specificItemDataDict itemType:(NSString *)itemType TaskIsFullyCompleted:(BOOL)TaskIsFullyCompleted {
    
    BOOL TaskIsRepeatingWhenCompleted = [[[BoolDataObject alloc] init] TaskIsRepeatingWhenCompleted:specificItemDataDict itemType:itemType];
    
    BOOL ItemRepeatsOnlyWhenCompletedAndIsFullyCompleted = (TaskIsRepeatingWhenCompleted == YES && TaskIsFullyCompleted == YES);
    
    return ItemRepeatsOnlyWhenCompletedAndIsFullyCompleted;
}

#pragma mark

-(NSDictionary *)UpdateDataResetRepeatingTask_GenerateMultipleDueDatesNextDueDateNo1:(NSMutableArray *)itemSpecificDueDates {
    
    NSString *possibleNewDueDate = @"";
    
    BOOL FutureDateFound = false;
    
    if (itemSpecificDueDates.count > 0) {
        
        NSString *dateStringCurrent = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy hh:mm a" returnAs:[NSString class]];
        
        //Use To Test Updating Due Dates
        //dateStringCurrent = @"November 18, 2022 11:59 PM";
        
        for (NSString *dueDate in itemSpecificDueDates) {
            
            NSString *dueDateToUse = dueDate;
            
            dueDateToUse = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:dueDateToUse stringToReplace:@"Any Time" replacementString:@"11:59 PM"];
            
            NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
            
            NSTimeInterval secondsBetweenHour =  [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:dateStringCurrent dateString2:dueDateToUse dateFormat:dateFormat];
            
            if (secondsBetweenHour > 0) {
                
                possibleNewDueDate = dueDateToUse;
                FutureDateFound = true;
                break;
                
            }
            
        }
        
        if (FutureDateFound == false) {
            possibleNewDueDate = [itemSpecificDueDates count] > itemSpecificDueDates.count-1 ? itemSpecificDueDates[itemSpecificDueDates.count-1] : @"";
        }
        
    }
    
    return @{@"FutureDateFound" : FutureDateFound == YES ? @"Yes" : @"No", @"PossibleNewDueDate" : possibleNewDueDate};
    
}

#pragma mark

-(BOOL)UpdateDataResetRepeatingTask_ItemDueDatePlusItemGracePeriodHasPassed:(NSString *)itemDueDate itemGracePeriod:(NSString *)itemGracePeriod {
    
    NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
    
    if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:itemDueDate returnAs:[NSDate class]] == nil) {
        dateFormat = @"MMMM dd, yyyy HH:mm";
    }
    
    NSString *currentDateString = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
    
    //Use To Test Updating Due Dates - Search this string to find sister code
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"TestDueDateIsSet"] isEqualToString:@"Yes"]) {
        currentDateString = [[NSUserDefaults standardUserDefaults] objectForKey:@"TestDueDate"];
    }
    
    NSTimeInterval secondsPassedSinceItemDueDate = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:itemDueDate dateString2:currentDateString dateFormat:dateFormat];
    
    int secondsThatNeedToPass = [[[GeneralObject alloc] init] GenerateSecondsFromDisplayTime:itemGracePeriod];
    
    if (secondsPassedSinceItemDueDate >= secondsThatNeedToPass) {
        return YES;
    }
    
    return NO;
}

-(NSMutableDictionary *)ResetRepeatingTask_SetDataForResetTaskOccurrence_GenerateUpdatedSpecificItemOccurrenceDict:(NSMutableDictionary *)specificItemDataDictCopyForOccurrences itemTakeTurns:(NSString *)itemTakeTurns SkipOccurrence:(BOOL)SkipOccurrence TaskIsOccurrence:(BOOL)TaskIsOccurrence TaskIsFullyCompleted:(BOOL)TaskIsFullyCompleted {
    
    if (SkipOccurrence == NO && TaskIsOccurrence == NO) {
       
        [specificItemDataDictCopyForOccurrences setObject:TaskIsFullyCompleted ? @"Completed" : @"None" forKey:@"ItemOccurrenceStatus"];
        
        //Task Takes Turns and Is Not Fully Completed, Create Occurrence Just For Record Keeping
        if ([itemTakeTurns isEqualToString:@"Yes"]) {
            [specificItemDataDictCopyForOccurrences setObject:TaskIsFullyCompleted ? @"Completed" : @"Waived" forKey:@"ItemOccurrenceStatus"];
        }
        
    } else if (SkipOccurrence == NO && TaskIsOccurrence == YES) {
      
        [specificItemDataDictCopyForOccurrences removeObjectForKey:@"ItemOccurrenceID"];
        [specificItemDataDictCopyForOccurrences removeObjectForKey:@"ItemUniqueID"];
        
        [specificItemDataDictCopyForOccurrences setObject:TaskIsFullyCompleted ? @"Completed" : @"None" forKey:@"ItemOccurrenceStatus"];
        
    }
    
    return specificItemDataDictCopyForOccurrences;
}

-(NSMutableDictionary *)ResetRepeatingTask_SetDataForResetTaskOccurrence_GenerateUpdatedSpecificItemDict:(NSMutableDictionary *)itemDictToBeUpdated specificItemDataDictCopyForOccurrences:(NSMutableDictionary *)specificItemDataDictCopyForOccurrences itemTakeTurns:(NSString *)itemTakeTurns indexOfUniqueID:(NSUInteger)indexOfUniqueID SkipOccurrence:(BOOL)SkipOccurrence TaskIsOccurrence:(BOOL)TaskIsOccurrence TaskIsFullyCompleted:(BOOL)TaskIsFullyCompleted {
    
    if (SkipOccurrence == NO && TaskIsOccurrence == NO) {
        
        if ([specificItemDataDictCopyForOccurrences[@"ItemOccurrenceStatus"] isEqualToString:@"None"]) {
            
            //Update Item Dict With New Specific Item Data
            for (NSString *key in [specificItemDataDictCopyForOccurrences allKeys]) {
                
                NSMutableArray *arr = itemDictToBeUpdated[key] ? [itemDictToBeUpdated[key] mutableCopy] : [NSMutableArray array];
                id object = [[specificItemDataDictCopyForOccurrences allKeys] containsObject:key] ? specificItemDataDictCopyForOccurrences[key] : [[GeneralObject alloc] init] ? [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key] : @"";
                [arr addObject:object];
                [itemDictToBeUpdated setObject:arr forKey:key];
                
            }
            
        }
        
    } else if (SkipOccurrence == NO && TaskIsOccurrence == YES) {
        
        //Update Item Dict With New Specific Item Data
        for (NSString *key in [specificItemDataDictCopyForOccurrences allKeys]) {
            
            NSMutableArray *arr = itemDictToBeUpdated[key] ? [itemDictToBeUpdated[key] mutableCopy] : [NSMutableArray array];
            id object = [[specificItemDataDictCopyForOccurrences allKeys] containsObject:key] ? specificItemDataDictCopyForOccurrences[key] : [[GeneralObject alloc] init] ? [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key] : @"";
            if ([arr count] > indexOfUniqueID) { [arr replaceObjectAtIndex:indexOfUniqueID withObject:object]; }
            [itemDictToBeUpdated setObject:arr forKey:key];
            
        }
        
    }
    
    return itemDictToBeUpdated;
}

#pragma mark

-(NSMutableDictionary *)UpdateDataResetItemFields_GenerateSubTasksDict:(NSMutableDictionary *)subTaskDict {
    
    NSMutableDictionary *itemDict = [NSMutableDictionary dictionary];
    
    if (subTaskDict) {
        
        for (NSString *key in [subTaskDict allKeys]) {
            
            if ([[itemDict allKeys] containsObject:key] == NO) {
                
                NSString *previousAssignedTo = subTaskDict[key] && subTaskDict[key][@"Assigned To"] && [(NSArray *)subTaskDict[key][@"Assigned To"] count] > 0 ? subTaskDict[key][@"Assigned To"][0] : @"";
                [itemDict setObject:@{@"Completed Dict" : [NSMutableDictionary dictionary], @"In Progress Dict" : [NSMutableDictionary dictionary], @"Wont Do" : [NSMutableDictionary dictionary], @"Assigned To" : @[previousAssignedTo]} forKey:key];
                
            }
            
        }
        
    }
    
    return itemDict;
    
}

-(NSMutableDictionary *)UpdateDataResetItemFields_GenerateItemItemizedItems:(NSMutableDictionary *)itemItemizedItems {
    
    NSString *localCurrencyDecimalSeparatorSymbol = [[[GeneralObject alloc] init] GenerateLocalCurrencyDecimalSeparatorSymbol];
    
    NSMutableDictionary *itemDict = [NSMutableDictionary dictionary];
    
    if (itemItemizedItems) {
        
        for (NSString *key in [itemItemizedItems allKeys]) {
            
            if ([[itemDict allKeys] containsObject:key] == NO) {
                
                id previousAmount = itemItemizedItems[key] && itemItemizedItems[key][@"Amount"] ? itemItemizedItems[key][@"Amount"] : [NSString stringWithFormat:@"0%@00", localCurrencyDecimalSeparatorSymbol];
                
                BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:previousAmount classArr:@[[NSArray class], [NSMutableArray class]]];
                
                if (ObjectIsKindOfClass == YES) {
                    previousAmount = [(NSArray *)previousAmount count] > 0 ? previousAmount[0] : [NSString stringWithFormat:@"0%@00", localCurrencyDecimalSeparatorSymbol];
                }
                
                NSString *previousAssignedTo = itemItemizedItems[key] && itemItemizedItems[key][@"Assigned To"] && [(NSArray *)itemItemizedItems[key][@"Assigned To"] count] > 0 ? itemItemizedItems[key][@"Assigned To"][0] : @"";
                [itemDict setObject:@{@"Amount" : previousAmount, @"Assigned To" : @[previousAssignedTo], @"Status" : @"Uncompleted"} forKey:key];
                
            }
            
        }
        
    }
    
    return itemDict;
    
}

-(NSMutableDictionary *)UpdateDataResetItemFields_GenerateItemListItems:(NSMutableDictionary *)itemListItems {
    
    NSMutableDictionary *itemDict = [NSMutableDictionary dictionary];
    
    if (itemListItems) {
        
        for (NSString *key in [itemListItems allKeys]) {
           
            if ([[itemDict allKeys] containsObject:key] == NO) {
                
                NSString *previousAssignedTo = itemListItems[key] && itemListItems[key][@"Assigned To"] && [(NSArray *)itemListItems[key][@"Assigned To"] count] > 0 ? itemListItems[key][@"Assigned To"][0] : @"";
                [itemDict setObject:@{@"Assigned To" : @[previousAssignedTo], @"Status" : @"Uncompleted"} forKey:key];
                
            }
            
        }
        
    }
  
    return itemDict;
}

-(NSDictionary *)UpdateDataResetItemFields_GenerateComplicatedRandomArray:(NSMutableArray *)userIDArray homeMembersDict:(NSMutableDictionary *)homeMembersDict allItemAssignedToArrays:(NSMutableArray *)allItemAssignedToArrays {
    
    NSMutableDictionary *dictOfUsersAndAssignedCount = [[[SetDataObject alloc] init] GenerateDictOfUserIDsAndNumberCorrespondingToHowOftenTheyWereAssignedToATask:allItemAssignedToArrays];
    
    BOOL DifferentAmountFound = [[[SetDataObject alloc] init] CheckIfAtLeastOneUserWasAssignedMoreOrLessFrequently:dictOfUsersAndAssignedCount];
    
    if (DifferentAmountFound == true) {
        
        NSArray *dictOfUsersAndAssignedCountSortedKeys = [[[SetDataObject alloc] init] GenerateSortedDictOfUserIDsAndNumberCorrespondingToHowOftenTheyWereAssignedToATask:dictOfUsersAndAssignedCount];
        
        NSMutableArray *randomizeUserIDArray = [[[SetDataObject alloc] init] GenerateRandomizedUserIDArray:dictOfUsersAndAssignedCountSortedKeys userIDArray:userIDArray homeMembersDict:homeMembersDict];
        
        NSDictionary *dictOfRandomizedUsers = [[[SetDataObject alloc] init] GenerateDictOfRearrangedUserData:randomizeUserIDArray homeMemberUsernameArray:homeMembersDict[@"Username"] homeMemberProfileImageURLArray:homeMembersDict[@"ProfileImageURL"]];
        
        return dictOfRandomizedUsers;
        
    } else {
        
        NSDictionary *dictOfRandomizedUsers = [[[SetDataObject alloc] init] GenerateSimpleRandomizedArray:homeMembersDict];
        
        return dictOfRandomizedUsers;
        
    }
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark UpdateDataResetRepeatingTask

-(BOOL)UpdateDataResetRepeatingTask_ItemDueDateHasPassedAndNeedsToBeReset:(NSMutableDictionary *)dictToUse homeMembersDict:(NSMutableDictionary *)homeMembersDict itemDict:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemDueDate = dictToUse[@"ItemDueDate"] ? dictToUse[@"ItemDueDate"] : @"";
    NSString *itemGracePeriod = dictToUse[@"ItemGracePeriod"] ? dictToUse[@"ItemGracePeriod"] : @"";
    NSMutableArray *itemSpecificDueDates = dictToUse[@"ItemSpecificDueDates"] ? [dictToUse[@"ItemSpecificDueDates"] mutableCopy] : [NSMutableArray array];
    
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:dictToUse itemType:itemType];
    BOOL TaskIsFullyCompleted = [[[BoolDataObject alloc] init] TaskIsFullyCompleted:dictToUse itemType:itemType homeMembersDict:homeMembersDict];
    BOOL TaskIsRepeatingWhenCompleted = [[[BoolDataObject alloc] init] TaskIsRepeatingWhenCompleted:dictToUse itemType:itemType];
    BOOL TaskIsRepeatingAndRepeatingIfCompletedEarly = [[[BoolDataObject alloc] init] TaskIsRepeatingAndRepeatingIfCompletedEarly:dictToUse itemType:itemType];
    
    if (TaskIsRepeating == NO && TaskIsFullyCompleted == NO && itemSpecificDueDates.count == 0) {
        
        return NO;
        
    } else {
        
        BOOL ItemDueDatePlusItemGracePeriodHasPassed = [[[SetDataObject alloc] init] UpdateDataResetRepeatingTask_ItemDueDatePlusItemGracePeriodHasPassed:itemDueDate itemGracePeriod:itemGracePeriod];
        
        int numberOfTaskOccurrences = 0;
        
        for (NSString *itemID in itemDict[@"ItemID"]) {
            numberOfTaskOccurrences += [dictToUse[@"ItemID"] isEqualToString:itemID];
        }
        
        BOOL ItemEndDateHasPassed = [[[BoolDataObject alloc] init] TaskEndHasPassed:dictToUse itemType:itemType numberOfTaskOccurrences:numberOfTaskOccurrences];
        
        
        BOOL DueDateHasPassedAndMustBeReset =
        ItemDueDatePlusItemGracePeriodHasPassed == YES &&
        ItemEndDateHasPassed == NO;
       
        if ((TaskIsRepeatingWhenCompleted == YES || TaskIsRepeatingAndRepeatingIfCompletedEarly == YES) && TaskIsFullyCompleted == YES) {
            DueDateHasPassedAndMustBeReset = YES;
        }
        
        return DueDateHasPassedAndMustBeReset;
        
    }
    
}

-(NSDictionary *)GenerateSimpleRandomizedArray:(NSMutableDictionary *)homeMembersDict {
    
    NSMutableArray *randomizedUserIDArray = homeMembersDict && homeMembersDict[@"UserID"] ? [homeMembersDict[@"UserID"] mutableCopy] : [NSMutableArray array];
    
    NSUInteger count = [randomizedUserIDArray count];
    
    for (NSUInteger i = 0; i < count; ++i) {
        
        // Select a random element between i and end of array to swap with.
        int nElements = (int)count - (int)i;
        int n = (arc4random() % nElements) + (int)i;
        [randomizedUserIDArray exchangeObjectAtIndex:i withObjectAtIndex:n];
        
    }
    
    NSDictionary *dictOfRandomizedUsers = [[[SetDataObject alloc] init] GenerateDictOfRearrangedUserData:randomizedUserIDArray homeMemberUsernameArray:homeMembersDict[@"Username"] homeMemberProfileImageURLArray:homeMembersDict[@"ProfileImageURL"]];
    
    return dictOfRandomizedUsers;
    
}

-(NSDictionary *)GenerateDictOfRearrangedUserData:(NSMutableArray *)randomizedUserIDArray homeMemberUsernameArray:(NSMutableArray *)homeMemberUsernameArray homeMemberProfileImageURLArray:(NSMutableArray *)homeMemberProfileImageURLArray {
    
    NSMutableArray *newHomeMemberUsernameArray = [NSMutableArray array];
    NSMutableArray *newhomeMemberProfileImageURLArray = [NSMutableArray array];
    
    for (NSString *user in randomizedUserIDArray) {
        
        NSUInteger index = [randomizedUserIDArray indexOfObject:user];
        
        NSString *username = [homeMemberUsernameArray count] > index ? homeMemberUsernameArray[index] : @"";
        NSString *profileImageURL = [homeMemberProfileImageURLArray count] > index ?  homeMemberProfileImageURLArray[index] : @"xxx";
        
        [newHomeMemberUsernameArray addObject:username];
        [newhomeMemberProfileImageURLArray addObject:profileImageURL];
        
    }
    
    return @{@"UserIDArray" : randomizedUserIDArray, @"UsernameArray" : newHomeMemberUsernameArray, @"ProfileImageURLArray" : newhomeMemberProfileImageURLArray};
}

-(NSMutableDictionary *)GenerateDictOfUserIDsAndNumberCorrespondingToHowOftenTheyWereAssignedToATask:(NSMutableArray *)allItemAssignedToArrays {
    
    NSMutableDictionary *dictOfUsersAndAssignedCount = [NSMutableDictionary dictionary];
    
    for (NSMutableArray *arr in allItemAssignedToArrays) {
        
        for (NSString *user in arr) {
            
            if (dictOfUsersAndAssignedCount[user]) {
                
                int assignedCount = [[NSString stringWithFormat:@"%@", dictOfUsersAndAssignedCount[user]] intValue];
                assignedCount += ([arr indexOfObject:user] + 1);
                [dictOfUsersAndAssignedCount setObject:[NSString stringWithFormat:@"%d", assignedCount] forKey:user];
                
            } else {
                
                int assignedCount = ((int)[arr indexOfObject:user] + 1);
                [dictOfUsersAndAssignedCount setObject:[NSString stringWithFormat:@"%d", assignedCount] forKey:user];
                
            }
            
        }
        
    }
    
    return dictOfUsersAndAssignedCount;
}

-(BOOL)CheckIfAtLeastOneUserWasAssignedMoreOrLessFrequently:(NSMutableDictionary *)dictOfUsersAndAssignedCount {
    
    BOOL DifferentAmountFound = false;
    
    NSString *firstUserID = [[dictOfUsersAndAssignedCount allKeys] count] > 0 ? [dictOfUsersAndAssignedCount allKeys][0] : @"";
    NSString *firstUserAssignedCount = dictOfUsersAndAssignedCount[firstUserID] ? dictOfUsersAndAssignedCount[firstUserID] : @"";
    
    for (NSString *userIDKey in [dictOfUsersAndAssignedCount allKeys]) {
        
        if ([[NSString stringWithFormat:@"%@", firstUserAssignedCount] intValue] != [[NSString stringWithFormat:@"%@", dictOfUsersAndAssignedCount[userIDKey]] intValue]) {
            
            DifferentAmountFound = true;
            
        }
        
    }
    
    return DifferentAmountFound;
}

-(NSArray *)GenerateSortedDictOfUserIDsAndNumberCorrespondingToHowOftenTheyWereAssignedToATask:(NSMutableDictionary *)dictOfUsersAndAssignedCount {
    
    NSMutableArray *dictOfUsersAndAssignedCountSortedKeys = [NSMutableArray array];
    
    NSArray *dictOfUsersAndAssignedCountObjects = [dictOfUsersAndAssignedCount allValues];
    NSMutableArray *dictOfUsersAndAssignedCountSortedObjects = [[dictOfUsersAndAssignedCountObjects sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
    
    for (NSString *object in dictOfUsersAndAssignedCountSortedObjects) {
        
        NSArray *dictOfUsersAndAssignedCountKeys = [dictOfUsersAndAssignedCount allKeysForObject:object];
        [dictOfUsersAndAssignedCountSortedKeys addObjectsFromArray:dictOfUsersAndAssignedCountKeys];
        
    }
    
    NSMutableArray *dictOfUsersAndAssignedCountSortedKeysReverseArray = [[[GeneralObject alloc] init] GenerateArrayInReverse:[dictOfUsersAndAssignedCountSortedKeys mutableCopy]];
    
    return dictOfUsersAndAssignedCountSortedKeysReverseArray;
}

-(NSMutableArray *)GenerateRandomizedUserIDArray:(NSArray *)dictOfUsersAndAssignedCountSortedKeys userIDArray:(NSMutableArray *)userIDArray homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    NSMutableArray *randomizeUserIDArray = [NSMutableArray array];
    
    for (NSString *userID in dictOfUsersAndAssignedCountSortedKeys) {
        
        if ([userIDArray containsObject:userID] && [randomizeUserIDArray containsObject:userID] == NO) {
            
            [randomizeUserIDArray addObject:userID];
            
        }
        
    }
    
    for (NSString *userID in homeMembersDict[@"UserID"]) {
        
        if ([randomizeUserIDArray containsObject:userID] == NO) {
            
            [randomizeUserIDArray insertObject:userID atIndex:0];
            
        }
        
    }
    
    return randomizeUserIDArray;
}

@end
