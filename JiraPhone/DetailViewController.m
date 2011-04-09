//
//  DetailViewController.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 4/2/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "DetailViewController.h"
#import "IssueCell.h"

@implementation DetailViewController


// initWithRowIndex:
//
// Initializes the detail view with the only "detail view" piece of information:
// the row index of the selected view.
//
// Parameters:
//    aRowIndex - the selected row index
//
// returns the initialized row
// TODO - change to show groups and return the selection once selected
- (id)initWithRowIndex:(NSInteger)aRowIndex
{
	self = [super init];
	if (self != nil)
	{
		rowIndex = aRowIndex;
	}
	return self;
}

- (NSString *)title
{
	return NSLocalizedString(@"Details", @"");
}


// viewDidLoad
//
// Constructs a single, static row.
//
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self addSectionAtIndex:0 withAnimation:UITableViewRowAnimationNone];
	[self
	 appendRowToSection:0
	 cellClass:[LabelCell class]
	 cellData:[NSString stringWithFormat:
			   NSLocalizedString(@"You selected NIB loaded cell %ld", @""), rowIndex + 1]
	 withAnimation:UITableViewRowAnimationNone];
}


@end
