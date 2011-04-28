//
//  User.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 12/12/10.
//  Copyright 2010 AMaslov. All rights reserved.
//
#import "User.h"
#import "JiraPhoneAppDelegate.h"

@implementation User
@synthesize server=_server;
@synthesize name=_name;
@synthesize fullName=_fullName;
@synthesize email=_email;
//@synthesize hashcode=_hashcode;
@synthesize password=_password;
@synthesize lastLoginDate=_lastLoginDate;

- (void)dealloc {
	// Free up some memory
	if(self.server != nil) { [self.server release]; }
	if(self.name != nil) { [self.name release]; }
	if(self.fullName != nil) { [self.fullName release]; }
	if(self.email != nil) { [self.email release]; }
	if(self.password != nil) { [self.password release];}
	if(self.lastLoginDate != nil) { [self.lastLoginDate release];}
	[super dealloc];
}

#pragma mark -
#pragma mark Class methods

static User *LOGGED_IN_USER = nil;

+ (User *)loggedInUser {
	// return the user that is currently logged in
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
	// Build the query
	queryString = [NSString stringWithFormat: @"select * from users where name = \"%@\" and server = \"%@\"", LOGGED_IN_USER.name, LOGGED_IN_USER.server];
	// Get results of the query
	rs = [[JiraPhoneAppDelegate sharedDB] executeQuery:queryString];
	// If a record was found, populate logged in user
	if ([rs next]) {
		LOGGED_IN_USER.fullName = [rs stringForColumn:@"full_name"];
		LOGGED_IN_USER.ID = [rs stringForColumn:@"id"];
		[rs close];
	}
	// If a record was not found, add one
	else {
		// insert
		updateString = [NSString  stringWithFormat:@"insert into users (name, server) values (\"%@\", \"%@\")", LOGGED_IN_USER.name, LOGGED_IN_USER.server];
		[[JiraPhoneAppDelegate sharedDB] executeUpdate: updateString];
		[rs close];
		goto m1;
	}
}

- (void)fillFromResultSet:(FMResultSet *)rs
{
	// Create a User from a database record
	self.name = [rs stringForColumn: @"name"];
	self.fullName = [rs stringForColumn:@"full_name"];
	self.email = [rs stringForColumn:@"email"];
	self.server = [rs stringForColumn:@"server"];
}


@end
