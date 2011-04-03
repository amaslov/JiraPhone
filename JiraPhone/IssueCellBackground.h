//
//  IssueCellBackground.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 4/2/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
	IssueCellGroupPositionUnknown = 0,
	IssueCellGroupPositionTop,
	IssueCellGroupPositionBottom,
	IssueCellGroupPositionMiddle,
	IssueCellGroupPositionTopAndBottom
} IssueCellGroupPosition;

@interface IssueCellBackground : UIView {

	IssueCellGroupPosition position;
	BOOL selected;
	BOOL groupBackground;
	UIColor *strokeColor;
	
}

@property IssueCellGroupPosition position;
@property (nonatomic, retain) UIColor *strokeColor;

+ (IssueCellGroupPosition)positionForIndexPath:(NSIndexPath *)anIndexPath inTableView:(UITableView *)aTableView;
- (id)initSelected:(BOOL)isSelected grouped:(BOOL)isGrouped;


@end
