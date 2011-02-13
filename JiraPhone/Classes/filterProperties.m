//
//  filterProperties.m
//  JiraPhone
//
//  Created by Paul Dejardin on 2/11/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "filterProperties.h"


@implementation filterProperties
@synthesize search_queries, search_areas, search_issuetypes, search_projects;

-(id)initAllNil
{
	if (self = [super init])
	{ 
		search_queries = nil;
		search_areas = NULL;
		search_issuetypes = NULL;
		search_projects = NULL;
	}
	return self;
}

-(id)init
{
	return [self initAllNil];
}

@end
