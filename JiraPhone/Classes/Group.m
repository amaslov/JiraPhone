//
//  Group.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 3/15/11.
//  Copyright 2011 AMaslov. All rights reserved.
// SATISFIES ALL OBJECT CALISTHENICS!

#import "Group.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "JiraPhoneAppDelegate.h"


@implementation Group

@synthesize users=_users;


- (void)dealloc {
	if(self.users != nil) { 
		[self.users release]; 
	}
	[super dealloc];
}

+ (void)cacheGroup:(Group *)_group {
	FMDatabase *database = [JiraPhoneAppDelegate sharedDB];	
	
	// clear
	NSString *updateString = @"delete from groups";
	[database executeUpdate:updateString];
	
	// insert
	for (User *user in _group.users) {
		updateString = [NSString stringWithFormat:@"insert into groups (name, server, user_name) values (\"%@\", \"%@\", \"%@\")", _group.name, [User loggedInUser].server, user.name];
		[database executeUpdate:updateString];
	}
}

+ (void)getCachedGroup:(NSMutableArray *)_users {					   

	NSString *queryString = [NSString stringWithFormat: @"select users.name, users.full_name, users.email, users.server from USERS INNER JOIN groups ON users.name=groups.user_name where groups.name = \"jira-users\" and groups.server = \"%@\" and groups.server=users.server", [User loggedInUser].ID];
	
	FMDatabase *database = [JiraPhoneAppDelegate sharedDB];
	FMResultSet *resultSet = [database executeQuery:queryString];
	while ([resultSet next])
	{
		User *user = [[User alloc]init];
		[user fillFromResultSet:resultSet];
		[_users addObject:user];
		[user release];
	}
	[resultSet close];
}
@end
