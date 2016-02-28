//
//  filtersTableCell.h
//  UPS_mobile_iphone
//
//  Created by mobiledev on 9/17/14.
//  Copyright (c) 2014 United Parcel Service Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterProtocol.h"

@interface todoTableCell : UITableViewCell<UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
{   NSMutableArray *openTimeArray;
    NSMutableArray *dropoffDeadlineTimeArray;
    UIActionSheet *timeActionSheet;
    UIView *timeActionSheetView;
    int timeDropdown;
}

@property (strong, nonatomic)IBOutlet UILabel *cellLabel;
@property (strong, nonatomic)IBOutlet UISwitch *cellSwitch;
@property (strong, nonatomic)IBOutlet UILabel *cellCheckboxLabel;
@property (strong, nonatomic)IBOutlet UIButton *cellCheckbox;
@property (strong, nonatomic) IBOutlet UpsTextFieldDropdown *cellTimeDropdown;
@property (strong, nonatomic) IBOutlet UIView *cellViewTimeDropdown;
@property (strong, nonatomic) IBOutlet UIPickerView *timePickerView;
@property (strong, nonatomic) IBOutlet UIView *timeActionSheetView;
@property (strong, nonatomic) UIActionSheet *timeActionSheet;
@property (strong, nonatomic) NSMutableArray *openTimeArray;
@property (strong, nonatomic) NSMutableArray *dropoffDeadlineTimeArray;

+(todoTableCell*) cell;
-(IBAction)checkboxClicked;
-(IBAction)dismissActionSheet:(id)sender;
-(IBAction)switchStatusChanged:(id)sender;
-(IBAction)checkboxStatusChanged:(id)sender;

-(void) makeUpOpenCells;
@property (nonatomic, strong) id <FilterSwitchStatusChange> switchStatusDelegate;
@property (nonatomic, strong) id <FilterDropdownStatusChange> dropdownStatusDelegate;
@property (nonatomic, strong) id <FilterCheckboxStatusChange> checkboxStatusDelegate;

-(void)setSelectedIndexForTimeDropDown:(NSInteger)selectedIndex;

@end
