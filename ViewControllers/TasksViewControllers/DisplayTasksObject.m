//
//  DisplayTasksObject.m
//  WeDivvy
//
//  Created by Philip Nagel on 8/17/22.
//

#import "DisplayTasksObject.h"

#import "GeneralObject.h"
#import "BoolDataObject.h"
#import "SetDataObject.h"

#import "TasksViewController.h"

@implementation DisplayTasksObject

#pragma mark - Generate Single Item To Display

-(void)GenerateItemsToDisplayForSpecificItem:(NSDictionary *)userInfo itemType:(NSString *)itemType keyArray:(NSArray *)keyArray homeMembersDict:(NSMutableDictionary *)homeMembersDict sideBarCategorySectionArrayAltered:(NSMutableArray *)sideBarCategorySectionArrayAltered taskListDict:(NSMutableDictionary *)taskListDict dataDisplayDict:(NSMutableDictionary *)dataDisplayDict dataDisplaySectionsArray:(NSMutableArray *)dataDisplaySectionsArray dataDisplayAmountDict:(NSMutableDictionary *)dataDisplayAmountDict sectionDict:(NSMutableDictionary *)sectionDict pinnedDict:(NSMutableDictionary *)pinnedDict sideBarCategorySectionArrayOriginal:(NSMutableArray *)sideBarCategorySectionArrayOriginal sectionOriginalSection:(int)sectionOriginalSection usersSection:(int)usersSection tagsSection:(int)tagsSection colorsSection:(int)colorsSection completionHandler:(void (^)(BOOL finished, NSMutableArray *returningDataDisplaySectionsArray, NSMutableDictionary *returningDataDisplayDict, NSMutableDictionary *returningDataDisplayAmountDict))finishBlock {
   
    __block NSMutableDictionary *dataDisplayDictCopy = [dataDisplayDict mutableCopy];
    __block NSMutableArray *dataDisplaySectionsArrayCopy = [dataDisplaySectionsArray mutableCopy];
    __block NSMutableDictionary *dataDisplayAmountDictCopy = [dataDisplayAmountDict mutableCopy];
    
    NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleArraySingleObjectDictionary:[userInfo mutableCopy] keyArray:[userInfo allKeys] indexPath:nil];
    
  
    
    //Check If New Item Still Belongs In Selected Category
    [[[DisplayTasksObject alloc] init] GenerateItemsToDisplayInSelectedCategory:singleObjectItemDict itemType:itemType keyArray:keyArray homeMembersDict:homeMembersDict sideBarCategoryArray:sideBarCategorySectionArrayAltered taskListDict:taskListDict completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull itemsToDisplayInSelectedCategory) {
        
      
        
        NSDictionary *dict = [self GenerateItemsToDisplayForSpecificItem_GenerateOriginalSectionAndOriginalSectionDictOfItem:userInfo[@"ItemUniqueID"] dataDisplaySectionsArray:dataDisplaySectionsArrayCopy dataDisplayDict:dataDisplayDictCopy];
        NSString *originalSectionOfItem = dict[@"Section"];
        NSMutableDictionary *originalSectionDictOfItem = dict[@"Dict"];
  
       
        dispatch_async(dispatch_get_main_queue(), ^{
            
            BOOL TaskBelongsInSelectedCategory = itemsToDisplayInSelectedCategory && itemsToDisplayInSelectedCategory[@"ItemUniqueID"] && [(NSArray *)itemsToDisplayInSelectedCategory[@"ItemUniqueID"] count] > 0;
            
            
            
            //If Task Does Not Belong In Selected Category, Find Item In It's Section, Delete Item From Section It Was Found In
            if (TaskBelongsInSelectedCategory == NO) {
              
                NSDictionary *dict = [self GenerateItemsToDisplayForSpecificItem_RemoveItemFromItsOriginalSection:dataDisplayDictCopy dataDisplaySectionsArray:dataDisplaySectionsArray dataDisplayAmountDict:dataDisplayAmountDictCopy userInfo:userInfo originalSectionDictOfItem:originalSectionDictOfItem originalSectionOfItem:originalSectionOfItem itemType:itemType];
               
                dataDisplayDictCopy = dict[@"dataDisplayDict"];
                dataDisplaySectionsArrayCopy = dict[@"dataDisplaySectionsArray"];
                dataDisplayAmountDictCopy = dict[@"dataDisplayAmountDict"];
                
                finishBlock(YES, dataDisplaySectionsArrayCopy, dataDisplayDictCopy, dataDisplayAmountDictCopy);
                
            } else {
                
                BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemsToDisplayInSelectedCategory[@"ItemTags"] classArr:@[[NSArray class], [NSMutableArray class]]];
                NSMutableArray *itemTagArrayOfArrays = ObjectIsKindOfClass == YES ? itemsToDisplayInSelectedCategory[@"ItemTags"] : [NSMutableArray array];
                
                NSMutableArray *sectionsArray = [[[TasksViewController alloc] init] GenerateSectionsArray:itemTagArrayOfArrays taskListDict:taskListDict sectionDict:sectionDict sideBarCategorySectionArrayAltered:sideBarCategorySectionArrayAltered sideBarCategorySectionArrayOriginal:sideBarCategorySectionArrayOriginal sectionOriginalSection:sectionOriginalSection usersSection:usersSection tagsSection:tagsSection colorsSection:colorsSection];
                
              
               
                //Return The Section Where New Data Belongs
                [[[DisplayTasksObject alloc] init] GenerateItemsInSelectedCategorySpecificSections:itemsToDisplayInSelectedCategory keyArray:keyArray itemType:itemType sectionsArray:sectionsArray homeMembersDict:homeMembersDict pinnedDict:pinnedDict taskListDict:taskListDict sectionDict:sectionDict completionHandler:^(BOOL finished, NSMutableArray * _Nonnull sectionsArray, NSMutableDictionary * _Nonnull itemsInSelectedCategorySpecificSections) {
                   
                    NSString *newSectionOfItem = [self GenerateItemsToDisplayForSpecificItem_FindNewSectionItemBelongsTo:itemsInSelectedCategorySpecificSections singleObjectItemDict:singleObjectItemDict];
                    
                    BOOL TaskIsValid = [[[BoolDataObject alloc] init] TaskIsValidToBeDisplayed:singleObjectItemDict index:0 itemType:itemType homeMembersDict:homeMembersDict keyArray:keyArray];
                    BOOL ItemDeleted = [userInfo[@"ItemDeleted"] isEqualToString:@"Yes"];
                    BOOL ItemIsInSameSection = [newSectionOfItem isEqualToString:originalSectionOfItem] && [newSectionOfItem length] > 0;
                    
                    BOOL ItemBelongsInTheSameSectionItWasFoundIn = (ItemIsInSameSection == YES && TaskIsValid == YES && ItemDeleted == NO);
                    BOOL ItemBelongsInADifferentSectionThanItWasFoundIn = (ItemIsInSameSection == NO && TaskIsValid == YES && ItemDeleted == NO);
                    BOOL ItemIsNotValidOrItHasBeenDeleted = (TaskIsValid == NO || ItemDeleted == YES);
                    
                   
                    
                    if (ItemBelongsInTheSameSectionItWasFoundIn == YES) {
                      
                        NSDictionary *dict = [self GenerateItemsToDisplayForSpecificItem_UpdateItemDataInOriginalSection:dataDisplayDictCopy userInfo:userInfo originalSectionDictOfItem:originalSectionDictOfItem originalSectionOfItem:originalSectionOfItem];
                        dataDisplayDictCopy = dict[@"dataDisplayDict"];
                        
                    } else if (ItemBelongsInADifferentSectionThanItWasFoundIn == YES) {
                       
                        NSDictionary *dict = [self GenerateItemsToDisplayForSpecificItem_RemoveItemFromItsOriginalSection:dataDisplayDictCopy dataDisplaySectionsArray:dataDisplaySectionsArray dataDisplayAmountDict:dataDisplayAmountDictCopy userInfo:userInfo originalSectionDictOfItem:originalSectionDictOfItem originalSectionOfItem:originalSectionOfItem itemType:itemType];
                   
                        dataDisplayDictCopy = dict[@"dataDisplayDict"];
                        dataDisplaySectionsArrayCopy = dict[@"dataDisplaySectionsArray"];
                        dataDisplayAmountDictCopy = dict[@"dataDisplayAmountDict"];
                       
                        dict = [self GenerateItemsToDisplayForSpecificItem_AddItemDataInNewSection:dataDisplayDictCopy dataDisplaySectionsArray:dataDisplaySectionsArrayCopy dataDisplayAmountDict:dataDisplayAmountDictCopy userInfo:userInfo newSectionOfItem:newSectionOfItem itemsToDisplayInSelectedCategory:itemsToDisplayInSelectedCategory taskListDict:taskListDict sectionDict:sectionDict sideBarCategorySectionArrayAltered:sideBarCategorySectionArrayAltered sideBarCategorySectionArrayOriginal:sideBarCategorySectionArrayOriginal sectionOriginalSection:sectionOriginalSection usersSection:usersSection tagsSection:tagsSection colorsSection:colorsSection homeMembersDict:homeMembersDict itemType:itemType];
                       
                        dataDisplayDictCopy = dict[@"dataDisplayDict"];
                        dataDisplaySectionsArrayCopy = dict[@"dataDisplaySectionsArray"];
                        dataDisplayAmountDictCopy = dict[@"dataDisplayAmountDict"];
                   
                    } else if (ItemIsNotValidOrItHasBeenDeleted == YES) {
                       
                        NSDictionary *dict = [self GenerateItemsToDisplayForSpecificItem_RemoveItemFromItsOriginalSection:dataDisplayDictCopy dataDisplaySectionsArray:dataDisplaySectionsArray dataDisplayAmountDict:dataDisplayAmountDictCopy userInfo:userInfo originalSectionDictOfItem:originalSectionDictOfItem originalSectionOfItem:originalSectionOfItem itemType:itemType];
                      
                        dataDisplayDictCopy = dict[@"dataDisplayDict"];
                        dataDisplaySectionsArrayCopy = dict[@"dataDisplaySectionsArray"];
                        dataDisplayAmountDictCopy = dict[@"dataDisplayAmountDict"];
                        
                    }
                    
                   
                    
                    finishBlock(YES, dataDisplaySectionsArrayCopy, dataDisplayDictCopy, dataDisplayAmountDictCopy);
                    
                }];
                
            }
            
        });
        
    }];
    
}

#pragma mark - Generate Items To Display

-(void)GenerateItemsToDisplay:(NSMutableDictionary *)itemDict homeMembersDict:(NSMutableDictionary *)homeMembersDict keyArray:(NSArray *)keyArray itemType:(NSString *)itemType completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock {
    
    NSMutableDictionary *tempDict = [NSMutableDictionary dictionary];
    
    NSMutableArray *itemDictItemUniqueIDArrayCopy = itemDict[@"ItemUniqueID"] ? [itemDict[@"ItemUniqueID"] mutableCopy] : [NSMutableArray array];
    
    for (int i=0 ; i<itemDictItemUniqueIDArrayCopy.count ; i++) {
        
        NSUInteger index = i;
        
        BOOL TaskIsValid = [[[BoolDataObject alloc] init] TaskIsValidToBeDisplayed:itemDict index:index itemType:itemType homeMembersDict:homeMembersDict keyArray:keyArray];
        
        if (TaskIsValid == YES) {
            
            tempDict = [self FillDictWithData:tempDict itemDict:itemDict index:index keyArray:keyArray];
            
        }
        
    }
    
    NSMutableDictionary *dataDict = [tempDict mutableCopy];
    
    finishBlock(YES, dataDict);
}

#pragma mark - Generate Items In Selected Category

-(void)GenerateItemsToDisplayInSelectedCategory:(NSMutableDictionary *)specificDictToUse itemType:(NSString *)itemType keyArray:(NSArray *)keyArray homeMembersDict:(NSMutableDictionary *)homeMembersDict sideBarCategoryArray:(NSMutableArray *)sideBarCategoryArray taskListDict:(NSMutableDictionary *)taskListDict completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock {
    
    NSMutableArray *usernameArray = [NSMutableArray array];
    
    if (homeMembersDict[@"Username"]) {
        
        for (NSString *username in homeMembersDict[@"Username"]) {
            
            [usernameArray addObject:username];
            
        }
        
    }
    
    NSMutableArray *itemTags = [NSMutableArray array];
    
    if (specificDictToUse[@"ItemTags"]) {
        
        for (NSMutableArray *itemTagsArray in specificDictToUse[@"ItemTags"]) {
            
            for (NSString *itemTag in itemTagsArray) {
                
                [itemTags addObject:itemTag];
                
            }
            
        }
        
    }
    
    NSMutableArray *itemColors = [NSMutableArray array];
    
    if (specificDictToUse[@"ItemColor"]) {
        
        for (NSString *itemColor in specificDictToUse[@"ItemColor"]) {
            
            [itemColors addObject:itemColor];
            
        }
        
    }
    
    NSOrderedSet *orderedSet;
    
    orderedSet = [NSOrderedSet orderedSetWithArray:usernameArray];
    usernameArray = [[orderedSet array] mutableCopy];
    
    orderedSet = [NSOrderedSet orderedSetWithArray:itemTags];
    itemTags = [[orderedSet array] mutableCopy];
    
    orderedSet = [NSOrderedSet orderedSetWithArray:itemColors];
    itemColors = [[orderedSet array] mutableCopy];
    
    NSString *selectedCategory = [[NSUserDefaults standardUserDefaults] objectForKey:@"CategorySelected"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"CategorySelected"] : @"All";
    BOOL ListSelected = taskListDict[@"TaskListName"] && [taskListDict[@"TaskListName"] containsObject:selectedCategory];
    BOOL UserSelected = [usernameArray containsObject:selectedCategory];
    BOOL TagSelected = [itemTags containsObject:selectedCategory];
    BOOL ColorSelected = [itemColors containsObject:selectedCategory];
    
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    if (ListSelected == YES) {
        
        dataDict = [self GenerateItemsInCustomCategory:specificDictToUse keyArray:keyArray itemType:itemType homeMembersDict:homeMembersDict selectedCategory:selectedCategory taskListDict:taskListDict];
        
    } else if (UserSelected == YES) {
        
        dataDict = [self GenerateItemsInUser:specificDictToUse keyArray:keyArray itemType:itemType homeMembersDict:homeMembersDict selectedTag:selectedCategory];
        
    } else if (TagSelected == YES) {
        
        dataDict = [self GenerateItemsInCustomTag:specificDictToUse keyArray:keyArray itemType:itemType homeMembersDict:homeMembersDict selectedTag:selectedCategory];
        
    } else if (ColorSelected == YES) {
        
        dataDict = [self GenerateItemsInCustomColor:specificDictToUse keyArray:keyArray itemType:itemType homeMembersDict:homeMembersDict selectedTag:selectedCategory];
        
    } else {
        
        dataDict = [self GenerateItemsInDefaultCategory:specificDictToUse keyArray:keyArray itemType:itemType homeMembersDict:homeMembersDict selectedCategory:selectedCategory];
        
        
    }
    
    finishBlock(YES, dataDict);
    
}

#pragma mark - Generate Items In Selected Category Selected Section

