//
//  Version.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 2/28/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "Version.h"


@implementation Version
@synthesize releaseDate = _releaseDate;
@synthesize sequence=_sequence;
//@synthesize archived=_archived;
//@synthesize released=_released;

- (void) dealloc
{
	// Free up memory
	if(self.releaseDate != nil) { [self.releaseDate release]; }
	if(self.sequence != nil) { [self.sequence release]; }
	[super dealloc];
}

#pragma mark -
#pragma mark Class methods
+ (void)cacheVersions:(NSArray *)_versions {
	// Get the database
	FMDatabase *db = [JiraPhoneAppDelegate sharedDB];	
	
	// Delete versions from the database
	NSString *updateString = @"delete from versions";
	[db executeUpdate:updateString];
	
	// Insert versions into the database
	for (Version *ver in _versions) {
		updateString = [NSString stringWithFormat:@"insert into versions (version_id, name, releaseDate, server, sequence) values (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", 
						ver.ID, ver.name, ver.releaseDate, [User loggedInUser].server, ver.sequence;
		[db executeUpdate:updateString];		
	}
}

+ (void)getCachedVersions:(NSMutableArray *)_versions {
	// Build the query string
	NSString *queryString = [NSString stringWithFormat: @"select * from versions where server = \"%@\"", [User loggedInUser].server];
	// Get the database
	FMDatabase *db = [JiraPhoneAppDelegate sharedDB];
	// Get results of the query
	FMResultSet *rs = [db executeQuery:queryString];
	while ([rs next])
	{
		// Create a new version and store it
		Version *version = [[Version alloc]init];
		[version fillFromResultSet:rs];
		[_versions addObject:version];
		[version release];
	}
	// Close the result set
	[rs close];
}

#pragma mark -
#pragma mark Private Methods
- (void)fillFromResultSet:(FMResultSet *)rs
{
	// Create a version from the result set
	self.ID=[rs stringForColumn:@"version_id"];
	self.name=[rs stringForColumn:@"name"];
	self.releaseDate=[rs stringForColumn:@"releaseDate"];
	self.sequence=[rs stringForColumn:@"sequence"];
	self.server=[User loggedInUser].server;
}
@end
