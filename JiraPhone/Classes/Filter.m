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
	
	// Remove all filters from the database
	FMDatabase *db = [JiraPhoneAppDelegate sharedDB];
	[db executeUpdate:updateString];
	
	// Insert filters into the database
	for (Filter *filter in _filters) {
		updateString = [NSString stringWithFormat:@"insert into filters (filters_id, name, author, description, server) values (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", 
						filter.ID,
						filter.name,
						filter.author,
						filter.description,
						[User loggedInUser].server];
		
		
		[db executeUpdate:updateString];		
	}
	
	// Output database errors
	if ([db hadError]) {
		NSLog(@"db error: %@", [db lastErrorMessage]);
	}
}

+ (void)getCachedFilters:(NSMutableArray *)filters {
	// Build the query string
	NSString *queryString = [NSString stringWithFormat:@"select * from filters where author = \"%@\" limit 10",[User loggedInUser].name];
	
	// Get the database
	FMDatabase *db = [JiraPhoneAppDelegate sharedDB];
	// Get results of the query
	FMResultSet *rs = [db executeQuery:queryString];
	while ([rs next])
	{
		// Create a filter and store it
		Filter *filter = [[Filter alloc] init];
		[filter fillFromResultSet:rs];
		[filters addObject:filter];
		[filter release];
	}
	// Close the result set
	[rs close];
	
	// Output any database errors
	if ([db hadError]) {
		NSLog(@"db error: %@",[db lastErrorMessage]);
	}
}

- (void)fillFromResultSet:(FMResultSet *)rs
{
	// Create a filter from a database record
	self.ID=[rs stringForColumn:@"filters_id"];
	self.author = [rs stringForColumn:@"author"];
	self.name=[rs stringForColumn:@"name"];
	self.server=[rs stringForColumn:@"server"];
	self.description=[rs stringForColumn:@"description"];
}

@end
