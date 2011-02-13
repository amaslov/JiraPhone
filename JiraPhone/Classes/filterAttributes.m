//
//  filterAttributes.m
//  JiraPhone
//
//  Created by Paul Dejardin on 2/11/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "filterAttributes.h"


@implementation filterAttributes
@synthesize search_reporter_type, search_reporter, search_assignee_type;
@synthesize search_assignee, search_statuses, search_resolutions;
@synthesize search_priorities, search_labels;

-(id)initAllNil
{
	if (self = [super init])
	{ 
		search_reporter_type = nil;
		search_reporter = nil;
		search_assignee_type = nil;
		search_assignee = nil;
		search_statuses = NULL;
		search_resolutions = NULL;
		search_priorities = NULL;
		search_labels = nil;
	}
	return self;
}

-(id)init
{
	return [self initAllNil];
}

@end
