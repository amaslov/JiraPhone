//
//  IssueType.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 12/10/10.
//  Copyright 2010 AMaslov. All rights reserved.
//
#import "IssueType.h"


@implementation IssueType

- (NSString *)stringRepresentation {
	NSString *r = nil;
	switch (number) {
		case 1:
			r = @"Bug";
			break;
		case 2:
			r = @"New Feature";
			break;
		case 3:
			r = @"Task";
			break;
		case 4:
			r = @"Improvement";
			break;
	
		default:
			break;
	}
	return r;
}

@end
