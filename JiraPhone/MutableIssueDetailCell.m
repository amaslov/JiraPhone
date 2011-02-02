//
//  MutableIssueDetailCell.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 1/10/11.
//  Copyright 2011 AMaslov. All rights reserved.
//
#import "MutableIssueDetailCell.h"


@implementation MutableIssueDetailCell
@synthesize title;
@synthesize textField;

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
	[title release];
	[textField release];
    [super dealloc];
}


@end
