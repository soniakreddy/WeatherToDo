//
//  NewItemAddViewController.m
//  MyTodo
//
//  Created by Sonia Reddy Kolli on 02/10/15.
//  Copyright © 2015 Sonia. All rights reserved.
//

#import "NewItemAddViewController.h"
#import "UtilityClass.h"
#import "AppDefines.h"
#import "MBProgressHUD.h"
#import "ToDoItem+Wrapper.h"

@interface NewItemAddViewController (){
    MBProgressHUD *HUD;
}

@end

@implementation NewItemAddViewController

@synthesize cityName;
@synthesize taskName;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Add New Task";
}

-(void)viewDidAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTemperatureAccuring:) name:TEMP_ACCQUIRED_NOTIFICATION object:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)onTemperatureAccuring:(NSNotification*)notification{

    //create a new item here
    NSDictionary *userInfo = [notification userInfo];
    float cityTemperature = [[userInfo objectForKey:KEY_TEMP] floatValue];
    
    ToDoItem *item = [[ToDoItem alloc] init];
    item.itemName = taskName.text;
    item.temperature = cityTemperature;
    item.cityName = cityName.text;
    item.isCompleted = NO;
    
    [ToDoItem addItemInDB:item];
    [HUD removeFromSuperview];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)doneBtnPressed:(id)sender{
    NSString *cityStr = cityName.text;
    
    [UtilityClass getTemperatureForCity:cityStr];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.labelText = @"Getting Temperature";
    [HUD show:YES];

    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
