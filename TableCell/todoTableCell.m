//
//  filtersTableCell.m
//  UPS_mobile_iphone
//
//  Created by mobiledev on 9/17/14.
//  Copyright (c) 2014 United Parcel Service Inc. All rights reserved.
//

#import "todoTableCell.h"
#import "UpsColorPalette.h"

@implementation todoTableCell{
    NSInteger indexOpen;
    NSInteger timeDropdownSelectedIndex;
    NSUInteger tempIndex;
    
}
@synthesize timePickerView;
@synthesize timeActionSheetView;
@synthesize timeActionSheet;
@synthesize openTimeArray;
@synthesize dropoffDeadlineTimeArray;
@synthesize switchStatusDelegate;

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+(NSString*) identifier
{
    return @"todoTableCell";
}

+(todoTableCell *)cell{
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"todoTableCell" owner:self options:nil];
    for (id currentObject in nibContents) {
        if ([currentObject isKindOfClass:[todoTableCell class]]) {
            return currentObject;
        }
    }
    return nil;
}
-(IBAction)switchStatusChanged:(id)sender{
    
    UISwitch *changedSwitch = sender;
    
    if ([self.switchStatusDelegate respondsToSelector:@selector(onFilterSwitchStatusChange:userData:)]) {
        [self.switchStatusDelegate onFilterSwitchStatusChange:changedSwitch.isOn userData:[NSNumber numberWithLong:changedSwitch.tag]];
    }
}

-(void)setSelectedIndexForTimeDropDown:(NSInteger)selectedIndex{
    timeDropdownSelectedIndex = selectedIndex;
    [timePickerView reloadAllComponents];
}

-(IBAction)checkboxStatusChanged:(id)sender{
    
    UIButton *changedCheckbox = sender;
    
    if ([self.checkboxStatusDelegate respondsToSelector:@selector(onFilterCheckboxStatusChange:userData:)]) {
        [self.checkboxStatusDelegate onFilterCheckboxStatusChange:changedCheckbox.isSelected userData:[NSNumber numberWithLong:changedCheckbox.tag]];
    }
}
-(IBAction) checkboxClicked{
    
    if ([_cellCheckbox isSelected]) {
        
        [_cellCheckbox setSelected:NO];
    }
    else {
        [_cellCheckbox setSelected:YES];
    }
}


-(void) textFieldDidBeginEditing:(UITextField *)textField {
    
    
    
    timeDropdown = (int)textField.tag;
    
    [timePickerView reloadAllComponents];
    
    [self.timePickerView selectRow:timeDropdownSelectedIndex inComponent:0 animated:YES];
    
}

-(void) textFieldDidEndEditing:(UITextField *)textField {
    
    timeDropdownSelectedIndex =[self.timePickerView selectedRowInComponent:0];
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [openTimeArray count];
    
    
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;

{
    
    return [openTimeArray objectAtIndex:row];
    
}






@end
