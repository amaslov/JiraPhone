//
//  Group.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 3/15/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "Group.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "JiraPhoneAppDelegate.h"


@implementation Group

@synthesize users=_users;


- (void)dealloc {
	if(self.users != nil) { [self.users release]; }
	[super dealloc];
}

+ (void)cacheGroup:(Group *)_group {
	FMDatabase *db = [JiraPhoneAppDelegate sharedDB];	
	
	// clear
	NSString *updateString = @"delete from groups";
	[db executeUpdate:updateString];
	
	// insert
	for (User *us in _group.users) {
		updateString = [NSString stringWithFormat:@"insert into groups (name, server, user_name) values (\"%@\", \"%@\", \"%@\")", _group.name, [User loggedInUser].server, us.name];
		[db executeUpdate:updateString];
	}
}

+ (void)getCachedGroup:(NSMutableArray *)_users {					   
					
NSString *updateString;

	NSString *queryString = [NSString stringWithFormat: @"select users.name, users.full_name, users.email, users.server from USERS INNER JOIN groups ON users.name=groups.user_name where groups.name = \"jira-users\" and groups.server = \"%@\" and groups.server=users.server", [User loggedInUser].ID];
	
	FMDatabase *db = [JiraPhoneAppDelegate sharedDB];
	FMResultSet *rs = [db executeQuery:queryString];
	while ([rs next])
	{
		User *user = [[User alloc]init];
		[user fillFromResultSet:rs];
		[_users addObject:user];
		[user release];
	}
	[rs close];
}
@end
