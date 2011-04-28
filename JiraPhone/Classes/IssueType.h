//
//  IssueType.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 12/10/10.
//  Copyright 2010 AMaslov. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AbstractConstant.h"

@interface IssueType : AbstractConstant {
//TODO - remake as enum
/*	typedef enum {
		Bug=1,
		Feature=2,
		Task=3,
		Improvement=4
	} issueEnum;
*/	
	//static NSArray *issueTypesArray=[NSArray arrayWithObjects:@"Bug",@"New Feature",@"Task",@"Improvement",nil];
}


// overrides string representation method of AbstractConstant
- (NSString *)stringRepresentation;
//- (NSInteger)intRepresentation;
@end