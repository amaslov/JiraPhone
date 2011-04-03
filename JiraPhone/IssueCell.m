//
//  IssueCell.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 4/2/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "IssueCell.h"
#import "IssueCellBackground.h"
#import "IssueDetailsViewController.h"

const CGFloat IssueCellDefaultRowHeight = 44.0;


@implementation IssueCell

+ (NSString *)reuseIdentifier
{
	return NSStringFromClass(self);
}

+ (NSString *)nibName
{
	return nil;
}

+ (UITableViewCellStyle)style
{
	return UITableViewCellStyleDefault;
}

+ (Class)issueCellBackgroundClass
{
	return [IssueCellBackground class];
}

+ (CGFloat)rowHeight
{
	static CFMutableDictionaryRef rowHeightsForClasses = nil;
	
	NSNumber *rowHeight =
	rowHeightsForClasses ?
	(NSNumber *)CFDictionaryGetValue(rowHeightsForClasses, self) : nil;
	if (rowHeight == nil)
	{
		NSString *nibName = [[self class] nibName];
		if (nibName)
		{
			if (rowHeightsForClasses == nil)
			{
				rowHeightsForClasses =
				CFDictionaryCreateMutable(
										  kCFAllocatorDefault,
										  0,
										  &kCFTypeDictionaryKeyCallBacks,
										  &kCFTypeDictionaryValueCallBacks);
			}
			
			IssueCell *cellInstance = [[[[self class] alloc] init] autorelease];
			[[NSBundle mainBundle]
			 loadNibNamed:nibName
			 owner:cellInstance
			 options:nil];
			UIView *cellContentView = cellInstance->content;
			NSAssert(cellContentView != nil, @"NIB file loaded but content property not set.");
			rowHeight = [NSNumber numberWithFloat:cellContentView.bounds.size.height];
			CFDictionaryAddValue(rowHeightsForClasses, self, rowHeight);
		}
		else
		{
			return IssueCellDefaultRowHeight;
		}
	}
	
	return [rowHeight floatValue];
}

- (id)init
{
	UITableViewCellStyle style = [[self class] style];
	NSString *identifier = [[self class] reuseIdentifier];
	
	if (self = [super initWithStyle:style reuseIdentifier:identifier])
	{
		NSString *nibName = [[self class] nibName];
		if (nibName)
		{
			contentArray =
			[[[NSBundle mainBundle]
			  loadNibNamed:nibName
			  owner:self
			  options:nil]
			 retain];
			NSAssert(content != nil, @"NIB file loaded but content property not set.");
			[self addSubview:content];
		}
		
		[self finishConstruction];
	}
	return self;
}


//
// contentView
//
// Overrides the internal behavior to set the contentView
//
// returns the content view as loaded from the nib file.
//
- (UIView *)contentView
{
	if (content)
	{
		return content;
	}
	return [super contentView];
}

//
// prepareForReuse
//
// Normally used to unhighlight cells. Deliberately suppressed.
// 
- (void)prepareForReuse
{
}

//
// finishConstruction
//
// Invoked after the cell is constructed to perform any post load tasks
//
- (void)finishConstruction
{
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
	if (!self.backgroundView)
	{
		IssueCellBackground *cellBackgroundView =
		[[[[[self class] issueCellBackgroundClass] alloc]
		  initSelected:NO
		  grouped:aTableView.style == UITableViewStyleGrouped]
		 autorelease];
		self.backgroundView = cellBackgroundView;
		IssueCellBackground *cellSelectionView =
		[[[[[self class] issueCellBackgroundClass] alloc]
		  initSelected:YES
		  grouped:aTableView.style == UITableViewStyleGrouped]
		 autorelease];
		self.selectedBackgroundView = cellSelectionView;
	}
	
	if (aTableView.style == UITableViewStyleGrouped)
	{
		IssueCellGroupPosition position = 
		[IssueCellBackground positionForIndexPath:anIndexPath inTableView:aTableView];
		((IssueCellBackground *)self.backgroundView).position = position;
		((IssueCellBackground *)self.selectedBackgroundView).position = position;
	}
}

//
// handleSelectionInTableView:
//
// An overrideable method to handle behavior when a row is selected.
// Default implementation just deselects the row.
//
// Parameters:
//    aTableView - the table view from which the row was selected
//
- (void)handleSelectionInTableView:(UITableView *)aTableView
{
	[(IssueDetailsViewController *)aTableView.delegate
	 performSelector:@selector(deselect)
	 withObject:nil
	 afterDelay:0.25];
}

//
// setSelected:animated:
//
// The default setSelected:animated: method sets the textLabel and
// detailTextLabel background to white when invoked (or at least, it did in iOS
// 3 -- I haven't checked in a while). This override undoes that
// and sets their background to clearColor.
//
// Parameters:
//    selected - is the cell being selected
//    animated - should the selection be animated
//
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
	
	if (!content)
	{
		UIColor *clearColor = [UIColor clearColor];
		if (![self.textLabel.backgroundColor isEqual:clearColor])
		{
			self.textLabel.backgroundColor = [UIColor clearColor];
		}
		if (![self.detailTextLabel.backgroundColor isEqual:clearColor])
		{
			self.detailTextLabel.backgroundColor = [UIColor clearColor];
		}
	}
}

//
// dealloc
//
// Release instance memory
//
- (void)dealloc
{
	[contentArray release];
	
	[super dealloc];
}


@end
