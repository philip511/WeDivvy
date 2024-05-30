//
//  BoolDataObject.m
//  WeDivvy
//
//  Created by Philip Nagel on 8/17/22.
//

#import "BoolDataObject.h"

#import "SetDataObject.h"
#import "GeneralObject.h"
#import "NotificationsObject.h"

@implementation BoolDataObject

#pragma mark - High Compound BOOLs

-(BOOL)TaskIsFullyCompleted:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:itemDict itemType:itemType];
    BOOL TaskIsList = [[[BoolDataObject alloc] init] TaskIsList:itemDict itemType:itemType];
    BOOL TaskIsItemized = [[[BoolDataObject alloc] init] TaskIsItemized:itemDict itemType:itemType];
    BOOL TaskCompletedByAllAssignedUsers = [[[BoolDataObject alloc] init] TaskCompletedByAllAssignedUsers:itemDict itemType:itemType homeMembersDict:homeMembersDict];
    BOOL AllListItemsAreCompleted = [[[BoolDataObject alloc] init] AllListItemsAreCompleted:itemDict itemType:itemType];
    BOOL AllItemizedItemsAreCompleted = [[[BoolDataObject alloc] init] AllItemizedItemsAreCompleted:itemDict itemType:itemType];
    BOOL TaskCompletedByMinimumUsers = [[[BoolDataObject alloc] init] TaskCompletedByMinimumUsers:itemDict itemType:itemType homeMembersDict:homeMembersDict];
    BOOL TaskCompletedByCurrentUsersTurn = [[[BoolDataObject alloc] init] TaskCompletedByCurrentUsersTurn:itemDict itemType:itemType homeMembersDict:homeMembersDict];
    BOOL TaskMustBeCompletedByEveryoneAssigned = [[[BoolDataObject alloc] init] TaskMustBeCompletedByEveryoneAssigned:itemDict itemType:itemType];
    BOOL TaskIsAssignedToNobody = [[[BoolDataObject alloc] init] TaskIsAssignedToNobody:itemDict itemType:itemType];
    BOOL TaskCompletedByAllHomeMembers = [[[BoolDataObject alloc] init] TaskCompletedByAllHomeMembers:itemDict homeMembersDict:homeMembersDict];
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:itemDict itemType:itemType];
    
    
    
    BOOL TaskIsFullyCompleted =
    
    //Not Complete As Needed Because This Type Of Task Cannot Be Fully Completed
    (TaskIsCompleteAsNeeded == NO &&
     
     (
      
      //Standard Chore/Non-Itemized Expense, Assigned To Specific People, Must Be Completed By Everyone Assigned, Completed By Everyone Assigned
      (TaskIsTakingTurns == NO && TaskIsList == NO && TaskIsItemized == NO && TaskIsAssignedToNobody == NO && TaskMustBeCompletedByEveryoneAssigned == YES && TaskCompletedByAllAssignedUsers == YES) ||
      
      //Chore/Non-Itemized Expense, Assigned To Nobody, Must Be Completed By Everyone Assigned, Completed By All Home Members
      (TaskIsTakingTurns == NO && TaskIsList == NO && TaskIsItemized == NO && TaskIsAssignedToNobody == YES && TaskMustBeCompletedByEveryoneAssigned == YES && TaskCompletedByAllHomeMembers == YES) ||
      
      //Chore/Non-Itemized Expense, Assigned To Either Nobody or Specific People, Must Be Completed By Specific # of People, Completed By Specific # Of People
      (TaskIsTakingTurns == NO && TaskIsList == NO && TaskIsItemized == NO && TaskMustBeCompletedByEveryoneAssigned == NO && TaskCompletedByMinimumUsers == YES) ||
      
      //Chore/Non-Itemized Expense, Is Taking Turns, Assigned To Specific People, Completed By Specific Users Turn
      (TaskIsTakingTurns == YES && TaskIsList == NO && TaskIsItemized == NO && TaskIsAssignedToNobody == NO && TaskCompletedByCurrentUsersTurn == YES) ||
      
      //List/Itemized Expense, All List Items Are Completed Or All Itemized Items Are Completed
      ((TaskIsList == YES && AllListItemsAreCompleted == YES) || (TaskIsItemized == YES && AllItemizedItemsAreCompleted == YES))
      
      )
     
     );
    
    return TaskIsFullyCompleted;
}

-(BOOL)TaskIsFullyCompletedButNotByEveryone:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:itemDict itemType:itemType];
    BOOL TaskIsList = [[[BoolDataObject alloc] init] TaskIsList:itemDict itemType:itemType];
    BOOL TaskIsItemized = [[[BoolDataObject alloc] init] TaskIsItemized:itemDict itemType:itemType];
    BOOL AllListItemsAreCompleted = [[[BoolDataObject alloc] init] AllListItemsAreCompleted:itemDict itemType:itemType];
    BOOL AllItemizedItemsAreCompleted = [[[BoolDataObject alloc] init] AllItemizedItemsAreCompleted:itemDict itemType:itemType];
    BOOL TaskCompletedByMinimumUsers = [[[BoolDataObject alloc] init] TaskCompletedByMinimumUsers:itemDict itemType:itemType homeMembersDict:homeMembersDict];
    BOOL TaskCompletedByCurrentUsersTurn = [[[BoolDataObject alloc] init] TaskCompletedByCurrentUsersTurn:itemDict itemType:itemType homeMembersDict:homeMembersDict];
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:itemDict itemType:itemType];
    
    BOOL TaskIsFullyCompletedButNoByEveryone = ((TaskIsList == NO && TaskIsItemized == NO && TaskIsTakingTurns == NO && TaskCompletedByMinimumUsers == YES && TaskIsCompleteAsNeeded == NO) ||
                                                (TaskIsList == NO && TaskIsItemized == NO && TaskIsTakingTurns == YES && TaskCompletedByCurrentUsersTurn == YES && TaskIsCompleteAsNeeded == NO) ||
                                                (((TaskIsList == YES && AllListItemsAreCompleted == YES) || (TaskIsItemized == YES && AllItemizedItemsAreCompleted == YES)) && TaskIsCompleteAsNeeded == NO));
    
    return TaskIsFullyCompletedButNoByEveryone;
}

-(BOOL)TaskCanBeCompletedInTaskBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    BOOL TaskCompletedBySpecificUser = [[[BoolDataObject alloc] init] TaskCompletedBySpecificUser:itemDict itemType:itemType userID:userID];
    BOOL TaskWasAssignedToSpecificUser = [[[BoolDataObject alloc] init] TaskWasAssignedToSpecificUser:itemDict itemType:itemType userID:userID];
    BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:itemDict itemType:itemType];
    BOOL TaskIsSpecificUsersTurn = [[[BoolDataObject alloc] init] TaskIsSpecificUsersTurn:itemDict itemType:itemType userID:userID homeMembersDict:homeMembersDict];
    BOOL TaskIsAList = [[[BoolDataObject alloc] init] TaskIsList:itemDict itemType:itemType];
    BOOL TaskIsItemized = [[[BoolDataObject alloc] init] TaskIsItemized:itemDict itemType:itemType];
    BOOL TaskIsAssignedToNobody = [[[BoolDataObject alloc] init] TaskIsAssignedToNobody:itemDict itemType:itemType];
    
    BOOL TaskMustBeCompletedByEveryoneAssigned = [[[BoolDataObject alloc] init] TaskMustBeCompletedByEveryoneAssigned:itemDict itemType:itemType];
    BOOL TaskCompletedByMinimumUsers = [[[BoolDataObject alloc] init] TaskCompletedByMinimumUsers:itemDict itemType:itemType homeMembersDict:homeMembersDict];
    
    BOOL TaskHasBeenAssignedToSpecificUserAndMustBeCompletedByEveryone =
    (TaskIsAList == NO &&
     TaskIsItemized == NO &&
     TaskMustBeCompletedByEveryoneAssigned == YES &&
     (TaskWasAssignedToSpecificUser == YES || TaskIsAssignedToNobody == YES) &&
     (TaskIsTakingTurns == NO || (TaskIsTakingTurns == YES && TaskIsSpecificUsersTurn == YES)));
    
    BOOL TaskHasBeenAssignedToSpecificUserAndMustBeCompletedByAMinimumNumberOfPeopleAndHasNotBeenYet =
    (TaskIsAList == NO &&
     TaskIsItemized == NO &&
     TaskMustBeCompletedByEveryoneAssigned == NO &&
     TaskCompletedByMinimumUsers == NO &&
     (TaskWasAssignedToSpecificUser == YES || TaskIsAssignedToNobody == YES) &&
     (TaskIsTakingTurns == NO || (TaskIsTakingTurns == YES && TaskIsSpecificUsersTurn == YES)));
    
    BOOL TaskHasBeenAssignedToSpecificUserAndMustBeCompletedByAMinimumNumberOfPeopleAndHasAndIAmOneOfThem =
    (TaskIsAList == NO &&
     TaskIsItemized == NO &&
     TaskMustBeCompletedByEveryoneAssigned == NO &&
     TaskCompletedByMinimumUsers == YES &&
     TaskCompletedBySpecificUser == YES &&
     (TaskWasAssignedToSpecificUser == YES || TaskIsAssignedToNobody == YES) &&
     (TaskIsTakingTurns == NO || (TaskIsTakingTurns == YES && TaskIsSpecificUsersTurn == YES)));
    
    if (TaskHasBeenAssignedToSpecificUserAndMustBeCompletedByEveryone == YES ||
        TaskHasBeenAssignedToSpecificUserAndMustBeCompletedByAMinimumNumberOfPeopleAndHasNotBeenYet == YES ||
        TaskHasBeenAssignedToSpecificUserAndMustBeCompletedByAMinimumNumberOfPeopleAndHasAndIAmOneOfThem == YES) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskCanBeCompletedInViewTaskBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    //BOOL SpecificUserIsMe = [[[BoolDataObject alloc] init] SpecificUserIsMe:userID];
    BOOL TaskWasCreatedByMe = [[[BoolDataObject alloc] init] TaskWasCreatedBySpecificUser:itemDict itemType:itemType userID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:itemDict itemType:itemType];
    BOOL TaskIsSpecificUsersTurn = [[[BoolDataObject alloc] init] TaskIsSpecificUsersTurn:itemDict itemType:itemType userID:userID homeMembersDict:homeMembersDict];
    BOOL TaskIsAList = [[[BoolDataObject alloc] init] TaskIsList:itemDict itemType:itemType];
    BOOL TaskIsItemized = [[[BoolDataObject alloc] init] TaskIsItemized:itemDict itemType:itemType];
    
    BOOL TaskMustBeCompletedByEveryoneAssigned = [[[BoolDataObject alloc] init] TaskMustBeCompletedByEveryoneAssigned:itemDict itemType:itemType];
    BOOL TaskWasCompletedBySpecificUser = [[[BoolDataObject alloc] init] TaskCompletedBySpecificUser:itemDict itemType:itemType userID:userID];
    BOOL TaskWasCompletedByMe = [[[BoolDataObject alloc] init] TaskCompletedBySpecificUser:itemDict itemType:itemType userID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    BOOL TaskMinimumCompletionsMet = [[[BoolDataObject alloc] init] TaskCompletedByMinimumUsers:itemDict itemType:itemType homeMembersDict:homeMembersDict];
    
    BOOL TaskHasBeenAssignedToMeAndMustBeCompletedByEveryone = (TaskIsAList == NO &&
                                                                TaskIsItemized == NO &&
                                                                TaskMustBeCompletedByEveryoneAssigned == YES &&
                                                                //SpecificUserIsMe == YES &&
                                                                (TaskIsTakingTurns == NO || (TaskIsTakingTurns == YES && TaskIsSpecificUsersTurn == YES)));
    
    BOOL TaskHasBeenAssignedToMeAndMustBeCompletedByAMinimumNumberOfPeopleAndHasNotBeenYet = (TaskIsAList == NO &&
                                                                                              TaskIsItemized == NO &&
                                                                                              TaskMustBeCompletedByEveryoneAssigned == NO &&
                                                                                              TaskMinimumCompletionsMet == NO &&
                                                                                              //SpecificUserIsMe == YES &&
                                                                                              (TaskIsTakingTurns == NO || (TaskIsTakingTurns == YES && TaskIsSpecificUsersTurn == YES)));
    
    BOOL TaskHasBeenAssignedToMeAndMustBeCompletedByAMinimumNumberOfPeopleAndHasAndIAmOneOfThem = (TaskIsAList == NO &&
                                                                                                   TaskIsItemized == NO &&
                                                                                                   TaskMustBeCompletedByEveryoneAssigned == NO &&
                                                                                                   TaskMinimumCompletionsMet == YES &&
                                                                                                   TaskWasCompletedByMe == YES &&
                                                                                                   //SpecificUserIsMe == YES &&
                                                                                                   (TaskIsTakingTurns == NO || (TaskIsTakingTurns == YES && TaskIsSpecificUsersTurn == YES)));
    
    if (TaskWasCreatedByMe == YES &&
        
        (TaskMustBeCompletedByEveryoneAssigned == YES ||
         (TaskMustBeCompletedByEveryoneAssigned == NO && TaskMinimumCompletionsMet == NO) ||
         (TaskMustBeCompletedByEveryoneAssigned == NO && TaskMinimumCompletionsMet == YES &&
          TaskWasCompletedBySpecificUser == YES)) &&
        
        (TaskIsTakingTurns == NO ||
         (TaskIsTakingTurns == YES && TaskIsSpecificUsersTurn == YES))) {
        
        return YES;
        
    }
    
    if (TaskHasBeenAssignedToMeAndMustBeCompletedByEveryone == YES ||
        TaskHasBeenAssignedToMeAndMustBeCompletedByAMinimumNumberOfPeopleAndHasNotBeenYet == YES ||
        TaskHasBeenAssignedToMeAndMustBeCompletedByAMinimumNumberOfPeopleAndHasAndIAmOneOfThem == YES) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsValidToBeDisplayed:(NSMutableDictionary *)itemDict index:(NSUInteger)index itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict keyArray:(NSArray *)keyArray {
    
    NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:itemDict keyArray:keyArray indexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    
    
    BOOL TaskIsOccurrence = [[[BoolDataObject alloc] init] TaskIsOccurrence:singleObjectItemDict itemType:itemType];
    BOOL TaskOccurrenceStatusIsNone = [[[BoolDataObject alloc] init] TaskOccurrenceStatusIsNone:singleObjectItemDict itemType:itemType];
    
    BOOL TaskIsScheduledStart = [[[BoolDataObject alloc] init] TaskIsScheduledStart:singleObjectItemDict itemType:itemType];
    BOOL TaskIsScheduledStartAndVisible = [[[BoolDataObject alloc] init] TaskIsScheduledStartAndVisible:singleObjectItemDict itemType:itemType userID:userID];
    
    BOOL TaskIsFullyCompleted = [[[BoolDataObject alloc] init] TaskIsFullyCompleted:singleObjectItemDict itemType:itemType homeMembersDict:homeMembersDict];
    BOOL TaskIsPastDueIsUntilCompleted = [[[BoolDataObject alloc] init] TaskIsPastDueIsUntilCompleted:singleObjectItemDict itemType:itemType];
    
    BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:singleObjectItemDict itemType:itemType];
    
    BOOL TaskIsExpired = [[[BoolDataObject alloc] init] TaskIsExpired:singleObjectItemDict itemType:itemType homeMembersDict:homeMembersDict];
    BOOL TaskIsHiddenFromUser = [[[BoolDataObject alloc] init] TaskIsHiddenFromUser:singleObjectItemDict itemType:itemType userID:userID];
    BOOL TaskIsDeleted = [[[BoolDataObject alloc] init] TaskIsDeleted:singleObjectItemDict itemType:itemType];
    
    
    
    BOOL ItemOccurrenceShouldShow =
    
    (TaskIsOccurrence == YES && TaskOccurrenceStatusIsNone == YES) &&
    (TaskIsScheduledStart == NO || TaskIsScheduledStartAndVisible == YES) &&
    (TaskIsPastDueIsUntilCompleted == NO || (TaskIsPastDueIsUntilCompleted == YES && TaskIsFullyCompleted == NO)) &&
    TaskIsTakingTurns == NO &&
    TaskIsFullyCompleted == NO &&
    TaskIsExpired == NO &&
    TaskIsHiddenFromUser == NO &&
    TaskIsDeleted == NO;
    
    
    
    BOOL TaskNonOccurrenceShouldShow =
    
    TaskIsOccurrence == NO &&
    (TaskIsScheduledStart == NO || TaskIsScheduledStartAndVisible == YES) &&
    TaskIsExpired == NO &&
    TaskIsHiddenFromUser == NO &&
    TaskIsDeleted == NO;
    
    

    BOOL TaskIsValid = (TaskNonOccurrenceShouldShow == YES || ItemOccurrenceShouldShow == YES);

    return TaskIsValid;
}

