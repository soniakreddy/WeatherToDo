//
//  ToDoItem.h
//  MyTodo
//
//  Created by Sonia Reddy Kolli on 02/10/15.
//  Copyright (c) 2015 Sonia. All rights reserved.
//

#import "ToDoItem.h"


@interface ToDoItem(Wrapper)

+(RLMResults*)ToDoListForUser:(BOOL)bAscending;

+(ToDoItem*)todoItemByName:(NSString*)itemName;

+(BOOL)addItemInDB:(ToDoItem*)todoItem;

+(RLMResults*)CompletedToDoListForUser:(BOOL)bAscending;

+(void)markItemCompleted:(NSString*)itemName;
+(void)markItemInComplete:(NSString*)itemName;

@end
