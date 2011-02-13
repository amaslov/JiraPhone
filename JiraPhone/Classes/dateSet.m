//
//  dateSet.m
//  JiraPhone
//
//  Created by Paul Dejardin on 2/12/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "dateSet.h"


@implementation dateSet
@synthesize search_after, search_before, search_from, search_to;

-(id)initAllNil
{
	if (self = [super init])
	{ 
		search_after = [[date alloc] init];
		search_before = [[date alloc] init];
		search_from = [[range alloc] init];
		search_to = [[range alloc] init];
	}
	return self;
}

-(id)init
{
	return [self initAllNil];
}

@end
