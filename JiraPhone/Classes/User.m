//
//  User.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 12/12/10.
//  Copyright 2010 AMaslov. All rights reserved.
//
#import "User.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "JiraPhoneAppDelegate.h"

@implementation User
@synthesize server;

- (void)dealloc {
	[server release];
	[super dealloc];
}

#pragma mark -
#pragma mark Class methods

static User *LOGGED_IN_USER = nil;

+ (User *)loggedInUser {
	return LOGGED_IN_USER;
}

+ (void)setLoggedInUser:(User *)_user {
	if (LOGGED_IN_USER) {
		[LOGGED_IN_USER release];
	}
	LOGGED_IN_USER = [_user retain];
	
	// save (or get id of) user data to (in) local db
	NSString *queryString, *updateString;
	FMResultSet *rs;
m1:
	queryString = [NSString stringWithFormat: @"select * from users where name = \"%@\" and server = \"%@\"", LOGGED_IN_USER.name, LOGGED_IN_USER.server];
	rs = [[JiraPhoneAppDelegate sharedDB] executeQuery:queryString];
	if ([rs next]) {
		LOGGED_IN_USER.ID = [rs stringForColumn:@"id"];
		[rs close];
	}
	else {
		// insert
		updateString = [NSString  stringWithFormat:@"insert into users (name, server) values (\"%@\", \"%@\")", LOGGED_IN_USER.name, LOGGED_IN_USER.server];
		[[JiraPhoneAppDelegate sharedDB] executeUpdate: updateString];
		[rs close];
		goto m1;
	}
}

@end
