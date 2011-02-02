//
//  AbstractNamedEntity.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 11/24/10.
//  Copyright 2010 AMaslov. All rights reserved.
//
#import "AbstractNamedEntity.h"


@implementation AbstractNamedEntity
@synthesize name;

- (void)dealloc {
	[name release];
	[super dealloc];
}
@end
