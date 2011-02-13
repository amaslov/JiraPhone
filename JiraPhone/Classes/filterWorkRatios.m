//
//  filterWorkRatios.m
//  JiraPhone
//
//  Created by Paul Dejardin on 2/11/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "filterWorkRatios.h"


@implementation filterWorkRatios
@synthesize min, max;

-(id)initAllNil
{
	if (self = [super init])
	{ 
		min = nil;
		max = nil;
	}
	return self;
}

-(id)init
{
	return [self initAllNil];
}

@end
