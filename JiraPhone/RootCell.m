//
//  RootCell.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 4/27/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "RootCell.h"


@implementation RootCell

@synthesize valueField;
//@synthesize textField;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
	[valueField release];
	//[textField release];
    [super dealloc];
}
/*
-(void)textFieldDidEndEditing:(UITextField *)textField {
	valueField=textField.text;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
//	check for input correctness
	return YES;
}
*/

@end