-(void)GenerateItemsInSelectedCategorySpecificSections:(NSMutableDictionary *)DictToUse keyArray:(NSArray *)keyArray itemType:(NSString *)itemType sectionsArray:(NSMutableArray *)sectionsArray homeMembersDict:(NSMutableDictionary *)homeMembersDict pinnedDict:(NSMutableDictionary *)pinnedDict taskListDict:(NSMutableDictionary *)taskListDict sectionDict:(NSMutableDictionary *)sectionDict completionHandler:(void (^)(BOOL finished, NSMutableArray *sectionsArray, NSMutableDictionary *returningDataDict))finishBlock {
    
    NSString *key = @"SortSelectedDefaultCategory";
    NSString *key1 = @"SortSelectedDefaultUser";
    
    BOOL Name = [[[NSUserDefaults standardUserDefaults] objectForKey:key] isEqualToString:@"By Name"];
    BOOL Date = [[[NSUserDefaults standardUserDefaults] objectForKey:key] isEqualToString:@"By Date"];
    BOOL Difficulty = [[[NSUserDefaults standardUserDefaults] objectForKey:key] isEqualToString:@"By Difficulty"];
    BOOL Priority = [[[NSUserDefaults standardUserDefaults] objectForKey:key] isEqualToString:@"By Priority"];
    BOOL Tag = [[[NSUserDefaults standardUserDefaults] objectForKey:key] isEqualToString:@"By Tag"];
    BOOL Color = [[[NSUserDefaults standardUserDefaults] objectForKey:key] isEqualToString:@"By Color"];
    BOOL List = [[[NSUserDefaults standardUserDefaults] objectForKey:key] isEqualToString:@"By List"];
    BOOL Custom = [[[NSUserDefaults standardUserDefaults] objectForKey:key] isEqualToString:@"Custom"];
    BOOL AssignedTo = [[[NSUserDefaults standardUserDefaults] objectForKey:key1] containsObject:@"Assigned To"];
    BOOL CreatedBy = [[[NSUserDefaults standardUserDefaults] objectForKey:key1] containsObject:@"Created By"];
    
    if (Name == NO &&
        Tag == NO &&
        Difficulty == NO &&
        Priority == NO &&
        Color == NO &&
        List == NO &&
        Custom == NO &&
        AssignedTo == NO &&
        CreatedBy == NO) {
        
        Date = YES;
        
    }
    
    NSMutableArray *userSelected = [self GenerateUserSelectedUserSortType:key1];
   
    NSString *selectedCategory = [[NSUserDefaults standardUserDefaults] objectForKey:@"CategorySelected"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"CategorySelected"] : @"All";
    NSUInteger indexOfSelectedTaskList = taskListDict[@"TaskListName"] && [taskListDict[@"TaskListName"] containsObject:selectedCategory] ? [taskListDict[@"TaskListName"] indexOfObject:selectedCategory] : 0;
    BOOL ListSelected = taskListDict[@"TaskListName"] && [taskListDict[@"TaskListName"] containsObject:selectedCategory];
    
    NSMutableDictionary *selectedTaskListItems = ListSelected == YES && taskListDict[@"TaskListItems"] && [(NSArray *)taskListDict[@"TaskListItems"] count] > indexOfSelectedTaskList ? taskListDict[@"TaskListItems"][indexOfSelectedTaskList] : [NSMutableDictionary dictionary];
    
    NSMutableDictionary *allSectionDataDict = [self GenerateBlankAllSectionDataDict:sectionsArray];
    NSMutableArray *arrayToUse = [self GenerateArrayToUse:DictToUse Name:Name];
    
    
    
    for (int i=0 ; i<arrayToUse.count ; i++) {
        
        
        
        NSInteger indexOfCurrentItem = i;
        NSString *itemUniqueID = DictToUse[@"ItemUniqueID"] && [(NSArray *)DictToUse[@"ItemUniqueID"] count] > indexOfCurrentItem ? DictToUse[@"ItemUniqueID"][indexOfCurrentItem] : @"";
        
        NSString *keyToCheck = [self GenerateKeyToCheck:Name Date:Date Tag:Tag Difficulty:Difficulty Priority:Priority Color:Color];
        
        NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:DictToUse keyArray:keyArray indexPath:[NSIndexPath indexPathForRow:indexOfCurrentItem inSection:0]];
        
        BOOL TaskIsFullyCompleted = [[[BoolDataObject alloc] init] TaskIsFullyCompleted:singleObjectItemDict itemType:itemType homeMembersDict:homeMembersDict];
        BOOL TaskIsAssignedToSelectedUser = [self TaskIsAssignedToSelectedUser:AssignedTo CreatedBy:CreatedBy userSelected:userSelected DictToUse:DictToUse homeMembersDict:homeMembersDict indexOfCurrentItem:indexOfCurrentItem];
        
      
        
        NSMutableDictionary *specificSectionDataDict = [NSMutableDictionary dictionary];
        NSString *sectionToAddTask = @"";
     
        for (NSString *section in sectionsArray) {
            
            BOOL TaskBelongsInPinnedToHomeSection = [self CheckIfTaskBelongsInPinnedToHomeSection:DictToUse keyToCheck:@"ItemPinned" indexOfCurrentItem:indexOfCurrentItem section:section];
            
            BOOL TaskBelongsInPinnedSection = [self CheckIfTaskBelongsInPinnedSection:section pinnedDict:pinnedDict currentItemUniqueID:itemUniqueID TaskIsFullyCompleted:TaskIsFullyCompleted TaskIsAssignedToSelectedUser:TaskIsAssignedToSelectedUser];
            
            BOOL TaskBelongsInTagSection = [self CheckIfTaskBelongsInTagSection:DictToUse keyToCheck:keyToCheck currentItemUniqueID:itemUniqueID indexOfCurrentItem:indexOfCurrentItem section:section selectedTaskListItems:selectedTaskListItems TaskIsFullyCompleted:TaskIsFullyCompleted ListSelected:ListSelected TaskIsAssignedToSelectedUser:TaskIsAssignedToSelectedUser Tag:Tag];
            
            BOOL TaskBelongsInDifficultySection = [self CheckIfTaskBelongsInDifficultySection:DictToUse keyToCheck:keyToCheck currentItemUniqueID:itemUniqueID indexOfCurrentItem:indexOfCurrentItem section:section selectedTaskListItems:selectedTaskListItems TaskIsFullyCompleted:TaskIsFullyCompleted ListSelected:ListSelected TaskIsAssignedToSelectedUser:TaskIsAssignedToSelectedUser Difficulty:Difficulty];
            
            BOOL TaskBelongsInPrioritySection = [self CheckIfTaskBelongsInPrioritySection:DictToUse keyToCheck:keyToCheck currentItemUniqueID:itemUniqueID indexOfCurrentItem:indexOfCurrentItem section:section selectedTaskListItems:selectedTaskListItems TaskIsFullyCompleted:TaskIsFullyCompleted ListSelected:ListSelected TaskIsAssignedToSelectedUser:TaskIsAssignedToSelectedUser Priority:Priority];
            
            BOOL TaskBelongsInColorSection = [self CheckIfTaskBelongsInColorSection:DictToUse keyToCheck:keyToCheck currentItemUniqueID:itemUniqueID indexOfCurrentItem:indexOfCurrentItem section:section selectedTaskListItems:selectedTaskListItems TaskIsFullyCompleted:TaskIsFullyCompleted ListSelected:ListSelected TaskIsAssignedToSelectedUser:TaskIsAssignedToSelectedUser Color:Color];
            
            BOOL TaskBelongsInNameSection = [self CheckIfTaskBelongsInNameSection:DictToUse keyToCheck:keyToCheck currentItemUniqueID:itemUniqueID indexOfCurrentItem:indexOfCurrentItem section:section selectedTaskListItems:selectedTaskListItems TaskIsFullyCompleted:TaskIsFullyCompleted ListSelected:ListSelected TaskIsAssignedToSelectedUser:TaskIsAssignedToSelectedUser Name:Name];
            
            BOOL TaskBelongsInDateSection = [self CheckIfTaskBelongsInDateSection:DictToUse keyToCheck:keyToCheck currentItemUniqueID:itemUniqueID indexOfCurrentItem:indexOfCurrentItem section:section selectedTaskListItems:selectedTaskListItems TaskIsFullyCompleted:TaskIsFullyCompleted ListSelected:ListSelected TaskIsAssignedToSelectedUser:TaskIsAssignedToSelectedUser keyArray:keyArray itemType:itemType homeMembersDict:homeMembersDict Date:Date];
            
            BOOL TaskBelongsInListSection = [self CheckIfTaskBelongsInListSection:DictToUse keyToCheck:keyToCheck currentItemUniqueID:itemUniqueID indexOfCurrentItem:indexOfCurrentItem section:section selectedTaskListItems:selectedTaskListItems TaskIsFullyCompleted:TaskIsFullyCompleted ListSelected:ListSelected TaskIsAssignedToSelectedUser:TaskIsAssignedToSelectedUser taskListDict:taskListDict List:List];
            
            BOOL TaskBelongsInCustomSection = [self CheckIfTaskBelongsInCustomSection:DictToUse keyToCheck:keyToCheck currentItemUniqueID:itemUniqueID indexOfCurrentItem:indexOfCurrentItem section:section selectedTaskListItems:selectedTaskListItems TaskIsFullyCompleted:TaskIsFullyCompleted ListSelected:ListSelected TaskIsAssignedToSelectedUser:TaskIsAssignedToSelectedUser sectionDict:sectionDict Custom:Custom];
            
            if ((TaskBelongsInPinnedToHomeSection) ||
                (TaskBelongsInPinnedSection) ||
                (Tag && TaskBelongsInTagSection) ||
                (Difficulty && TaskBelongsInDifficultySection) ||
                (Priority && TaskBelongsInPrioritySection) ||
                (Color && TaskBelongsInColorSection) ||
                (Name && TaskBelongsInNameSection) ||
                (Date && TaskBelongsInDateSection) ||
                (List && TaskBelongsInListSection) ||
                (Custom && TaskBelongsInCustomSection)
                ) {
                
                specificSectionDataDict = allSectionDataDict[section] ? [allSectionDataDict[section] mutableCopy] : [NSMutableDictionary dictionary];
                sectionToAddTask = section;
                break;
                
            }
            
        }
        
        allSectionDataDict = [self GenerateAllSectionsDictWithNewSection:allSectionDataDict specificSectionDataDict:specificSectionDataDict sectionToAddTask:sectionToAddTask DictToUse:DictToUse indexOfCurrentItem:indexOfCurrentItem keyArray:keyArray];
        
        DictToUse = [self UpdateDictToUseWithXXX:DictToUse indexOfCurrentItem:indexOfCurrentItem keyArray:keyArray];
        
    }
    
    
    
    NSDictionary *dict;
    
    dict = [self RemoveAppropriateSectionsIfNeeded:allSectionDataDict sectionsArray:sectionsArray Custom:Custom];
    allSectionDataDict = dict[@"AllSectionDataDict"] ? [dict[@"AllSectionDataDict"] mutableCopy] : [NSMutableDictionary dictionary];
    sectionsArray = dict[@"SectionsArray"] ? [dict[@"SectionsArray"] mutableCopy] : [NSMutableArray array];
    
    dict = [self RemoveCompletedSectionIfNeeded:allSectionDataDict sectionsArray:sectionsArray];
    allSectionDataDict = dict[@"AllSectionDataDict"] ? [dict[@"AllSectionDataDict"] mutableCopy] : [NSMutableDictionary dictionary];
    sectionsArray = dict[@"SectionsArray"] ? [dict[@"SectionsArray"] mutableCopy] : [NSMutableArray array];
    
    allSectionDataDict = [self GenerateAllSectionsDataDictWithSortedDataDicts:allSectionDataDict keyArray:keyArray];
    
    
    
    finishBlock(YES, sectionsArray, allSectionDataDict);
    
}

#pragma mark - Generate Amount Of Items In Categories

-(void)GenerateItemAmountForAllCategories:(NSMutableDictionary *)specificDictToUse itemType:(NSString *)itemType keyArray:(NSArray *)keyArray homeMembersDict:(NSMutableDictionary *)homeMembersDict sideBarCategoryArray:(NSMutableArray *)sideBarCategoryArray taskListDict:(NSMutableDictionary *)taskListDict completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock {
    
    NSMutableArray *usernameArray = [NSMutableArray array];
    
    if (homeMembersDict[@"Username"]) {
        
        for (NSString *username in homeMembersDict[@"Username"]) {
            
            [usernameArray addObject:username];
            
        }
        
    }
    
    NSMutableArray *itemTags = [NSMutableArray array];
    
    if (specificDictToUse[@"ItemTags"]) {
        
        for (NSMutableArray *itemTagsArray in specificDictToUse[@"ItemTags"]) {
            
            for (NSString *itemTag in itemTagsArray) {
                
                [itemTags addObject:itemTag];
                
            }
            
        }
        
    }
    
    NSMutableArray *itemColors = [NSMutableArray array];
    
    if (specificDictToUse[@"ItemColor"]) {
        
        for (NSString *itemColor in specificDictToUse[@"ItemColor"]) {
            
            [itemColors addObject:itemColor];
            
        }
        
    }
    
    NSOrderedSet *orderedSet;
    
    orderedSet = [NSOrderedSet orderedSetWithArray:usernameArray];
    usernameArray = [[orderedSet array] mutableCopy];
    
    orderedSet = [NSOrderedSet orderedSetWithArray:itemTags];
    itemTags = [[orderedSet array] mutableCopy];
    
    orderedSet = [NSOrderedSet orderedSetWithArray:itemColors];
    itemColors = [[orderedSet array] mutableCopy];
    
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    for (int i=0; i<sideBarCategoryArray.count ; i++) {
        
        if ([sideBarCategoryArray count] > i && sideBarCategoryArray[i][@"Names"]) {
            
            for (NSString *selectedCategory in sideBarCategoryArray[i][@"Names"]) {
                
                BOOL ListSelected = taskListDict[@"TaskListName"] && [taskListDict[@"TaskListName"] containsObject:selectedCategory];
                BOOL UserSelected = [usernameArray containsObject:selectedCategory];
                BOOL TagSelected = [itemTags containsObject:selectedCategory];
                BOOL ColorSelected = [itemColors containsObject:selectedCategory];
                
                NSMutableDictionary *dataDictLocal;
                
                if (ListSelected == YES) {

                    dataDictLocal = [self GenerateItemsInCustomCategory:specificDictToUse keyArray:keyArray itemType:itemType homeMembersDict:homeMembersDict selectedCategory:selectedCategory taskListDict:taskListDict];

                } else if (UserSelected == YES) {
                    
                    dataDictLocal = [self GenerateItemsInUser:specificDictToUse keyArray:keyArray itemType:itemType homeMembersDict:homeMembersDict selectedTag:selectedCategory];
                    
                } else if (TagSelected == YES) {
                    
                    dataDictLocal = [self GenerateItemsInCustomTag:specificDictToUse keyArray:keyArray itemType:itemType homeMembersDict:homeMembersDict selectedTag:selectedCategory];
                    
                } else if (ColorSelected == YES) {
                    
                    dataDictLocal = [self GenerateItemsInCustomColor:specificDictToUse keyArray:keyArray itemType:itemType homeMembersDict:homeMembersDict selectedTag:selectedCategory];
                    
                } else {
                    
                    dataDictLocal = [self GenerateItemsInDefaultCategory:specificDictToUse keyArray:keyArray itemType:itemType homeMembersDict:homeMembersDict selectedCategory:selectedCategory];
                    
                }
                
                NSMutableArray *itemUniqueIDArray = dataDictLocal[@"ItemUniqueID"] ? [dataDictLocal[@"ItemUniqueID"] mutableCopy] : [NSMutableArray array];
                
                [dataDict setObject:[NSString stringWithFormat:@"%lu", [itemUniqueIDArray count]] forKey:selectedCategory];
                
            }
            
        }
        
    }

    finishBlock(YES, dataDict);
}

-(void)GenerateItemAmountForAllCategoriesCopy:(NSMutableDictionary *)specificDictToUse itemType:(NSString *)itemType keyArray:(NSArray *)keyArray homeMembersDict:(NSMutableDictionary *)homeMembersDict sideBarCategoryArray:(NSMutableArray *)sideBarCategoryArray taskListDict:(NSMutableDictionary *)taskListDict dateToCheck:(NSString *)dateToCheck completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock {
    
    NSMutableArray *usernameArray = [NSMutableArray array];
    
    if (homeMembersDict[@"Username"]) {
        
        for (NSString *username in homeMembersDict[@"Username"]) {
            
            [usernameArray addObject:username];
            
        }
        
    }
    
    NSMutableArray *itemTags = [NSMutableArray array];
    
    if (specificDictToUse[@"ItemTags"]) {
        
        for (NSMutableArray *itemTagsArray in specificDictToUse[@"ItemTags"]) {
            
            for (NSString *itemTag in itemTagsArray) {
                
                [itemTags addObject:itemTag];
                
            }
            
        }
        
    }
    
    NSMutableArray *itemColors = [NSMutableArray array];
    
    if (specificDictToUse[@"ItemColor"]) {
        
        for (NSString *itemColor in specificDictToUse[@"ItemColor"]) {
            
            [itemColors addObject:itemColor];
            
        }
        
    }
    
    NSOrderedSet *orderedSet;
    
    orderedSet = [NSOrderedSet orderedSetWithArray:usernameArray];
    usernameArray = [[orderedSet array] mutableCopy];
    
    orderedSet = [NSOrderedSet orderedSetWithArray:itemTags];
    itemTags = [[orderedSet array] mutableCopy];
    
    orderedSet = [NSOrderedSet orderedSetWithArray:itemColors];
    itemColors = [[orderedSet array] mutableCopy];
    
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    for (int i=0; i<sideBarCategoryArray.count ; i++) {
        
        if ([sideBarCategoryArray count] > i && sideBarCategoryArray[i][@"Names"]) {
            
            for (NSString *selectedCategory in sideBarCategoryArray[i][@"Names"]) {
                
                BOOL ListSelected = taskListDict[@"TaskListName"] && [taskListDict[@"TaskListName"] containsObject:selectedCategory];
                BOOL UserSelected = [usernameArray containsObject:selectedCategory];
                BOOL TagSelected = [itemTags containsObject:selectedCategory];
                BOOL ColorSelected = [itemColors containsObject:selectedCategory];
                
                NSMutableDictionary *dataDictLocal;
                
                if (ListSelected == YES) {
                    
                    dataDictLocal = [self GenerateItemsInCustomCategory:specificDictToUse keyArray:keyArray itemType:itemType homeMembersDict:homeMembersDict selectedCategory:selectedCategory taskListDict:taskListDict];
                    
                } else if (UserSelected == YES) {
                    
                    dataDictLocal = [self GenerateItemsInUser:specificDictToUse keyArray:keyArray itemType:itemType homeMembersDict:homeMembersDict selectedTag:selectedCategory];
                    
                } else if (TagSelected == YES) {
                    
                    dataDictLocal = [self GenerateItemsInCustomTag:specificDictToUse keyArray:keyArray itemType:itemType homeMembersDict:homeMembersDict selectedTag:selectedCategory];
                    
                } else if (ColorSelected == YES) {
                    
                    dataDictLocal = [self GenerateItemsInCustomColor:specificDictToUse keyArray:keyArray itemType:itemType homeMembersDict:homeMembersDict selectedTag:selectedCategory];
                    
                } else {
                    
                    dataDictLocal = [self GenerateItemsInDefaultCategoryCopy:specificDictToUse keyArray:keyArray itemType:itemType homeMembersDict:homeMembersDict selectedCategory:selectedCategory dateToCheck:dateToCheck];
                    
                    
                }
                
                NSMutableArray *itemIDArray = dataDictLocal[@"ItemID"] ? [dataDictLocal[@"ItemID"] mutableCopy] : [NSMutableArray array];
                
                [dataDict setObject:[NSString stringWithFormat:@"%lu", [itemIDArray count]] forKey:selectedCategory];
                
            }
            
        }
        
    }
    
    finishBlock(YES, dataDict);
    
}

