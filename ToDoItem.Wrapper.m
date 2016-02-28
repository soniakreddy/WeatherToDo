//
//  ToDoItem.h
//  MyTodo
//
//  Created by Sonia Reddy Kolli on 02/10/15.
//  Copyright (c) 2015 Sonia. All rights reserved.
//

#import "ToDoItem+Wrapper.h"
#import "ToDoRealm.h"

@implementation ToDoItem(Wrapper)

+(RLMResults*)ToDoListForUser:(BOOL)bAscending{
    
    RLMRealm *realm = [[ToDoRealm sharedManager] toDoDatabase];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isCompleted=%d",NO];
    RLMResults *results = [[ToDoItem objectsInRealm:realm withPredicate:predicate] sortedResultsUsingProperty:@"temperature" ascending:bAscending];
;
    
    return results;

}

+(RLMResults*)CompletedToDoListForUser:(BOOL)bAscending{
    RLMRealm *realm = [[ToDoRealm sharedManager] toDoDatabase];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isCompleted=%d",YES];
    RLMResults *results = [[ToDoItem objectsInRealm:realm withPredicate:predicate] sortedResultsUsingProperty:@"temperature" ascending:bAscending];

    
    return results;
}


+(BOOL)addItemInDB:(ToDoItem*)todoItem{
    RLMRealm *realm = [[ToDoRealm sharedManager] toDoDatabase];
    [realm beginWriteTransaction];

    ToDoItem *itemInDB = [ToDoItem objectInRealm:realm forPrimaryKey:todoItem.itemName];
    if (nil == itemInDB) {
        itemInDB = [[ToDoItem alloc] init];
        itemInDB.itemName = todoItem.itemName;
    }
    
    itemInDB.temperature = todoItem.temperature;
    itemInDB.isCompleted = todoItem.isCompleted;
    itemInDB.cityName = todoItem.cityName;
    
    [realm addOrUpdateObject:itemInDB];
    [realm commitWriteTransaction];
    
    return YES;
}


+(ToDoItem*)todoItemByName:(NSString*)name{
    ToDoItem *itemInDB = nil;
    RLMRealm *realm = [[ToDoRealm sharedManager] toDoDatabase];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"itemName=%@",name];
    
    RLMResults *results = [ToDoItem objectsInRealm:realm withPredicate:predicate];
    if (results.count > 0) {
       itemInDB = [[ToDoItem objectsInRealm:realm withPredicate:predicate] objectAtIndex:0];
    }
    return itemInDB;
}

+(void)markItemCompleted:(NSString*)itemName{
    ToDoItem *item = [ToDoItem todoItemByName:itemName];
    
    if (item) {
        
        RLMRealm *realm = [[ToDoRealm sharedManager] toDoDatabase];
        
        [realm beginWriteTransaction];
        item.isCompleted = YES;
        [realm addOrUpdateObject:item];
        [realm commitWriteTransaction];
    }
}

+(void)markItemInComplete:(NSString*)itemName{
    
    ToDoItem *item = [ToDoItem todoItemByName:itemName];
    
    if (item) {
        
        RLMRealm *realm = [[ToDoRealm sharedManager] toDoDatabase];
        
        [realm beginWriteTransaction];
        item.isCompleted = NO;
        [realm addOrUpdateObject:item];
        [realm commitWriteTransaction];
    }
}

@end
