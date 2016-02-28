//
//  UtilityClass.m
//  MyTodo
//
//  Created by Sonia Reddy Kolli on 02/10/15.
//  Copyright © 2015 Sonia. All rights reserved.
//

#import "UtilityClass.h"
#import "PrefixHeader.pch"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "AppDefines.h"

@implementation UtilityClass


+(float)getTemperatureForCity:(NSString *)cityName{
    __block float temperature = 0.0;
    NSString *urlString = @"http://api.openweathermap.org/data/2.5/weather?q=%@&appid=bd82977b86bf27fb59a04b61b657fb6f";

    NSString *formatedUrl = [NSString stringWithFormat:urlString,[cityName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURL *url = [NSURL URLWithString:formatedUrl];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"response %@",responseObject);
        
        NSDictionary *mainDict =  [responseObject objectForKey:@"main"];
        temperature = [[mainDict valueForKey:@"temp"] floatValue];
        
        NSDictionary *userInfo = @{KEY_TEMP:[NSNumber numberWithFloat:temperature]};

        [[NSNotificationCenter defaultCenter] postNotificationName:TEMP_ACCQUIRED_NOTIFICATION object:nil userInfo:userInfo];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSDictionary *userInfo = @{KEY_TEMP:[NSNumber numberWithFloat:0]};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:TEMP_ACCQUIRED_NOTIFICATION object:nil userInfo:userInfo];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Server Error"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    // 5
    [operation start];
    
//    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
//    [self.navigationController.view addSubview:HUD];
//    
//    HUD.delegate = self;
//    HUD.labelText = @"Loading";
//    [HUD show:YES];
//
    
    return temperature;
}

@end
