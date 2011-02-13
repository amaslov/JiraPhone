//
//  date.m
//  JiraPhone
//
//  Created by Paul Dejardin on 2/12/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "date.h"


@implementation date
@synthesize day, month, year;

-(id)initAllNil
{
	if (self = [super init])
	{ 
		day = nil;
		month = nil;
		year = nil;
	}
	return self;
}

-(id)init
{
	return [self initAllNil];
}

-(NSString*)formattedDate
{
	return [NSString stringWithFormat:@"%@%@%@%@%@", month, @"/", day, @"/", year];
}

@end
