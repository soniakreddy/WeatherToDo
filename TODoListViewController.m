//
//  ViewController.m
//  MyTodo
//
//  Created by Sonia Reddy Kolli on 02/10/15.
//  Copyright (c) 2015 Sonia. All rights reserved.
//

#import "TODoListViewController.h"
#import "CustomToDoTableViewCell.h"
#import "ToDoItem+Wrapper.h"
#import <Realm/Realm.h>
#import "NewItemAddViewController.h"

@interface TODoListViewController (){
    RLMResults *toDoItems;
    RLMResults *toDoCompletedItems;
    BOOL bSortByAscending;
}

@end

@implementation TODoListViewController

@synthesize todoTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    todoTableView.dataSource = self;
    todoTableView.delegate = self;
    
    todoTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    UIBarButtonItem *bbutton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(Add)];
    
    UIBarButtonItem *sortBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(sortItems)];
    NSArray *buttons = @[bbutton,sortBtn];
    self.navigationItem.rightBarButtonItems = buttons;
    bSortByAscending = YES;
    
    self.title = @"Todo List";
}

-(void)sortItems{
    
    bSortByAscending = !bSortByAscending;
    [self refreshView];
}

-(void)Add{

    NSLog(@"Launch add view controller");
    
    NewItemAddViewController *newTaskVC = (NewItemAddViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"NewItemAddViewController"];
    
    [self.navigationController pushViewController:newTaskVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [self refreshView];
}


#pragma mark -
#pragma mark Table View Datasource & Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   
    NSInteger numberOfSections = 0;
    
    numberOfSections = toDoItems.count?numberOfSections+1:numberOfSections;
    numberOfSections = toDoCompletedItems.count?numberOfSections+1:numberOfSections;
    
    return numberOfSections;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = @"";
    
    if (0 == section) {
        if (toDoItems.count > 0) {
            sectionTitle = @"Tasks To Do";
        }
        else{
            sectionTitle = @"Tasks Completed";
        }
    }
    else if(1 == section){
        sectionTitle = @"Tasks Completed";
    }

    return sectionTitle;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    view.tintColor = [UIColor darkGrayColor];
    
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger numberOfRows = 0;
    
    if (0 == section) {
        if (toDoItems.count > 0) {
            numberOfRows = toDoItems.count;
        }
        else{
            numberOfRows = toDoCompletedItems.count;
        }
    }
    else if(1 == section){
        numberOfRows = toDoCompletedItems.count;
    }
    
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RLMResults *results;
    BOOL bCompleted = NO;
    if (0 == indexPath.section) {
        if (toDoItems.count > 0) {
            results = toDoItems;
        }
        else{
            results = toDoCompletedItems;
            bCompleted = YES;
        }
    }
    else if(1 == indexPath.section){
        results = toDoCompletedItems;
        bCompleted = YES;
    }
    
    static NSString *CellIdentifier = @"CustomToDoTableViewCell";
    CustomToDoTableViewCell *cell = (CustomToDoTableViewCell *)[todoTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    ToDoItem *item = [results objectAtIndex:indexPath.row];
    
    cell.todoItem.text = item.itemName;
    cell.temperature.text = [NSString stringWithFormat:@"%@ %2.0f",item.cityName,item.temperature];

    [cell.btnCompleted setHidden:!bCompleted];
    return cell;
}

-( CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80.0;
}

-( CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 58.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //do nothing as of now. we can remove this
    RLMResults *results;
    
    if (0 == indexPath.section) {
        if (toDoItems.count > 0) {
            results = toDoItems;
        }
        else{
            results = toDoCompletedItems;
        }
    }
    else if(1 == indexPath.section){
        results = toDoCompletedItems;
    }
    
    ToDoItem *item = [results objectAtIndex:indexPath.row];
    
    
    if (!item.isCompleted) {
        [ToDoItem markItemCompleted:item.itemName];
    }
    else {
        [ToDoItem markItemInComplete:item.itemName];
    }

    [self refreshView];
}


#pragma mark - button Action related

-(void)refreshView{
    toDoItems = [ToDoItem ToDoListForUser:bSortByAscending];
    toDoCompletedItems = [ToDoItem CompletedToDoListForUser:bSortByAscending];
    [todoTableView reloadData];
}

@end
