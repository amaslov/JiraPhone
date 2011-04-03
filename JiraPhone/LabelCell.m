//
//  LabelCell.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 4/2/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "LabelCell.h"
#import "DetailViewController.h"

@implementation LabelCell

- (void)configureForData:(id)dataObject
			   tableView:(UITableView *)aTableView
			   indexPath:(NSIndexPath *)anIndexPath
{
	[super configureForData:dataObject tableView:aTableView indexPath:anIndexPath];
	
	self.textLabel.text = dataObject;
}

//
// handleSelectionInTableView:
//
// Performs the appropriate action when the cell is selected
//
- (void)handleSelectionInTableView:(UITableView *)aTableView
{
	[super handleSelectionInTableView:aTableView];
	
	NSInteger rowIndex = [aTableView indexPathForCell:self].row;
	[((IssueDetailsViewController *)aTableView.delegate).navigationController
	 pushViewController:[[[DetailViewController alloc] initWithRowIndex:rowIndex] autorelease]
	 animated:YES];
}

@end
