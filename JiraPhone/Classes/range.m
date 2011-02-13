//
//  range.m
//  JiraPhone
//
//  Created by Paul Dejardin on 2/12/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "range.h"


@implementation range
@synthesize weeks, days, hours, minutes, past_or_future;

-(id)initAllNil
{
	if (self = [super init])
	{ 
		weeks = nil;
		days = nil;
		hours = nil;
		minutes = nil;
		past_or_future = nil;
	}
	return self;
}

-(id)init
{
	return [self initAllNil];
}


@end
