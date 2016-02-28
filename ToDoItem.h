//
//  ToDoItem.h
//  MyTodo
//
//  Created by Sonia Reddy Kolli on 02/10/15.
//  Copyright (c) 2015 Sonia. All rights reserved.
//

#import <Realm/Realm.h>

@interface ToDoItem : RLMObject

@property(nonatomic,strong) NSString *itemName;
@property(nonatomic) BOOL isCompleted;
@property(nonatomic) float temperature;
@property(nonatomic,strong) NSString *cityName;

@end

RLM_ARRAY_TYPE(ToDoItem)