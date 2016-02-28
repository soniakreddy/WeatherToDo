//
//  ToDoItem.h
//  MyTodo
//
//  Created by Sonia Reddy Kolli on 02/10/15.
//  Copyright (c) 2015 Sonia. All rights reserved.
//

#import "ToDoRealm.h"
#import "SingletonDefines.h"

@implementation ToDoRealm

defineSingleton(ToDoRealm);

-(instancetype) init {
    if (self = [super init]) {
        realmPath = [NSString stringWithFormat:@"%@/todo.realm"
                     ,[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]];
    }
    
    return self;
}

-(RLMRealm *) toDoDatabase {
    
    RLMRealm *realm =  [RLMRealm realmWithPath:realmPath];
    return realm;
}

@end
