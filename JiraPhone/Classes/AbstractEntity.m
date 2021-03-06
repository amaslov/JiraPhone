//
//  AbstractEntity.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 11/24/10.
//  Copyright 2010 AMaslov. All rights reserved.
//
#import "AbstractEntity.h"


@implementation AbstractEntity
@synthesize ID;
@synthesize server;

- (void)dealloc {
	[ID release];
	[server release];
	[super dealloc];
}
@end