#pragma mark -
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark -

#pragma mark Generate Specific Item To Display

-(NSDictionary *)GenerateItemsToDisplayForSpecificItem_GenerateOriginalSectionAndOriginalSectionDictOfItem:(NSString *)itemUniqueIDLocal dataDisplaySectionsArray:(NSMutableArray *)dataDisplaySectionsArray dataDisplayDict:(NSMutableDictionary *)dataDisplayDict {
    
    NSString *sectionFound = @"";
    NSMutableDictionary *dictFound = [NSMutableDictionary dictionary];
    
    for (NSString *sectionName in dataDisplaySectionsArray) {
        NSDictionary *dictToUse = dataDisplayDict[sectionName];
        for (NSString *itemUniqueID in dictToUse[@"ItemUniqueID"]) {
            if ([itemUniqueID isEqualToString:itemUniqueIDLocal]) {
                sectionFound = sectionName;
                dictFound = [dictToUse mutableCopy];
                break;
            }
        }
        if (dictFound[@"ItemID"]) {
            break;
        }
    }
    
    return @{@"Section" : sectionFound, @"Dict" : dictFound};
}

-(NSString *)GenerateItemsToDisplayForSpecificItem_FindNewSectionItemBelongsTo:(NSMutableDictionary *)itemsInSelectedCategorySpecificSections singleObjectItemDict:(NSMutableDictionary *)singleObjectItemDict {
    
    NSString *newSectionOfItem = @"";
    
    for (NSString *sectionName in [itemsInSelectedCategorySpecificSections allKeys]) {
        
        NSString *itemUniqueID =
        itemsInSelectedCategorySpecificSections[sectionName] &&
        itemsInSelectedCategorySpecificSections[sectionName][@"ItemUniqueID"] &&
        [(NSArray *)itemsInSelectedCategorySpecificSections[sectionName][@"ItemUniqueID"] count] > 0 ?
        itemsInSelectedCategorySpecificSections[sectionName][@"ItemUniqueID"][0] : @"";
        
        NSString *userInfoItemUniqueID =
        singleObjectItemDict &&
        singleObjectItemDict[@"ItemUniqueID"] &&
        [(NSArray *)singleObjectItemDict[@"ItemUniqueID"] count] > 0 ?
        singleObjectItemDict[@"ItemUniqueID"][0] : @"";
        
        if ([itemUniqueID isEqualToString:userInfoItemUniqueID]) {
            
            newSectionOfItem = sectionName;
            break;
            
        }
        
    }
    
    return newSectionOfItem;
}


-(NSDictionary *)GenerateItemsToDisplayForSpecificItem_RemoveItemFromItsOriginalSection:(NSMutableDictionary *)dataDisplayDict dataDisplaySectionsArray:(NSMutableArray *)dataDisplaySectionsArray dataDisplayAmountDict:(NSMutableDictionary *)dataDisplayAmountDict userInfo:(NSDictionary *)userInfo originalSectionDictOfItem:(NSMutableDictionary *)originalSectionDictOfItem originalSectionOfItem:(NSString *)originalSectionOfItem itemType:(NSString *)itemType {
    
    NSMutableDictionary *originalSectionDictOfItemWithdItemDataRemove = [self GenerateItemsToDisplayForSpecificItem_RemoveItemFromItsOriginalSection_GenerateOriginalSectionDictOfItemWithItemDataRemoved:[originalSectionDictOfItem mutableCopy] userInfo:userInfo itemType:itemType];
    
    dataDisplayDict = [self GenerateItemsToDisplayForSpecificItem_RemoveItemFromItsOriginalSection_GenerateDataDisplayDict:dataDisplayDict originalSectionDictOfItemWithdItemDataRemove:originalSectionDictOfItemWithdItemDataRemove originalSectionOfItem:originalSectionOfItem];
    
    dataDisplaySectionsArray = [self GenerateItemsToDisplayForSpecificItem_RemoveItemFromItsOriginalSection_GenerateDataDisplaySectionsArray:dataDisplaySectionsArray originalSectionDictOfItemWithdItemDataRemove:originalSectionDictOfItemWithdItemDataRemove originalSectionOfItem:originalSectionOfItem];
    
    dataDisplayAmountDict = [self GenerateItemsToDisplayForSpecificItem_RemoveItemFromItsOriginalSection_GenerateDataDisplayAmountDict:dataDisplayAmountDict originalSectionOfItem:originalSectionOfItem];
    
    return @{@"dataDisplayDict" : dataDisplayDict, @"dataDisplaySectionsArray" : dataDisplaySectionsArray, @"dataDisplayAmountDict" : dataDisplayAmountDict};
}

-(NSDictionary *)GenerateItemsToDisplayForSpecificItem_UpdateItemDataInOriginalSection:(NSMutableDictionary *)dataDisplayDict userInfo:(NSDictionary *)userInfo originalSectionDictOfItem:(NSMutableDictionary *)originalSectionDictOfItem originalSectionOfItem:(NSString *)originalSectionOfItem {
    
    dataDisplayDict = [self GenerateItemsToDisplayForSpecificItem_UpdateItemDataInOriginalSection_GenerateDataDisplayDict:dataDisplayDict userInfo:userInfo originalSectionDictOfItem:originalSectionDictOfItem originalSectionOfItem:originalSectionOfItem];
    
    return @{@"dataDisplayDict" : dataDisplayDict};
}

-(NSDictionary *)GenerateItemsToDisplayForSpecificItem_AddItemDataInNewSection:(NSMutableDictionary *)dataDisplayDict dataDisplaySectionsArray:(NSMutableArray *)dataDisplaySectionsArray dataDisplayAmountDict:(NSMutableDictionary *)dataDisplayAmountDict userInfo:(NSDictionary *)userInfo newSectionOfItem:(NSString *)newSectionOfItem itemsToDisplayInSelectedCategory:(NSMutableDictionary *)itemsToDisplayInSelectedCategory taskListDict:(NSMutableDictionary *)taskListDict sectionDict:(NSMutableDictionary *)sectionDict sideBarCategorySectionArrayAltered:(NSMutableArray *)sideBarCategorySectionArrayAltered sideBarCategorySectionArrayOriginal:(NSMutableArray *)sideBarCategorySectionArrayOriginal sectionOriginalSection:(int)sectionOriginalSection usersSection:(int)usersSection tagsSection:(int)tagsSection colorsSection:(int)colorsSection homeMembersDict:(NSMutableDictionary *)homeMembersDict itemType:(NSString *)itemType {
    
    BOOL TaskIsFullyCompleted = [[[BoolDataObject alloc] init] TaskIsFullyCompleted:[userInfo mutableCopy] itemType:itemType homeMembersDict:homeMembersDict];
    BOOL ShowCompleted = ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ShowCompleted"] isEqualToString:@"Yes"] ||
                          [[NSUserDefaults standardUserDefaults] objectForKey:@"ShowCompleted"] == NULL ||
                          [[[NSUserDefaults standardUserDefaults] objectForKey:@"ShowCompletedToggledAtLeastOnce"] isEqualToString:@"Yes"] == NO);
   
    if (TaskIsFullyCompleted == NO || (TaskIsFullyCompleted == YES && ShowCompleted == YES)) {
      
        NSDictionary *dict = [self GenerateItemsToDisplayForSpecificItem_AddItemToItsNewSection:dataDisplayDict dataDisplayAmountDict:dataDisplayAmountDict dataDisplaySectionsArray:dataDisplaySectionsArray userInfo:userInfo newSectionOfItem:newSectionOfItem itemsToDisplayInSelectedCategory:itemsToDisplayInSelectedCategory taskListDict:taskListDict sectionDict:sectionDict sideBarCategorySectionArrayAltered:sideBarCategorySectionArrayAltered sideBarCategorySectionArrayOriginal:sideBarCategorySectionArrayOriginal sectionOriginalSection:sectionOriginalSection usersSection:usersSection tagsSection:tagsSection colorsSection:colorsSection itemType:itemType];
        
        dataDisplayDict = dict[@"dataDisplayDict"];
        dataDisplaySectionsArray = dict[@"dataDisplaySectionsArray"];
        dataDisplayAmountDict = dict[@"dataDisplayAmountDict"];
        
    }
    
    return @{@"dataDisplayDict" : dataDisplayDict, @"dataDisplaySectionsArray" : dataDisplaySectionsArray, @"dataDisplayAmountDict" : dataDisplayAmountDict};
}

#pragma mark - Generate Items To Display

-(NSMutableDictionary *)FillDictWithData:(NSMutableDictionary *)dictToUse itemDict:(NSMutableDictionary *)itemDict index:(NSUInteger)index keyArray:(NSArray *)keyArray {
    
    for (NSString *key in keyArray) {
        
        NSMutableArray *arr = dictToUse[key] ? [dictToUse[key] mutableCopy] : [NSMutableArray array];
        
        id object = itemDict[key] && [(NSArray *)itemDict[key] count] > index ? itemDict[key][index] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
        [arr addObject:object];
        
        [dictToUse setObject:arr forKey:key];
        
    }
    
    return dictToUse;
    
}

#pragma mark - Generate Items In Selected Category Selected Section

//-(NSString *)GenerateUserSelectedUserSortType:(NSString *)key {
-(NSMutableArray *)GenerateUserSelectedUserSortType:(NSString *)key {
    
    //NSString *userSelected = [[NSUserDefaults standardUserDefaults] objectForKey:key] ? [[NSUserDefaults standardUserDefaults] objectForKey:key] : @"";
    NSMutableArray *userSelected = [[NSUserDefaults standardUserDefaults] objectForKey:key] ? [[NSUserDefaults standardUserDefaults] objectForKey:key] : [NSMutableArray array];
    
    //    if ([userSelected containsString:@"Assigned To ••• "]) {
    //
    //        userSelected = [[userSelected componentsSeparatedByString:@"Assigned To ••• "] count] > 1 ? [userSelected componentsSeparatedByString:@"Assigned To ••• "][1] : @"";
    //
    //    } else if ([userSelected containsString:@"Created By ••• "]) {
    //
    //        userSelected = [[userSelected componentsSeparatedByString:@"Created By ••• "] count] > 1 ? [userSelected componentsSeparatedByString:@"Created By ••• "][1] : @"";
    //
    //    }
    
    return userSelected;
}

-(NSMutableDictionary *)GenerateBlankAllSectionDataDict:(NSMutableArray *)sectionsArray {
    
    NSMutableDictionary *allSectionDataDict = [NSMutableDictionary dictionary];
    
    for (NSString *section in sectionsArray) {
        [allSectionDataDict setObject:[@{} mutableCopy] forKey:section];
    }
    
    return allSectionDataDict;
}

-(NSMutableArray *)GenerateArrayToUse:(NSMutableDictionary *)DictToUse Name:(BOOL)Name {
    
    NSMutableArray *arrayToUse = [NSMutableArray array];
    
    if (Name == YES && DictToUse[@"ItemName"]) {
        
        arrayToUse = [[DictToUse[@"ItemName"] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] mutableCopy];
        
    } else if (DictToUse[@"ItemID"]) {
        
        arrayToUse = [DictToUse[@"ItemID"] mutableCopy];
        
    }
    
    return arrayToUse;
}

-(NSString *)GenerateKeyToCheck:(BOOL)Name Date:(BOOL)Date Tag:(BOOL)Tag Difficulty:(BOOL)Difficulty Priority:(BOOL)Priority Color:(BOOL)Color {
    
    NSString *keyToCheck = @"ItemID";
    
    if (Name) {
        keyToCheck = @"ItemName";
    } else if (Date) {
        keyToCheck = @"ItemDueDate";
    } else if (Tag) {
        keyToCheck = @"ItemTags";
    } else if (Difficulty) {
        keyToCheck = @"ItemDifficulty";
    } else if (Priority) {
        keyToCheck = @"ItemPriority";
    } else if (Color) {
        keyToCheck = @"ItemColor";
    }
    
    return keyToCheck;
}

-(NSString *)GenerateCreatedByUsername:(NSMutableDictionary *)DictToUse homeMembersDict:(NSMutableDictionary *)homeMembersDict indexOfCurrentItem:(NSUInteger)indexOfCurrentItem {
    
    NSString *itemCreatedByUsername = @"";
    
    if (DictToUse[@"ItemCreatedBy"] && [(NSArray *)DictToUse[@"ItemCreatedBy"] count] > indexOfCurrentItem) {
        
        if (homeMembersDict[@"UserID"] && [homeMembersDict[@"UserID"] containsObject:DictToUse[@"ItemCreatedBy"][indexOfCurrentItem]]) {
            
            NSUInteger index = [homeMembersDict[@"UserID"] indexOfObject:DictToUse[@"ItemCreatedBy"][indexOfCurrentItem]];
            itemCreatedByUsername = homeMembersDict[@"Username"] && [(NSArray *)homeMembersDict[@"Username"] count] > index ? homeMembersDict[@"Username"][index] : @"";
            
        }
        
    }
    
    return itemCreatedByUsername;
}

-(NSMutableArray *)GenerateItemAssignedToUsernameArray:(NSMutableDictionary *)DictToUse homeMembersDict:(NSMutableDictionary *)homeMembersDict indexOfCurrentItem:(NSUInteger)indexOfCurrentItem {
    
    NSMutableArray *itemAssignedToUsername = [NSMutableArray array];
    
    if (DictToUse[@"ItemAssignedTo"] && [(NSArray *)DictToUse[@"ItemAssignedTo"] count] > indexOfCurrentItem) {
        
        for (NSString *userID in DictToUse[@"ItemAssignedTo"][indexOfCurrentItem]) {
            
            if (homeMembersDict[@"UserID"] && [homeMembersDict[@"UserID"] containsObject:userID]) {
                
                NSUInteger index = [homeMembersDict[@"UserID"] indexOfObject:userID];
                NSString *username = homeMembersDict[@"Username"] && [(NSArray *)homeMembersDict[@"Username"] count] > index ? homeMembersDict[@"Username"][index] : @"";
                
                [itemAssignedToUsername addObject:username];
                
            }
            
        }
        
    }
    
    return itemAssignedToUsername;
}

-(BOOL)TaskContainsAtLeastOneSelectedUser:(NSMutableDictionary *)DictToUse indexOfCurrentItem:(NSUInteger)indexOfCurrentItem itemAssignedToUsername:(NSMutableArray *)itemAssignedToUsername userSelected:(NSMutableArray *)userSelected homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    BOOL TaskContainsAtLeastOneSelectedUser = NO;
    
    for (NSString *username in itemAssignedToUsername) {
        
        if ([userSelected containsObject:username]) {
            
            TaskContainsAtLeastOneSelectedUser = YES;
            break;
            
        }
        
    }
    
    BOOL TaskIsTakingTurns =
    DictToUse &&
    DictToUse[@"ItemTakeTurns"] &&
    [(NSArray *)DictToUse[@"ItemTakeTurns"] count] > indexOfCurrentItem ?
    [DictToUse[@"ItemTakeTurns"][indexOfCurrentItem] isEqualToString:@"Yes"] : NO;
    
    if (TaskIsTakingTurns) {
        
        NSString *turnUsername = @"";
        
        if ([homeMembersDict[@"UserID"] containsObject:DictToUse[@"ItemTurnUserID"][indexOfCurrentItem]]) {
            
            NSUInteger index = [homeMembersDict[@"UserID"] indexOfObject:DictToUse[@"ItemTurnUserID"][indexOfCurrentItem]];
            turnUsername = homeMembersDict[@"Username"][index];
            
            TaskContainsAtLeastOneSelectedUser = [userSelected containsObject:turnUsername];
            
        }
        
    }
    
    return TaskContainsAtLeastOneSelectedUser;
}

-(BOOL)TaskIsAssignedToSelectedUser:(BOOL)AssignedTo CreatedBy:(BOOL)CreatedBy userSelected:(NSMutableArray *)userSelected DictToUse:(NSMutableDictionary *)DictToUse homeMembersDict:(NSMutableDictionary *)homeMembersDict indexOfCurrentItem:(NSUInteger)indexOfCurrentItem {
    
    NSString *itemCreatedByUsername = [self GenerateCreatedByUsername:DictToUse homeMembersDict:homeMembersDict indexOfCurrentItem:indexOfCurrentItem];
    NSMutableArray *itemAssignedToUsername = [self GenerateItemAssignedToUsernameArray:DictToUse homeMembersDict:homeMembersDict indexOfCurrentItem:indexOfCurrentItem];
    
    BOOL TaskContainsAtLeastOneSelectedUser = [self TaskContainsAtLeastOneSelectedUser:DictToUse indexOfCurrentItem:indexOfCurrentItem itemAssignedToUsername:itemAssignedToUsername userSelected:userSelected homeMembersDict:homeMembersDict];
    
    BOOL TaskIsAssignedToSelectedUser = (
                       (AssignedTo == NO && CreatedBy == NO) ||
                       (AssignedTo == YES && TaskContainsAtLeastOneSelectedUser == YES) ||
                       (CreatedBy == YES && [userSelected containsObject:itemCreatedByUsername])
                       );
    
    return TaskIsAssignedToSelectedUser;
}

