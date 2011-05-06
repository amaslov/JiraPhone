//
//  Project.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 12/10/10.
//  Copyright 2010 AMaslov. All rights reserved.
//
#import "Project.h"
#import <sqlite3.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"
#import "JiraPhoneAppDelegate.h"
#import "User.h"

@interface Project (Private)

- (void)fillFromResultSet:(FMResultSet *)rs;

@end


@implementation Project
@synthesize description = _description;
@synthesize key = _key;
@synthesize lead = _lead;
@synthesize projectUrl = _projectUrl;
@synthesize url = _url;
@synthesize hashCode=_hashCode;
- (void) dealloc
{
	// Free up memory
	if(self.description != nil) { [self.description release]; }
	if(self.key != nil) { [self.key release]; }
	if(self.lead != nil) { [self.lead release]; }
	if(self.projectUrl != nil) { [self.projectUrl release]; }
	if(self.url != nil) { [self.url release]; }
//	[self.hashCode release];
	
	[super dealloc];
}

#pragma mark -
#pragma mark Class methods
+ (void)cacheProjects:(NSArray *)_projects {
	// Get the database
	FMDatabase *db = [JiraPhoneAppDelegate sharedDB];	

	// Build the delete query
	NSString *updateString = @"delete from projects";
	
	// Execute the delete
	[db executeUpdate:updateString];

	// Insert projects into database
	for (Project *proj in _projects) {
		updateString = [NSString stringWithFormat:@"insert into projects (description, key, lead, project_url, url, name, user_id) values (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", 
						proj.description, proj.key, proj.lead, proj.projectUrl, proj.url, proj.name, [User loggedInUser].ID];
		[db executeUpdate:updateString];		
	}
}

+ (void)getCachedProjects:(NSMutableArray *)_projects {
	// Build a query string
	NSString *queryString = [NSString stringWithFormat: @"select * from projects where user_id = \"%@\"", [User loggedInUser].ID];
	
	// Get the database
	FMDatabase *db = [JiraPhoneAppDelegate sharedDB];
	
	// Get results from the query
	FMResultSet *rs = [db executeQuery:queryString];
	while ([rs next])
	{
		// Make a project from the results and store it
		Project *project = [[Project alloc]init];
		[project fillFromResultSet:rs];
		[_projects addObject:project];
		[project release];
	}
	// Close the result set
	[rs close];
}

#pragma mark -
#pragma mark Private Methods
- (void)fillFromResultSet:(FMResultSet *)rs
{
	// Create a project from a database record
	self.description = [rs stringForColumn: @"description"];
	self.key = [rs stringForColumn:@"key"];
	self.lead = [rs stringForColumn:@"lead"];
	self.projectUrl = [rs stringForColumn:@"project_url"];
	self.url = [rs stringForColumn:@"url"];
	self.name = [rs stringForColumn:@"name"];
}

@end
