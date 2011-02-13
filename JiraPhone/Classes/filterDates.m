//
//  filterDates.m
//  JiraPhone
//
//  Created by Paul Dejardin on 2/12/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "filterDates.h"


@implementation filterDates
@synthesize search_created, search_updated, search_due, search_resolved;

-(id)initAllNil
{
	if (self = [super init])
	{ 
		search_created =  [[dateSet alloc] init];
		search_updated =  [[dateSet alloc] init];
		search_due =      [[dateSet alloc] init];
		search_resolved = [[dateSet alloc] init];
	}
	return self;
}

-(id)init
{
	return [self initAllNil];
}

@end
