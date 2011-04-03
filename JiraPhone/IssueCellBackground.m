//
//  IssueCellBackground.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 4/2/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "IssueCellBackground.h"
#import "RoundRect.h"
#import "IssueDetailsViewController.h"
#import <QuartzCore/QuartzCore.h>

CGGradientRef IssueCellBackgroundGradient(BOOL selected)
{
	static CGGradientRef backgroundGradient = NULL;
	static CGGradientRef selectedBackgroundGradient = NULL;
	
	if (!selected && !backgroundGradient ||
		selected && !selectedBackgroundGradient)
	{
		UIColor *contentColorTop;
		UIColor *contentColorBottom;
		if (selected)
		{
			contentColorTop = [UIColor colorWithRed:0.70 green:0.82 blue:0.0 alpha:1.0];
			contentColorBottom = [UIColor colorWithRed:0.95 green:0.90 blue:0.0 alpha:1.0];
		}
		else
		{
			contentColorTop = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
			contentColorBottom = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
		}
		
		CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
		CGFloat backgroundColorComponents[3][4];
		memcpy(
			   backgroundColorComponents[0],
			   CGColorGetComponents(contentColorTop.CGColor),
			   sizeof(CGFloat) * 4);
		memcpy(
			   backgroundColorComponents[1],
			   CGColorGetComponents(contentColorTop.CGColor),
			   sizeof(CGFloat) * 4);
		memcpy(
			   backgroundColorComponents[2],
			   CGColorGetComponents(contentColorBottom.CGColor),
			   sizeof(CGFloat) * 4);
		
		const CGFloat endpointLocations[3] = {0.0, 0.35, 1.0};
		CGGradientRef gradient =
		CGGradientCreateWithColorComponents(
											colorspace,
											(const CGFloat *)backgroundColorComponents,
											endpointLocations,
											3);
		CFRelease(colorspace);
		
		if (selected)
		{
			selectedBackgroundGradient = gradient;
		}
		else
		{
			backgroundGradient = gradient;
		}
	}
	
	if (selected)
	{
		return selectedBackgroundGradient;
	}
	
	return backgroundGradient;
}

@implementation IssueCellBackground

@synthesize position;
@synthesize strokeColor;

//
// positionForIndexPath:inTableView:
//
// Parameters:
//    anIndexPath - the indexPath of a cell
//    aTableView; - the table view for the cell
//
// returns the PageCellGroupPosition for the indexPath in the table view
//

//TODO - implement your groups
+ (IssueCellGroupPosition)positionForIndexPath:(NSIndexPath *)anIndexPath
								  inTableView:(UITableView *)aTableView;
{
	IssueCellGroupPosition result;
	
	if ([anIndexPath row] != 0)
	{
		result = IssueCellGroupPositionMiddle;
	}
	else
	{
		result = IssueCellGroupPositionTop;
	}
	
	IssueDetailsViewController *issueViewController =
	(IssueDetailsViewController *)[aTableView delegate];	
	if ([anIndexPath row] ==
		[issueViewController tableView:aTableView numberOfRowsInSection:anIndexPath.section] - 1)
	{
		if (result == IssueCellGroupPositionTop)
		{
			result = IssueCellGroupPositionTopAndBottom;
		}
		else
		{
			result = IssueCellGroupPositionBottom;
		}
	}
	return result;
}

//
// init
//
// Init method for the object.
//
- (id)initSelected:(BOOL)isSelected grouped:(BOOL)isGrouped
{
	self = [super init];
	if (self != nil)
	{
		selected = isSelected;
		groupBackground = isGrouped;
		self.strokeColor = [UIColor lightGrayColor];
		self.backgroundColor = [UIColor clearColor];
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	}
	return self;
}

//
// layoutSubviews
//
// On rotation/resize/rescale, we need to redraw.
//
- (void)layoutSubviews
{
	[super layoutSubviews];
	
	[self setNeedsDisplay];
}

//
// setPosition:
//
// Makes certain the view gets redisplayed when the position changes
//
// Parameters:
//    aPosition - the new position
//
- (void)setPosition:(IssueCellGroupPosition)aPosition
{
	if (position != aPosition)
	{
		position = aPosition;
		[self setNeedsDisplay];
	}
}

//
// drawRect:
//
// Draw the view.
//

//TODO - update according to our categories
- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	const CGFloat IssueCellBackgroundRadius = 10.0;
	if (groupBackground)
	{
		if (position != IssueCellGroupPositionTop &&
			position != IssueCellGroupPositionTopAndBottom)
		{
			rect.origin.y -= IssueCellBackgroundRadius;
			rect.size.height += IssueCellBackgroundRadius;
		}
		
		if (position != IssueCellGroupPositionBottom && position != IssueCellGroupPositionTopAndBottom)
		{
			rect.size.height += IssueCellBackgroundRadius;
		}
	}
	
	rect = CGRectInset(rect, 0.5, 0.5);
	
	CGPathRef roundRectPath;
	
	if (groupBackground)
	{
		roundRectPath = NewPathWithRoundRect(rect, IssueCellBackgroundRadius);
		
		CGContextSaveGState(context);
		CGContextAddPath(context, roundRectPath);
		CGContextClip(context);
	}
	
	CGFloat visibleWidth = rect.size.width;
	CGContextDrawLinearGradient(
								context,
								IssueCellBackgroundGradient(selected),
								CGPointMake(0.25 * visibleWidth, -0.25 * visibleWidth),
								CGPointMake(rect.size.width - 0.25 * visibleWidth, rect.size.height + 0.25 * visibleWidth),
								0);
	
	if (groupBackground)
	{
		CGContextRestoreGState(context);
		
		CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
		CGContextAddPath(context, roundRectPath);
		CGContextSetLineWidth(context, 1.0);
		CGContextStrokePath(context);
		
		CGPathRelease(roundRectPath);
		
		if (position != IssueCellGroupPositionTop && position != IssueCellGroupPositionTopAndBottom)
		{
			rect.origin.y += IssueCellBackgroundRadius;
			rect.size.height -= IssueCellBackgroundRadius;
			
			CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
			CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y);
			CGContextStrokePath(context);
		}
	}
	else
	{
		CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
		CGContextSetLineWidth(context, 1.0);
		CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + rect.size.height);
		CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
		CGContextStrokePath(context);
	}
}

//
// dealloc
//
// Releases instance memory.
//
- (void)dealloc
{
	[strokeColor release];
	
	[super dealloc];
}


@end