-(BOOL)CheckIfTaskBelongsInPinnedToHomeSection:(NSMutableDictionary *)DictToUse keyToCheck:(NSString *)keyToCheck indexOfCurrentItem:(NSUInteger)indexOfCurrentItem section:(NSString *)section {
    
    if ([section isEqualToString:@"Pinned To Home"] == NO) {
        return NO;
    }
    
    NSString *specificObjectKeyToCheck = DictToUse[keyToCheck][indexOfCurrentItem];
    
    BOOL TaskBelongsInThisSection =
    ([specificObjectKeyToCheck isEqualToString:@"Yes"] && [section isEqualToString:@"Pinned To Home"] == YES);
    
    if (TaskBelongsInThisSection == YES) {
        
        return YES;
        
    }
    
    return NO;
}

-(BOOL)CheckIfTaskBelongsInPinnedSection:(NSString *)section pinnedDict:(NSMutableDictionary *)pinnedDict currentItemUniqueID:(NSString *)currentItemUniqueID TaskIsFullyCompleted:(BOOL)TaskIsFullyCompleted TaskIsAssignedToSelectedUser:(BOOL)TaskIsAssignedToSelectedUser {
    
    BOOL SectionIsPinnedAndItemIsPinnedAndTaskIsNotFullyCompletedAndTaskIsAssignedToSelectedUser =
    ([section isEqualToString:@"Pinned"] && pinnedDict[currentItemUniqueID] && TaskIsFullyCompleted == NO && TaskIsAssignedToSelectedUser == YES);
    
    return SectionIsPinnedAndItemIsPinnedAndTaskIsNotFullyCompletedAndTaskIsAssignedToSelectedUser;
}

-(BOOL)CheckIfTaskBelongsInTagSection:(NSMutableDictionary *)DictToUse keyToCheck:(NSString *)keyToCheck currentItemUniqueID:(NSString *)currentItemUniqueID indexOfCurrentItem:(NSUInteger)indexOfCurrentItem section:(NSString *)section selectedTaskListItems:(NSMutableDictionary *)selectedTaskListItems TaskIsFullyCompleted:(BOOL)TaskIsFullyCompleted ListSelected:(BOOL)ListSelected TaskIsAssignedToSelectedUser:(BOOL)TaskIsAssignedToSelectedUser Tag:(BOOL)Tag {
  
    if (Tag == NO) {
        return Tag;
    }
    
    BOOL TaskTagsContainsSection = DictToUse[keyToCheck] && [(NSArray *)DictToUse[keyToCheck] count] > indexOfCurrentItem && [DictToUse[keyToCheck][indexOfCurrentItem] containsObject:section] && [section isEqualToString:@"Completed"] == NO && TaskIsFullyCompleted == NO;
   
    BOOL TaskTagsIsEmptyAndCurrentSectionIsNone = (DictToUse[keyToCheck] && [(NSArray *)DictToUse[keyToCheck] count] > indexOfCurrentItem && [(NSArray *)DictToUse[keyToCheck][indexOfCurrentItem] count] == 0 && [section isEqualToString:@"No Tag"] && [section isEqualToString:@"Completed"] == NO && TaskIsFullyCompleted == NO);
  
    BOOL TaskSectionIsCompletedAndTaskIsFullyCompleted = [section isEqualToString:@"Completed"] && TaskIsFullyCompleted == YES;
    
    BOOL CategorySelectedIsNotAListOrIsAListAndTaskBelongsToList = (ListSelected == NO || (ListSelected == YES && [[selectedTaskListItems allKeys] containsObject:currentItemUniqueID]));
    
  
    if ((TaskTagsContainsSection == YES || TaskTagsIsEmptyAndCurrentSectionIsNone == YES || TaskSectionIsCompletedAndTaskIsFullyCompleted == YES) &&
        CategorySelectedIsNotAListOrIsAListAndTaskBelongsToList == YES && TaskIsAssignedToSelectedUser == YES) {
       
        return YES;
        
    }
    
    return NO;
}

-(BOOL)CheckIfTaskBelongsInDifficultySection:(NSMutableDictionary *)DictToUse keyToCheck:(NSString *)keyToCheck currentItemUniqueID:(NSString *)currentItemUniqueID indexOfCurrentItem:(NSUInteger)indexOfCurrentItem section:(NSString *)section selectedTaskListItems:(NSMutableDictionary *)selectedTaskListItems TaskIsFullyCompleted:(BOOL)TaskIsFullyCompleted ListSelected:(BOOL)ListSelected TaskIsAssignedToSelectedUser:(BOOL)TaskIsAssignedToSelectedUser Difficulty:(BOOL)Difficulty {
    
    if (Difficulty == NO) {
        return Difficulty;
    }
    
    NSString *specificObjectKeyToCheck = DictToUse[keyToCheck] && [(NSArray *)DictToUse[keyToCheck] count] > indexOfCurrentItem ? DictToUse[keyToCheck][indexOfCurrentItem] : @"";
    
    specificObjectKeyToCheck = [NSString stringWithFormat:@"%@", specificObjectKeyToCheck];
    
    if ([specificObjectKeyToCheck isEqualToString:@"None"]) {
        
        specificObjectKeyToCheck = @"No Difficulty";
        
    }
    
    BOOL TaskBelongsInThisSection =
    ([section isEqualToString:specificObjectKeyToCheck] && [section isEqualToString:@"Completed"] == NO && TaskIsFullyCompleted == NO) ||
    ([section isEqualToString:@"Completed"] && TaskIsFullyCompleted == YES);
    BOOL CategorySelectedIsNotAListOrIsAListAndTaskBelongsToList = (ListSelected == NO || (ListSelected == YES && [[selectedTaskListItems allKeys] containsObject:currentItemUniqueID]));
    
    if (TaskBelongsInThisSection == YES && CategorySelectedIsNotAListOrIsAListAndTaskBelongsToList == YES && TaskIsAssignedToSelectedUser == YES) {
        
        return YES;
        
    }
    
    return NO;
}

-(BOOL)CheckIfTaskBelongsInPrioritySection:(NSMutableDictionary *)DictToUse keyToCheck:(NSString *)keyToCheck currentItemUniqueID:(NSString *)currentItemUniqueID indexOfCurrentItem:(NSUInteger)indexOfCurrentItem section:(NSString *)section selectedTaskListItems:(NSMutableDictionary *)selectedTaskListItems TaskIsFullyCompleted:(BOOL)TaskIsFullyCompleted ListSelected:(BOOL)ListSelected TaskIsAssignedToSelectedUser:(BOOL)TaskIsAssignedToSelectedUser Priority:(BOOL)Priority {
    
    if (Priority == NO) {
        return Priority;
    }
    
    NSString *specificObjectKeyToCheck = DictToUse[keyToCheck] && [(NSArray *)DictToUse[keyToCheck] count] > indexOfCurrentItem ? DictToUse[keyToCheck][indexOfCurrentItem] : @"";
    
    if ([specificObjectKeyToCheck isEqualToString:@"Low"] || [specificObjectKeyToCheck isEqualToString:@"Medium"] || [specificObjectKeyToCheck isEqualToString:@"High"]) {
        
        specificObjectKeyToCheck = [NSString stringWithFormat:@"%@ Priority", specificObjectKeyToCheck];
        
    }
    
    BOOL TaskBelongsInThisSection =
    ([section isEqualToString:specificObjectKeyToCheck] && [section isEqualToString:@"Completed"] == NO && TaskIsFullyCompleted == NO) ||
    ([section isEqualToString:@"Completed"] && TaskIsFullyCompleted == YES);
    BOOL CategorySelectedIsNotAListOrIsAListAndTaskBelongsToList = (ListSelected == NO || (ListSelected == YES && [[selectedTaskListItems allKeys] containsObject:currentItemUniqueID]));
    
    if (TaskBelongsInThisSection == YES && CategorySelectedIsNotAListOrIsAListAndTaskBelongsToList == YES && TaskIsAssignedToSelectedUser == YES) {
        
        return YES;
        
    }
    
    return NO;
}

-(BOOL)CheckIfTaskBelongsInColorSection:(NSMutableDictionary *)DictToUse keyToCheck:(NSString *)keyToCheck currentItemUniqueID:(NSString *)currentItemUniqueID indexOfCurrentItem:(NSUInteger)indexOfCurrentItem section:(NSString *)section selectedTaskListItems:(NSMutableDictionary *)selectedTaskListItems TaskIsFullyCompleted:(BOOL)TaskIsFullyCompleted ListSelected:(BOOL)ListSelected TaskIsAssignedToSelectedUser:(BOOL)TaskIsAssignedToSelectedUser Color:(BOOL)Color {
    
    if (Color == NO) {
        return Color;
    }
    
    NSString *specificObjectKeyToCheck = DictToUse[keyToCheck][indexOfCurrentItem];
    
    BOOL TaskBelongsInThisSection =
    ([section isEqualToString:specificObjectKeyToCheck] && [section isEqualToString:@"Completed"] == NO && TaskIsFullyCompleted == NO) ||
    ([section isEqualToString:@"No Color"] && [specificObjectKeyToCheck isEqualToString:@"None"] && TaskIsFullyCompleted == NO) ||
    ([section isEqualToString:@"Completed"] && TaskIsFullyCompleted == YES);
    BOOL CategorySelectedIsNotAListOrIsAListAndTaskBelongsToList = (ListSelected == NO || (ListSelected == YES && [[selectedTaskListItems allKeys] containsObject:currentItemUniqueID]));
    
    if (TaskBelongsInThisSection == YES && CategorySelectedIsNotAListOrIsAListAndTaskBelongsToList == YES && TaskIsAssignedToSelectedUser == YES) {
        
        return YES;
        
    }
    
    return NO;
}

-(BOOL)CheckIfTaskBelongsInNameSection:(NSMutableDictionary *)DictToUse keyToCheck:(NSString *)keyToCheck currentItemUniqueID:(NSString *)currentItemUniqueID indexOfCurrentItem:(NSUInteger)indexOfCurrentItem section:(NSString *)section selectedTaskListItems:(NSMutableDictionary *)selectedTaskListItems TaskIsFullyCompleted:(BOOL)TaskIsFullyCompleted ListSelected:(BOOL)ListSelected TaskIsAssignedToSelectedUser:(BOOL)TaskIsAssignedToSelectedUser Name:(BOOL)Name {
    
    if (Name == NO) {
        return Name;
    }
    
    NSString *object = DictToUse[keyToCheck][indexOfCurrentItem];
    NSString *firstChar = @"a";
    NSString *characterSet = @"0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz";
    
    for (int i = 0; i < [object length]; i++) {
        unichar character = [object characterAtIndex:i];
        NSString *characterString = [NSString stringWithFormat:@"%C", character];
        if ([characterSet containsString:characterString]) {
            firstChar = characterString;
            break;
        }
    }
    
    if (
        
        (([[firstChar uppercaseString] isEqualToString:section] && TaskIsFullyCompleted == NO) ||
         ([section isEqualToString:@"Completed"] && TaskIsFullyCompleted == YES))
        
        && TaskIsAssignedToSelectedUser == YES) {
            
            return YES;
            
        }
    
    return NO;
}

-(BOOL)CheckIfTaskBelongsInDateSection:(NSMutableDictionary *)DictToUse keyToCheck:(NSString *)keyToCheck currentItemUniqueID:(NSString *)currentItemUniqueID indexOfCurrentItem:(NSUInteger)indexOfCurrentItem section:(NSString *)section selectedTaskListItems:(NSMutableDictionary *)selectedTaskListItems TaskIsFullyCompleted:(BOOL)TaskIsFullyCompleted ListSelected:(BOOL)ListSelected TaskIsAssignedToSelectedUser:(BOOL)TaskIsAssignedToSelectedUser keyArray:(NSArray *)keyArray itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict Date:(BOOL)Date {
   
    if (Date == NO) {
        return Date;
    }
    
    NSString *sectionItemBelongsTo = [self GenerateSectionSpecificItemBelongsTo:DictToUse keyArray:keyArray itemType:itemType homeMembersDict:homeMembersDict itemUniqueID:currentItemUniqueID section:section];
  
    BOOL TaskBelongsInThisSection = [section isEqualToString:sectionItemBelongsTo];
    BOOL CategorySelectedIsNotAListOrIsAListAndTaskBelongsToList = (ListSelected == NO || (ListSelected == YES && [[selectedTaskListItems allKeys] containsObject:currentItemUniqueID]));
   
    if (TaskBelongsInThisSection == YES && CategorySelectedIsNotAListOrIsAListAndTaskBelongsToList == YES && TaskIsAssignedToSelectedUser == YES) {
       
        return YES;
        
    }
    
    return NO;
}

