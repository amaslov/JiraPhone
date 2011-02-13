//
//  Filter.m
//  JiraPhone
//
//  Created by Paul Dejardin on 2/11/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "Filter.h"


@implementation Filter
@synthesize search_properties, search_attributes, search_dates, search_ratios;

-(id)initAllNil
{
	if (self = [super init])
	{ 
		search_properties = [[filterProperties alloc] init];
		search_attributes = [[filterAttributes alloc] init];
		search_dates =      [[filterDates alloc] init];
		search_ratios =     [[filterWorkRatios alloc] init];
	}
	return self;
}

-(id)init
{
	return [self initAllNil];
}

@end
