//
//  DisplayTasksObject.h
//  WeDivvy
//
//  Created by Philip Nagel on 8/17/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DisplayTasksObject : NSObject

#pragma mark - Split Tasks

-(void)GenerateItemsToDisplayForSpecificItem:(NSDictionary *)userInfo itemType:(NSString *)itemType keyArray:(NSArray *)keyArray homeMembersDict:(NSMutableDictionary *)homeMembersDict sideBarCategorySectionArrayAltered:(NSMutableArray *)sideBarCategorySectionArrayAltered taskListDict:(NSMutableDictionary *)taskListDict dataDisplayDict:(NSMutableDictionary *)dataDisplayDict dataDisplaySectionsArray:(NSMutableArray *)dataDisplaySectionsArray dataDisplayAmountDict:(NSMutableDictionary *)dataDisplayAmountDict sectionDict:(NSMutableDictionary *)sectionDict pinnedDict:(NSMutableDictionary *)pinnedDict sideBarCategorySectionArrayOriginal:(NSMutableArray *)sideBarCategorySectionArrayOriginal sectionOriginalSection:(int)sectionOriginalSection usersSection:(int)usersSection tagsSection:(int)tagsSection colorsSection:(int)colorsSection completionHandler:(void (^)(BOOL finished, NSMutableArray *returningDataDisplaySectionsArray, NSMutableDictionary *returningDataDisplayDict, NSMutableDictionary *returningDataDisplayAmountDict))finishBlock;

-(void)GenerateItemsToDisplay:(NSMutableDictionary *)itemDict homeMembersDict:(NSMutableDictionary *)homeMembersDict keyArray:(NSArray *)keyArray itemType:(NSString *)itemType completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock;

-(void)GenerateItemAmountForAllCategories:(NSMutableDictionary *)specificDictToUse itemType:(NSString *)itemType keyArray:(NSArray *)keyArray homeMembersDict:(NSMutableDictionary *)homeMembersDict sideBarCategoryArray:(NSMutableArray *)sideBarCategoryArray taskListDict:(NSMutableDictionary *)taskListDict completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock;

-(void)GenerateItemAmountForAllCategoriesCopy:(NSMutableDictionary *)specificDictToUse itemType:(NSString *)itemType keyArray:(NSArray *)keyArray homeMembersDict:(NSMutableDictionary *)homeMembersDict sideBarCategoryArray:(NSMutableArray *)sideBarCategoryArray taskListDict:(NSMutableDictionary *)taskListDict dateToCheck:(NSString *)dateToCheck completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock;

-(void)GenerateItemsToDisplayInSelectedCategory:(NSMutableDictionary *)specificDictToUse itemType:(NSString *)itemType keyArray:(NSArray *)keyArray homeMembersDict:(NSMutableDictionary *)homeMembersDict sideBarCategoryArray:(NSMutableArray *)sideBarCategoryArray taskListDict:(NSMutableDictionary *)taskListDict completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock;

-(void)GenerateItemsInSelectedCategorySpecificSections:(NSMutableDictionary *)ColorDictToUse keyArray:(NSArray *)keyArray itemType:(NSString *)itemType sectionsArray:(NSMutableArray *)sectionsArray homeMembersDict:(NSMutableDictionary *)homeMembersDict pinnedDict:(NSMutableDictionary *)pinnedDict taskListDict:(NSMutableDictionary *)taskListDict sectionDict:(NSMutableDictionary *)sectionDict completionHandler:(void (^)(BOOL finished, NSMutableArray *sectionsArray, NSMutableDictionary *returningDataDict))finishBlock;

@end

NS_ASSUME_NONNULL_END