-(BOOL)CheckIfTaskBelongsInListSection:(NSMutableDictionary *)DictToUse keyToCheck:(NSString *)keyToCheck currentItemUniqueID:(NSString *)currentItemUniqueID indexOfCurrentItem:(NSUInteger)indexOfCurrentItem section:(NSString *)section selectedTaskListItems:(NSMutableDictionary *)selectedTaskListItems TaskIsFullyCompleted:(BOOL)TaskIsFullyCompleted ListSelected:(BOOL)ListSelected TaskIsAssignedToSelectedUser:(BOOL)TaskIsAssignedToSelectedUser taskListDict:(NSMutableDictionary *)taskListDict List:(BOOL)List {
    
    if (List == NO) {
        return List;
    }
    
    NSString *specificObjectKeyToCheck = DictToUse[@"ItemID"] && [(NSArray *)DictToUse[@"ItemID"] count] > indexOfCurrentItem ? DictToUse[@"ItemID"][indexOfCurrentItem] : @"";
    
    NSUInteger indexOfCurrentSectionTaskList = taskListDict[@"TaskListName"] && [taskListDict[@"TaskListName"] containsObject:section] ? [taskListDict[@"TaskListName"] indexOfObject:section] : 0;
    
    NSMutableDictionary *currentSectionTaskListItems = indexOfCurrentSectionTaskList >= 0 && indexOfCurrentSectionTaskList < 10000 && taskListDict[@"TaskListItems"] && [(NSArray *)taskListDict[@"TaskListItems"] count] > indexOfCurrentSectionTaskList ? [taskListDict[@"TaskListItems"][indexOfCurrentSectionTaskList] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSMutableArray *currentSectionTaskListItemIDs = [NSMutableArray array];
    
    for (NSString *itemUniqueID in [currentSectionTaskListItems allKeys]) {
        
        [currentSectionTaskListItemIDs addObject:itemUniqueID];
        
    }
    
    BOOL ItemExistsInAtLeastOneTaskList = false;
    
    if (taskListDict[@"TaskListID"]) {
        
        for (NSString *taskListID in taskListDict[@"TaskListID"]) {
            
            NSUInteger index = [taskListDict[@"TaskListID"] indexOfObject:taskListID];
            
            NSMutableDictionary *taskListItemsInner = taskListDict[@"TaskListItems"] && [(NSArray *)taskListDict[@"TaskListItems"] count] > index ? [taskListDict[@"TaskListItems"][index] mutableCopy] : [NSMutableDictionary dictionary];
            
            for (NSString *itemUniqueID in [taskListItemsInner allKeys]) {
                
                NSString *itemID = taskListItemsInner[itemUniqueID] && taskListItemsInner[itemUniqueID][@"ItemUniqueID"] ? taskListItemsInner[itemUniqueID][@"ItemUniqueID"] : @"";
                
                if ([itemID isEqualToString:specificObjectKeyToCheck]) {
                    
                    ItemExistsInAtLeastOneTaskList = true;
                    
                }
                
            }
            
        }
        
    }
    
    BOOL TaskBelongsInThisSection =
    ([section isEqualToString:@"No List"] == NO && [currentSectionTaskListItemIDs containsObject:specificObjectKeyToCheck]) ||
    ([section isEqualToString:@"No List"] == YES && ItemExistsInAtLeastOneTaskList == false);
    
    BOOL CategorySelectedIsNotAListOrIsAListAndTaskBelongsToList = (ListSelected == NO || (ListSelected == YES && [[selectedTaskListItems allKeys] containsObject:currentItemUniqueID]));
    
    if (TaskBelongsInThisSection == YES && CategorySelectedIsNotAListOrIsAListAndTaskBelongsToList == YES && TaskIsAssignedToSelectedUser == YES) {
        
        return YES;
        
    }
    
    return NO;
}

-(BOOL)CheckIfTaskBelongsInCustomSection:(NSMutableDictionary *)DictToUse keyToCheck:(NSString *)keyToCheck currentItemUniqueID:(NSString *)currentItemUniqueID indexOfCurrentItem:(NSUInteger)indexOfCurrentItem section:(NSString *)section selectedTaskListItems:(NSMutableDictionary *)selectedTaskListItems TaskIsFullyCompleted:(BOOL)TaskIsFullyCompleted ListSelected:(BOOL)ListSelected TaskIsAssignedToSelectedUser:(BOOL)TaskIsAssignedToSelectedUser sectionDict:(NSMutableDictionary *)sectionDict Custom:(BOOL)Custom {
    
    if (Custom == NO) {
        return Custom;
    }
    
    NSString *specificObjectKeyToCheck = DictToUse[@"ItemID"] && [(NSArray *)DictToUse[@"ItemID"] count] > indexOfCurrentItem ? DictToUse[@"ItemID"][indexOfCurrentItem] : @"";
    
    NSUInteger indexOfCurrentSectionSection = sectionDict[@"SectionName"] && [sectionDict[@"SectionName"] containsObject:section] ? [sectionDict[@"SectionName"] indexOfObject:section] : 0;
    
    NSMutableDictionary *currentSectionSectionItems = indexOfCurrentSectionSection >= 0 && indexOfCurrentSectionSection < 10000 && sectionDict[@"SectionItems"] && [(NSArray *)sectionDict[@"SectionItems"] count] > indexOfCurrentSectionSection ? [sectionDict[@"SectionItems"][indexOfCurrentSectionSection] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSMutableArray *currentSectionSectionItemIDs = [NSMutableArray array];
    
    for (NSString *itemUniqueID in [currentSectionSectionItems allKeys]) {
        
        NSString *itemID = currentSectionSectionItems[itemUniqueID] && currentSectionSectionItems[itemUniqueID][@"ItemUniqueID"] ? currentSectionSectionItems[itemUniqueID][@"ItemUniqueID"] : @"";
        [currentSectionSectionItemIDs addObject:itemID];
        
    }
    
    BOOL ItemExistsInAtLeastOneSection = false;
    
    if (sectionDict[@"SectionID"]) {
        
        for (NSString *sectionIDInner in sectionDict[@"SectionID"]) {
            
            NSUInteger index = [sectionDict[@"SectionID"] indexOfObject:sectionIDInner];
            
            NSMutableDictionary *sectionItemsInner = sectionDict[@"SectionItems"] &&  [(NSArray *)sectionDict[@"SectionItems"] count] > index ? sectionDict[@"SectionItems"][index] : [NSMutableDictionary dictionary];
            
            for (NSString *itemUniqueID in [sectionItemsInner allKeys]) {
                
                NSString *itemID = sectionItemsInner[itemUniqueID] && sectionItemsInner[itemUniqueID][@"ItemUniqueID"] ? sectionItemsInner[itemUniqueID][@"ItemUniqueID"] : @"";
                
                if ([itemID isEqualToString:specificObjectKeyToCheck]) {
                    
                    ItemExistsInAtLeastOneSection = true;
                    
                }
                
            }
            
        }
        
    }
    
    BOOL TaskBelongsInThisSection =
    ([section isEqualToString:@"Not Sectioned"] == NO && [currentSectionSectionItemIDs containsObject:specificObjectKeyToCheck]) ||
    ([section isEqualToString:@"Not Sectioned"] == YES && ItemExistsInAtLeastOneSection == false);
    
    BOOL CategorySelectedIsNotAListOrIsAListAndTaskBelongsToList = (ListSelected == NO || (ListSelected == YES && [[selectedTaskListItems allKeys] containsObject:currentItemUniqueID]));
    
    if (TaskBelongsInThisSection == YES && CategorySelectedIsNotAListOrIsAListAndTaskBelongsToList == YES && TaskIsAssignedToSelectedUser == YES) {
        
        return YES;
        
    }
    
    return NO;
}

-(NSMutableDictionary *)GenerateAllSectionsDictWithNewSection:(NSMutableDictionary *)allSectionDataDict specificSectionDataDict:(NSMutableDictionary *)specificSectionDataDict sectionToAddTask:(NSString *)sectionToAddTask DictToUse:(NSMutableDictionary *)DictToUse indexOfCurrentItem:(NSUInteger)indexOfCurrentItem keyArray:(NSArray *)keyArray {
    
    for (NSString *key in keyArray) {
        
        NSMutableArray *specificKeyObjectArray = specificSectionDataDict[key] ? [specificSectionDataDict[key] mutableCopy] : [NSMutableArray array];
        
        id object = DictToUse[key] && [(NSArray *)DictToUse[key] count] > indexOfCurrentItem ? DictToUse[key][indexOfCurrentItem] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
        [specificKeyObjectArray addObject:object];
        
        [specificSectionDataDict setObject:specificKeyObjectArray forKey:key];
        
    }
    
    [allSectionDataDict setObject:[specificSectionDataDict mutableCopy] forKey:sectionToAddTask];
    
    return allSectionDataDict;
}

-(NSMutableDictionary *)UpdateDictToUseWithXXX:(NSMutableDictionary *)DictToUse indexOfCurrentItem:(NSUInteger)indexOfCurrentItem keyArray:(NSArray *)keyArray {
    
    for (NSString *key in keyArray) {
        
        NSMutableArray *arr = DictToUse[key] ? [DictToUse[key] mutableCopy] : [NSMutableArray array];
        if (arr.count > indexOfCurrentItem) { [arr replaceObjectAtIndex:indexOfCurrentItem withObject:@"xxx"]; };
        [DictToUse setObject:arr forKey:key];
        
    }
    
    return DictToUse;
}

-(NSDictionary *)RemoveAppropriateSectionsIfNeeded:(NSMutableDictionary *)allSectionDataDict sectionsArray:(NSMutableArray *)sectionsArray Custom:(BOOL)Custom {
    
    NSMutableDictionary *allSectionDataDictCopy = [allSectionDataDict mutableCopy];
    
    for (NSString *section in allSectionDataDictCopy) {
        
        if (allSectionDataDict[section]) {
            
            if (
                ([(NSArray *)allSectionDataDict[section][@"ItemID"] count] == 0 && Custom == NO && [section isEqualToString:@"Completed"] == NO) ||
                ([(NSArray *)allSectionDataDict[section][@"ItemID"] count] == 0 && Custom == YES && [section isEqualToString:@"Completed"])
                ) {
                    
                    if ([[allSectionDataDict allKeys] containsObject:section]) { [allSectionDataDict removeObjectForKey:section]; }
                    if ([sectionsArray containsObject:section]) { [sectionsArray removeObject:section]; }
                    
                }
            
        }
        
    }
    
    return @{@"AllSectionDataDict" : allSectionDataDict, @"SectionsArray" : sectionsArray};
}

-(NSDictionary *)RemoveCompletedSectionIfNeeded:(NSMutableDictionary *)allSectionDataDict sectionsArray:(NSMutableArray *)sectionsArray {
    
    if (sectionsArray.count == 1 && [sectionsArray[0] isEqualToString:@"Completed"]) {
        
        NSString *firstSection = sectionsArray[0];
        
        if ((!allSectionDataDict[firstSection]) ||
            (allSectionDataDict[firstSection] && !allSectionDataDict[firstSection][@"ItemID"]) ||
            (allSectionDataDict[firstSection] && allSectionDataDict[firstSection][@"ItemID"] && [(NSArray *)allSectionDataDict[firstSection][@"ItemID"] count] == 0)) {
            
            allSectionDataDict = [NSMutableDictionary dictionary];
            sectionsArray = [NSMutableArray array];
            
        }
        
    }
    
    return @{@"AllSectionDataDict" : allSectionDataDict, @"SectionsArray" : sectionsArray};
}

-(NSMutableDictionary *)GenerateAllSectionsDataDictWithSortedDataDicts:(NSMutableDictionary *)allSectionDataDict keyArray:(NSArray *)keyArray {
    
    NSMutableDictionary *allSectionDataDictCopy = [allSectionDataDict mutableCopy];
    
    for (NSString *section in [allSectionDataDictCopy allKeys]) {
        
        NSMutableDictionary *sortedDict = [self GenerateSortedDict:[allSectionDataDictCopy[section] mutableCopy] keyArray:keyArray];
        [allSectionDataDict setObject:sortedDict forKey:section];
        
    }
    
    return allSectionDataDict;
}

#pragma mark - Generate Items (Generate Items In Selected Category Selected Section & Generate Amount Of Items In Categories)

-(NSMutableDictionary *)GenerateItemsInDefaultCategory:(NSMutableDictionary *)DictToUse keyArray:(NSArray *)keyArray itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict selectedCategory:(NSString *)selectedCategory {
    
    NSMutableDictionary *dictToReturn = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *AllDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *NoDueDateDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *TodayDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *TomorrowDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *Next7DaysDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *AssignedToMeDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *UpcomingDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *CompletedDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *PastDueDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *TrashDict = [NSMutableDictionary dictionary];
    
    NSMutableArray *DictToUseItemIDArrayCopy = DictToUse[@"ItemUniqueID"] ? [DictToUse[@"ItemUniqueID"] mutableCopy] : [NSMutableArray array];
    
    if (DictToUse[@"ItemUniqueID"]) {
        
        for (NSString *itemUniqueID in DictToUse[@"ItemUniqueID"]) {
            
            NSInteger index = [DictToUseItemIDArrayCopy indexOfObject:itemUniqueID];
            
            NSString *itemDueDate = DictToUse[@"ItemDueDate"] && [(NSArray *)DictToUse[@"ItemDueDate"] count] > index ? DictToUse[@"ItemDueDate"][index] : @"";
            NSString *itemGracePeriod = DictToUse[@"ItemGracePeriod"] && [(NSArray *)DictToUse[@"ItemGracePeriod"] count] > index ? DictToUse[@"ItemGracePeriod"][index] : @"";
            
            NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:DictToUse keyArray:keyArray indexPath:[NSIndexPath indexPathForRow:index inSection:0]];
            
            
            
            
           
            BOOL TaskIsFullyCompleted = [[[BoolDataObject alloc] init] TaskIsFullyCompleted:singleObjectItemDict itemType:itemType homeMembersDict:homeMembersDict];
            BOOL TaskHasNoDueDate = [[[BoolDataObject alloc] init] TaskHasNoDueDate:singleObjectItemDict itemType:itemType];
            BOOL TaskIsPastDue = [[[BoolDataObject alloc] init] TaskIsPastDue:singleObjectItemDict itemType:itemType];
            BOOL TaskWasAssignedToSpecificUser = [[[BoolDataObject alloc] init] TaskWasAssignedToSpecificUser:singleObjectItemDict itemType:itemType userID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
            BOOL TaskIsSpecificUsersTurn = [[[BoolDataObject alloc] init] TaskIsSpecificUsersTurn:singleObjectItemDict itemType:itemType userID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] homeMembersDict:homeMembersDict];
            BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:singleObjectItemDict itemType:itemType];
            BOOL TaskIsTrash = [[[BoolDataObject alloc] init] TaskIsTrash:singleObjectItemDict itemType:itemType];
            
            NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
            
            if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:itemDueDate returnAs:[NSDate class]] == nil) {
                dateFormat = @"MMMM dd, yyyy HH:mm";
            }
            
            NSString *currentDateString = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
            
            NSDate *date1 = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:itemDueDate returnAs:[NSDate class]];
            NSDate *date2 = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:currentDateString returnAs:[NSDate class]];
            
            NSTimeInterval secondsPassedSinceItemDueDate = [date2 timeIntervalSinceDate:date1];
            
            int secondsThatNeedToPass = [[[GeneralObject alloc] init] GenerateSecondsFromDisplayTime:itemGracePeriod];
            
            if (secondsPassedSinceItemDueDate >= 0) {
                
                NSDate *dueDateDate = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:itemDueDate returnAs:[NSDate class]];
                itemDueDate = [[[GeneralObject alloc] init] GenerateDateWithAddedTimeWithFormat:dateFormat dateToAddTimeTo:dueDateDate timeToAdd:secondsThatNeedToPass returnAs:[NSString class]];
         
            }
            
            
            
            
            
            NSString *convertedDate = [[[GeneralObject alloc] init] GetDisplayTimeRemainingUntilDateStartingFromCurrentDate:itemDueDate shortStyle:NO reallyShortStyle:NO];
            NSArray *splitArr = [convertedDate componentsSeparatedByString:@" "];
            
            NSDate *currentDate = [NSDate date];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *components = [calendar components:(NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:currentDate];
            int hoursRemainingInDay = 24 - (int)components.hour;
            
            int amountOfUnitOfTime = splitArr.count > 0 ? [splitArr[0] intValue] : 0;
            
            
            
            BOOL TaskRemainingTimeIsLessThanTodaysRemainingTime =
            ([convertedDate containsString:@"min "]) ||
            ([convertedDate containsString:@"hour"] && (amountOfUnitOfTime <= hoursRemainingInDay));
            
            BOOL TaskRemainingTimeIsGreaterThanTodaysRemainingTime =
            ([convertedDate isEqualToString:@"1 day left"]) ||
            ([convertedDate containsString:@"hour"] && amountOfUnitOfTime > hoursRemainingInDay);
            
            BOOL TaskRemainingTimeIsLessThanThisWeeksRemainingTime =
            ([convertedDate containsString:@"2 days left"] || [convertedDate containsString:@"3 days left"] || [convertedDate containsString:@"4 days left"] || [convertedDate containsString:@"5 days left"] || [convertedDate containsString:@"6 days left"] || [convertedDate containsString:@"7 days left"]);
            
            
            
            
            
            
            
            NSMutableDictionary *dictFoundForSpecificTask = [NSMutableDictionary dictionary];
            BOOL DictFound = false;
            
            
            
           
            
            
            
            if (TaskHasNoDueDate == YES && TaskIsFullyCompleted == NO && TaskIsTrash == NO && DictFound == false) {
               
                dictFoundForSpecificTask = NoDueDateDict;
                DictFound = true;
                
            }
            
            if (TaskRemainingTimeIsLessThanTodaysRemainingTime == YES && TaskIsFullyCompleted == NO && TaskIsPastDue == NO && TaskIsTrash == NO && DictFound == false) {
                
                dictFoundForSpecificTask = TodayDict;
                DictFound = true;
                
            }
            
            if (TaskRemainingTimeIsGreaterThanTodaysRemainingTime == YES && TaskIsFullyCompleted == NO && TaskIsPastDue == NO && TaskIsTrash == NO && DictFound == false) {
                
                dictFoundForSpecificTask = TomorrowDict;
                DictFound = true;
                
            }
            
            if (TaskRemainingTimeIsLessThanThisWeeksRemainingTime == YES && TaskIsFullyCompleted == NO && TaskIsPastDue == NO && TaskIsTrash == NO && DictFound == false) {
                
                dictFoundForSpecificTask = Next7DaysDict;
                DictFound = true;
                
            }
            
            if (TaskIsFullyCompleted == YES && TaskIsTrash == NO && DictFound == false) {
                
                dictFoundForSpecificTask = CompletedDict;
                DictFound = true;
                
            }
            
            if (TaskIsFullyCompleted == NO && TaskIsPastDue == YES && TaskHasNoDueDate == NO && TaskIsTrash == NO && DictFound == false) {
               
                dictFoundForSpecificTask = PastDueDict;
                DictFound = true;
                
            }
            
            if (TaskRemainingTimeIsLessThanTodaysRemainingTime == NO && TaskRemainingTimeIsGreaterThanTodaysRemainingTime == NO && TaskRemainingTimeIsLessThanThisWeeksRemainingTime == NO && TaskIsFullyCompleted == NO && TaskIsPastDue == NO && TaskHasNoDueDate == NO && TaskIsTrash == NO && DictFound == false) {
                
                dictFoundForSpecificTask = UpcomingDict;
                DictFound = true;
                
            }
            
            if (TaskIsTrash == YES) {
                
                dictFoundForSpecificTask = TrashDict;
                DictFound = true;
                
            }
            
            
            
            
            
            
            
            //Set object in appropriate dict
            
            for (NSString *key in keyArray) {
                
                NSMutableArray *arr = dictFoundForSpecificTask[key] ? [dictFoundForSpecificTask[key] mutableCopy] : [NSMutableArray array];
                id object = DictToUse[key] && [(NSArray *)DictToUse[key] count] > index ? DictToUse[key][index] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                [arr addObject:object];
                [dictFoundForSpecificTask setObject:arr forKey:key];
                
            }
            
            
            
            
            
            
            
            //Set object in assigned to myself dict
            
            if (((TaskWasAssignedToSpecificUser == YES && TaskIsTakingTurns == NO) || (TaskWasAssignedToSpecificUser == YES && TaskIsTakingTurns == YES && TaskIsSpecificUsersTurn == YES)) && TaskIsTrash == NO) {
                
                dictFoundForSpecificTask = AssignedToMeDict;
                
                for (NSString *key in keyArray) {
                    
                    NSMutableArray *arr = dictFoundForSpecificTask[key] ? [dictFoundForSpecificTask[key] mutableCopy] : [NSMutableArray array];
                    id object = DictToUse[key] && [(NSArray *)DictToUse[key] count] > index ? DictToUse[key][index] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                    [arr addObject:object];
                    [dictFoundForSpecificTask setObject:arr forKey:key];
                    
                }
                
            }
            
            
            
            
            
            
            
            //Set object in all dict
           
            if (TaskIsTrash == NO) {
              
                dictFoundForSpecificTask = AllDict;
                
                for (NSString *key in keyArray) {
                    
                    NSMutableArray *arr = dictFoundForSpecificTask[key] ? [dictFoundForSpecificTask[key] mutableCopy] : [NSMutableArray array];
                    id object = DictToUse[key] && [(NSArray *)DictToUse[key] count] > index ? DictToUse[key][index] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                    [arr addObject:object];
                    [dictFoundForSpecificTask setObject:arr forKey:key];
                    
                }
           
            }
            
            
            
            
            
            
            
            if ([DictToUseItemIDArrayCopy count] > index) { [DictToUseItemIDArrayCopy replaceObjectAtIndex:index withObject:@"xxx"]; }
            
        }
        
    }
    
    if ([selectedCategory isEqualToString:@"All"]) { [dictToReturn setObject:[self GenerateSortedDict:AllDict keyArray:keyArray] forKey:@"All"]; }
    if ([selectedCategory isEqualToString:@"No Due Date"]) { [dictToReturn setObject:[self GenerateSortedDict:NoDueDateDict keyArray:keyArray] forKey:@"No Due Date"]; }
    if ([selectedCategory isEqualToString:@"Today"]) { [dictToReturn setObject:[self GenerateSortedDict:TodayDict keyArray:keyArray] forKey:@"Today"]; }
    if ([selectedCategory isEqualToString:@"Tomorrow"]) { [dictToReturn setObject:[self GenerateSortedDict:TomorrowDict keyArray:keyArray] forKey:@"Tomorrow"]; }
    if ([selectedCategory isEqualToString:@"Next 7 Days"]) { [dictToReturn setObject:[self GenerateSortedDict:Next7DaysDict keyArray:keyArray] forKey:@"Next 7 Days"]; }
    if ([selectedCategory isEqualToString:@"Assigned To Me"]) { [dictToReturn setObject:[self GenerateSortedDict:AssignedToMeDict keyArray:keyArray] forKey:@"Assigned To Me"]; }
    if ([selectedCategory isEqualToString:@"Completed"]) { [dictToReturn setObject:[self GenerateSortedDict:CompletedDict keyArray:keyArray] forKey:@"Completed"]; }
    if ([selectedCategory isEqualToString:@"Past Due"]) { [dictToReturn setObject:[self GenerateSortedDict:PastDueDict keyArray:keyArray] forKey:@"Past Due"]; }
    if ([selectedCategory isEqualToString:@"Upcoming"]) {  [dictToReturn setObject:[self GenerateSortedDict:UpcomingDict keyArray:keyArray] forKey:@"Upcoming"]; }
    if ([selectedCategory isEqualToString:@"Trash"]) {  [dictToReturn setObject:[self GenerateSortedDict:TrashDict keyArray:keyArray] forKey:@"Trash"]; }
   
    return dictToReturn[selectedCategory];
    
}

