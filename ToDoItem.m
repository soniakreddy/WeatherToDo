//
//  ToDoItem.m
//  MyTodo
//
//  Created by Sonia Reddy Kolli on 02/10/15.
//  Copyright (c) 2015 Sonia. All rights reserved.
//

#import "ToDoItem.h"


@implementation ToDoItem


+ (NSDictionary *)defaultPropertyValues
{
    
    return @{@"itemName":@"",
             @"cityName":@"",
             @"isCompleted":@(NO),
             @"temperature":@(0)
            };
}

// Specify properties to ignore (Realm won't persist these)

+ (NSArray *)ignoredProperties
{
    return @[];
}

+(NSString *)primaryKey{
    return @"itemName";
}

@end