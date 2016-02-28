//
//  ToDoItem.h
//  MyTodo
//
//  Created by Sonia Reddy Kolli on 02/10/15.
//  Copyright (c) 2015 Sonia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "SingletonDefines.h"

@interface ToDoRealm : NSObject

declareSingleton(ToDoRealm);

-(RLMRealm *) toDoDatabase;

@end


@interface ToDoRealm (){
    NSString *realmPath;
}

@end

