//
//  Status.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 2/28/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "Status.h"


@implementation Status

- (NSString *)stringRepresentation {
	NSString *output = nil;
	switch (number) {
		case 1:
			output = @"Open";
			break;
		case 3:
			output = @"In Progress";
			break;
		case 4:
			output=@"Reopened";
			break;
		case 5:
			output = @"Resolved";
			break;
		case 6:
			output=@"Closed";
			break;
		default:
			output=@"Error!";
	}
	return output;
	
}
@end
