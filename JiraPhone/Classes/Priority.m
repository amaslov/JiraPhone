//
//  Priority.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 12/11/10.
//  Copyright 2010 AMaslov. All rights reserved.
//
#import "Priority.h"


@implementation Priority

- (NSString *)stringRepresentation {
	NSString *r = nil;
	switch (number) {
		case 1:
			r = @"Blocker";
			break;
		case 2:
			r = @"Critical";
			break;
		case 3:
			r = @"Major";
			break;
		case 4:
			r = @"Minor";
			break;
		case 5:
			r = @"Trivial";
			break;

		default:
			break;
	}
	return r;
}

@end
