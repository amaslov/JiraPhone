//
//  Filter.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 3/24/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "Filter.h"
#import "User.h"
#import "JiraPhoneAppDelegate.h"

@implementation Filter

@synthesize author=_author;
@synthesize description=_description;
@synthesize server=_server;


+ (void)cacheFilters:(NSArray *)_filters{
	
	//TODO: change to support issue updating in the DB
	NSString *updateString = [NSString stringWithFormat:@"delete from filters where user_id = \"%@\"", [User loggedInUser].ID];	
	
	// clear
	FMDatabase *db = [JiraPhoneAppDelegate sharedDB];
	[db executeUpdate:updateString];
	
	// insert
	for (Filter *filter in _filters) {
		updateString = [NSString stringWithFormat:@"insert into filters (id, name, author, description, server) values (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", 
						filter.ID,
						filter.name,
						filter.author,
						filter.description,
						[User loggedInUser].server];
		
		
		[db executeUpdate:updateString];		
	}
	
	if ([db hadError]) {
		NSLog(@"db error: %@", [db lastErrorMessage]);
	}
}

+ (void)getCachedFilters:(NSMutableArray *)filters {
	NSString *queryString = [NSString stringWithFormat:@"select * from filters where author = \"%@\" limit 10",[User loggedInUser].name];
	
	FMDatabase *db = [JiraPhoneAppDelegate sharedDB];
	FMResultSet *rs = [db executeQuery:queryString];
	while ([rs next])
	{
		Filter *filter = [[Filter alloc] init];
		[filter fillFromResultSet:rs];
		[filters addObject:filter];
		[filter release];
	}
	[rs close];
	if ([db hadError]) {
		NSLog(@"db error: %@",[db lastErrorMessage]);
	}
}

- (void)fillFromResultSet:(FMResultSet *)rs
{
	self.ID=[rs stringForColumn:@"ID"];
	self.author = [rs stringForColumn:@"author"];
	self.name=[rs stringForColumn:@"name"];
	self.server=[rs stringForColumn:@"server"];
	self.description=[rs stringForColumn:@"description"];
}

@end
