//
//  CustomToDoTableViewCell.h
//  MyTodo
//
//  Created by Sonia Reddy Kolli on 02/10/15.
//  Copyright (c) 2015 Sonia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomToDoTableViewCell : UITableViewCell

@property(nonatomic,strong) IBOutlet UILabel *todoItem;
@property(nonatomic,strong) IBOutlet UIButton *btnCompleted;

@property(nonatomic,strong) IBOutlet UILabel *temperature;
@end