-(BOOL)TaskIsExpired:(NSMutableDictionary *)singleObjectItemDict itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    BOOL TaskIsPastDueIsUntilCompleted = [[[BoolDataObject alloc] init] TaskIsPastDueIsUntilCompleted:singleObjectItemDict itemType:itemType];
    BOOL TaskIsPastPastDueLimit = [[[BoolDataObject alloc] init] TaskIsPastPastDueLimit:singleObjectItemDict itemType:itemType];
    BOOL TaskHasAddMoreTime = [[[BoolDataObject alloc] init] TaskHasAddMoreTime:singleObjectItemDict itemType:itemType];
    BOOL TaskAddMoreTimeRejected = [[[BoolDataObject alloc] init] TaskAddMoreTimeRejected:singleObjectItemDict itemType:itemType];
    BOOL TaskIsPastAddMoreTimeLimit = [[[BoolDataObject alloc] init] TaskIsPastAddMoreTimeLimit:singleObjectItemDict itemType:itemType];
    BOOL TaskIsAddMoreTimeUnlimited = [[[BoolDataObject alloc] init] TaskIsAddMoreTimeUnlimited:singleObjectItemDict itemType:itemType];
    BOOL TaskHasNoDueDate = [[[BoolDataObject alloc] init] TaskHasNoDueDate:singleObjectItemDict itemType:itemType];
    
    BOOL TaskIsPastDueUntilCompletedAndIsFullyCompleted_OR_TaskIsNotPastDueUntilCompletedAndTaskIsPastPastDueTimne
    = ((TaskHasNoDueDate == NO && TaskIsPastDueIsUntilCompleted == NO && TaskIsPastPastDueLimit == YES && TaskHasAddMoreTime == NO) ||
       (TaskHasNoDueDate == NO && TaskIsPastDueIsUntilCompleted == NO && TaskIsPastPastDueLimit == YES && TaskHasAddMoreTime == YES && TaskAddMoreTimeRejected == YES && TaskIsAddMoreTimeUnlimited == NO) ||
       (TaskHasNoDueDate == NO && TaskIsPastDueIsUntilCompleted == NO && TaskIsPastPastDueLimit == YES && TaskHasAddMoreTime == YES && TaskAddMoreTimeRejected == NO && TaskIsPastAddMoreTimeLimit == YES && TaskIsAddMoreTimeUnlimited == NO));
    
    return TaskIsPastDueUntilCompletedAndIsFullyCompleted_OR_TaskIsNotPastDueUntilCompletedAndTaskIsPastPastDueTimne;
}

-(BOOL)TaskIsScheduledStartAndVisible:(NSMutableDictionary *)singleObjectItemDict itemType:(NSString *)itemType userID:(NSString *)userID {
    
    BOOL TaskIsCreatedByMe = [[[BoolDataObject alloc] init] TaskWasCreatedBySpecificUser:singleObjectItemDict itemType:itemType userID:userID];
    
    BOOL TaskIsScheduledStart = [[[BoolDataObject alloc] init] TaskIsScheduledStart:singleObjectItemDict itemType:itemType];
    BOOL TaskIsScheduledStartHasPassed = [[[BoolDataObject alloc] init] TaskIsScheduledStartHasPassed:singleObjectItemDict itemType:itemType];
    
    BOOL TaskIsScheduledToStartAndHasNotStartedYetButYouAreTheCreator_OR_TaskIsScheduledToStartAndHasNotStartedYetAndYouAreNotTheCreator =
    ((TaskIsScheduledStart == YES && TaskIsCreatedByMe == YES) ||
     (TaskIsScheduledStart == YES && TaskIsScheduledStartHasPassed == YES));
    
    return TaskIsScheduledToStartAndHasNotStartedYetButYouAreTheCreator_OR_TaskIsScheduledToStartAndHasNotStartedYetAndYouAreNotTheCreator;
}

-(BOOL)TaskIsHiddenFromUser:(NSMutableDictionary *)singleObjectItemDict itemType:(NSString *)itemType userID:(NSString *)userID {
    
    BOOL TaskIsAssignedToMe = [[[BoolDataObject alloc] init] TaskWasAssignedToSpecificUser:singleObjectItemDict itemType:itemType userID:userID];
    BOOL TaskIsCreatedByMe = [[[BoolDataObject alloc] init] TaskWasCreatedBySpecificUser:singleObjectItemDict itemType:itemType userID:userID];
    BOOL TaskIsAssignedToNobody = [[[BoolDataObject alloc] init] TaskIsAssignedToNobody:singleObjectItemDict itemType:itemType];
    BOOL TaskIsPrivate = [[[BoolDataObject alloc] init] TaskIsPrivate:singleObjectItemDict itemType:itemType];

    BOOL TaskIsHiddenFromThisUser = (TaskIsPrivate == YES && TaskIsCreatedByMe == NO && TaskIsAssignedToMe == NO && TaskIsAssignedToNobody == NO);
    
    return TaskIsHiddenFromThisUser;
}

#pragma mark

-(BOOL)SubtaskCanBeCompletedBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID subtask:(NSString *)subtask homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    BOOL TaskIsAList = [[[BoolDataObject alloc] init] TaskIsList:itemDict itemType:itemType];
    BOOL TaskIsItemized = [[[BoolDataObject alloc] init] TaskIsItemized:itemDict itemType:itemType];
    BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:itemDict itemType:itemType];
    BOOL TaskIsSpecificUsersTurn = [[[BoolDataObject alloc] init] TaskIsSpecificUsersTurn:itemDict itemType:itemType userID:userID homeMembersDict:homeMembersDict];
    BOOL TaskIsAssignedToMe = [[[BoolDataObject alloc] init] TaskWasAssignedToSpecificUser:itemDict itemType:itemType userID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    BOOL TaskIsCreatedByMe = [[[BoolDataObject alloc] init] TaskWasCreatedBySpecificUser:itemDict itemType:itemType userID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    BOOL SubtaskIsAssignedToAnybody = [[[BoolDataObject alloc] init] SubtaskIsAssignedToAnybody:itemDict itemType:itemType subtask:subtask];
    BOOL SubtaskAssignedToSpecificUser = [[[BoolDataObject alloc] init] SubtaskAssignedToSpecificUser:itemDict itemType:itemType subtask:subtask userID:userID];
    BOOL TaskIsAssignedToNobody = [[[BoolDataObject alloc] init] TaskIsAssignedToNobody:itemDict itemType:itemType];
    
    BOOL TaskMustBeCompletedByEveryoneAssigned = [[[BoolDataObject alloc] init] TaskMustBeCompletedByEveryoneAssigned:itemDict itemType:itemType];
    BOOL TaskWasCompletedByMe = [[[BoolDataObject alloc] init] TaskCompletedBySpecificUser:itemDict itemType:itemType userID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    BOOL TaskMinimumCompletionsMet = [[[BoolDataObject alloc] init] TaskCompletedByMinimumUsers:itemDict itemType:itemType homeMembersDict:homeMembersDict];
    
    //    BOOL SubtaskIsCompleted = [[[BoolDataObject alloc] init] SubtaskIsCompleted:itemDict itemType:itemType subtask:subtask];
    //    BOOL SubtaskIsCompletedBySpecificUser = [[[BoolDataObject alloc] init] SubtaskCompletedBySpecificUser:itemDict itemType:itemType subtask:subtask userID:userID];
    //    BOOL SubtaskIsInProgress = [[[BoolDataObject alloc] init] SubtaskIsInProgress:itemDict itemType:itemType subtask:subtask];
    //    BOOL SubtaskInProgressBySpecificUser = [[[BoolDataObject alloc] init] SubtaskInProgressBySpecificUser:itemDict itemType:itemType subtask:subtask userID:userID];
    //    BOOL SubtaskIsWontDo = [[[BoolDataObject alloc] init] SubtaskIsIWontDo:itemDict itemType:itemType subtask:subtask];
    //    BOOL SubtaskWontDoBySpecificUser = [[[BoolDataObject alloc] init] SubtaskWontDoBySpecificUser:itemDict itemType:itemType subtask:subtask userID:userID];
    
    BOOL SubtaskHasBeenAssignedToMeAndMustBeCompletedByEveryone = (TaskIsAList == NO &&
                                                                   TaskIsItemized == NO &&
                                                                   
                                                                   TaskMustBeCompletedByEveryoneAssigned == YES &&
                                                                   
                                                                   (SubtaskIsAssignedToAnybody == YES ||
                                                                    SubtaskAssignedToSpecificUser == YES ||
                                                                    SubtaskAssignedToSpecificUser == NO) &&
                                                                   
                                                                   (TaskIsTakingTurns == NO ||
                                                                    (TaskIsTakingTurns == YES &&
                                                                     (TaskIsSpecificUsersTurn == YES || TaskIsSpecificUsersTurn == NO))));
    
    //    (TaskIsAList == NO &&
    //     TaskIsItemized == NO &&
    //     TaskMustBeCompletedByEveryoneAssigned == YES &&
    //     (SubtaskIsAssignedToAnybody == YES || SubtaskAssignedToSpecificUser == YES) &&
    //     (TaskIsTakingTurns == NO || (TaskIsTakingTurns == YES && TaskIsSpecificUsersTurn == YES)));
    
    BOOL SubtaskHasBeenAssignedToMeAndMustBeCompletedByAMinimumNumberOfPeopleAndHasNotBeenYet = (TaskIsAList == NO &&
                                                                                                 TaskIsItemized == NO &&
                                                                                                 
                                                                                                 TaskMustBeCompletedByEveryoneAssigned == NO &&
                                                                                                 
                                                                                                 TaskMinimumCompletionsMet == NO &&
                                                                                                 
                                                                                                 (SubtaskIsAssignedToAnybody == YES ||
                                                                                                  SubtaskAssignedToSpecificUser == YES ||
                                                                                                  SubtaskAssignedToSpecificUser == NO) &&
                                                                                                 
                                                                                                 (TaskIsTakingTurns == NO ||
                                                                                                  (TaskIsTakingTurns == YES &&
                                                                                                   (TaskIsSpecificUsersTurn == YES || TaskIsSpecificUsersTurn == NO))));
    
    //    (TaskIsAList == NO &&
    //     TaskIsItemized == NO &&
    //     TaskMustBeCompletedByEveryoneAssigned == NO &&
    //     TaskMinimumCompletionsMet == NO &&
    //     (SubtaskIsAssignedToAnybody == YES || SubtaskAssignedToSpecificUser == YES) &&
    //     (TaskIsTakingTurns == NO || (TaskIsTakingTurns == YES && TaskIsSpecificUsersTurn == YES)));
    
    BOOL SubtaskHasBeenAssignedToMeAndMustBeCompletedByAMinimumNumberOfPeopleAndHasAndIAmOneOfThem = (TaskIsAList == NO &&
                                                                                                      TaskIsItemized == NO &&
                                                                                                      
                                                                                                      TaskMustBeCompletedByEveryoneAssigned == NO &&
                                                                                                      
                                                                                                      TaskMinimumCompletionsMet == YES &&
                                                                                                      
                                                                                                      TaskWasCompletedByMe == YES &&
                                                                                                      
                                                                                                      (SubtaskIsAssignedToAnybody == YES ||
                                                                                                       SubtaskAssignedToSpecificUser == YES ||
                                                                                                       SubtaskAssignedToSpecificUser == NO) &&
                                                                                                      
                                                                                                      (TaskIsTakingTurns == NO ||
                                                                                                       (TaskIsTakingTurns == YES &&
                                                                                                        (TaskIsSpecificUsersTurn == YES || TaskIsSpecificUsersTurn == NO))));
    
    //    (TaskIsAList == NO &&
    //     TaskIsItemized == NO &&
    //     TaskMustBeCompletedByEveryoneAssigned == NO &&
    //     TaskMinimumCompletionsMet == YES &&
    //     TaskWasCompletedByMe == YES &&
    //     (SubtaskIsAssignedToAnybody == YES || SubtaskAssignedToSpecificUser == YES) &&
    //     (TaskIsTakingTurns == NO || (TaskIsTakingTurns == YES && TaskIsSpecificUsersTurn == YES)));
    
    BOOL SubtaskIsAssignedOrCreatedByMe = (TaskIsAssignedToMe == YES || TaskIsCreatedByMe == YES);
    //BOOL SubtaskIsCompletedOrInProgressBySomeoneElse = ((SubtaskIsCompleted == YES && SubtaskIsCompletedBySpecificUser == NO) || (SubtaskIsInProgress == YES && SubtaskInProgressBySpecificUser == NO));
    
    if ((SubtaskIsAssignedOrCreatedByMe == YES || SubtaskIsAssignedOrCreatedByMe == NO || TaskIsAssignedToNobody == YES)) { //if ((SubtaskIsAssignedOrCreatedByMe == YES || TaskIsAssignedToNobody == YES) && SubtaskIsCompletedOrInProgressBySomeoneElse == NO) {
        
        if (SubtaskHasBeenAssignedToMeAndMustBeCompletedByEveryone == YES ||
            SubtaskHasBeenAssignedToMeAndMustBeCompletedByAMinimumNumberOfPeopleAndHasNotBeenYet == YES ||
            SubtaskHasBeenAssignedToMeAndMustBeCompletedByAMinimumNumberOfPeopleAndHasAndIAmOneOfThem == YES) {
            return YES;
        }
        
    }
    
    return NO;
}

#pragma mark

-(BOOL)ListItemCanBeCompletedBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID listItem:(NSString *)listItem {
    
    BOOL TaskIsAList = [[[BoolDataObject alloc] init] TaskIsList:itemDict itemType:itemType];
    BOOL TaskIsAssignedToMe = [[[BoolDataObject alloc] init] TaskWasAssignedToSpecificUser:itemDict itemType:itemType userID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    BOOL TaskIsCreatedByMe = [[[BoolDataObject alloc] init] TaskWasCreatedBySpecificUser:itemDict itemType:itemType userID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    
    //    BOOL ListItemIsCompleted = [[[BoolDataObject alloc] init] ListItemIsCompleted:itemDict itemType:itemType listItem:listItem];
    //    BOOL ListItemIsCompletedBySpecificUser = [[[BoolDataObject alloc] init] ListItemIsCompletedBySpecificUser:itemDict itemType:itemType listItem:listItem userID:userID];
    //    BOOL ListItemIsInProgress = [[[BoolDataObject alloc] init] ListItemIsInProgress:itemDict itemType:itemType listItem:listItem];
    //    BOOL ListItemInProgressBySpecificUser = [[[BoolDataObject alloc] init] ListItemIsInProgressBySpecificUser:itemDict itemType:itemType listItem:listItem userID:userID];
    //    BOOL ListItemIsWontDo = [[[BoolDataObject alloc] init] ListItemIsWontDo:itemDict itemType:itemType listItem:listItem];
    //    BOOL ListItemIsWontDoBySpecificUser = [[[BoolDataObject alloc] init] ListItemIsInProgress:itemDict itemType:itemType listItem:listItem userID:userID];
    
    BOOL ListItemIsAssignedOrCreatedByMe = (TaskIsAssignedToMe == YES || TaskIsCreatedByMe == YES);
    //BOOL ListItemIsCompletedOrInProgressBySomeoneElse = ((ListItemIsCompleted == YES && ListItemIsCompletedBySpecificUser == NO) || (ListItemIsInProgress == YES && ListItemInProgressBySpecificUser == NO) || (ListItemIsWontDo == YES && ListItemIsWontDoBySpecificUser == NO));
    
    BOOL ListItemIsAssignedToNewHomeMembers = [[[BoolDataObject alloc] init] ListItemIsAssignedToNewHomeMembers:itemDict itemType:itemType listItem:listItem];
    BOOL ListItemIsAssignedToSpecificUser = [[[BoolDataObject alloc] init] ListItemAssignedToSpecificUser:itemDict itemType:itemType listItem:listItem userID:userID];
    BOOL TaskIsAssignedToNobody = [[[BoolDataObject alloc] init] TaskIsAssignedToNobody:itemDict itemType:itemType];
    
    if (TaskIsAList == YES && (ListItemIsAssignedOrCreatedByMe == YES || ListItemIsAssignedOrCreatedByMe == NO || TaskIsAssignedToNobody == YES)) { //if (TaskIsAList == YES && (ListItemIsAssignedOrCreatedByMe == YES || TaskIsAssignedToNobody == YES) && ListItemIsCompletedOrInProgressBySomeoneElse == NO) {
        
        if (ListItemIsAssignedToNewHomeMembers == YES || ListItemIsAssignedToSpecificUser == YES || ListItemIsAssignedToSpecificUser == NO) { //if (ListItemIsAssignedToNewHomeMembers == YES || ListItemIsAssignedToSpecificUser == YES) {
            return YES;
        }
        
    }
    
    return NO;
}

#pragma mark

-(BOOL)ItemizedItemCanBeCompletedBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID itemizedItem:(NSString *)itemizedItem {
    
    BOOL TaskIsAItemized = [[[BoolDataObject alloc] init] TaskIsItemized:itemDict itemType:itemType];
    BOOL TaskIsAssignedToMe = [[[BoolDataObject alloc] init] TaskWasAssignedToSpecificUser:itemDict itemType:itemType userID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    BOOL TaskIsCreatedByMe = [[[BoolDataObject alloc] init] TaskWasCreatedBySpecificUser:itemDict itemType:itemType userID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    
    //    BOOL ItemizedItemIsCompleted = [[[BoolDataObject alloc] init] ItemizedItemIsCompleted:itemDict itemType:itemType ItemizedItem:ItemizedItem];
    //    BOOL ItemizedItemIsCompletedBySpecificUser = [[[BoolDataObject alloc] init] ItemizedItemIsCompletedBySpecificUser:itemDict itemType:itemType ItemizedItem:ItemizedItem userID:userID];
    //    BOOL ItemizedItemIsInProgress = [[[BoolDataObject alloc] init] ItemizedItemIsInProgress:itemDict itemType:itemType ItemizedItem:ItemizedItem];
    //    BOOL ItemizedItemInProgressBySpecificUser = [[[BoolDataObject alloc] init] ItemizedItemIsInProgressBySpecificUser:itemDict itemType:itemType ItemizedItem:ItemizedItem userID:userID];
    //    BOOL ItemizedItemIsWontDo = [[[BoolDataObject alloc] init] ItemizedItemIsWontDo:itemDict itemType:itemType itemizedItem:itemizedItem];
    //    BOOL ItemizedItemIsWontDoBySpecificUser = [[[BoolDataObject alloc] init] ItemizedItemIsInProgress:itemDict itemType:itemType itemizedItem:itemizedItem userID:userID];
    
    BOOL ItemizedItemIsAssignedOrCreatedByMe = (TaskIsAssignedToMe == YES || TaskIsCreatedByMe == YES);
    //BOOL ItemizedItemIsCompletedOrInProgressBySomeoneElse = ((ItemizedItemIsCompleted == YES && ItemizedItemIsCompletedBySpecificUser == NO) || (ItemizedItemIsInProgress == YES && ItemizedItemInProgressBySpecificUser == NO) || (ItemizedItemIsWontDo == YES && ItemizedItemIsWontDoBySpecificUser == NO));
    
    BOOL ItemizedItemIsAssignedToNewHomeMembers = [[[BoolDataObject alloc] init] ItemizedItemIsAssignedToNewHomeMembers:itemDict itemType:itemType itemizedItem:itemizedItem];
    BOOL ItemizedItemIsAssignedToSpecificUser = [[[BoolDataObject alloc] init] ItemizedItemAssignedToSpecificUser:itemDict itemType:itemType itemizedItem:itemizedItem userID:userID];
    BOOL TaskIsAssignedToNobody = [[[BoolDataObject alloc] init] TaskIsAssignedToNobody:itemDict itemType:itemType];
    
    if (TaskIsAItemized == YES && (ItemizedItemIsAssignedOrCreatedByMe == YES || ItemizedItemIsAssignedOrCreatedByMe == NO || TaskIsAssignedToNobody == YES)) { //if (TaskIsAItemized == YES && (ItemizedItemIsAssignedOrCreatedByMe == YES || TaskIsAssignedToNobody == YES) && ItemizedItemIsCompletedOrInProgressBySomeoneElse == NO) {
        
        if (ItemizedItemIsAssignedToNewHomeMembers == YES || ItemizedItemIsAssignedToSpecificUser == YES || ItemizedItemIsAssignedToSpecificUser == NO) { //if (ItemizedItemIsAssignedToNewHomeMembers == YES || ItemizedItemIsAssignedToSpecificUser == YES) {
            return YES;
        }
        
    }
    
    return NO;
}

#pragma mark

-(BOOL)SpecificUserShouldDisplayDeactivatedColor:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:itemDict itemType:itemType];
    BOOL TaskIsSpecificUsersTurn = [[[BoolDataObject alloc] init] TaskIsSpecificUsersTurn:itemDict itemType:itemType userID:userID homeMembersDict:homeMembersDict];
    BOOL TaskIsAList = [[[BoolDataObject alloc] init] TaskIsList:itemDict itemType:itemType];
    BOOL TaskIsItemized = [[[BoolDataObject alloc] init] TaskIsItemized:itemDict itemType:itemType];
    
    BOOL TaskMustBeCompletedByEveryoneAssigned = [[[BoolDataObject alloc] init] TaskMustBeCompletedByEveryoneAssigned:itemDict itemType:itemType];
    BOOL TaskWasCompletedBySpecficUser = [[[BoolDataObject alloc] init] TaskCompletedBySpecificUser:itemDict itemType:itemType userID:userID];
    BOOL TaskMinimumCompletionsMet = [[[BoolDataObject alloc] init] TaskCompletedByMinimumUsers:itemDict itemType:itemType homeMembersDict:homeMembersDict];
    
    BOOL TaskHasBeenAssignedToMeAndMustBeCompletedByEveryone = (TaskIsAList == NO &&
                                                                TaskIsItemized == NO &&
                                                                TaskMustBeCompletedByEveryoneAssigned == YES &&
                                                                (TaskIsTakingTurns == YES && TaskIsSpecificUsersTurn == NO));
    
    BOOL TaskHasBeenAssignedToMeAndMustBeCompletedByAMinimumNumberOfPeopleAndHasAndIAmOneOfThem = (TaskIsAList == NO &&
                                                                                                   TaskIsItemized == NO &&
                                                                                                   TaskMustBeCompletedByEveryoneAssigned == NO &&
                                                                                                   TaskIsTakingTurns == NO &&
                                                                                                   TaskMinimumCompletionsMet == YES &&
                                                                                                   TaskWasCompletedBySpecficUser == NO);
    
    if (TaskHasBeenAssignedToMeAndMustBeCompletedByEveryone == YES ||
        TaskHasBeenAssignedToMeAndMustBeCompletedByAMinimumNumberOfPeopleAndHasAndIAmOneOfThem == YES) {
        return YES;
    }
    
    return NO;
}

#pragma mark - Low Compound BOOLs

-(BOOL)TaskCompletedByMinimumUsers:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    BOOL TaskMustBeCompletedByEveryoneAssigned = [[[BoolDataObject alloc] init] TaskMustBeCompletedByEveryoneAssigned:itemDict itemType:itemType];
    
    if (TaskMustBeCompletedByEveryoneAssigned == NO) {
        
        NSMutableDictionary *itemCompletedDict = itemDict[@"ItemCompletedDict"] ? [itemDict[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableDictionary *itemWontDo = itemDict[@"ItemWontDo"] ? [itemDict[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
        NSString *itemMustCompleted = itemDict[@"ItemMustComplete"] ? itemDict[@"ItemMustComplete"] : @"";
        NSString *itemMustCompletedMinimumAmount = [itemMustCompleted containsString:@" "] && [[itemMustCompleted componentsSeparatedByString:@" "] count] > 1 ? [itemMustCompleted componentsSeparatedByString:@" "][1] : @"";
        
        itemCompletedDict = [[[GeneralObject alloc] init] GenerateObjectWithNonHomeMembersRemoved:[itemCompletedDict mutableCopy] homeMembersDict:homeMembersDict];
        itemWontDo = [[[GeneralObject alloc] init] GenerateObjectWithNonHomeMembersRemoved:[itemWontDo mutableCopy] homeMembersDict:homeMembersDict];
        
        if (([[itemCompletedDict allKeys] count] + [[itemWontDo allKeys] count]) >= [itemMustCompletedMinimumAmount intValue]) {
            return YES;
        }
        
    }
    
    return NO;
}

-(BOOL)TaskCompletedByCurrentUsersTurn:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:itemDict itemType:itemType];
    
    NSMutableDictionary *itemCompletedDict = itemDict[@"ItemCompletedDict"] ? [itemDict[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemWontDo = itemDict[@"ItemWontDo"] ? [itemDict[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    NSString *itemTurnUserID = [[[GeneralObject alloc] init] GenerateCurrentUserTurnFromDict:[itemDict mutableCopy] homeMembersDict:homeMembersDict itemType:itemType];
    
    if (TaskIsTakingTurns == YES) {
       
        NSString *currentUsersTurn = itemTurnUserID;
        
        if (([[itemCompletedDict allKeys] count] + [[itemWontDo allKeys] count]) >= 1) {
            
            if ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:currentUsersTurn] ||
                [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemWontDo userIDToFind:currentUsersTurn]) {
                
                return YES;
                
            }
            
        }
        
    }
    
    return NO;
}

-(BOOL)TaskEndHasPassed:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType numberOfTaskOccurrences:(int)numberOfTaskOccurrences {
    
    NSString *itemEndDate = itemDict[@"ItemEndDate"] ? itemDict[@"ItemEndDate"] : @"";
    
    BOOL ItemEndDateSelected = [[[BoolDataObject alloc] init] ItemEndDateSelected:itemDict itemType:itemType];
    
    if (ItemEndDateSelected == YES) {
        
        BOOL TaskEndIsNumberOfTimes = [[[BoolDataObject alloc] init] TaskEndIsNumberOfTimes:itemDict itemType:itemType];
        BOOL TaskEndIsSpecificDate = [[[BoolDataObject alloc] init] TaskEndIsSpecificDate:itemDict itemType:itemType];
       
        if (TaskEndIsNumberOfTimes == YES) {
          
            NSArray *numberOfTimesBeforeEndArr = [itemEndDate containsString:@" "] ? [itemEndDate componentsSeparatedByString:@" "] : @[];
            NSString *numberOfTimesBeforeEnd = [numberOfTimesBeforeEndArr count] > 1 ? numberOfTimesBeforeEndArr[1] : @"";
           
            if ([numberOfTimesBeforeEnd isEqualToString:@""] == NO &&
                numberOfTaskOccurrences > [numberOfTimesBeforeEnd intValue]) {
                return YES;
            }
            
        } else if (TaskEndIsSpecificDate == YES) {
            
            NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
            
            if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:itemEndDate returnAs:[NSDate class]] != nil) {
                
                NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
              
                NSString *currentDateString = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
                
                int secondsSinceEndDatePassed = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:itemEndDate dateString2:currentDateString dateFormat:dateFormat];
                
                if (secondsSinceEndDatePassed > 0) {
                    return YES;
                }
                
            }
            
        }
        
    }
   
    return NO;
}

#pragma mark

-(BOOL)SubtaskCompletedBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType subtask:(NSString *)subtask userID:(NSString *)userID {
    
    BOOL SubtaskIsCompleted = [[[BoolDataObject alloc] init] SubtaskIsCompleted:itemDict itemType:itemType subtask:subtask];
    
    NSMutableDictionary *itemSubtask = itemDict[@"ItemSubTasks"] ? [itemDict[@"ItemSubTasks"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if (SubtaskIsCompleted == YES) {
        
        if (itemSubtask[subtask]) {
            
            if (itemSubtask[subtask][@"Completed Dict"]) {
                
                if ([[itemSubtask[subtask][@"Completed Dict"] allKeys][0] isEqualToString:userID]) {
                    return YES;
                }
                
            }
            
        }
        
    }
    
    return NO;
}

-(BOOL)SubtaskInProgressBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType subtask:(NSString *)subtask userID:(NSString *)userID {
    
    BOOL SubtaskIsInProgress = [[[BoolDataObject alloc] init] SubtaskIsInProgress:itemDict itemType:itemType subtask:subtask];
    
    NSMutableDictionary *itemSubtask = itemDict[@"ItemSubTasks"] ? [itemDict[@"ItemSubTasks"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if (SubtaskIsInProgress == YES) {
        
        if (itemSubtask[subtask]) {
            
            if (itemSubtask[subtask][@"In Progress Dict"]) {
                
                if ([[itemSubtask[subtask][@"In Progress Dict"] allKeys][0] isEqualToString:userID]) {
                    return YES;
                }
                
            }
            
        }
        
    }
    
    return NO;
}

-(BOOL)SubtaskWontDoBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType subtask:(NSString *)subtask userID:(NSString *)userID {
    
    BOOL SubtaskIsInProgress = [[[BoolDataObject alloc] init] SubtaskIsInProgress:itemDict itemType:itemType subtask:subtask];
    
    NSMutableDictionary *itemSubtask = itemDict[@"ItemSubTasks"] ? [itemDict[@"ItemSubTasks"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if (SubtaskIsInProgress == YES) {
        
        if (itemSubtask[subtask]) {
            
            if (itemSubtask[subtask][@"Wont Do"]) {
                
                if ([[itemSubtask[subtask][@"Wont Do"] allKeys][0] isEqualToString:userID]) {
                    return YES;
                }
                
            }
            
        }
        
    }
    
    return NO;
}

-(BOOL)SubtaskAssignedToSpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType subtask:(NSString *)subtask userID:(NSString *)userID {
    
    BOOL SubtaskIsAssignedToAnybody = [[[BoolDataObject alloc] init] SubtaskIsAssignedToAnybody:itemDict itemType:itemType subtask:subtask];
    
    NSMutableDictionary *itemSubtask = itemDict[@"ItemSubTasks"] ? [itemDict[@"ItemSubTasks"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if (SubtaskIsAssignedToAnybody == NO) {
        
        if (itemSubtask[subtask]) {
            
            if (itemSubtask[subtask][@"Assigned To"]) {
                
                if ([itemSubtask[subtask][@"Assigned To"][0] isEqualToString:userID]) {
                    return YES;
                }
                
            }
            
        }
        
    }
    
    return NO;
}

#pragma mark

-(BOOL)ListItemIsCompletedBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType listItem:(NSString *)listItem userID:(NSString *)userID {
    
    BOOL ListItemIsCompleted = [[[BoolDataObject alloc] init] ListItemIsCompleted:itemDict itemType:itemType listItem:listItem];
    
    NSMutableDictionary *itemListItems = itemDict[@"ItemListItems"] ? [itemDict[@"ItemListItems"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if (ListItemIsCompleted == YES) {
        
        if (itemListItems[listItem]) {
            
            if (itemListItems[listItem][@"Status"]) {
                
                if ([itemListItems[listItem][@"Status"] isEqualToString:userID]) {
                    
                    return YES;
                    
                }
                
            }
            
        }
        
    }
    
    return NO;
}

-(BOOL)ListItemIsInProgressBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType listItem:(NSString *)listItem userID:(NSString *)userID {
    
    BOOL ListItemIsInProgress = [[[BoolDataObject alloc] init] ListItemIsInProgress:itemDict itemType:itemType listItem:listItem];
    
    NSMutableDictionary *itemListItems = itemDict[@"ItemListItems"] ? [itemDict[@"ItemListItems"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if (ListItemIsInProgress == YES) {
        
        if (itemListItems[listItem]) {
            
            if (itemListItems[listItem][@"Status"]) {
                
                if ([itemListItems[listItem][@"Status"] isEqualToString:userID]) {
                    
                    return YES;
                    
                }
                
            }
            
        }
        
    }
    
    return NO;
}

-(BOOL)ListItemIsWontDoBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType listItem:(NSString *)listItem userID:(NSString *)userID {
    
    BOOL ListItemIsCompleted = [[[BoolDataObject alloc] init] ListItemIsWontDo:itemDict itemType:itemType listItem:listItem];
    
    NSMutableDictionary *itemListItems = itemDict[@"ItemListItems"] ? [itemDict[@"ItemListItems"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if (ListItemIsCompleted == YES) {
        
        if (itemListItems[listItem]) {
            
            if (itemListItems[listItem][@"Status"]) {
                
                if ([itemListItems[listItem][@"Status"] isEqualToString:userID]) {
                    
                    return YES;
                    
                }
                
            }
            
        }
        
    }
    
    return NO;
}

-(BOOL)ListItemAssignedToSpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType listItem:(NSString *)listItem userID:(NSString *)userID {
    
    BOOL ListItemIsAssignedToNewHomeMembers = [[[BoolDataObject alloc] init] ListItemIsAssignedToNewHomeMembers:itemDict itemType:itemType listItem:listItem];
    
    NSMutableDictionary *itemListItem = itemDict[@"ItemListItems"] ? [itemDict[@"ItemListItems"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if (ListItemIsAssignedToNewHomeMembers == NO) {
        
        if (itemListItem[listItem]) {
            
            if (itemListItem[listItem][@"Assigned To"]) {
                
                if ([itemListItem[listItem][@"Assigned To"][0] isEqualToString:userID]) {
                    return YES;
                }
                
            }
            
        }
        
    }
    
    return NO;
}

#pragma mark

-(BOOL)ItemizedItemIsCompletedBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType itemizedItem:(NSString *)itemizedItem userID:(NSString *)userID {
    
    BOOL ItemizedItemIsCompleted = [[[BoolDataObject alloc] init] ItemizedItemIsCompleted:itemDict itemType:itemType itemizedItem:itemizedItem];
    
    NSMutableDictionary *itemItemizedItems = itemDict[@"ItemItemizedItems"] ? [itemDict[@"ItemItemizedItems"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if (ItemizedItemIsCompleted == YES) {
        
        if (itemItemizedItems[itemizedItem]) {
            
            if (itemItemizedItems[itemizedItem][@"Status"]) {
                
                if ([itemItemizedItems[itemizedItem][@"Status"] isEqualToString:userID]) {
                    
                    return YES;
                    
                }
                
            }
            
        }
        
    }
    
    return NO;
}

-(BOOL)ItemizedItemIsInProgressBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType itemizedItem:(NSString *)itemizedItem userID:(NSString *)userID {
    
    BOOL ItemizedItemIsInProgress = [[[BoolDataObject alloc] init] ItemizedItemIsInProgress:itemDict itemType:itemType itemizedItem:itemizedItem];
    
    NSMutableDictionary *itemItemizedItems = itemDict[@"ItemItemizedItems"] ? [itemDict[@"ItemItemizedItems"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if (ItemizedItemIsInProgress == YES) {
        
        if (itemItemizedItems[itemizedItem]) {
            
            if (itemItemizedItems[itemizedItem][@"Status"]) {
                
                if ([itemItemizedItems[itemizedItem][@"Status"] isEqualToString:userID]) {
                    
                    return YES;
                    
                }
                
            }
            
        }
        
    }
    
    return NO;
}

-(BOOL)ItemizedItemIsWontDoBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType itemizedItem:(NSString *)itemizedItem userID:(NSString *)userID {
    
    BOOL ItemizedItemIsInProgress = [[[BoolDataObject alloc] init] ItemizedItemIsWontDo:itemDict itemType:itemType itemizedItem:itemizedItem];
    
    NSMutableDictionary *itemItemizedItems = itemDict[@"ItemItemizedItems"] ? [itemDict[@"ItemItemizedItems"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if (ItemizedItemIsInProgress == YES) {
        
        if (itemItemizedItems[itemizedItem]) {
            
            if (itemItemizedItems[itemizedItem][@"Status"]) {
                
                if ([itemItemizedItems[itemizedItem][@"Status"] isEqualToString:userID]) {
                    
                    return YES;
                    
                }
                
            }
            
        }
        
    }
    
    return NO;
}

-(BOOL)ItemizedItemAssignedToSpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType itemizedItem:(NSString *)itemizedItem userID:(NSString *)userID {
    
    BOOL ItemizedItemIsAssignedToNewHomeMembers = [[[BoolDataObject alloc] init] ItemizedItemIsAssignedToNewHomeMembers:itemDict itemType:itemType itemizedItem:itemizedItem];
    
    NSMutableDictionary *itemItemizedItems = itemDict[@"ItemItemizedItems"] ? [itemDict[@"ItemItemizedItems"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if (ItemizedItemIsAssignedToNewHomeMembers == NO) {
        
        if (itemItemizedItems[itemizedItem]) {
            
            if (itemItemizedItems[itemizedItem][@"Assigned To"]) {
                
                if ([itemItemizedItems[itemizedItem][@"Assigned To"][0] isEqualToString:userID]) {
                    return YES;
                }
                
            }
            
        }
        
    }
    
    return NO;
}

#pragma mark - Simple BOOLs

-(BOOL)TaskHasGracePeriod:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemGracePeriod = itemDict[@"ItemGracePeriod"] ? itemDict[@"ItemGracePeriod"] : @"";
    
    if ([itemGracePeriod isEqualToString:@"None"] == NO && itemGracePeriod.length > 0) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsOccurrence:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemOccurrenceID = itemDict[@"ItemOccurrenceID"] ? itemDict[@"ItemOccurrenceID"] : @"xxx";
    
    if (itemOccurrenceID.length > 0 && [itemOccurrenceID isEqualToString:@"xxx"] == NO) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskOccurrenceStatusIsNone:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemOccurrenceStatus = itemDict[@"ItemOccurrenceStatus"] ? itemDict[@"ItemOccurrenceStatus"] : @"xxx";
    
    if ([itemOccurrenceStatus isEqualToString:@"None"]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsPaused:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemStatus = itemDict[@"ItemStatus"] ? itemDict[@"ItemStatus"] : @"None";
    
    if ([itemStatus isEqualToString:@"Paused"]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsPinned:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSMutableArray *pinnedItemsArray = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"PinnedItems%@", itemType]] ?
    [[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"PinnedItems%@", itemType]] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSString *itemID = itemDict[@"ItemID"] ? itemDict[@"ItemID"] : @"";
    
    if ([pinnedItemsArray containsObject:itemID]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsList:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    if ([itemType isEqualToString:@"List"]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsItemized:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemItemized = itemDict[@"ItemItemized"] ? itemDict[@"ItemItemized"] : @"";
    
    if ([itemType isEqualToString:@"Expense"]) {
        if ([itemItemized isEqualToString:@"Yes"]) {
            return YES;
        }
    }
    
    return NO;
}

-(BOOL)TaskHasTime:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemTime = itemDict[@"ItemTime"] ? itemDict[@"ItemTime"] : @"";
    
    if (itemTime.length > 0) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskHasReminder:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSDictionary *itemReminderDict = itemDict[@"ItemReminderDict"] ? itemDict[@"ItemReminderDict"] : @{};
    
    if ([[itemReminderDict allKeys] count] > 0) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskHasSelfDestruct:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemSelfDestruct = itemDict[@"ItemSelfDestruct"] ? itemDict[@"ItemSelfDestruct"] : @"";
    
    if ([itemSelfDestruct isEqualToString:@"Never"] == NO && itemSelfDestruct.length > 0) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskHasEstimatedTime:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemEstimatedTime = itemDict[@"ItemEstimatedTime"] ? itemDict[@"ItemEstimatedTime"] : @"";
    
    if ([itemEstimatedTime isEqualToString:@"None"] == NO && itemEstimatedTime.length > 0) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskHasColor:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemColor = itemDict[@"ItemColor"] ? itemDict[@"ItemColor"] : @"";
    
    if ([itemColor isEqualToString:@"None"] == NO && itemColor.length > 0) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskHasDifficulty:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemDifficulty = itemDict[@"ItemDifficulty"] ? itemDict[@"ItemDifficulty"] : @"";
    
    if ([itemDifficulty isEqualToString:@"None"] == NO && itemDifficulty.length > 0) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskHasPriority:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemPriority = itemDict[@"ItemPriority"] ? itemDict[@"ItemPriority"] : @"";
    
    if ([itemPriority isEqualToString:@"No Priority"] == NO && itemPriority.length > 0) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskHasAnyTime:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
//    BOOL TaskHasAnyDay = [[[BoolDataObject alloc] init] TaskHasAnyDay:itemDict itemType:itemType];
//    BOOL TaskHasMultipleDueDate =  [[[BoolDataObject alloc] init] TaskHasMultipleDueDate:[itemDict mutableCopy] itemType:itemType];
//    BOOL TaskHasNoDueDate = [[[BoolDataObject alloc] init] TaskHasNoDueDate:[itemDict mutableCopy] itemType:itemType];
//    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:[itemDict mutableCopy] itemType:itemType];
//    BOOL TaskIsRepeatingHourly = [[[BoolDataObject alloc] init] TaskIsRepeatingHourly:[itemDict mutableCopy] itemType:itemType];
//    BOOL TaskIsRepeatingDaily = [[[BoolDataObject alloc] init] TaskIsRepeatingDaily:[itemDict mutableCopy] itemType:itemType];
    
    NSString *itemTime = itemDict[@"ItemTime"] ? itemDict[@"ItemTime"] : @"";

    if (/*(TaskIsRepeating == YES && TaskIsRepeatingHourly == NO && TaskIsRepeatingDaily == NO && TaskHasAnyDay == YES) ||
        (TaskIsRepeating == YES && TaskIsRepeatingHourly == NO && [itemTime isEqualToString:@""]) ||
        (*/[itemTime isEqualToString:@"Any Time"] == YES)/*)*/ {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskHasAnyDay:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:itemDict itemType:itemType];
    BOOL TaskIsRepeatingWeekly = [[[BoolDataObject alloc] init] TaskIsRepeatingWeekly:itemDict itemType:itemType];
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:itemDict itemType:itemType];
    
    NSString *itemDays = itemDict[@"ItemDays"] ? itemDict[@"ItemDays"] : @"";
    
    if (([itemDays containsString:@"Any Day"] == YES || itemDays.length == 0) &&
        TaskIsRepeating == YES &&
        (TaskIsRepeatingWeekly == YES || TaskIsRepeatingMonthly == YES)) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsCompleteAsNeeded:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemRepeats = itemDict[@"ItemRepeats"] ? itemDict[@"ItemRepeats"] : @"";
    NSString *itemCompleteAsNeeded = itemDict[@"ItemCompleteAsNeeded"] ? itemDict[@"ItemCompleteAsNeeded"] : @"";
    
    BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemCompleteAsNeeded classArr:@[[NSString class]]];
    
    if (ObjectIsKindOfClass == YES) {
        
        if ([itemRepeats isEqualToString:@"As Needed"] || ([itemCompleteAsNeeded isEqualToString:@"Yes"] && itemCompleteAsNeeded.length > 0)) {
            return YES;
        }
        
    }
    
    return NO;
}

-(BOOL)TaskIsRepeating:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemRepeats = itemDict[@"ItemRepeats"] ? itemDict[@"ItemRepeats"] : @"";
    
    if ([itemRepeats isEqualToString:@"Never"] == NO && [itemRepeats isEqualToString:@"One-Time"] == NO /*&& [itemRepeats isEqualToString:@"As Needed"] == NO*/ && itemRepeats.length > 0) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsRepeatingInterval:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemRepeats = itemDict[@"ItemRepeats"] ? itemDict[@"ItemRepeats"] : @"";
    
    if ([itemRepeats containsString:@"Every Other"] ||
        [itemRepeats containsString:@"Every 1st"] ||
        [itemRepeats containsString:@"Every 2nd"] ||
        [itemRepeats containsString:@"Every 3rd"] ||
        [itemRepeats containsString:@"Every 4th"] ||
        [itemRepeats containsString:@"Every 5th"] ||
        [itemRepeats containsString:@"Every 6th"] ||
        [itemRepeats containsString:@"Every 7th"] ||
        [itemRepeats containsString:@"Every 8th"] ||
        [itemRepeats containsString:@"Every 9th"] ||
        [itemRepeats containsString:@"Every 10th"] ||
        [itemRepeats containsString:@"Every 11th"] ||
        [itemRepeats containsString:@"Every 12th"]) {
        return YES;
    }
    
    return NO;
}


-(BOOL)TaskIsRepeatingOneTime:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemRepeats = itemDict[@"ItemRepeats"] ? itemDict[@"ItemRepeats"] : @"";
    
    if ([itemRepeats containsString:@"One-Time"]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsRepeatingAsNeeded:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemRepeats = itemDict[@"ItemRepeats"] ? itemDict[@"ItemRepeats"] : @"";
    
    if ([itemRepeats containsString:@"As Needed"]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsRepeatingHourly:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemRepeats = itemDict[@"ItemRepeats"] ? itemDict[@"ItemRepeats"] : @"";
    
    if ([itemRepeats containsString:@"Hour"] || [itemRepeats containsString:@"Hourly"]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsRepeatingDaily:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemRepeats = itemDict[@"ItemRepeats"] ? itemDict[@"ItemRepeats"] : @"";
    
    if ([itemRepeats containsString:@"Day"] || [itemRepeats containsString:@"Daily"]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsRepeatingWeekly:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemRepeats = itemDict[@"ItemRepeats"] ? itemDict[@"ItemRepeats"] : @"";
    
    if ([itemRepeats containsString:@"Week"]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsRepeatingBiWeekly:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemRepeats = itemDict[@"ItemRepeats"] ? itemDict[@"ItemRepeats"] : @"";
    
    if ([itemRepeats containsString:@"Bi-Week"]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsRepeatingSemiMonthly:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemRepeats = itemDict[@"ItemRepeats"] ? itemDict[@"ItemRepeats"] : @"";
    
    if ([itemRepeats containsString:@"Semi-Month"]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsRepeatingMonthly:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemRepeats = itemDict[@"ItemRepeats"] ? itemDict[@"ItemRepeats"] : @"";
    
    if ([itemRepeats containsString:@"Month"]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsRepeatingWhenCompleted:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemRepeats = itemDict[@"ItemRepeats"] ? itemDict[@"ItemRepeats"] : @"";
    
    if ([itemRepeats containsString:@"When Completed"]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsRepeatingAndRepeatingIfCompletedEarly:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:itemDict itemType:itemType];
    BOOL TaskIsRepeatingAsNeeded = [[[BoolDataObject alloc] init] TaskIsRepeatingAsNeeded:itemDict itemType:itemType];
    BOOL TaskIsRepeatingWhenCompleted = [[[BoolDataObject alloc] init] TaskIsRepeatingWhenCompleted:itemDict itemType:itemType];
    
    NSString *itemRepeatIfCompletedEarly = itemDict[@"ItemRepeatIfCompletedEarly"] ? itemDict[@"ItemRepeatIfCompletedEarly"] : @"";
    
    if (TaskIsRepeating == YES &&
        TaskIsRepeatingAsNeeded == NO &&
        TaskIsRepeatingWhenCompleted == NO &&
        [itemRepeatIfCompletedEarly containsString:@"Yes"]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskHasNoDueDate:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemDueDate = itemDict[@"ItemDueDate"] ? itemDict[@"ItemDueDate"] : @"No Due Date";
    NSMutableArray *itemSpecificDueDates = itemDict[@"ItemSpecificDueDates"] ? [itemDict[@"ItemSpecificDueDates"] mutableCopy] : [NSMutableArray array];
    
    if (([itemDueDate containsString:@"No Due Date"] || itemDueDate.length == 0) && itemSpecificDueDates.count == 0) {
        
        return YES;
        
    }
    
    return NO;
}

-(BOOL)TaskHasMultipleDueDate:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:itemDict itemType:itemType];
  
    NSMutableArray *itemSpecificDueDates = itemDict[@"ItemSpecificDueDates"] ? [itemDict[@"ItemSpecificDueDates"] mutableCopy] : [NSMutableArray array];
    
    if (TaskIsRepeating == NO && [itemSpecificDueDates count] > 0) {
          
        return YES;
   
    }
    
    return NO;
}

-(BOOL)ItemStartDateSelected:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemStartDate = itemDict[@"ItemStartDate"] ? itemDict[@"ItemStartDate"] : @"";
    
    BOOL ItemIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:itemDict itemType:itemType];
    
    if ((itemStartDate.length > 0 &&
         [itemStartDate isEqualToString:@"(null)"] == NO) &&
        [itemStartDate containsString:@"Now"] == NO &&
        ItemIsRepeating == YES) {
        return YES;
    }
    
    return NO;
}

-(BOOL)ItemEndDateSelected:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemEndDate = itemDict[@"ItemEndDate"] ? itemDict[@"ItemEndDate"] : @"";
    
    BOOL ItemIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:itemDict itemType:itemType];
    
    if ((itemEndDate.length > 0 &&
         [itemEndDate isEqualToString:@"(null)"] == NO) &&
        [itemEndDate containsString:@"Never"] == NO &&
        ItemIsRepeating == YES) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskEndIsNumberOfTimes:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemEndDate = itemDict[@"ItemEndDate"] ? itemDict[@"ItemEndDate"] : @"";
    
    if ([itemEndDate containsString:@"After "] && [itemEndDate containsString:@" Time"]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskEndIsSpecificDate:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemEndDate = itemDict[@"ItemEndDate"] ? itemDict[@"ItemEndDate"] : @"";
    
    if ([itemEndDate containsString:@"After "]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsTakingTurns:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemTakeTurns = itemDict[@"ItemTakeTurns"] ? itemDict[@"ItemTakeTurns"] : @"";
   
    if ([itemTakeTurns isEqualToString:@"Yes"]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsPrivate:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemPrivate = itemDict[@"ItemPrivate"] ? itemDict[@"ItemPrivate"] : @"";
    
    if ([itemPrivate isEqualToString:@"Yes"]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsTrash:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemTrash = itemDict[@"ItemTrash"] ? itemDict[@"ItemTrash"] : @"";
    
    if ([itemTrash isEqualToString:@"Yes"]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsDeleted:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemDeleted = itemDict[@"ItemDeleted"] ? itemDict[@"ItemDeleted"] : @"";
    
    if ([itemDeleted isEqualToString:@"Yes"]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsSpecificUsersTurn:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    NSString *itemTurnUserID = itemDict[@"ItemTurnUserID"] ? itemDict[@"ItemTurnUserID"] : @"";
    
    NSString *userIDWhosTurn = itemTurnUserID;
    
    if ([userID isEqualToString:userIDWhosTurn]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsSpecificUsersTurnNext:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID {

    NSMutableArray *itemAssignedTo = itemDict[@"ItemAssignedTo"] ? itemDict[@"ItemAssignedTo"] : [NSMutableArray array];
    NSString *itemTurnUserID = itemDict[@"ItemTurnUserID"] ? itemDict[@"ItemTurnUserID"] : @"";
    NSString *itemTakeTurns = itemDict[@"ItemTakeTurns"] ? itemDict[@"ItemTakeTurns"] : @"";
    
    if (itemTurnUserID.length > 0 &&
        [itemTakeTurns isEqualToString:@"Yes"] &&
        [itemAssignedTo containsObject:itemTurnUserID]) {
        
        NSUInteger indexOfUsersTurn = [itemAssignedTo indexOfObject:itemTurnUserID];
        NSUInteger indexOfUsersTurnNext =
        indexOfUsersTurn == itemAssignedTo.count-1 ?
        0 : indexOfUsersTurn + 1;
        
        if ([itemAssignedTo count] > indexOfUsersTurnNext &&
            [itemAssignedTo[indexOfUsersTurnNext] isEqualToString:userID]) {
            return YES;
        }
        
    }
    
    return NO;
}

-(BOOL)TaskMustBeCompletedByEveryoneAssigned:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemMustComplete = itemDict[@"ItemMustComplete"] ? itemDict[@"ItemMustComplete"] : @"";
    
    if ([itemMustComplete isEqualToString:@"Everyone"] || [itemMustComplete isEqualToString:@""] || itemMustComplete == NULL) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskCompletedByAllHomeMembers:(NSMutableDictionary *)itemDict homeMembersDict:(NSMutableDictionary *)homeMembersDict {
   
    if (itemDict[@"ItemCompletedDict"] && homeMembersDict[@"UserID"]) {

        NSMutableDictionary *itemCompletedDict = itemDict[@"ItemCompletedDict"] ? [itemDict[@"ItemCompletedDict"] mutableCopy] : [NSMutableArray array];
        
        itemCompletedDict = [[[GeneralObject alloc] init] GenerateObjectWithNonHomeMembersRemoved:[itemCompletedDict mutableCopy] homeMembersDict:homeMembersDict];
        
        return [[itemCompletedDict allKeys] count] >= [(NSArray *)homeMembersDict[@"UserID"] count];
        
    }
    
    return NO;
}

-(BOOL)TaskCompletedByAllAssignedUsers:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    NSMutableArray *itemAssignedTo = itemDict[@"ItemAssignedTo"] ? [itemDict[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    NSMutableDictionary *itemCompletedDict = itemDict[@"ItemCompletedDict"] ? [itemDict[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemWontDo = itemDict[@"ItemWontDo"] ? [itemDict[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    
    BOOL CompletedObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemCompletedDict classArr:@[[NSDictionary class], [NSMutableDictionary class]]];
    BOOL WontDoObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemWontDo classArr:@[[NSDictionary class], [NSMutableDictionary class]]];
    BOOL AssignedToObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemAssignedTo classArr:@[[NSArray class], [NSMutableArray class]]];
 
    if ((CompletedObjectIsKindOfClass == YES) &&
        (WontDoObjectIsKindOfClass == YES) &&
        (AssignedToObjectIsKindOfClass == YES)) {

        itemAssignedTo = [[[GeneralObject alloc] init] GenerateObjectWithNonHomeMembersRemoved:[itemAssignedTo mutableCopy] homeMembersDict:homeMembersDict];
        itemCompletedDict = [[[GeneralObject alloc] init] GenerateObjectWithNonHomeMembersRemoved:[itemCompletedDict mutableCopy] homeMembersDict:homeMembersDict];
        itemWontDo = [[[GeneralObject alloc] init] GenerateObjectWithNonHomeMembersRemoved:[itemWontDo mutableCopy] homeMembersDict:homeMembersDict];
        
        if (([[itemCompletedDict allKeys] count] + [[itemWontDo allKeys] count]) >= itemAssignedTo.count) {
            return YES;
        }
        
    }
    
    return NO;
}

-(BOOL)TaskCompletedBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID {
    
    NSMutableDictionary *itemCompletedDict = itemDict[@"ItemCompletedDict"] ? [itemDict[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemWontDo = itemDict[@"ItemWontDo"] ? [itemDict[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:userID] ||
        [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemWontDo userIDToFind:userID]) {
        
        return YES;
        
    }
    
    return NO;
}

-(BOOL)TaskInProgressBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID {
    
    NSMutableDictionary *itemInProgressDict = itemDict[@"ItemInProgressDict"] ? [itemDict[@"ItemInProgressDict"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemInProgressDict userIDToFind:userID]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskWontDoBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID {
    
    NSMutableDictionary *itemWontDo = itemDict[@"ItemWontDo"] ? [itemDict[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemWontDo userIDToFind:userID]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsPhotoConfirmation:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemPhotoConfirmation = itemDict[@"ItemPhotoConfirmation"] ? itemDict[@"ItemPhotoConfirmation"] : @"";
    
    if ([[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemPhotoConfirmation classArr:@[[NSString class]]]) {
        
        if ([itemPhotoConfirmation isEqualToString:@"Yes"]) {
            return YES;
        }
        
    }
    
    return NO;
}

-(BOOL)TaskPhotoConfirmationNeededForSpecificObject:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType objectToUse:(NSString *)objectToUse {
    
    //    NSString *itemPhotoConfirmation = itemDict[@"ItemPhotoConfirmation"] ? itemDict[@"ItemPhotoConfirmation"] : @"";
    //    NSMutableDictionary *itemPhotoConfirmationDict = itemDict[@"ItemPhotoConfirmationDict"] ? [itemDict[@"ItemPhotoConfirmationDict"] mutableCopy] : [NSMutableDictionary dictionary];
    //    NSMutableDictionary *itemCompletedDict = itemDict[@"ItemCompletedDict"] ? [itemDict[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    //
//    if ([[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemPhotoConfirmation classArr:@[[NSString class]]]) {
        //    if ([itemPhotoConfirmation isEqualToString:@"Yes"] &&
        //        [[itemCompletedDict allKeys] containsObject:objectToUse] == YES &&
        //        [[itemPhotoConfirmationDict allKeys] containsObject:objectToUse] == NO) {
        //        return YES;
        //    }
//    }
    
    return NO;
}

-(BOOL)TaskApprovalRequestPendingBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID {
    
    NSMutableDictionary *itemApprovalRequests = itemDict[@"ItemApprovalRequests"] ? [itemDict[@"ItemApprovalRequests"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if (itemApprovalRequests[userID] && [itemApprovalRequests[userID][@"ApprovalRequestStatus"] isEqualToString:@"Pending"]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskApprovalRequestAcceptedBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID {
    
    NSMutableDictionary *itemApprovalRequests = itemDict[@"ItemApprovalRequests"] ? [itemDict[@"ItemApprovalRequests"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if (itemApprovalRequests[userID] && [itemApprovalRequests[userID][@"ApprovalRequestStatus"] isEqualToString:@"Accepted"]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsRequestApproval:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemApprovalNeeded = itemDict[@"ItemApprovalNeeded"] ? itemDict[@"ItemApprovalNeeded"] : @"";
    
    if ([itemApprovalNeeded isEqualToString:@"Yes"]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskWasCreatedBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID {
    
    NSString *itemCreatedBy = itemDict[@"ItemCreatedBy"] ? itemDict[@"ItemCreatedBy"] : @"";
    
    if ([itemCreatedBy isEqualToString:userID]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskWasAssignedToSpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID {
    
    NSMutableArray *itemAssignedTo = itemDict[@"ItemAssignedTo"] ? [itemDict[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    
    if ([itemAssignedTo containsObject:userID]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsAssignedToOnlyMyself:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSMutableArray *itemAssignedTo = itemDict[@"ItemAssignedTo"] ? [itemDict[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    
    if (itemAssignedTo.count == 1 && [itemAssignedTo containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsAssignedToAnybody:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemAssignedToAnybody = itemDict[@"ItemAssignedToAnybody"] ? itemDict[@"ItemAssignedToAnybody"] : @"";
    
    if ([itemAssignedToAnybody isEqualToString:@"Yes"]) {
        return YES;
    }
    
    return NO;
    
}

-(BOOL)TaskIsAssignedToNobody:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSMutableArray *itemAssignedTo = itemDict[@"ItemAssignedTo"] ? [itemDict[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    
    if (itemAssignedTo.count == 0) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsPastDueIsUntilNever:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemPastDue = itemDict[@"ItemPastDue"] ? itemDict[@"ItemPastDue"] : @"";
    
    if ([itemPastDue isEqualToString:@"Never"]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsPastDueIsUntilCompleted:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemPastDue = itemDict[@"ItemPastDue"] ? itemDict[@"ItemPastDue"] : @"";
    
    if ([itemPastDue isEqualToString:@"Until Completed"]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskHasAddMoreTime:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSMutableDictionary *itemOccurrencePastDue = itemDict[@"ItemOccurrencePastDue"] ? itemDict[@"ItemOccurrencePastDue"] : [NSMutableDictionary dictionary];

    if ([[itemOccurrencePastDue allKeys] count] > 0) {
        return YES;
    }
        
    return NO;
}

-(BOOL)TaskAddMoreTimeRejected:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSMutableDictionary *itemOccurrencePastDue = itemDict[@"ItemOccurrencePastDue"] ? itemDict[@"ItemOccurrencePastDue"] : [NSMutableDictionary dictionary];
    
    BOOL NoneFound = NO;
    
    for (NSString *key in [itemOccurrencePastDue allKeys]) {
        
        NSDictionary *dict = itemOccurrencePastDue[key];
        NSString *addTime = dict[@"Add Time"];
        
        if ([addTime isEqualToString:@"None"]) {
            
            NoneFound = YES;
            break;
            
        }
        
    }
    
    if (NoneFound == YES) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsAddMoreTimeUnlimited:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSMutableDictionary *itemOccurrencePastDue = itemDict[@"ItemOccurrencePastDue"] ? itemDict[@"ItemOccurrencePastDue"] : [NSMutableDictionary dictionary];
    
    for (NSString *key in [itemOccurrencePastDue allKeys]) {
        
        NSString *addTime = itemOccurrencePastDue[key][@"Add Time"];
        
        if ([addTime isEqualToString:@"Unlimited"]) {
            return YES;
        }
        
    }

    return NO;
}

-(BOOL)TaskIsPastPastDueLimit:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemDueDate = itemDict[@"ItemDueDate"] ? itemDict[@"ItemDueDate"] : @"";
    NSString *itemPastDue = itemDict[@"ItemPastDue"] ? itemDict[@"ItemPastDue"] : @"";
    NSString *itemGracePeriod = itemDict[@"ItemGracePeriod"] ? itemDict[@"ItemGracePeriod"] : @"None";
   
    BOOL TaskIsPastDueIsUntilCompleted = [[[BoolDataObject alloc] init] TaskIsPastDueIsUntilCompleted:itemDict itemType:itemType];
    BOOL TaskIsPastDueIsUntilNever = [[[BoolDataObject alloc] init] TaskIsPastDueIsUntilNever:itemDict itemType:itemType];
    
    if (TaskIsPastDueIsUntilCompleted == NO) {
        
        NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
        
        if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:itemDueDate returnAs:[NSDate class]] == nil) {
            dateFormat = @"MMMM dd, yyyy HH:mm";
        }
        
        NSString *currentDateString = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
        
        NSTimeInterval secondsSinceItemDueDatePassed = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:itemDueDate dateString2:currentDateString dateFormat:dateFormat];
        
        int secondsUntilGracePeriodExpires = [[[GeneralObject alloc] init] GenerateSecondsFromDisplayTime:itemGracePeriod];
        
        itemPastDue = TaskIsPastDueIsUntilNever == YES ? @"0 Minutes" : itemPastDue;
        int secondsUntilPastDueTaskExpires = [[[GeneralObject alloc] init] GenerateSecondsFromDisplayTime:itemPastDue];
        
        if ((secondsSinceItemDueDatePassed - secondsUntilGracePeriodExpires) >= secondsUntilPastDueTaskExpires) {
            return YES;
        }
        
    }
    
    return NO;
}

-(BOOL)TaskIsPastDue:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemDueDate = itemDict[@"ItemDueDate"] ? itemDict[@"ItemDueDate"] : @"";
    NSString *itemGracePeriod = itemDict[@"ItemGracePeriod"] ? itemDict[@"ItemGracePeriod"] : @"None";
    
    NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
    
    if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:itemDueDate returnAs:[NSDate class]] == nil) {
        dateFormat = @"MMMM dd, yyyy HH:mm";
    }
    
    NSString *currentDateString = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
    
    NSTimeInterval secondsSinceItemDueDatePassed = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:itemDueDate dateString2:currentDateString dateFormat:dateFormat];
    
    int secondsUntilGracePeriodExpires = [[[GeneralObject alloc] init] GenerateSecondsFromDisplayTime:itemGracePeriod];
    
    if ((secondsSinceItemDueDatePassed - secondsUntilGracePeriodExpires) >= 0) {
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskIsPastAddMoreTimeLimit:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSMutableDictionary *itemOccurrencePastDue = itemDict[@"ItemOccurrencePastDue"] ? itemDict[@"ItemOccurrencePastDue"] : [NSMutableDictionary dictionary];
    
    BOOL TaskHasAddMoreTime = [[[BoolDataObject alloc] init] TaskHasAddMoreTime:itemDict itemType:itemType];
    BOOL TaskIsAddMoreTimeUnlimited = [[[BoolDataObject alloc] init] TaskIsPastDueIsUntilCompleted:itemDict itemType:itemType];
    
    if (TaskHasAddMoreTime == YES && TaskIsAddMoreTimeUnlimited == NO) {
        
        for (NSString *key in [itemOccurrencePastDue allKeys]) {
            
            NSString *addTime = itemOccurrencePastDue[key][@"Add Time"];
            NSString *dateAdded = itemOccurrencePastDue[key][@"Date Selected"];
            
            NSString *dateFormat = @"yyyy-MM-dd HH:mm:ss";
            
            if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:dateAdded returnAs:[NSDate class]] == nil) {
                dateFormat = @"yyyy-MM-dd HH:mm:ss";
            }
            
            NSString *currentDateString = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
            
            NSTimeInterval secondsPassedSinceDateAdd = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:dateAdded dateString2:currentDateString dateFormat:dateFormat];
            int secsToAdd = [[[GeneralObject alloc] init] GenerateSecondsFromDisplayTime:addTime];
            
            if (secondsPassedSinceDateAdd >= secsToAdd) {
                return YES;
            }
            
        }
        
    }
    
    return NO;
}

-(BOOL)TaskIsScheduledStart:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemScheduledStart = itemDict[@"ItemScheduledStart"] ? itemDict[@"ItemScheduledStart"] : @"";
    
    if ([itemScheduledStart isEqualToString:@""] == NO && [itemScheduledStart isEqualToString:@"Never"] == NO && [itemScheduledStart isEqualToString:@"Now"] == NO && [itemScheduledStart isEqualToString:@"None"] == NO) {
        
        return YES;
        
    }
    
    return NO;
}

-(BOOL)TaskIsScheduledStartHasPassed:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemDatePosted = itemDict[@"ItemDatePosted"] ? itemDict[@"ItemDatePosted"] : @"";
    NSString *itemScheduledStart = itemDict[@"ItemScheduledStart"] ? itemDict[@"ItemScheduledStart"] : @"";
    
    NSString *dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSString *currentDateString = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
    
    NSTimeInterval secondsPassedSinceItemDatePosted = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:itemDatePosted dateString2:currentDateString dateFormat:dateFormat];
    
    float reminderAmount = 0;
    
    NSArray *arr = [itemScheduledStart containsString:@" "] ? [itemScheduledStart componentsSeparatedByString:@" "] : @[];
    NSString *frequencyAmountString = [arr count] > 0 ? arr[0] : @"";
    NSString *frequencyString = [arr count] > 1 ? arr[1] : @"";
    
    if ([frequencyString containsString:@"Minute"]) {
        
        reminderAmount = [frequencyAmountString intValue] * 60;
        
    } else if ([frequencyString containsString:@"Hour"]) {
        
        reminderAmount = [frequencyAmountString intValue] * 3600;
        
    } else if ([frequencyString containsString:@"Day"]) {
        
        reminderAmount = [frequencyAmountString intValue] * 86400;
        
    } else if ([frequencyString containsString:@"Week"]) {
        
        reminderAmount = [frequencyAmountString intValue] * 604800;
        
    }
    
    if (secondsPassedSinceItemDatePosted > reminderAmount) {
        
        return YES;
        
    }
    
    return NO;
}

-(BOOL)TaskIsTutorial:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSString *itemTutorial = itemDict[@"ItemTutorial"] ? itemDict[@"ItemTutorial"] : @"";
    
    if ([itemTutorial isEqualToString:@"Yes"]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)UserShouldReceiveNotificationsForTask:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID homeMembersDict:(NSMutableDictionary *)homeMembersDict {
   
    NSString *notificationStatus = @"No";
    
    if (homeMembersDict &&
        homeMembersDict[@"UserID"] &&
        [homeMembersDict[@"UserID"] containsObject:userID]) {
        NSUInteger index = [homeMembersDict[@"UserID"] indexOfObject:userID];
        notificationStatus = homeMembersDict[@"Notifications"] && [(NSArray *)homeMembersDict[@"Notifications"] count] > index ? homeMembersDict[@"Notifications"][index] : @"No";
    }
    
    NSString *itemDueDate = itemDict[@"ItemDueDate"] ? itemDict[@"ItemDueDate"] : @"";
    NSString *itemOccurrenceID = itemDict[@"ItemOccurrenceID"] ? itemDict[@"ItemOccurrenceID"] : @"";
    NSMutableArray *itemAssignedTo = itemDict[@"ItemAssignedTo"] ? itemDict[@"ItemAssignedTo"] : [NSMutableArray array];
    NSString *itemCreatedBy = itemDict[@"ItemCreatedBy"] ? itemDict[@"ItemCreatedBy"] : @"";
    NSString *itemGracePeriod = itemDict[@"ItemGracePeriod"] ? itemDict[@"ItemGracePeriod"] : @"";
    
    NSString *subLabel = [[[GeneralObject alloc] init] GetDisplayTimeRemainingUntilDateStartingFromCurrentDate:itemDueDate shortStyle:NO reallyShortStyle:NO];
    
    if ([subLabel isEqualToString:@"Past due"]) {
        subLabel = [[[GeneralObject alloc] init] GenerateDisplayTimeUntilDisplayTimeStartingFromCustomStartDate:itemGracePeriod itemDueDate:itemDueDate shortStyle:NO reallyShortStyle:NO];
    }
    
    if ([subLabel isEqualToString:@"Past due"] || [subLabel isEqualToString:@""]) {
        subLabel = [NSString stringWithFormat:@"Due %@", [[[GeneralObject alloc] init] GetDisplayTimeSinceDate:itemDueDate shortStyle:NO reallyShortStyle:NO]];
    }
   
    BOOL TaskIsFullyCompleted = [[[BoolDataObject alloc] init] TaskIsFullyCompleted:itemDict itemType:itemType homeMembersDict:homeMembersDict];
    
    BOOL TaskIsPastDue = TaskIsFullyCompleted == NO && ([subLabel isEqualToString:@"Past due"] || [subLabel containsString:@" ago"]) ? YES : NO;

    if ([notificationStatus isEqualToString:@"Yes"] &&
        [itemDueDate isEqualToString:@"No Due Date"] == NO &&
        TaskIsPastDue == NO &&
        [itemOccurrenceID length] == 0 &&
        ([itemAssignedTo containsObject:userID] || [itemCreatedBy isEqualToString:userID] || [itemAssignedTo count] == 0)) { 
        return YES;
    }
    
    return NO;
}

-(BOOL)TaskHasBeenMuted:(NSMutableDictionary *)itemDict {
  
    NSMutableArray *mutedItemsArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"MutedItems"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"MutedItems"] : [NSMutableArray array];
    
    NSString *itemUniqueID = itemDict[@"ItemUniqueID"] ? itemDict[@"ItemUniqueID"] : @"";
    
    if ([mutedItemsArray containsObject:itemUniqueID]) {
        
        return YES;
        
    }
    
    return NO;
}

-(BOOL)TaskHasReminderNotification:(NSMutableDictionary *)itemDict {
    
    NSMutableArray *notificationIdentifierArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"MyNotifications"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"MyNotifications"] : [NSMutableArray array];
    
    NSString *itemUniqueID = itemDict[@"ItemUniqueID"];
    
    for (NSString *identifier in notificationIdentifierArray) {
        
        if ([identifier containsString:[NSString stringWithFormat:@"%@ - Remind Me - ", itemUniqueID]]) {
            
            return YES;
            
        }
        
    }
    
    return NO;
}

#pragma mark

-(BOOL)SubtaskIsCompleted:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType subtask:(NSString *)subtask {
    
    NSMutableDictionary *itemSubtask = itemDict[@"ItemSubTasks"] ? [itemDict[@"ItemSubTasks"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if ([[itemSubtask[subtask][@"Completed Dict"] allKeys] count] > 0) {
        return YES;
    }
    
    return NO;
}

-(BOOL)SubtaskIsInProgress:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType subtask:(NSString *)subtask {
    
    NSMutableDictionary *itemSubtask = itemDict[@"ItemSubTasks"] ? [itemDict[@"ItemSubTasks"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if ([[itemSubtask[subtask][@"In Progress Dict"] allKeys] count] > 0) {
        return YES;
    }
    
    return NO;
}

-(BOOL)SubtaskIsWontDo:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType subtask:(NSString *)subtask {
    
    NSMutableDictionary *itemSubtask = itemDict[@"ItemSubTasks"] ? [itemDict[@"ItemSubTasks"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if (itemSubtask[subtask][@"Wont Do"]) {
        
        if ([[itemSubtask[subtask][@"Wont Do"] allKeys] count] > 0) {
            return YES;
        }
        
    }
    
    return NO;
}

-(BOOL)SubtaskIsAssignedToAnybody:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType subtask:(NSString *)subtask {
    
    NSMutableDictionary *itemSubtask = itemDict[@"ItemSubTasks"] ? [itemDict[@"ItemSubTasks"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if ([(NSArray *)itemSubtask[subtask][@"Assigned To"] count] == 0) {
        return YES;
    }
    
    if ([(NSArray *)itemSubtask[subtask][@"Assigned To"] count] > 0) {
        if ([itemSubtask[subtask][@"Assigned To"][0] isEqualToString:@"Anybody"]) {
            return YES;
        }
    }
    
    return NO;
}

-(BOOL)SubtaskIsRequestingApprovalPending:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType subtask:(NSString *)subtask {
    
    NSMutableDictionary *itemSubtask = itemDict[@"ItemSubTasks"] ? [itemDict[@"ItemSubTasks"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if ([[itemSubtask[subtask][@"Approval Request"] allKeys] count] > 0) {
        NSString *firstKeyUserID = [itemSubtask[subtask][@"Approval Request"] allKeys][0];
        if (itemSubtask[subtask][@"Approval Request"][firstKeyUserID] && [itemSubtask[subtask][@"Approval Request"][firstKeyUserID][@"ApprovalRequestStatus"] isEqualToString:@"Pending"]) {
            return YES;
        }
    }
    
    return NO;
}

#pragma mark

-(BOOL)AllListItemsAreCompleted:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSMutableDictionary *itemListItems = itemDict[@"ItemListItems"] ? [itemDict[@"ItemListItems"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemCompletedDict = itemDict[@"ItemCompletedDict"] ? [itemDict[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemWontDo = itemDict[@"ItemWontDo"] ? [itemDict[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if (([[itemCompletedDict allKeys] count] + [[itemWontDo allKeys] count]) >= [[itemListItems allKeys] count] && [[itemListItems allKeys] count] > 0) {
        return YES;
    }
    
    return NO;
}

-(BOOL)ListItemIsCompleted:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType listItem:(NSString *)listItem {
    
    NSMutableDictionary *itemListItems = itemDict[@"ItemListItems"] ? [itemDict[@"ItemListItems"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemCompletedDict = itemDict[@"ItemCompletedDict"] ? [itemDict[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
   
    if ([[itemListItems allKeys] containsObject:listItem]) {
      
        if (([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:listItem]) &&
            [itemListItems[listItem][@"Status"] isEqualToString:@"Uncompleted"] == NO) {
            return YES;
        }
        
    }
    
    return NO;
}

-(BOOL)ListItemIsInProgress:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType listItem:(NSString *)listItem {
    
    NSMutableDictionary *itemListItems = itemDict[@"ItemListItems"] ? [itemDict[@"ItemListItems"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemCompletedDict = itemDict[@"ItemCompletedDict"] ? [itemDict[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemInProgressDict = itemDict[@"ItemInProgressDict"] ? [itemDict[@"ItemInProgressDict"] mutableCopy] : [NSMutableDictionary dictionary];
    
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:itemDict itemType:itemType];
    
    if ([[itemListItems allKeys] containsObject:listItem]) {
        
        if (([[itemInProgressDict allKeys] containsObject:listItem]) &&
            ((TaskIsCompleteAsNeeded == NO && [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:listItem] == NO) || (TaskIsCompleteAsNeeded == YES)) &&
            [itemListItems[listItem][@"Status"] isEqualToString:@"Uncompleted"] == NO) {
            return YES;
        }
        
    }
    
    return NO;
}

-(BOOL)ListItemIsWontDo:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType listItem:(NSString *)listItem {
    
    NSMutableDictionary *itemListItems = itemDict[@"ItemListItems"] ? [itemDict[@"ItemListItems"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemCompletedDict = itemDict[@"ItemCompletedDict"] ? [itemDict[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemWontDo = itemDict[@"ItemWontDo"] ? [itemDict[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:itemDict itemType:itemType];
    
    if ([[itemListItems allKeys] containsObject:listItem]) {
        
        if (([[itemWontDo allKeys] containsObject:listItem]) &&
            ((TaskIsCompleteAsNeeded == NO && [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:listItem] == NO) || (TaskIsCompleteAsNeeded == YES)) &&
            [itemListItems[listItem][@"Status"] isEqualToString:@"Uncompleted"] == NO) {
            return YES;
        }
        
    }
    
    return NO;
}

-(BOOL)ListItemIsAssignedToNewHomeMembers:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType listItem:(NSString *)listItem {
    
    NSMutableDictionary *itemListItems = itemDict[@"ItemListItems"] ? [itemDict[@"ItemListItems"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if ([(NSArray *)itemListItems[listItem][@"Assigned To"] count] == 0) {
        return YES;
    }
    
    if ([(NSArray *)itemListItems[listItem][@"Assigned To"] count] > 0) {
        if ([itemListItems[listItem][@"Assigned To"][0] isEqualToString:@"Anybody"]) {
            return YES;
        }
    }
    
    return NO;
}

-(BOOL)ListItemIsRequestingApprovalPending:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType listItem:(NSString *)listItem {
    
    NSMutableDictionary *itemListItems = itemDict[@"ItemListItems"] ? [itemDict[@"ItemListItems"] mutableCopy] : [NSMutableDictionary dictionary];
    
    
    
    BOOL ListItemObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemListItems classArr:@[[NSDictionary class], [NSMutableDictionary class]]];
    
    if (ListItemObjectIsKindOfClass == YES && itemListItems[listItem]) {
        
        
        
        BOOL ListItemObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemListItems[listItem] classArr:@[[NSDictionary class], [NSMutableDictionary class]]];
        
        if (ListItemObjectIsKindOfClass == YES && itemListItems[listItem][@"Approval Request"]) {
            
            
            
            BOOL ListItemObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemListItems[listItem][@"Approval Request"] classArr:@[[NSDictionary class], [NSMutableDictionary class]]];
            
            if (ListItemObjectIsKindOfClass == YES && [[itemListItems[listItem][@"Approval Request"] allKeys] count] > 0) {
                
                
                
                NSString *firstKeyUserID = [itemListItems[listItem][@"Approval Request"] allKeys] && [[itemListItems[listItem][@"Approval Request"] allKeys] count] > 0 ? [itemListItems[listItem][@"Approval Request"] allKeys][0] : @"";
                
                BOOL ListItemObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:firstKeyUserID classArr:@[[NSString class]]];
                
                if (ListItemObjectIsKindOfClass == YES && itemListItems[listItem][@"Approval Request"][firstKeyUserID]) {
                    
                    
                    
                    BOOL ListItemObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemListItems[listItem][@"Approval Request"][firstKeyUserID][@"ApprovalRequestStatus"] classArr:@[[NSString class]]];
                    
                    if (ListItemObjectIsKindOfClass == YES && [itemListItems[listItem][@"Approval Request"][firstKeyUserID][@"ApprovalRequestStatus"] isEqualToString:@"Pending"]) {
                        return YES;
                    }
                    
                    
                    
                }
                
            }
            
        }
        
    }
    
    return NO;
}

#pragma mark

-(BOOL)AllItemizedItemsAreCompleted:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType {
    
    NSMutableDictionary *itemItemizedItems = itemDict[@"ItemItemizedItems"] ? [itemDict[@"ItemItemizedItems"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemCompletedDict = itemDict[@"ItemCompletedDict"] ? [itemDict[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemWontDo = itemDict[@"ItemWontDo"] ? [itemDict[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    
    BOOL ItemizedObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemItemizedItems classArr:@[[NSDictionary class], [NSMutableDictionary class]]];
    BOOL CompletedObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemCompletedDict classArr:@[[NSDictionary class], [NSMutableDictionary class]]];
    BOOL WontDoObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemWontDo classArr:@[[NSDictionary class], [NSMutableDictionary class]]];
    
    //Dict crash
    if (ItemizedObjectIsKindOfClass == NO) {
        itemItemizedItems = [@{} mutableCopy];
    }
    
    if (CompletedObjectIsKindOfClass == NO) {
        itemCompletedDict = [@{} mutableCopy];
    }
    
    if (WontDoObjectIsKindOfClass == NO) {
        itemWontDo = [@{} mutableCopy];
    }
    
    if (([[itemCompletedDict allKeys] count] + [[itemWontDo allKeys] count]) >= [[itemItemizedItems allKeys] count] && [[itemItemizedItems allKeys] count] > 0) {
        return YES;
    }
    
    return NO;
}

-(BOOL)ItemizedItemIsCompleted:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType itemizedItem:(NSString *)itemizedItem {
    
    NSMutableDictionary *itemItemizedItems = itemDict[@"ItemItemizedItems"] ? [itemDict[@"ItemItemizedItems"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemCompletedDict = itemDict[@"ItemCompletedDict"] ? [itemDict[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if ([[itemItemizedItems allKeys] containsObject:itemizedItem]) {
        
        if (([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:itemizedItem]) &&
            [itemItemizedItems[itemizedItem][@"Status"] isEqualToString:@"Uncompleted"] == NO) {
            return YES;
        }
        
    }
    
    return NO;
}

-(BOOL)ItemizedItemIsInProgress:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType itemizedItem:(NSString *)itemizedItem {
    
    NSMutableDictionary *itemItemizedItems = itemDict[@"ItemItemizedItems"] ? [itemDict[@"ItemItemizedItems"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemCompletedDict = itemDict[@"ItemCompletedDict"] ? [itemDict[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemInProgressDict = itemDict[@"ItemInProgressDict"] ? [itemDict[@"ItemInProgressDict"] mutableCopy] : [NSMutableDictionary dictionary];
    
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:itemDict itemType:itemType];
    
    if ([[itemItemizedItems allKeys] containsObject:itemizedItem]) {
        
        if (([[itemInProgressDict allKeys] containsObject:itemizedItem]) &&
            ((TaskIsCompleteAsNeeded == NO && [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:itemizedItem] == NO) || (TaskIsCompleteAsNeeded == YES)) &&
            [itemItemizedItems[itemizedItem][@"Status"] isEqualToString:@"Uncompleted"] == NO) {
            return YES;
        }
        
    }
    
    return NO;
}

-(BOOL)ItemizedItemIsWontDo:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType itemizedItem:(NSString *)itemizedItem {
    
    NSMutableDictionary *itemItemizedItems = itemDict[@"ItemItemizedItems"] ? [itemDict[@"ItemItemizedItems"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemWontDo = itemDict[@"ItemWontDo"] ? [itemDict[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if ([[itemItemizedItems allKeys] containsObject:itemizedItem]) {
        
        if (([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemWontDo userIDToFind:itemizedItem]) &&
            [itemItemizedItems[itemizedItem][@"Status"] isEqualToString:@"Uncompleted"] == NO) {
            return YES;
        }
        
    }
    
    return NO;
}

-(BOOL)ItemizedItemIsAssignedToNewHomeMembers:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType itemizedItem:(NSString *)itemizedItem {
    
    NSMutableDictionary *itemItemizedItems = itemDict[@"ItemItemizedItems"] ? [itemDict[@"ItemItemizedItems"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if ([(NSArray *)itemItemizedItems[itemizedItem][@"Assigned To"] count] == 0) {
        return YES;
    }
    
    if ([(NSArray *)itemItemizedItems[itemizedItem][@"Assigned To"] count] > 0) {
        if ([itemItemizedItems[itemizedItem][@"Assigned To"][0] isEqualToString:@"Anybody"]) {
            return YES;
        }
    }
    
    return NO;
}

-(BOOL)ItemizedItemIsRequestingApprovalPending:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType itemizedItem:(NSString *)itemizedItem {
    
    NSMutableDictionary *itemItemizedItems = itemDict[@"ItemItemizedItems"] ? [itemDict[@"ItemItemizedItems"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if ([[itemItemizedItems[itemizedItem][@"Approval Request"] allKeys] count] > 0) {
        NSString *firstKeyUserID = [itemItemizedItems[itemizedItem][@"Approval Request"] allKeys][0];
        if (itemItemizedItems[itemizedItem][@"Approval Request"][firstKeyUserID] && [itemItemizedItems[itemizedItem][@"Approval Request"][firstKeyUserID][@"ApprovalRequestStatus"] isEqualToString:@"Pending"]) {
            return YES;
        }
    }
    
    return NO;
}

#pragma mark

-(BOOL)UserCanReceiveNotification:(NSMutableDictionary *)notificationSettingsDict userID:(NSString *)userID notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType {
    
    BOOL UserAllowsNotification = [[[BoolDataObject alloc] init] UserAllowsNotification:notificationSettingsDict userID:userID notificationItemType:notificationItemType notificationType:notificationType];
    BOOL UserCanReceiveNotificationForSpecificDay = [[[BoolDataObject alloc] init] UserCanReceiveNotificationForSpecificDay:notificationSettingsDict userID:userID notificationItemType:notificationItemType notificationType:notificationType];
    BOOL UserCanReceiveNotificationForSpecificNotificationType = [[[BoolDataObject alloc] init] UserCanReceiveNotificationForSpecificNotificationType:notificationSettingsDict userID:userID notificationItemType:notificationItemType notificationType:notificationType];
   
    if (UserAllowsNotification == NO ||
        
        ([notificationItemType containsString:@"DaysOfTheWeek"] && UserCanReceiveNotificationForSpecificDay == NO) ||
        
        (([notificationItemType containsString:@"Chore"] ||
          [notificationItemType containsString:@"Expense"] ||
          [notificationItemType containsString:@"List"] ||
          [notificationItemType containsString:@"GroupChat"] ||
          [notificationItemType containsString:@"HomeMember"] ||
          [notificationItemType containsString:@"Forum"]) && UserCanReceiveNotificationForSpecificNotificationType == NO)) {
       
        return NO;
        
    }
    
    return YES;
}

-(BOOL)UserAllowsNotification:(NSMutableDictionary *)notificationSettingsDict userID:(NSString *)userID notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType {
    
    BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:notificationSettingsDict[userID] classArr:@[[NSDictionary class], [NSMutableDictionary class]]];
    
    NSMutableDictionary *specificUserNotificationSettingsDict =
    notificationSettingsDict &&
    notificationSettingsDict[userID] &&
    ObjectIsKindOfClass == YES ?
    
    notificationSettingsDict[userID] : [NSMutableDictionary dictionary];
    
    ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:specificUserNotificationSettingsDict[@"AllowNotifications"] classArr:@[[NSString class]]];
    
    NSString *allowNotifications =
    specificUserNotificationSettingsDict &&
    specificUserNotificationSettingsDict[@"AllowNotifications"] &&
    ObjectIsKindOfClass == YES ?
    
    specificUserNotificationSettingsDict[@"AllowNotifications"] : @"Yes";
    
    if ([allowNotifications isEqualToString:@"No"]) {
        
        return NO;
        
    }
    
    return YES;
}

-(BOOL)UserCanReceiveBagdeIconNotification:(NSMutableDictionary *)notificationSettingsDict userID:(NSString *)userID {
    
    BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:notificationSettingsDict[userID] classArr:@[[NSDictionary class], [NSMutableDictionary class]]];
    
    NSMutableDictionary *specificUserNotificationSettingsDict =
    notificationSettingsDict &&
    notificationSettingsDict[userID] &&
    ObjectIsKindOfClass == YES ?
    
    notificationSettingsDict[userID] : [NSMutableDictionary dictionary];
    
    ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:specificUserNotificationSettingsDict[@"BadgeIcon"] classArr:@[[NSString class]]];
    
    NSString *sepcificUsersBadgeIcon =
    specificUserNotificationSettingsDict &&
    specificUserNotificationSettingsDict[@"BadgeIcon"] &&
    ObjectIsKindOfClass == YES ?
    
    specificUserNotificationSettingsDict[@"BadgeIcon"] : @"Yes";
    
    if ([sepcificUsersBadgeIcon isEqualToString:@"Yes"] == NO) {
        
        return NO;
        
    }
    
    return YES;
}

-(BOOL)UserCanReceiveNotificationForSpecificDay:(NSMutableDictionary *)notificationSettingsDict userID:(NSString *)userID notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType {
    
    BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:notificationSettingsDict[userID] classArr:@[[NSDictionary class], [NSMutableDictionary class]]];
    
    NSMutableDictionary *specificUserNotificationSettingsDict =
    notificationSettingsDict &&
    notificationSettingsDict[userID] &&
    ObjectIsKindOfClass == YES ?
    
    notificationSettingsDict[userID] : [NSMutableDictionary dictionary];
    
    if ([notificationItemType containsString:@"DaysOfTheWeek"]) {
        
        BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:specificUserNotificationSettingsDict[notificationItemType] classArr:@[[NSArray class], [NSMutableArray class]]];
        
        NSMutableArray *sepcificUsersDaysOfTheWeekArray =
        specificUserNotificationSettingsDict &&
        specificUserNotificationSettingsDict[notificationItemType] &&
        ObjectIsKindOfClass == YES ?
        
        specificUserNotificationSettingsDict[notificationItemType] : [NSMutableArray array];
        
        if ([sepcificUsersDaysOfTheWeekArray containsObject:notificationType] == NO) {
            
            return NO;
            
        }
        
    }
    
    return YES;
}

-(BOOL)UserCanReceiveNotificationForSpecificNotificationType:(NSMutableDictionary *)notificationSettingsDict userID:(NSString *)userID notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType {
    
    BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:notificationSettingsDict[userID] classArr:@[[NSDictionary class], [NSMutableDictionary class]]];
    
    NSMutableDictionary *specificUserNotificationSettingsDict =
    notificationSettingsDict &&
    notificationSettingsDict[userID] &&
    ObjectIsKindOfClass == YES ?
    
    notificationSettingsDict[userID] : [NSMutableDictionary dictionary];
    
    if ([notificationItemType containsString:@"Chore"]) {
        
        notificationItemType = @"Chores";
        
    } else if ([notificationItemType containsString:@"Expense"]) {
        
        notificationItemType = @"Expenses";
        
    } else if ([notificationItemType containsString:@"List"]) {
        
        notificationItemType = @"Lists";
        
    } else if ([notificationItemType containsString:@"GroupChat"]) {
        
        notificationItemType = @"GroupChats";
        
    } else if ([notificationItemType containsString:@"HomeMember"]) {
        
        notificationItemType = @"HomeMembers";
        
    } else if ([notificationItemType containsString:@"Forum"]) {
        
        notificationItemType = @"Forums";
        
    }
    
    if ([notificationItemType containsString:@"Chore"] == NO &&
        [notificationItemType containsString:@"Expense"] == NO &&
        [notificationItemType containsString:@"List"] == NO &&
        [notificationItemType containsString:@"GroupChat"] == NO &&
        [notificationItemType containsString:@"HomeMember"] == NO &&
        [notificationItemType containsString:@"Forum"] == NO) {
        
        return NO;
        
    }
    
    ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:specificUserNotificationSettingsDict[notificationItemType][notificationType] classArr:@[[NSString class]]];
    
    NSString *sepcificUsersNotificationItemTypeDict =
    specificUserNotificationSettingsDict &&
    specificUserNotificationSettingsDict[notificationItemType] &&
    specificUserNotificationSettingsDict[notificationItemType][notificationType] &&
    ObjectIsKindOfClass == YES ?
    
    specificUserNotificationSettingsDict[notificationItemType][notificationType] : @"Yes";
    
    if ([sepcificUsersNotificationItemTypeDict isEqualToString:@"No"]) {
        
        return NO;
        
    }
    
    return YES;
}

-(BOOL)UserWithUsernameHasNotificationsTurnedOn:(NSString *)username homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    NSUInteger index = homeMembersDict && [homeMembersDict[@"Username"] containsObject:username] ? [homeMembersDict[@"Username"] indexOfObject:username] : 0;
    NSString *notification = [(NSArray *)homeMembersDict[@"Notifications"] count] > index ? homeMembersDict[@"Notifications"][index] : @"Yes";
    
    if ([notification isEqualToString:@"Yes"]) {
        return YES;
    }
    
    return NO;
}

#pragma mark

-(BOOL)SpecificUserIsMe:(NSString *)userID {
    
    if ([userID isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]]) {
        return YES;
    }
    
    return NO;
}

#pragma mark

-(BOOL)TimeToAlternateTurns:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict itemType:(NSString *)itemType keyArray:(NSArray *)keyArray homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    BOOL TimeToAlternateTurns = NO;

    NSString *itemAlternateTurns = dictToUse[@"ItemAlternateTurns"] ? dictToUse[@"ItemAlternateTurns"] : @"";
   
    if ([itemAlternateTurns containsString:@"Occurrence"]) {
       
        TimeToAlternateTurns = [[[BoolDataObject alloc] init] TimeToAlternateTurnsEveryOccurrence:dictToUse itemOccurrencesDict:itemOccurrencesDict itemType:itemType];
   
    } else if ([itemAlternateTurns containsString:@"Completion"]) {
      
        TimeToAlternateTurns = [[[BoolDataObject alloc] init] TimeToAlternateTurnsEveryCompletion:dictToUse itemOccurrencesDict:itemOccurrencesDict itemType:itemType keyArray:keyArray homeMembersDict:homeMembersDict];
     
//    } else if ([itemAlternateTurns containsString:@"Every"]) {
//
//        if (([itemAlternateTurns containsString:@"1st"] || [itemAlternateTurns containsString:@"2nd"] || [itemAlternateTurns containsString:@"3rd"] || [itemAlternateTurns containsString:@"4th"] || [itemAlternateTurns containsString:@"5th"] || [itemAlternateTurns containsString:@"6th"] || [itemAlternateTurns containsString:@"7th"] || [itemAlternateTurns containsString:@"8th"] || [itemAlternateTurns containsString:@"9th"] || [itemAlternateTurns containsString:@"10th"] || [itemAlternateTurns containsString:@"11th"] || [itemAlternateTurns containsString:@"12th"] || [itemAlternateTurns containsString:@"13th"] || [itemAlternateTurns containsString:@"14th"] || [itemAlternateTurns containsString:@"15th"] || [itemAlternateTurns containsString:@"16th"] || [itemAlternateTurns containsString:@"17th"] || [itemAlternateTurns containsString:@"18th"] || [itemAlternateTurns containsString:@"19th"] || [itemAlternateTurns containsString:@"20th"] || [itemAlternateTurns containsString:@"21st"] || [itemAlternateTurns containsString:@"22nd"] || [itemAlternateTurns containsString:@"23rd"] || [itemAlternateTurns containsString:@"24th"] || [itemAlternateTurns containsString:@"25th"] || [itemAlternateTurns containsString:@"26th"] || [itemAlternateTurns containsString:@"27th"] || [itemAlternateTurns containsString:@"28th"])) {
//
//            TimeToAlternateTurns = [[[BoolDataObject alloc] init] TimeToAlternateTurnsEveryMonthDays:itemAlternateTurns itemDatePosted:itemDatePosted];
            
//        } else if ([itemAlternateTurns containsString:@"Sunday"] || [itemAlternateTurns containsString:@"Monday"] || [itemAlternateTurns containsString:@"Tuesday"] || [itemAlternateTurns containsString:@"Wednesday"] || [itemAlternateTurns containsString:@"Thursday"] || [itemAlternateTurns containsString:@"Friday"] || [itemAlternateTurns containsString:@"Saturday"]) {
//
//            TimeToAlternateTurns = [[[BoolDataObject alloc] init] TimeToAlternateTurnsEveryWeekDays:itemAlternateTurns itemDatePosted:itemDatePosted];
            
        } else if ([itemAlternateTurns containsString:@" Day"] || [itemAlternateTurns containsString:@" Week"] || [itemAlternateTurns containsString:@" Month"]) {
            
//            NSString *itemDatePosted = dictToUse[@"ItemDatePosted"] ? dictToUse[@"ItemDatePosted"] : @"";
//            NSString *itemRepeats = dictToUse[@"ItemRepeats"] ? dictToUse[@"ItemRepeats"] : @"";
//            NSString *itemRepeatIfCompletedEarly = dictToUse[@"ItemRepeatIfCompletedEarly"] ? dictToUse[@"ItemRepeatIfCompletedEarly"] : @"";
//            NSString *itemCompleteAsNeeded = dictToUse[@"ItemCompleteAsNeeded"] ? dictToUse[@"ItemCompleteAsNeeded"] : @"";
//            NSString *itemStartDate = dictToUse[@"ItemStartDate"] ? dictToUse[@"ItemStartDate"] : @"";
//            NSString *itemEndDate = dictToUse[@"ItemEndDate"] ? dictToUse[@"ItemEndDate"] : @"";
//            NSString *itemTime = dictToUse[@"ItemTime"] ? dictToUse[@"ItemTime"] : @"";
//            NSString *itemDays = dictToUse[@"ItemDays"] ? dictToUse[@"ItemDays"] : @"";
//            NSMutableArray *itemDueDatesSkipped = dictToUse[@"ItemDueDatesSkipped"] ? dictToUse[@"ItemDueDatesSkipped"] : [NSMutableArray array];
//            
//            NSMutableArray *allDueDatesArray = [[[NotificationsObject alloc] init] GenerateArrayOfRepeatingDueDates:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly itemCompleteAsNeeded:itemCompleteAsNeeded totalAmountOfFutureDates:365 maxAmountOfDueDatesToLoopThrough:1000 itemDatePosted:itemDatePosted itemDueDate:@"" itemStartDate:itemStartDate itemEndDate:itemEndDate itemTime:itemTime itemDays:itemDays itemDueDatesSkipped:itemDueDatesSkipped SkipStartDate:NO];
//            
//            TimeToAlternateTurns = [[[BoolDataObject alloc] init] TimeToAlternateTurnsEveryDayWeekMonth:dictToUse allDueDatesArray:allDueDatesArray];
            
        }
        
//    }
    
    return TimeToAlternateTurns;
}

-(BOOL)TimeToAlternateTurnsEveryOccurrence:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict itemType:(NSString *)itemType {
    
    BOOL TimeToAlternateTurns = NO;
    
    int numOfOccurrencesBeforeAlternate = 1;

    NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
    NSString *itemAlternateTurns = dictToUse[@"ItemAlternateTurns"] ? dictToUse[@"ItemAlternateTurns"] : @"";
    
    if ([itemAlternateTurns containsString:@" "] && [[itemAlternateTurns componentsSeparatedByString:@" "] count] > 2) {
        NSArray *arr = [itemAlternateTurns componentsSeparatedByString:@" "];
        numOfOccurrencesBeforeAlternate = [(NSString *)arr[1] intValue];
    }
   
    int numOfOccurrences = itemOccurrencesDict[@"Occurrences_AlternatingTurns"] && itemOccurrencesDict[@"Occurrences_AlternatingTurns"][itemID] ? [(NSString *)itemOccurrencesDict[@"Occurrences_AlternatingTurns"][itemID] intValue] : 0;
   
    TimeToAlternateTurns = (numOfOccurrences % numOfOccurrencesBeforeAlternate) == 0;
    
    if (numOfOccurrences == 0 && numOfOccurrencesBeforeAlternate > 0) {
        TimeToAlternateTurns = NO;
    }
    
    return TimeToAlternateTurns;
}

-(BOOL)TimeToAlternateTurnsEveryCompletion:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict itemType:(NSString *)itemType keyArray:(NSArray *)keyArray homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    BOOL TimeToAlternateTurns = NO;
    
    int numOfCompletionsBeforeAlternate = 1;
    
    NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
    NSString *itemAlternateTurns = dictToUse[@"ItemAlternateTurns"] ? dictToUse[@"ItemAlternateTurns"] : @"";
    NSMutableDictionary *itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? [dictToUse[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if ([itemAlternateTurns containsString:@" "] && [[itemAlternateTurns componentsSeparatedByString:@" "] count] > 2) {
        NSArray *arr = [itemAlternateTurns componentsSeparatedByString:@" "];
        numOfCompletionsBeforeAlternate = [(NSString *)arr[1] intValue];
    }
    
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:dictToUse itemType:itemType];
    
    int numOfCompletions = 0;
    
    if (TaskIsCompleteAsNeeded == NO) {
        
        numOfCompletions = itemOccurrencesDict[@"Completions_AlternatingTurns"] && itemOccurrencesDict[@"Completions_AlternatingTurns"][itemID] ?
        [(NSString *)itemOccurrencesDict[@"Completions_AlternatingTurns"][itemID] intValue] : 0;
        
    } else {
        
        numOfCompletions = (int)[(NSArray *)[itemCompletedDict allKeys] count];
        
    }
    
  
    
    TimeToAlternateTurns = (numOfCompletions % numOfCompletionsBeforeAlternate) == 0;
    
    if (numOfCompletions == 0 && numOfCompletionsBeforeAlternate > 0) {
        TimeToAlternateTurns = NO;
    }
    
    return TimeToAlternateTurns;
}

-(BOOL)TimeToAlternateTurnsEveryMonthDays:(NSMutableDictionary *)dictToUse {
    
    BOOL TimeToAlternateTurns = NO;
    
    int numOfOccurrences = 0;
    int numOfTimesBeforeAlternate = 1;
    
    NSString *itemAlternateTurns = dictToUse[@"ItemAlternateTurns"] ? dictToUse[@"ItemAlternateTurns"] : @"";
    NSString *itemDatePosted = dictToUse[@"ItemDatePosted"] ? dictToUse[@"ItemDatePosted"] : @"";
    
    if ([itemAlternateTurns containsString:@" "] && [[itemAlternateTurns componentsSeparatedByString:@" "] count] > 2) {
        NSArray *arr = [itemAlternateTurns componentsSeparatedByString:@" "];
        numOfTimesBeforeAlternate = [(NSString *)arr[1] intValue];
    }
    
    // Define the reference date
    NSString *referenceDateString = itemDatePosted;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *referenceDate = [dateFormatter dateFromString:referenceDateString];
    
    // Define the target weekday (1 is Sunday, 2 is Monday, and so on)
    NSInteger targetWeekday = 1; // Sunday
    
    for (int i=1 ; i<29 ; i++) {
        
        NSString *ending = @"th";
        
        if (i == 1 || i == 21) {
            ending = @"st";
        } else if (i == 2 || i == 22) {
            ending = @"nd";
        } else if (i == 3 || i == 23) {
            ending = @"rd";
        }
        
        if ([itemAlternateTurns containsString:[NSString stringWithFormat:@"%d%@", i, ending]]) {
            
            targetWeekday = i;
            
        }
        
    }
    
    // Create a calendar and set the desired components
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit calendarUnit = NSCalendarUnitMonth;
    NSDateComponents *components = [calendar components:calendarUnit fromDate:referenceDate];
    
    // Get the weekday of the reference date
    NSInteger referenceWeekday = [components day];
    
    // Calculate the number of times the target weekday has passed since the reference date
    NSInteger numberOfOccurrences = (NSInteger)floor((float)(referenceWeekday - targetWeekday) / 30) + 1;
    
    NSLog(@"Number of occurrences of target weekday since the reference date: %ld", (long)numberOfOccurrences);
    
    TimeToAlternateTurns = numOfOccurrences % numOfTimesBeforeAlternate == 0;
    
    return TimeToAlternateTurns;
}

-(BOOL)TimeToAlternateTurnsEveryWeekDays:(NSMutableDictionary *)dictToUse {
    
    BOOL TimeToAlternateTurns = NO;
    
    int numOfOccurrences = 0;
    int numOfTimesBeforeAlternate = 1;
    
    NSString *itemAlternateTurns = dictToUse[@"ItemAlternateTurns"] ? dictToUse[@"ItemAlternateTurns"] : @"";
    NSString *itemDatePosted = dictToUse[@"ItemDatePosted"] ? dictToUse[@"ItemDatePosted"] : @"";
    
    if ([itemAlternateTurns containsString:@" "] && [[itemAlternateTurns componentsSeparatedByString:@" "] count] > 2) {
        NSArray *arr = [itemAlternateTurns componentsSeparatedByString:@" "];
        numOfTimesBeforeAlternate = [(NSString *)arr[1] intValue];
    }
    
    // Define the reference date
    NSString *referenceDateString = itemDatePosted;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *referenceDate = [dateFormatter dateFromString:referenceDateString];
    
    // Define the target weekday (1 is Sunday, 2 is Monday, and so on)
    NSInteger targetWeekday = 1; // Sunday
    
    if ([itemAlternateTurns containsString:@"Sunday"]) {
        
        targetWeekday = 1;
        
    } else if ([itemAlternateTurns containsString:@"Monday"]) {
        
        targetWeekday = 2;
        
    } else if ([itemAlternateTurns containsString:@"Tuesday"]) {
        
        targetWeekday = 3;
        
    } else if ([itemAlternateTurns containsString:@"Wednesday"]) {
        
        targetWeekday = 4;
        
    } else if ([itemAlternateTurns containsString:@"Thursday"]) {
        
        targetWeekday = 5;
        
    } else if ([itemAlternateTurns containsString:@"Friday"]) {
        
        targetWeekday = 6;
        
    } else if ([itemAlternateTurns containsString:@"Saturday"]) {
        
        targetWeekday = 7;
        
    }
    
    // Create a calendar and set the desired components
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *components = [calendar components:calendarUnit fromDate:referenceDate];
    
    // Get the weekday of the reference date
    NSInteger referenceWeekday = [components weekday];
    
    // Calculate the number of times the target weekday has passed since the reference date
    NSInteger numberOfOccurrences = (NSInteger)ceil((float)(referenceWeekday - targetWeekday + 1) / 7);
    
    NSLog(@"Number of occurrences of target weekday since the reference date: %ld", (long)numberOfOccurrences);
    
    TimeToAlternateTurns = numOfOccurrences % numOfTimesBeforeAlternate == 0;
    
    return TimeToAlternateTurns;
}

-(BOOL)TimeToAlternateTurnsEveryDayWeekMonth:(NSMutableDictionary *)dictToUse allDueDatesArray:(NSMutableArray *)allDueDatesArray {
    
    BOOL TimeToAlternateTurns = NO;
    
    NSString *itemAlternateTurns = dictToUse[@"ItemAlternateTurns"] ? dictToUse[@"ItemAlternateTurns"] : @"";
    NSString *itemDateLastAlternatedTurns = dictToUse[@"ItemDateLastAlternatedTurns"] ? dictToUse[@"ItemDateLastAlternatedTurns"] : @"";
    
    //Find the starting day, week or month of the first due date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MMMM dd, yyyy hh:mm a";
    NSDate *firstPotentialDueDate = [dateFormatter dateFromString:allDueDatesArray.firstObject];
    
    int dayWeekOrMonthOfYearToStartFrom = [[[NotificationsObject alloc] init] GenerateUnitToCheck:firstPotentialDueDate itemAlternateTurns:itemAlternateTurns];
    
    int timesBeforeAlternatingTurns = 1;
  
    if ([itemAlternateTurns containsString:@" "] && [[itemAlternateTurns componentsSeparatedByString:@" "] count] > 2) {
        NSArray *arr = [itemAlternateTurns componentsSeparatedByString:@" "];
        timesBeforeAlternatingTurns = [(NSString *)arr[1] intValue];
    }
 
    //Specify the day, week, or month numbers of when to alternate turns
    NSMutableArray *desiredWeekNumbers = [NSMutableArray array];
    
    for (NSInteger i = dayWeekOrMonthOfYearToStartFrom; i < allDueDatesArray.count; i += timesBeforeAlternatingTurns) {
        
        [desiredWeekNumbers addObject:[NSString stringWithFormat:@"%ld", i]];
        
    }
  
    //Check if current day, week, or month is a valid time to alternate turns
    int currentWeekOfYear = [[[NotificationsObject alloc] init] GenerateUnitToCheck:[NSDate date] itemAlternateTurns:itemAlternateTurns];
  
    
  
    
    
    NSString *lastAlternateTurnsDate = itemDateLastAlternatedTurns;
    NSDate *lastAlternateTurnsDateForm = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:@"MMMM dd, yyyy hh:mm a" dateToConvert:lastAlternateTurnsDate returnAs:[NSDate class]];
    int lastAlternateTurnsWeekOfYear = [[[NotificationsObject alloc] init] GenerateUnitToCheck:lastAlternateTurnsDateForm itemAlternateTurns:itemAlternateTurns];
   
    
   
    
    
    BOOL CurrentTimeIsTheSameAsLastAlternateTime = currentWeekOfYear == lastAlternateTurnsWeekOfYear;
    BOOL CurrentTimeIsAValidTimeToAlternateTurns = [desiredWeekNumbers containsObject:[NSString stringWithFormat:@"%d", currentWeekOfYear]];
 
    
   
    
    
    if (CurrentTimeIsTheSameAsLastAlternateTime == NO && CurrentTimeIsAValidTimeToAlternateTurns == YES) {
        TimeToAlternateTurns = YES;
    }
    
    return TimeToAlternateTurns;
}

#pragma mark - Preimum BOOLs

-(BOOL)PremiumSubscriptionIsOn {
    
//    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"PremiumSubscription"];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"PremiumSubscription"] &&
        [[[NSUserDefaults standardUserDefaults] objectForKey:@"PremiumSubscription"] isEqualToString:@"Yes"]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)PremiumSubscriptionIsActiveForSpecificUserAtIndex:(NSMutableDictionary *)homeMembersDict userID:(NSString *)userID {
  
        NSUInteger index = -1;
        
        if (homeMembersDict &&
            homeMembersDict[@"UserID"] &&
            [homeMembersDict[@"UserID"] containsObject:userID]) {
            index = [homeMembersDict[@"UserID"] indexOfObject:userID];
        }
        
        if ((index != -1) &&
            (homeMembersDict &&
             homeMembersDict[@"WeDivvyPremium"] &&
             [(NSArray *)homeMembersDict[@"WeDivvyPremium"] count] > index &&
             homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionPlan"] &&
             [homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionPlan"] isEqualToString:@""] == NO)) {
            return YES;
        }
    
    return NO;
}

-(BOOL)PremiumSubscriptionIsOnForAtLeastOneHomeMember:(NSMutableDictionary *)homeMembersDict {
    
    BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:homeMembersDict[@"WeDivvyPremium"] classArr:@[[NSArray class], [NSMutableArray class]]];
    
    if (homeMembersDict[@"WeDivvyPremium"] &&
        ObjectIsKindOfClass == YES) {
        
        for (NSDictionary *weDivvyPremium in homeMembersDict[@"WeDivvyPremium"]) {
            
            NSString *weDivvyPremiumPlan = weDivvyPremium[@"SubscriptionPlan"] ? weDivvyPremium[@"SubscriptionPlan"] : @"";
            
            if ([weDivvyPremiumPlan length] > 0) {
                return YES;
            }
            
        }
        
    }
    
    return NO;
}

-(BOOL)PremiumUserHasSubscriptionHistory:(NSMutableDictionary *)homeMembersDict purchasingUserID:(NSString *)purchasingUserID {
    
    NSUInteger index = [homeMembersDict[@"UserID"] containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] ? [homeMembersDict[@"UserID"] indexOfObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] : 1000;
    
    NSMutableDictionary *weDivvyPremium = [(NSArray *)homeMembersDict[@"WeDivvyPremium"] count] > index ? homeMembersDict[@"WeDivvyPremium"][index] : [NSMutableDictionary dictionary];
    
    if (weDivvyPremium[@"SubscriptionHistory"] && [[weDivvyPremium[@"SubscriptionHistory"] allKeys] count] > 0) {
        return YES;
    }
    
    return YES;//return NO;
}

-(BOOL)PremiumUserHasAccountsToGiveAndNotAllUsersHavePremium:(NSMutableDictionary *)homeMembersDict purchasingUserID:(NSString *)purchasingUserID {
    
    BOOL PremiumUserHasAccountsToGive = NO;
    BOOL NotAllUsersHavePremium = NO;
    
    BOOL SubscriptionGivenBySomeoneElse = YES;
    NSString *subscriptionPlan = @"";
    
    NSUInteger index = [homeMembersDict[@"UserID"] containsObject:purchasingUserID] ? [homeMembersDict[@"UserID"] indexOfObject:purchasingUserID] : -1;
    
    if (index == -1) {
        return NO;
    }
    
    if (homeMembersDict &&
        homeMembersDict[@"WeDivvyPremium"] &&
        [(NSArray *)homeMembersDict[@"WeDivvyPremium"] count] > index &&
        homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionDatePurchased"] &&
        [homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionDatePurchased"] length] > 0) {
        
        SubscriptionGivenBySomeoneElse = NO;
        
    }
    
    if (homeMembersDict &&
        homeMembersDict[@"WeDivvyPremium"] &&
        [(NSArray *)homeMembersDict[@"WeDivvyPremium"] count] > index &&
        homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionPlan"] &&
        [homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionPlan"] length] > 0) {
        
        subscriptionPlan = homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionPlan"];
        
    }
    
    if (SubscriptionGivenBySomeoneElse == NO && ([subscriptionPlan containsString:@"Housemate"] || [subscriptionPlan containsString:@"Family"])) {
        
        int accountsToGive = [subscriptionPlan containsString:@"Housemate"] ? 3 : 6;
        int accountsRemainingToGive = accountsToGive;
        
        for (NSDictionary *weDivvyPremiumDict in homeMembersDict[@"WeDivvyPremium"]) {
            
            NSString *datePurchased = weDivvyPremiumDict[@"SubscriptionDatePurchased"] ? weDivvyPremiumDict[@"SubscriptionDatePurchased"] : @"";
            NSString *subscriptionGivenBy = weDivvyPremiumDict[@"SubscriptionGivenBy"] ? weDivvyPremiumDict[@"SubscriptionGivenBy"] : @"";
            
            if ([datePurchased length] == 0 && [subscriptionGivenBy isEqualToString:purchasingUserID]) {
                
                accountsRemainingToGive -= 1;
                
            } else if ([datePurchased length] == 0 && [subscriptionGivenBy length] == 0) {
                
                NotAllUsersHavePremium = YES;
                
            }
            
        }
        
        if (accountsRemainingToGive > 0) {
            PremiumUserHasAccountsToGive = YES;
        }
        
        return PremiumUserHasAccountsToGive == YES && NotAllUsersHavePremium == YES;
        
    }
    
    return NO;
}

-(BOOL)PremiumUnusedAccountsNotificationExists {
    
    NSMutableArray *notificationIdentifierArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"MyNotifications"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"MyNotifications"] : [NSMutableArray array];
    
    for (NSString *identifier in notificationIdentifierArray) {
        
        if ([identifier containsString:@"Unused Premium Accounts"]) {
            
            return YES;
            
        }
        
    }
    
    return NO;
}

-(BOOL)PremiumUserHasIndividualPlanAndHasMoreThanOneHomeMember:(NSMutableDictionary *)homeMembersDict purchasingUserID:(NSString *)purchasingUserID {

    BOOL SubscriptionGivenBySomeoneElse = YES;
    BOOL SubscriptionPurchasedIsIndividual = NO;
    BOOL MoreThanOneHomeMember = NO;
    
    NSString *subscriptionPlan = @"";
    
    NSUInteger index = [homeMembersDict[@"UserID"] containsObject:purchasingUserID] ? [homeMembersDict[@"UserID"] indexOfObject:purchasingUserID] : -1;
    
    if (index == -1) {
        return NO;
    }
    
    if (homeMembersDict &&
        homeMembersDict[@"WeDivvyPremium"] &&
        [(NSArray *)homeMembersDict[@"WeDivvyPremium"] count] > index &&
        homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionDatePurchased"] &&
        [homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionDatePurchased"] length] > 0) {
        
        SubscriptionGivenBySomeoneElse = NO;
        
    }
    
    if (homeMembersDict &&
        homeMembersDict[@"WeDivvyPremium"] &&
        [(NSArray *)homeMembersDict[@"WeDivvyPremium"] count] > index &&
        homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionPlan"] &&
        [homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionPlan"] length] > 0) {
        
        subscriptionPlan = homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionPlan"];
        
    }
    
    SubscriptionPurchasedIsIndividual = [subscriptionPlan containsString:@"Individual"];
    MoreThanOneHomeMember = [(NSArray *)homeMembersDict[@"UserID"] count] > 1;
    
    if (SubscriptionGivenBySomeoneElse == NO && SubscriptionPurchasedIsIndividual == YES && MoreThanOneHomeMember == YES) {
        
        return YES;
        
    }
    
    return NO;
}

-(BOOL)PremiumUserHasHousemateOrFamilyPlan:(NSMutableDictionary *)homeMembersDict purchasingUserID:(NSString *)purchasingUserID {
    
    BOOL SubscriptionGivenBySomeoneElse = YES;
    BOOL SubscriptionPurchasedIsHousemateOrFamily = NO;
    
    NSString *subscriptionPlan = @"";
    
    NSUInteger index = [homeMembersDict[@"UserID"] containsObject:purchasingUserID] ? [homeMembersDict[@"UserID"] indexOfObject:purchasingUserID] : -1;
    
    if (index == -1) {
        return NO;
    }
    
    if (homeMembersDict &&
        homeMembersDict[@"WeDivvyPremium"] &&
        [(NSArray *)homeMembersDict[@"WeDivvyPremium"] count] > index &&
        homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionDatePurchased"] &&
        [homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionDatePurchased"] length] > 0) {
        
        SubscriptionGivenBySomeoneElse = NO;
        
    }
    
    if (homeMembersDict &&
        homeMembersDict[@"WeDivvyPremium"] &&
        [(NSArray *)homeMembersDict[@"WeDivvyPremium"] count] > index &&
        homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionPlan"] &&
        [homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionPlan"] length] > 0) {
        
        subscriptionPlan = homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionPlan"];
        
    }
    
    SubscriptionPurchasedIsHousemateOrFamily = [subscriptionPlan containsString:@"Housemate"] || [subscriptionPlan containsString:@"Family"];
    
    if (SubscriptionGivenBySomeoneElse == NO && SubscriptionPurchasedIsHousemateOrFamily == YES) {
        
        return YES;
        
    }
    
    return NO;
}

-(BOOL)PremiumLimitForTasksReached:(NSMutableArray *)allItemIDsArrays homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
//    //Lucia
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] &&
//        [[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] isEqualToString:@"2023-03-04 12:56:571364166"]) {
//        
//        if ([[[BoolDataObject alloc] init] PremiumSubscriptionIsOnForAtLeastOneHomeMember:homeMembersDict] == NO && [allItemIDsArrays count] >= 50) {
//            return YES;
//        }
//        
//    } else {
//        
//        if ([[[BoolDataObject alloc] init] PremiumSubscriptionIsOnForAtLeastOneHomeMember:homeMembersDict] == NO && [allItemIDsArrays count] >= 50) {
//            return YES;
//        }
//        
//    }
    
    return NO;
}


#pragma mark - Other BOOLs

-(BOOL)CheckIfObjectIsKindOfClass:(id)object classArr:(NSArray *)classArr {
    
    for (Class class in classArr) {
        
        if ([object isKindOfClass:class]) {
            return YES;
        }
        
    }
    
    return NO;
}

-(BOOL)NoSignUp {
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"NoSignUp"] isEqualToString:@"Yes"]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)DarkModeIsOn {
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"DarkModeSelected"] isEqualToString:@"Yes"]) {
        return YES;
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"AutoDarkModeSelected"]) {
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"AutoDarkModeSelected"] isEqualToString:@"Manual"] == NO) {
            
            NSString *autoDateModeTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"AutoDarkModeSelected"];
            NSString *startTimeString = [[autoDateModeTime componentsSeparatedByString:@" to "] count] > 0 ? [autoDateModeTime componentsSeparatedByString:@" to "][0] : @"";
            NSString *endTimeString = [[autoDateModeTime componentsSeparatedByString:@" to "] count] > 1 ? [autoDateModeTime componentsSeparatedByString:@" to "][1] : @"";
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"hh:mm a"];
            
            NSString *nowTimeString = [formatter stringFromDate:[NSDate date]];
            
            NSDateComponents *startTimeComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[formatter dateFromString:startTimeString]];
            NSDateComponents *endTimeComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[formatter dateFromString:endTimeString]];
            NSDateComponents *nowTimeComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[formatter dateFromString:nowTimeString]];
            
            int startTime = (60 * (int)[startTimeComponents hour] + (int)[startTimeComponents minute]);
            int endTime = (60 * (int)[endTimeComponents hour] + (int)[endTimeComponents minute]);
            int nowTime = (60 * (int)[nowTimeComponents hour] + (int)[nowTimeComponents minute]);
            
            if (startTime <= nowTime && nowTime < endTime) {
                return YES;
            }
            
        }
        
    }
    
    return NO;
}

-(BOOL)DateHasAMPM:(NSString *)dateString {
    
    if ([dateString containsString:@"AM"] || [dateString containsString:@"PM"] || [dateString containsString:@"am"] || [dateString containsString:@"pm"] || [dateString containsString:@"a.m."] || [dateString containsString:@"p.m."] || [dateString containsString:@"a.m"] || [dateString containsString:@"p.m"] || [dateString containsString:@"No Due Date"]) {
        
        return YES;
        
    }
    
    return NO;
}

-(BOOL)EmailFormatValid:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}

-(BOOL)CheckIfUserIsUsing24HourFormat {
    
    NSString *format = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    BOOL is24Hour = ([format rangeOfString:@"a"].location == NSNotFound);
    
    return is24Hour;
    
}

-(BOOL)UseLocallyGeneratedTopics:(NSMutableDictionary *)homeMembersDict {
    
    NSArray *userIDArray = homeMembersDict[@"UserID"] ? homeMembersDict[@"UserID"] : [NSMutableArray array];
    
    if ([userIDArray count] <= 6) {
        return YES;
    }
    
    return NO;
}

-(BOOL)UserWasCreatedAfterChange {
    
    NSString *myUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    NSArray *arr = [myUserID containsString:@" "] ? [myUserID componentsSeparatedByString:@" "] : @[];
    NSString *myUserIDDate = [arr count] > 0 ? arr[0] : @"0000-00-00";
    NSDate *myUserIDDateInDateForm = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:@"yyyy-MM-dd" dateToConvert:myUserIDDate returnAs:[NSDate class]];
    NSDate *changeDateInDateForm = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:@"yyyy-MM-dd" dateToConvert:@"2023-11-11" returnAs:[NSDate class]];
    
    BOOL UserWasCreatedAfterTheChange = [myUserIDDateInDateForm timeIntervalSinceDate:changeDateInDateForm] > 0;
    
    return UserWasCreatedAfterTheChange;
}

@end