-(NSMutableDictionary *)GenerateItemsInDefaultCategoryCopy:(NSMutableDictionary *)DictToUse keyArray:(NSArray *)keyArray itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict selectedCategory:(NSString *)selectedCategory dateToCheck:(NSString *)dateToCheck {
    
    NSMutableDictionary *dictToReturn = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *AllDict = [NSMutableDictionary dictionary];
    //NSMutableDictionary *PinnedDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *NoDueDateDict = [NSMutableDictionary dictionary];
    //NSMutableDictionary *GracePeriodDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *TodayDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *TomorrowDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *Next7DaysDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *AssignedToMeDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *UpcomingDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *CompletedDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *PastDueDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *TrashDict = [NSMutableDictionary dictionary];
    
    NSMutableArray *DictToUseItemIDArrayCopy = DictToUse[@"ItemUniqueID"] ? [DictToUse[@"ItemUniqueID"] mutableCopy] : [NSMutableArray array];
    
    if (DictToUse[@"ItemUniqueID"]) {
        
        for (NSString *itemUniqueID in DictToUse[@"ItemUniqueID"]) {
            
            NSInteger index = [DictToUseItemIDArrayCopy indexOfObject:itemUniqueID];
            
            NSString *itemDueDate = DictToUse[@"ItemDueDate"] && [(NSArray *)DictToUse[@"ItemDueDate"] count] > index ? DictToUse[@"ItemDueDate"][index] : @"";
            NSString *itemGracePeriod = DictToUse[@"ItemGracePeriod"] && [(NSArray *)DictToUse[@"ItemGracePeriod"] count] > index ? DictToUse[@"ItemGracePeriod"][index] : @"";
            
            NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:DictToUse keyArray:keyArray indexPath:[NSIndexPath indexPathForRow:index inSection:0]];
            
            
            
            
            
            BOOL TaskIsFullyCompleted = [[[BoolDataObject alloc] init] TaskIsFullyCompleted:singleObjectItemDict itemType:itemType homeMembersDict:homeMembersDict];
            BOOL TaskHasNoDueDate = [[[BoolDataObject alloc] init] TaskHasNoDueDate:singleObjectItemDict itemType:itemType];
            BOOL TaskIsPastDue = [[[BoolDataObject alloc] init] TaskIsPastDue:singleObjectItemDict itemType:itemType];
            BOOL TaskWasAssignedToSpecificUser = [[[BoolDataObject alloc] init] TaskWasAssignedToSpecificUser:singleObjectItemDict itemType:itemType userID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
            BOOL TaskIsSpecificUsersTurn = [[[BoolDataObject alloc] init] TaskIsSpecificUsersTurn:singleObjectItemDict itemType:itemType userID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] homeMembersDict:homeMembersDict];
            BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:singleObjectItemDict itemType:itemType];
            BOOL TaskIsTrash = [[[BoolDataObject alloc] init] TaskIsTrash:singleObjectItemDict itemType:itemType];
            
            NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
            
            if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:itemDueDate returnAs:[NSDate class]] == nil) {
                dateFormat = @"MMMM dd, yyyy HH:mm";
            }
            
            NSString *currentDateString = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
            
            NSDate *date1 = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:itemDueDate returnAs:[NSDate class]];
            NSDate *date2 = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:currentDateString returnAs:[NSDate class]];
            
            NSTimeInterval secondsPassedSinceItemDueDate = [date2 timeIntervalSinceDate:date1];
            
            int secondsThatNeedToPass = [[[GeneralObject alloc] init] GenerateSecondsFromDisplayTime:itemGracePeriod];
            
            if (secondsPassedSinceItemDueDate >= 0) {
                
                NSDate *dueDateDate = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:itemDueDate returnAs:[NSDate class]];
                itemDueDate = [[[GeneralObject alloc] init] GenerateDateWithAddedTimeWithFormat:dateFormat dateToAddTimeTo:dueDateDate timeToAdd:secondsThatNeedToPass returnAs:[NSString class]];
                
            }
            
            
            
            
            
            NSString *convertedDate = [[[GeneralObject alloc] init] GetDisplayTimeUntilDateStartingFromCustomStartDate:itemDueDate dateToStartFrom:dateToCheck shortStyle:NO reallyShortStyle:NO];
            NSArray *splitArr = [convertedDate componentsSeparatedByString:@" "];
            
            NSDate *currentDate = [NSDate date];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *components = [calendar components:(NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:currentDate];
            int hoursRemainingInDay = 24 - (int)components.hour;
            
            int amountOfUnitOfTime = splitArr.count > 0 ? [splitArr[0] intValue] : 0;
            
            
            
            BOOL TaskRemainingTimeIsLessThanTodaysRemainingTime =
            ([convertedDate containsString:@"min "]) ||
            ([convertedDate containsString:@"hour"] && (amountOfUnitOfTime <= hoursRemainingInDay));
            
            BOOL TaskRemainingTimeIsGreaterThanTodaysRemainingTime =
            ([convertedDate isEqualToString:@"1 day left"]) ||
            ([convertedDate containsString:@"hour"] && amountOfUnitOfTime > hoursRemainingInDay);
            
            BOOL TaskRemainingTimeIsLessThanThisWeeksRemainingTime =
            ([convertedDate containsString:@"2 days left"] || [convertedDate containsString:@"3 days left"] || [convertedDate containsString:@"4 days left"] || [convertedDate containsString:@"5 days left"] || [convertedDate containsString:@"6 days left"] || [convertedDate containsString:@"7 days left"]);
            
            
            
            
            
            
            
            NSMutableDictionary *dictToUse = [NSMutableDictionary dictionary];
            BOOL DictFound = false;
            
            
            
            
            
            
            
            if (TaskHasNoDueDate == YES && TaskIsFullyCompleted == NO && TaskIsTrash == NO && DictFound == false) {
                
                dictToUse = NoDueDateDict;
                DictFound = true;
                
            }
            
            if (TaskRemainingTimeIsLessThanTodaysRemainingTime == YES && TaskIsFullyCompleted == NO && TaskIsPastDue == NO && TaskIsTrash == NO && DictFound == false) {
                
                dictToUse = TodayDict;
                DictFound = true;
                
            }
            
            if (TaskRemainingTimeIsGreaterThanTodaysRemainingTime == YES && TaskIsFullyCompleted == NO && TaskIsPastDue == NO && TaskIsTrash == NO && DictFound == false) {
                
                dictToUse = TomorrowDict;
                DictFound = true;
                
            }
            
            if (TaskRemainingTimeIsLessThanThisWeeksRemainingTime == YES && TaskIsFullyCompleted == NO && TaskIsPastDue == NO && TaskIsTrash == NO && DictFound == false) {
                
                dictToUse = Next7DaysDict;
                DictFound = true;
                
            }
            
            if (TaskIsFullyCompleted == YES && TaskIsTrash == NO && DictFound == false) {
                
                dictToUse = CompletedDict;
                DictFound = true;
                
            }
            
            if (TaskIsFullyCompleted == NO && TaskIsPastDue == YES && TaskHasNoDueDate == NO && TaskIsTrash == NO && DictFound == false) {
                
                dictToUse = PastDueDict;
                DictFound = true;
                
            }
            
            if (TaskRemainingTimeIsLessThanTodaysRemainingTime == NO && TaskRemainingTimeIsGreaterThanTodaysRemainingTime == NO && TaskRemainingTimeIsLessThanThisWeeksRemainingTime == NO && TaskIsFullyCompleted == NO && TaskIsPastDue == NO && TaskHasNoDueDate == NO && TaskIsTrash == NO && DictFound == false) {
                
                dictToUse = UpcomingDict;
                DictFound = true;
                
            }
            
            if (TaskIsTrash == YES) {
                
                dictToUse = TrashDict;
                DictFound = true;
                
            }
            
            
            
            
            
            
            
            //Set object in appropriate dict
            
            for (NSString *key in keyArray) {
                
                NSMutableArray *arr = dictToUse[key] ? [dictToUse[key] mutableCopy] : [NSMutableArray array];
                id object = DictToUse[key] && [(NSArray *)DictToUse[key] count] > index ? DictToUse[key][index] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                [arr addObject:object];
                [dictToUse setObject:arr forKey:key];
                
            }
            
            
            
            
            
            
            
            //Set object in assigned to myself dict
            
            if (((TaskWasAssignedToSpecificUser == YES && TaskIsTakingTurns == NO) || (TaskWasAssignedToSpecificUser == YES && TaskIsTakingTurns == YES && TaskIsSpecificUsersTurn == YES)) && TaskIsTrash == NO) {
                
                dictToUse = AssignedToMeDict;
                
                for (NSString *key in keyArray) {
                    
                    NSMutableArray *arr = dictToUse[key] ? [dictToUse[key] mutableCopy] : [NSMutableArray array];
                    id object = DictToUse[key] && [(NSArray *)DictToUse[key] count] > index ? DictToUse[key][index] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                    [arr addObject:object];
                    [dictToUse setObject:arr forKey:key];
                    
                }
                
            }
            
            
            
            
            
            
            
            //Set object in all dict
            
            if (TaskIsTrash == NO) {
                
                dictToUse = AllDict;
                
                for (NSString *key in keyArray) {
                    
                    NSMutableArray *arr = dictToUse[key] ? [dictToUse[key] mutableCopy] : [NSMutableArray array];
                    id object = DictToUse[key] && [(NSArray *)DictToUse[key] count] > index ? DictToUse[key][index] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                    [arr addObject:object];
                    [dictToUse setObject:arr forKey:key];
                    
                }
                
            }
            
            
            
            
            
            
            
            if ([DictToUseItemIDArrayCopy count] > index) { [DictToUseItemIDArrayCopy replaceObjectAtIndex:index withObject:@"xxx"]; }
            
        }
        
    }
    
    if ([selectedCategory isEqualToString:@"All"]) { [dictToReturn setObject:[self GenerateSortedDict:AllDict keyArray:keyArray] forKey:@"All"]; }
    if ([selectedCategory isEqualToString:@"No Due Date"]) { [dictToReturn setObject:[self GenerateSortedDict:NoDueDateDict keyArray:keyArray] forKey:@"No Due Date"]; }
    if ([selectedCategory isEqualToString:@"Today"]) { [dictToReturn setObject:[self GenerateSortedDict:TodayDict keyArray:keyArray] forKey:@"Today"]; }
    if ([selectedCategory isEqualToString:@"Tomorrow"]) { [dictToReturn setObject:[self GenerateSortedDict:TomorrowDict keyArray:keyArray] forKey:@"Tomorrow"]; }
    if ([selectedCategory isEqualToString:@"Next 7 Days"]) { [dictToReturn setObject:[self GenerateSortedDict:Next7DaysDict keyArray:keyArray] forKey:@"Next 7 Days"]; }
    if ([selectedCategory isEqualToString:@"Assigned To Me"]) { [dictToReturn setObject:[self GenerateSortedDict:AssignedToMeDict keyArray:keyArray] forKey:@"Assigned To Me"]; }
    if ([selectedCategory isEqualToString:@"Completed"]) { [dictToReturn setObject:[self GenerateSortedDict:CompletedDict keyArray:keyArray] forKey:@"Completed"]; }
    if ([selectedCategory isEqualToString:@"Past Due"]) { [dictToReturn setObject:[self GenerateSortedDict:PastDueDict keyArray:keyArray] forKey:@"Past Due"]; }
    if ([selectedCategory isEqualToString:@"Upcoming"]) {  [dictToReturn setObject:[self GenerateSortedDict:UpcomingDict keyArray:keyArray] forKey:@"Upcoming"]; }
    if ([selectedCategory isEqualToString:@"Trash"]) {  [dictToReturn setObject:[self GenerateSortedDict:TrashDict keyArray:keyArray] forKey:@"Trash"]; }
    
    return dictToReturn[selectedCategory];
    
}

-(NSMutableDictionary *)GenerateItemsInCustomCategory:(NSMutableDictionary *)DictToUse keyArray:(NSArray *)keyArray itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict selectedCategory:(NSString *)selectedCategory taskListDict:(NSMutableDictionary *)taskListDict {
    
    NSMutableDictionary *AllDict = [NSMutableDictionary dictionary];
    
    NSMutableArray *DictToUseItemIDArrayCopy = DictToUse[@"ItemUniqueID"] ? [DictToUse[@"ItemUniqueID"] mutableCopy] : [NSMutableArray array];
    
    if (DictToUse[@"ItemUniqueID"]) {
        
        for (NSString *itemUniqueID in DictToUse[@"ItemUniqueID"]) {
         
            if ([DictToUseItemIDArrayCopy containsObject:itemUniqueID]) {
                
                NSInteger index = [DictToUseItemIDArrayCopy indexOfObject:itemUniqueID];
                
                NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:DictToUse keyArray:keyArray indexPath:[NSIndexPath indexPathForRow:index inSection:0]];
                
                BOOL TaskIsTrash = [[[BoolDataObject alloc] init] TaskIsTrash:singleObjectItemDict itemType:itemType];
                
                NSUInteger indexOfTaskList = taskListDict[@"TaskListName"] && [taskListDict[@"TaskListName"] containsObject:selectedCategory] ? [taskListDict[@"TaskListName"] indexOfObject:selectedCategory] : 0;
                NSMutableDictionary *taskListItems = taskListDict[@"TaskListItems"] && [(NSArray *)taskListDict[@"TaskListItems"] count] > indexOfTaskList ? taskListDict[@"TaskListItems"][indexOfTaskList] : [NSMutableDictionary dictionary];
                
                //Set object in all dict
              
                if ([[taskListItems allKeys] containsObject:itemUniqueID] && TaskIsTrash == NO) {
                    
                    NSMutableDictionary *dictToUse = AllDict;
                    
                    for (NSString *key in keyArray) {
                        
                        NSMutableArray *arr = dictToUse[key] ? [dictToUse[key] mutableCopy] : [NSMutableArray array];
                        id object = DictToUse[key] && [(NSArray *)DictToUse[key] count] > index ? DictToUse[key][index] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                        [arr addObject:object];
                        [dictToUse setObject:arr forKey:key];
                        
                    }
                    
                }
                
                if ([DictToUseItemIDArrayCopy count] > index) {
                    
                    [DictToUseItemIDArrayCopy replaceObjectAtIndex:index withObject:@"xxx"];
                    
                }
                
            }
            
        }
        
    }
   
    return AllDict;
    
}

