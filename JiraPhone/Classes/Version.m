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
	if(self.releaseDate != nil) { [self.releaseDate release]; }
	if(self.sequence != nil) { [self.sequence release]; }
	[super dealloc];
}

#pragma mark -
#pragma mark Class methods
+ (void)cacheVersions:(NSArray *)_versions {
	FMDatabase *db = [JiraPhoneAppDelegate sharedDB];	
	
	// clear
	NSString *updateString = @"delete from versions";
	[db executeUpdate:updateString];
	
	// insert
	for (Version *ver in _versions) {
		updateString = [NSString stringWithFormat:@"insert into versions (version_id, name, releaseDate, server, sequence) values (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", 
						ver.ID, ver.name, ver.releaseDate, [User loggedInUser].server, ver.sequence;
		[db executeUpdate:updateString];		
	}
}

+ (void)getCachedVersions:(NSMutableArray *)_versions {
	
	NSString *queryString = [NSString stringWithFormat: @"select * from versions where server = \"%@\"", [User loggedInUser].server];
	
	FMDatabase *db = [JiraPhoneAppDelegate sharedDB];
	FMResultSet *rs = [db executeQuery:queryString];
	while ([rs next])
	{
		Version *version = [[Version alloc]init];
		[version fillFromResultSet:rs];
		[_versions addObject:version];
		[version release];
	}
	[rs close];
}

#pragma mark -
#pragma mark Private Methods
- (void)fillFromResultSet:(FMResultSet *)rs
{
	self.ID=[rs stringForColumn:@"version_id"];
	self.name=[rs stringForColumn:@"name"];
	self.releaseDate=[rs stringForColumn:@"releaseDate"];
	self.sequence=[rs stringForColumn:@"sequence"];
	self.server=[User loggedInUser].server;
}
@end
