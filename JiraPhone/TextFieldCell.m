//
//  TextFieldCell.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 4/2/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "TextFieldCell.h"


@implementation TextFieldCell


@synthesize textField;

- (void)dealloc
{
	[textField release];
	textField = nil;
	[label release];
	label = nil;
	
	[super dealloc];
}

- (NSString *)accessibilityLabel
{
	return [NSString stringWithFormat:@"%@ %@", label.text, textField.text];
}

// finishConstruction
//
// Completes construction of the cell.
// WITHOUT DAMNED NIBS!!!!!

- (void)finishConstruction
{
	[super finishConstruction];
	
	CGFloat height = self.contentView.bounds.size.height;
	CGFloat width = self.contentView.bounds.size.width;
	CGFloat fontSize = [UIFont labelFontSize] - 2;
	CGFloat labelWidth = 100;
	CGFloat margin = 8;
	CGFloat heightPadding = 8;
	
	self.selectionStyle = UITableViewCellSelectionStyleNone;
	
    textField =
	[[UITextField alloc]
	 initWithFrame:
	 CGRectMake(
				labelWidth + 2 * margin,
				0, 
				width - labelWidth - 2.0 * margin,
				height - 1)];
	textField.font = [UIFont systemFontOfSize:fontSize];
	textField.textAlignment = UITextAlignmentLeft;
	textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	textField.autocorrectionType = UITextAutocorrectionTypeNo;
	textField.backgroundColor = [UIColor clearColor];
	textField.clearButtonMode = UITextFieldViewModeWhileEditing;
	textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	
	[self.contentView addSubview:textField];
	
	label = 
	[[UILabel alloc]
	 initWithFrame:
	 CGRectMake(
				margin,
				floor(0.5 * (height - fontSize - heightPadding)),
				labelWidth,
				fontSize + heightPadding)];
	label.textAlignment = UITextAlignmentRight;
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:fontSize];
	label.highlightedTextColor = [UIColor colorWithRed:0.50 green:0.2 blue:0.0 alpha:1.0];
	label.textColor = [UIColor blackColor];
	label.shadowColor = [UIColor whiteColor];
	label.shadowOffset = CGSizeMake(0, 1);
	
	[self.contentView addSubview:label];
}

//
// configureForData:tableView:indexPath:
//
// Invoked when the cell is given data. All fields should be updated to reflect
// the data.
//
// Parameters:
//    dataObject - the dataObject (can be nil for data-less objects)
//    aTableView - the tableView (passed in since the cell may not be in the
//		hierarchy)
//    anIndexPath - the indexPath of the cell
//

- (void)configureForData:(id)dataObject
			   tableView:(UITableView *)aTableView
			   indexPath:(NSIndexPath *)anIndexPath
{
	[super configureForData:dataObject tableView:aTableView indexPath:anIndexPath];
	
	label.text = [(NSDictionary *)dataObject objectForKey:@"label"];
	textField.text = [(NSDictionary *)dataObject objectForKey:@"value"];
	textField.placeholder = [(NSDictionary *)dataObject objectForKey:@"placeholder"];
	
	textField.delegate = (IssueDetailsViewController *)aTableView.delegate;
}



@end