-(NSMutableDictionary *)GenerateItemsInUser:(NSMutableDictionary *)DictToUse keyArray:(NSArray *)keyArray itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict selectedTag:(NSString *)selectedTag {
    
    NSMutableDictionary *AllDict = [NSMutableDictionary dictionary];
    
    NSMutableArray *DictToUseItemIDArrayCopy = DictToUse[@"ItemUniqueID"] ? [DictToUse[@"ItemUniqueID"] mutableCopy] : [NSMutableArray array];
    
    if (DictToUse[@"ItemUniqueID"]) {
        
        for (NSString *itemUniqueID in DictToUse[@"ItemUniqueID"]) {
            
            if ([DictToUseItemIDArrayCopy containsObject:itemUniqueID]) {
                
                NSInteger index = [DictToUseItemIDArrayCopy indexOfObject:itemUniqueID];
                
                NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:DictToUse keyArray:keyArray indexPath:[NSIndexPath indexPathForRow:index inSection:0]];
                
                BOOL TaskIsTrash = [[[BoolDataObject alloc] init] TaskIsTrash:singleObjectItemDict itemType:itemType];
               
                NSMutableArray *itemAssignedTo = DictToUse[@"ItemAssignedTo"] && [(NSArray *)DictToUse[@"ItemAssignedTo"] count] > index ? DictToUse[@"ItemAssignedTo"][index] : [NSMutableArray array];
                
                //Set object in all dict
                
                if (homeMembersDict[@"Username"] && [homeMembersDict[@"Username"] containsObject:selectedTag]) {
                    
                    NSUInteger indexOfUser = [homeMembersDict[@"Username"] indexOfObject:selectedTag];
                    NSString *userID = homeMembersDict[@"UserID"] && [(NSArray *)homeMembersDict[@"UserID"] count] > indexOfUser ? homeMembersDict[@"UserID"][indexOfUser] : @"";
                    
                    if ([itemAssignedTo containsObject:userID] && TaskIsTrash == NO) {
                        
                        NSMutableDictionary *dictToUse = AllDict;
                        
                        for (NSString *key in keyArray) {
                            
                            NSMutableArray *arr = dictToUse[key] ? [dictToUse[key] mutableCopy] : [NSMutableArray array];
                            id object = DictToUse[key] && [(NSArray *)DictToUse[key] count] > index ? DictToUse[key][index] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                            [arr addObject:object];
                            [dictToUse setObject:arr forKey:key];
                            
                        }
                        
                    }
                    
                    
                }
                
                if ([DictToUseItemIDArrayCopy count] > index) {
                    
                    [DictToUseItemIDArrayCopy replaceObjectAtIndex:index withObject:@"xxx"];
                    
                }
                
            }
            
        }
        
    }
    
    return AllDict;
    
}


-(NSMutableDictionary *)GenerateItemsInCustomTag:(NSMutableDictionary *)DictToUse keyArray:(NSArray *)keyArray itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict selectedTag:(NSString *)selectedTag {
    
    NSMutableDictionary *AllDict = [NSMutableDictionary dictionary];
    
    NSMutableArray *DictToUseItemIDArrayCopy = DictToUse[@"ItemUniqueID"] ? [DictToUse[@"ItemUniqueID"] mutableCopy] : [NSMutableArray array];
    
    if (DictToUse[@"ItemUniqueID"]) {
        
        for (NSString *itemUniqueID in DictToUse[@"ItemUniqueID"]) {
            
            if ([DictToUseItemIDArrayCopy containsObject:itemUniqueID]) {
                
                NSInteger index = [DictToUseItemIDArrayCopy indexOfObject:itemUniqueID];
                
                NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:DictToUse keyArray:keyArray indexPath:[NSIndexPath indexPathForRow:index inSection:0]];
                
                BOOL TaskIsTrash = [[[BoolDataObject alloc] init] TaskIsTrash:singleObjectItemDict itemType:itemType];
                
                NSMutableArray *itemTags = DictToUse[@"ItemTags"] && [(NSArray *)DictToUse[@"ItemTags"] count] > index ? DictToUse[@"ItemTags"][index] : [NSMutableArray array];
                
                //Set object in all dict
                
                if ([itemTags containsObject:selectedTag] && TaskIsTrash == NO) {
                    
                    NSMutableDictionary *dictToUse = AllDict;
                    
                    for (NSString *key in keyArray) {
                        
                        NSMutableArray *arr = dictToUse[key] ? [dictToUse[key] mutableCopy] : [NSMutableArray array];
                        id object = DictToUse[key] && [(NSArray *)DictToUse[key] count] > index ? DictToUse[key][index] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                        [arr addObject:object];
                        [dictToUse setObject:arr forKey:key];
                        
                    }
                    
                }
                
                if ([DictToUseItemIDArrayCopy count] > index) {
                    
                    [DictToUseItemIDArrayCopy replaceObjectAtIndex:index withObject:@"xxx"];
                    
                }
                
            }
            
        }
        
    }
    
    return AllDict;
    
}

-(NSMutableDictionary *)GenerateItemsInCustomColor:(NSMutableDictionary *)DictToUse keyArray:(NSArray *)keyArray itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict selectedTag:(NSString *)selectedColor {
    
    NSMutableDictionary *AllDict = [NSMutableDictionary dictionary];
    
    NSMutableArray *DictToUseItemIDArrayCopy = DictToUse[@"ItemUniqueID"] ? [DictToUse[@"ItemUniqueID"] mutableCopy] : [NSMutableArray array];
    
    if (DictToUse[@"ItemUniqueID"]) {
        
        for (NSString *itemUniqueID in DictToUse[@"ItemUniqueID"]) {
            
            if ([DictToUseItemIDArrayCopy containsObject:itemUniqueID]) {
                
                NSInteger index = [DictToUseItemIDArrayCopy indexOfObject:itemUniqueID];
                
                NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:DictToUse keyArray:keyArray indexPath:[NSIndexPath indexPathForRow:index inSection:0]];
                
                BOOL TaskIsTrash = [[[BoolDataObject alloc] init] TaskIsTrash:singleObjectItemDict itemType:itemType];
                
                NSString *itemColor = DictToUse[@"ItemColor"] && [(NSArray *)DictToUse[@"ItemColor"] count] > index ? DictToUse[@"ItemColor"][index] : @"";
                
                if ([itemColor isEqualToString:selectedColor] && TaskIsTrash == NO) {
                    
                    NSMutableDictionary *dictToUse = AllDict;
                    
                    for (NSString *key in keyArray) {
                        
                        NSMutableArray *arr = dictToUse[key] ? [dictToUse[key] mutableCopy] : [NSMutableArray array];
                        id object = DictToUse[key] && [(NSArray *)DictToUse[key] count] > index ? DictToUse[key][index] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                        [arr addObject:object];
                        [dictToUse setObject:arr forKey:key];
                        
                    }
                    
                }
                
                if ([DictToUseItemIDArrayCopy count] > index) {
                    
                    [DictToUseItemIDArrayCopy replaceObjectAtIndex:index withObject:@"xxx"];
                    
                }
                
            }
            
        }
        
    }
    
    return AllDict;
    
}

#pragma mark -
#pragma mark
#pragma mark Sub-Internal Methods
#pragma mark
#pragma mark -

#pragma mark Generate Speific Item To Display

-(NSMutableDictionary *)GenerateItemsToDisplayForSpecificItem_RemoveItemFromItsOriginalSection_GenerateOriginalSectionDictOfItemWithItemDataRemoved:(NSMutableDictionary *)dictFound userInfo:(NSDictionary *)userInfo itemType:(NSString *)itemType {
    
    if ([dictFound[@"ItemUniqueID"] containsObject:userInfo[@"ItemUniqueID"]]) {
        
        NSUInteger indexOfObject = [dictFound[@"ItemUniqueID"] indexOfObject:userInfo[@"ItemUniqueID"]];
        
        NSArray *keyArray = [[[GeneralObject alloc] init] GenerateKeyArrayManually:[itemType isEqualToString:@"Chore"] Expense:[itemType isEqualToString:@"Expense"] List:[itemType isEqualToString:@"List"] Home:NO];
        
        for (NSString *key in keyArray) {
        
            NSMutableArray *arr = dictFound[key] ? [dictFound[key] mutableCopy] : [NSMutableArray array];
            if (arr.count  > indexOfObject) { [arr removeObjectAtIndex:indexOfObject]; }
            [dictFound setObject:arr forKey:key];
            
        }
        
    }
    
    return dictFound;
}

-(NSMutableDictionary *)GenerateItemsToDisplayForSpecificItem_RemoveItemFromItsOriginalSection_GenerateDataDisplayDict:(NSMutableDictionary *)dataDisplayDict originalSectionDictOfItemWithdItemDataRemove:(NSMutableDictionary *)originalSectionDictOfItemWithdItemDataRemove originalSectionOfItem:(NSString *)originalSectionOfItem {
    
    if (dataDisplayDict == nil) {
        dataDisplayDict = [NSMutableDictionary dictionary];
    }
    
    BOOL sectionDictContainsAtLeastOneItem = (originalSectionDictOfItemWithdItemDataRemove && originalSectionDictOfItemWithdItemDataRemove[@"ItemUniqueID"] && [(NSArray *)originalSectionDictOfItemWithdItemDataRemove[@"ItemUniqueID"] count] > 0);
    
    if (sectionDictContainsAtLeastOneItem == YES) {
        [dataDisplayDict setObject:originalSectionDictOfItemWithdItemDataRemove forKey:originalSectionOfItem];
    } else {
        [dataDisplayDict removeObjectForKey:originalSectionOfItem];
    }
    
    return dataDisplayDict;
}

-(NSMutableArray *)GenerateItemsToDisplayForSpecificItem_RemoveItemFromItsOriginalSection_GenerateDataDisplaySectionsArray:(NSMutableArray *)dataDisplaySectionsArray originalSectionDictOfItemWithdItemDataRemove:(NSMutableDictionary *)originalSectionDictOfItemWithdItemDataRemove originalSectionOfItem:(NSString *)originalSectionOfItem {
    
    if (dataDisplaySectionsArray == nil) {
        dataDisplaySectionsArray = [NSMutableArray array];
    }
    
    BOOL sectionDictContainsAtLeastOneItem = (originalSectionDictOfItemWithdItemDataRemove && originalSectionDictOfItemWithdItemDataRemove[@"ItemUniqueID"] && [(NSArray *)originalSectionDictOfItemWithdItemDataRemove[@"ItemUniqueID"] count] > 0);
    
    if (sectionDictContainsAtLeastOneItem == NO) {
        if ([dataDisplaySectionsArray containsObject:originalSectionOfItem]) {
            [dataDisplaySectionsArray removeObject:originalSectionOfItem];
        }
    }
    
    dataDisplaySectionsArray = [[[GeneralObject alloc] init] RemoveDupliatesFromArray:dataDisplaySectionsArray];
    
    return dataDisplaySectionsArray;
}

-(NSMutableDictionary *)GenerateItemsToDisplayForSpecificItem_RemoveItemFromItsOriginalSection_GenerateDataDisplayAmountDict:(NSMutableDictionary *)dataDisplayAmountDict originalSectionOfItem:(NSString *)originalSectionOfItem {
    
    if (dataDisplayAmountDict == nil) {
        dataDisplayAmountDict = [NSMutableDictionary dictionary];
    }
    
    int currentSectionAmount = dataDisplayAmountDict[originalSectionOfItem] ? [(NSString *)dataDisplayAmountDict[originalSectionOfItem] intValue] : 0;
    currentSectionAmount -= 1;
    [dataDisplayAmountDict setObject:[NSString stringWithFormat:@"%d", currentSectionAmount] forKey:originalSectionOfItem];
    
    return dataDisplayAmountDict;
}

#pragma mark

