//
//  SingletonDefines.h
//  VisyblApp
//
//  Created by Sonia Reddy Kolli on 02/10/15.
//  Copyright (c) 2015 Senthil Navigations Pvt. Ltd. All rights reserved.
//

#ifndef VisyblApp_SingletonDefines_h
#define VisyblApp_SingletonDefines_h

#pragma mark - Singletons

#define declareSingleton(MyClass) \
+(MyClass*)sharedManager;


#define defineSingleton(MyClass) \
\
+ (MyClass *)sharedManager   \
\
{   \
\
static MyClass *sharedManager = nil;   \
\
static dispatch_once_t onceToken;   \
\
dispatch_once(&onceToken, ^{    \
\
sharedManager = [[MyClass alloc] init];    \
\
}); \
\
return sharedManager; \
}

#endif
