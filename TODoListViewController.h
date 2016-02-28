//
//  ViewController.h
//  MyTodo
//
//  Created by Sonia Reddy Kolli on 02/10/15.
//  Copyright (c) 2015 Sonia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TODoListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) IBOutlet UITableView *todoTableView;

@end