-(NSMutableDictionary *)GenerateItemsToDisplayForSpecificItem_UpdateItemDataInOriginalSection_GenerateOriginalSectionDictOfItemWithItemDataUpdated:(NSMutableDictionary *)dictFound userInfo:(NSDictionary *)userInfo {
    
    if (dictFound == nil) {
        dictFound = [NSMutableDictionary dictionary];
    }
    
    if ([dictFound[@"ItemUniqueID"] containsObject:userInfo[@"ItemUniqueID"]]) {
        
        NSUInteger indexOfObject = [dictFound[@"ItemUniqueID"] indexOfObject:userInfo[@"ItemUniqueID"]];
        
        for (NSString *key in [userInfo allKeys]) {
            
            NSMutableArray *arr = dictFound[key] ? [dictFound[key] mutableCopy] : [NSMutableArray array];
            id object = userInfo[key] ? userInfo[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            if (arr.count  > indexOfObject) { [arr replaceObjectAtIndex:indexOfObject withObject:object]; }
            [dictFound setObject:arr forKey:key];
            
        }
        
    }
    
    return dictFound;
}

-(NSMutableDictionary *)GenerateItemsToDisplayForSpecificItem_UpdateItemDataInOriginalSection_GenerateDataDisplayDict:(NSMutableDictionary *)dataDisplayDict userInfo:(NSDictionary *)userInfo originalSectionDictOfItem:(NSMutableDictionary *)originalSectionDictOfItem originalSectionOfItem:(NSString *)originalSectionOfItem {
    
    if (dataDisplayDict == nil) {
        dataDisplayDict = [NSMutableDictionary dictionary];
    }
    
    //Replace Data In Appropriate Section
    NSMutableDictionary *dictFoundWithRemovedItemData = [self GenerateItemsToDisplayForSpecificItem_UpdateItemDataInOriginalSection_GenerateOriginalSectionDictOfItemWithItemDataUpdated:[originalSectionDictOfItem mutableCopy] userInfo:userInfo];
    [dataDisplayDict setObject:dictFoundWithRemovedItemData forKey:originalSectionOfItem];
    
    return dataDisplayDict;
}

#pragma mark

-(NSMutableDictionary *)GenerateItemsToDisplayForSpecificItem_AddItemToItsNewSection_GenerateNewSectionDictOfItemWithItemDataAdded:(NSMutableDictionary *)dataDisplayDict userInfo:(NSDictionary *)userInfo newSectionForItem:(NSString *)newSectionForItem itemType:(NSString *)itemType {
    
    if (dataDisplayDict == nil) {
        dataDisplayDict = [NSMutableDictionary dictionary];
    }
    
    NSMutableDictionary *dictFound = dataDisplayDict[newSectionForItem] ? [dataDisplayDict[newSectionForItem] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableArray *itemUniqueIDArray = dataDisplayDict[newSectionForItem] && dataDisplayDict[newSectionForItem][@"ItemUniqueID"] ? dataDisplayDict[newSectionForItem][@"ItemUniqueID"] : [NSMutableArray array];
 
    if ((!userInfo[@"ItemUniqueID"]) || (userInfo[@"ItemUniqueID"] && [itemUniqueIDArray containsObject:userInfo[@"ItemUniqueID"]] == NO)) {
       
        NSArray *keyArray = [[[GeneralObject alloc] init] GenerateKeyArrayManually:[itemType isEqualToString:@"Chore"] Expense:[itemType isEqualToString:@"Expense"] List:[itemType isEqualToString:@"List"] Home:NO];
        
        for (NSString *key in keyArray) {
            
            NSMutableArray *arr = dictFound[key] ? [dictFound[key] mutableCopy] : [NSMutableArray array];
            id object = userInfo[key] ? userInfo[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            [arr addObject:object];
            [dictFound setObject:arr forKey:key];
            
        }
        
    }
   
    return dictFound;
}

-(NSMutableDictionary *)GenerateItemsToDisplayForSpecificItem_AddItemToItsNewSection_GenerateDataDisplayDict:(NSMutableDictionary *)dataDisplayDict userInfo:(NSDictionary *)userInfo newSectionOfItem:(NSString *)newSectionOfItem itemType:(NSString *)itemType {
   
    if (dataDisplayDict == nil) {
        dataDisplayDict = [NSMutableDictionary dictionary];
    }
    
    //Add Data In New Section
    NSMutableDictionary *newSectionDictOfItemWithdItemDataAdded = [self GenerateItemsToDisplayForSpecificItem_AddItemToItsNewSection_GenerateNewSectionDictOfItemWithItemDataAdded:dataDisplayDict userInfo:userInfo newSectionForItem:newSectionOfItem itemType:itemType];
    [dataDisplayDict setObject:newSectionDictOfItemWithdItemDataAdded forKey:newSectionOfItem];
    
    return dataDisplayDict;
}

-(NSMutableDictionary *)GenerateItemsToDisplayForSpecificItem_AddItemToItsNewSection_GenerateDataDisplayAmountDict:(NSMutableDictionary *)dataDisplayAmountDict newSectionOfItem:(NSString *)newSectionOfItem {
    
    if (dataDisplayAmountDict == nil) {
        dataDisplayAmountDict = [NSMutableDictionary dictionary];
    }
    
    int currentSectionAmount = dataDisplayAmountDict[newSectionOfItem] ? [(NSString *)dataDisplayAmountDict[newSectionOfItem] intValue] : 0;
    currentSectionAmount += 1;
    [dataDisplayAmountDict setObject:[NSString stringWithFormat:@"%d", currentSectionAmount] forKey:newSectionOfItem];
    
    return dataDisplayAmountDict;
}

-(NSMutableArray *)GenerateItemsToDisplayForSpecificItem_AddItemToItsNewSection_GenerateDataDisplaySectionsArray:(NSMutableArray *)dataDisplaySectionsArray newSectionOfItem:(NSString *)newSectionOfItem itemsToDisplayInSelectedCategory:(NSMutableDictionary *)itemsToDisplayInSelectedCategory taskListDict:(NSMutableDictionary *)taskListDict sectionDict:(NSMutableDictionary *)sectionDict sideBarCategorySectionArrayAltered:(NSMutableArray *)sideBarCategorySectionArrayAltered sideBarCategorySectionArrayOriginal:(NSMutableArray *)sideBarCategorySectionArrayOriginal sectionOriginalSection:(int)sectionOriginalSection usersSection:(int)usersSection tagsSection:(int)tagsSection colorsSection:(int)colorsSection {
    
    if (dataDisplaySectionsArray == nil) {
        dataDisplaySectionsArray = [NSMutableArray array];
    }
    
    BOOL FoundCorrectPositionOfNewSection = NO;
    
    if ([dataDisplaySectionsArray containsObject:newSectionOfItem] == NO) {
        
        BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemsToDisplayInSelectedCategory[@"ItemTags"] classArr:@[[NSArray class], [NSMutableArray class]]];
        NSMutableArray *itemTagArrayOfArrays = ObjectIsKindOfClass == YES ? itemsToDisplayInSelectedCategory[@"ItemTags"] : [NSMutableArray array];
        
        NSMutableArray *sectionsArray = [[[TasksViewController alloc] init] GenerateSectionsArray:itemTagArrayOfArrays taskListDict:taskListDict sectionDict:sectionDict sideBarCategorySectionArrayAltered:sideBarCategorySectionArrayAltered sideBarCategorySectionArrayOriginal:sideBarCategorySectionArrayOriginal sectionOriginalSection:sectionOriginalSection usersSection:usersSection tagsSection:tagsSection colorsSection:colorsSection];
        
        NSUInteger indexOfNewSectionInSectionsArray = [sectionsArray containsObject:newSectionOfItem] ? [sectionsArray indexOfObject:newSectionOfItem] : 1000;
        
        for (NSString *sectionName in [dataDisplaySectionsArray mutableCopy]) {
            
            NSUInteger indexOfLoopedSectionInSectionsArray = [sectionsArray containsObject:sectionName] ? [sectionsArray indexOfObject:sectionName] : 1000;
           
            if (indexOfLoopedSectionInSectionsArray > indexOfNewSectionInSectionsArray) {
                
                NSUInteger indexOfLoopedSectionInDataDisplaySectionsArray = [dataDisplaySectionsArray indexOfObject:sectionName];
                [dataDisplaySectionsArray insertObject:newSectionOfItem atIndex:indexOfLoopedSectionInDataDisplaySectionsArray];
                FoundCorrectPositionOfNewSection = YES;
           
            }
            
        }
        
        if (FoundCorrectPositionOfNewSection == NO) {
            
            [dataDisplaySectionsArray addObject:newSectionOfItem];
       
        }
        
    }
   
    dataDisplaySectionsArray = [[[GeneralObject alloc] init] RemoveDupliatesFromArray:dataDisplaySectionsArray];
    
    return dataDisplaySectionsArray;
}

-(NSDictionary *)GenerateItemsToDisplayForSpecificItem_AddItemToItsNewSection:(NSMutableDictionary *)dataDisplayDict dataDisplayAmountDict:(NSMutableDictionary *)dataDisplayAmountDict dataDisplaySectionsArray:(NSMutableArray *)dataDisplaySectionsArray userInfo:(NSDictionary *)userInfo newSectionOfItem:(NSString *)newSectionOfItem itemsToDisplayInSelectedCategory:(NSMutableDictionary *)itemsToDisplayInSelectedCategory taskListDict:(NSMutableDictionary *)taskListDict sectionDict:(NSMutableDictionary *)sectionDict sideBarCategorySectionArrayAltered:(NSMutableArray *)sideBarCategorySectionArrayAltered sideBarCategorySectionArrayOriginal:(NSMutableArray *)sideBarCategorySectionArrayOriginal sectionOriginalSection:(int)sectionOriginalSection usersSection:(int)usersSection tagsSection:(int)tagsSection colorsSection:(int)colorsSection itemType:(NSString *)itemType {
   
    dataDisplayDict = [self GenerateItemsToDisplayForSpecificItem_AddItemToItsNewSection_GenerateDataDisplayDict:dataDisplayDict userInfo:userInfo newSectionOfItem:newSectionOfItem itemType:itemType];
    
    dataDisplayAmountDict = [self GenerateItemsToDisplayForSpecificItem_AddItemToItsNewSection_GenerateDataDisplayAmountDict:dataDisplayAmountDict newSectionOfItem:newSectionOfItem];
    
    dataDisplaySectionsArray = [self GenerateItemsToDisplayForSpecificItem_AddItemToItsNewSection_GenerateDataDisplaySectionsArray:dataDisplaySectionsArray newSectionOfItem:newSectionOfItem itemsToDisplayInSelectedCategory:itemsToDisplayInSelectedCategory taskListDict:taskListDict sectionDict:sectionDict sideBarCategorySectionArrayAltered:sideBarCategorySectionArrayAltered sideBarCategorySectionArrayOriginal:sideBarCategorySectionArrayOriginal sectionOriginalSection:sectionOriginalSection usersSection:usersSection tagsSection:tagsSection colorsSection:colorsSection];
    
    return @{@"dataDisplayDict" : dataDisplayDict, @"dataDisplaySectionsArray" : dataDisplaySectionsArray, @"dataDisplayAmountDict" : dataDisplayAmountDict};
}

#pragma mark - Generate Items In Selected Category Selected Section

-(NSString *)GenerateSectionSpecificItemBelongsTo:(NSMutableDictionary *)DictToUse keyArray:(NSArray *)keyArray itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict itemUniqueID:(NSString *)itemUniqueID section:(NSString *)section {
    
    NSInteger index = DictToUse[@"ItemUniqueID"] && [DictToUse[@"ItemUniqueID"] containsObject:itemUniqueID] ? [DictToUse[@"ItemUniqueID"] indexOfObject:itemUniqueID] : 0;
    
    NSString *itemDueDate = DictToUse[@"ItemDueDate"] && [(NSArray *)DictToUse[@"ItemDueDate"] count] > index ? DictToUse[@"ItemDueDate"][index] : @"";
    NSString *itemGracePeriod = DictToUse[@"ItemGracePeriod"] && [(NSArray *)DictToUse[@"ItemGracePeriod"] count] > index ? DictToUse[@"ItemGracePeriod"][index] : @"";
    
    NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:DictToUse keyArray:keyArray indexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    
    
    
    
    BOOL TaskIsFullyCompleted = [[[BoolDataObject alloc] init] TaskIsFullyCompleted:singleObjectItemDict itemType:itemType homeMembersDict:homeMembersDict];
    BOOL TaskHasNoDueDate = [[[BoolDataObject alloc] init] TaskHasNoDueDate:singleObjectItemDict itemType:itemType];
    BOOL TaskIsPastDue = [[[BoolDataObject alloc] init] TaskIsPastDue:singleObjectItemDict itemType:itemType];
    BOOL TaskIsScheduledStart = [[[BoolDataObject alloc] init] TaskIsScheduledStart:singleObjectItemDict itemType:itemType];
    BOOL TaskIsScheduledStartAndVisible = [[[BoolDataObject alloc] init] TaskIsScheduledStartAndVisible:singleObjectItemDict itemType:itemType userID:userID];
    
     NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
    
    if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:itemDueDate returnAs:[NSDate class]] == nil) {
        dateFormat = @"MMMM dd, yyyy HH:mm";
    }
    
    NSString *currentDateString = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
    
    NSDate *date1 = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:itemDueDate returnAs:[NSDate class]];
    NSDate *date2 = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:currentDateString returnAs:[NSDate class]];
    
    NSTimeInterval secondsPassedSinceItemDueDate = [date2 timeIntervalSinceDate:date1];
    
    int secondsThatNeedToPass = [[[GeneralObject alloc] init] GenerateSecondsFromDisplayTime:itemGracePeriod];
   
    if (secondsPassedSinceItemDueDate >= 0) {
        
        NSDate *dueDateDate = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:itemDueDate returnAs:[NSDate class]];
        itemDueDate = [[[GeneralObject alloc] init] GenerateDateWithAddedTimeWithFormat:dateFormat dateToAddTimeTo:dueDateDate timeToAdd:secondsThatNeedToPass returnAs:[NSString class]];
        
    }
    
    
    
    
    
    NSString *convertedDate = [[[GeneralObject alloc] init] GetDisplayTimeRemainingUntilDateStartingFromCurrentDate:itemDueDate shortStyle:NO reallyShortStyle:NO];
    NSArray *splitArr = [convertedDate componentsSeparatedByString:@" "];
    
    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:currentDate];
    int hoursRemainingInDay = 24 - (int)components.hour;
    //int daysRemainingInWeek = 7 - (int)components.weekday;
    
    int amountOfUnitOfTime = splitArr.count > 0 ? [splitArr[0] intValue] : 0;
    //NSString *unitOfTime = splitArr.count > 1 ? splitArr[1] : @"";
    
    BOOL TaskRemainingTimeIsLessThanTodaysRemainingTime =
    ([convertedDate containsString:@"min "]) ||
    ([convertedDate containsString:@"hour"] && (amountOfUnitOfTime <= hoursRemainingInDay));
    
    BOOL TaskRemainingTimeIsGreaterThanTodaysRemainingTime =
    ([convertedDate isEqualToString:@"1 day left"]) ||
    ([convertedDate containsString:@"hour"] && amountOfUnitOfTime > hoursRemainingInDay);
    
    BOOL TaskRemainingTimeIsLessThanThisWeeksRemainingTime =
    ([convertedDate isEqualToString:@"2 days left"] || [convertedDate isEqualToString:@"3 days left"] || [convertedDate isEqualToString:@"4 days left"] || [convertedDate isEqualToString:@"5 days left"] || [convertedDate isEqualToString:@"6 days left"] || [convertedDate isEqualToString:@"7 days left"]);
    
    
    
    
    
    
    
    NSString *dateSectionItemBelongsTo = @"";
    
    
    
    
    
    
    
    if (TaskHasNoDueDate == YES && TaskIsFullyCompleted == NO && (TaskIsScheduledStart == NO || TaskIsScheduledStartAndVisible == YES)) {
        
        dateSectionItemBelongsTo = @"No Due Date";
        
    } else if (TaskRemainingTimeIsLessThanTodaysRemainingTime == YES && TaskIsFullyCompleted == NO && TaskIsPastDue == NO && (TaskIsScheduledStart == NO || TaskIsScheduledStartAndVisible == YES)) {
        
        dateSectionItemBelongsTo = @"Today";
        
    } else if (TaskRemainingTimeIsGreaterThanTodaysRemainingTime == YES && TaskIsFullyCompleted == NO && TaskIsPastDue == NO && (TaskIsScheduledStart == NO || TaskIsScheduledStartAndVisible == YES)) {
        
        dateSectionItemBelongsTo = @"Tomorrow";
        
    } else if (TaskRemainingTimeIsLessThanThisWeeksRemainingTime == YES && TaskIsFullyCompleted == NO && TaskIsPastDue == NO && (TaskIsScheduledStart == NO || TaskIsScheduledStartAndVisible == YES)) {
        
        dateSectionItemBelongsTo = @"Next 7 Days";
        
    } else if (TaskIsFullyCompleted == NO && TaskIsPastDue == YES && TaskHasNoDueDate == NO) {
        
        dateSectionItemBelongsTo = @"Past Due";
        
    } else if (TaskRemainingTimeIsLessThanTodaysRemainingTime == NO && TaskRemainingTimeIsGreaterThanTodaysRemainingTime == NO && TaskRemainingTimeIsLessThanThisWeeksRemainingTime == NO && TaskIsFullyCompleted == NO && TaskIsPastDue == NO && TaskHasNoDueDate == NO && (TaskIsScheduledStart == NO || TaskIsScheduledStartAndVisible == YES)) {
        
        dateSectionItemBelongsTo = @"Upcoming";
        
    }
    
    if ([section isEqualToString:@"Scheduled"]) {
        
        if (TaskIsScheduledStartAndVisible == YES) {
            
            dateSectionItemBelongsTo = @"Scheduled";
            
        }
        
    }
    
    if ([section isEqualToString:@"Completed"]) {
        
        if (TaskIsFullyCompleted == YES) {
            
            dateSectionItemBelongsTo = @"Completed";
            
        }
        
    }
    
    return dateSectionItemBelongsTo;
}

#pragma mark - Generate Items (Generate Items In Selected Category Selected Section & Generate Amount Of Items In Categories)

-(NSMutableDictionary *)GenerateSortedDict:(NSMutableDictionary *)dataDict keyArray:(NSArray *)keyArray {
    
    NSMutableArray *itemDueDatesCopy = [dataDict[@"ItemDueDate"] mutableCopy];
    
    NSMutableArray *itemDueDatesSorted = [NSMutableArray array];
    
    if (dataDict[@"ItemDueDate"]) {
        
        for (int i=0 ; i<[(NSArray *)dataDict[@"ItemDueDate"] count] ; i++) {
            
            NSString *itemDueDate = dataDict[@"ItemDueDate"] && [(NSArray *)dataDict[@"ItemDueDate"] count] > i ? dataDict[@"ItemDueDate"][i] : @"";
            NSString *itemDatePosted = dataDict[@"ItemDatePosted"] && [(NSArray *)dataDict[@"ItemDatePosted"] count] > i ? dataDict[@"ItemDatePosted"][i] : @"";
            
            if ([itemDueDate isEqualToString:@"No Due Date"]) {
                
                NSString *totalDueDate = itemDatePosted;
                
                if ([itemDueDatesCopy count] > i) {
                    
                    [itemDueDatesCopy replaceObjectAtIndex:i withObject:totalDueDate];
                    
                }
                
                if (i == [(NSArray *)dataDict[@"ItemDueDate"] count]-1) {
                    
                    itemDueDatesSorted = [[[GeneralObject alloc] init] SortArrayOfDates:[itemDueDatesCopy mutableCopy] dateFormatString:@"yyyy-MM-dd HH:mm:ss"];
                    
                }
                
            } else {
                
                NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
                
                NSString *totalDueDate = itemDueDate;
                
                BOOL AnyTimeReplaced = NO;
                
                if ([itemDueDate containsString:@"Any Time"]) {
                    AnyTimeReplaced = YES;
                    itemDueDate = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:itemDueDate stringToReplace:@"Any Time" replacementString:@"11:59 PM"];
                }
                
                if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:itemDueDate returnAs:[NSDate class]]) {
                    
                    NSArray *arr;
                    BOOL SplitAM = NO;
                    
                    if ([itemDueDate containsString:@" AM"]) {
                        arr = [itemDueDate componentsSeparatedByString:@" AM"];
                        SplitAM = YES;
                    } else if ([itemDueDate containsString:@" PM"]) {
                        arr = [itemDueDate componentsSeparatedByString:@" PM"];
                        SplitAM = NO;
                    }
                    
                    NSString *firstHalfOfDueDate = [arr count] > 0 ? arr[0] : @"";
                    firstHalfOfDueDate = [NSString stringWithFormat:@"%@:%02d", firstHalfOfDueDate, i];
                    totalDueDate = [NSString stringWithFormat:@"%@%@", firstHalfOfDueDate, SplitAM == YES ? @" AM" : @" PM"];
                    
                }
                
                if ([itemDueDatesCopy count] > i) {
                    
                    [itemDueDatesCopy replaceObjectAtIndex:i withObject:totalDueDate];
                    
                }
                
                //Get all due dates with multiple occurrences
                //Sort them in separate arrays
                //Loop through due date array until you find correct spot (where secondsPassed is greater than 0)
                
                if (i == [(NSArray *)dataDict[@"ItemDueDate"] count]-1) {
                    
                    itemDueDatesSorted = [[[GeneralObject alloc] init] SortArrayOfDates:[itemDueDatesCopy mutableCopy] dateFormatString:@"MMMM dd, yyyy hh:mm:SS a"];
                    
                }
                
            }
            
        }
        
    }
    
    
    NSMutableDictionary *sortedDict = [NSMutableDictionary dictionary];
    
    for (NSString *itemDueDate in itemDueDatesSorted) {
        
        if ([itemDueDatesCopy containsObject:itemDueDate]) {
            
            NSUInteger index = [itemDueDatesCopy indexOfObject:itemDueDate];
            
            for (NSString *key in keyArray) {
                
                NSMutableArray *arr = sortedDict[key] ? [sortedDict[key] mutableCopy] : [NSMutableArray array];
                id object = dataDict[key] && [(NSArray *)dataDict[key] count] > index ? dataDict[key][index] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                [arr addObject:object];
                [sortedDict setObject:arr forKey:key];
                
            }
            
            if ([itemDueDatesCopy count] > index) {
                
                [itemDueDatesCopy replaceObjectAtIndex:index withObject:@"xxx"];
                
            }
            
        }
        
    }
    
    return sortedDict;
}

@end
