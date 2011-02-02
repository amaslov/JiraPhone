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

- (void) dealloc
{
	if(self.description != nil) { [self.description release]; }
	if(self.key != nil) { [self.key release]; }
	if(self.lead != nil) { [self.lead release]; }
	if(self.projectUrl != nil) { [self.projectUrl release]; }
	if(self.url != nil) { [self.url release]; }
	[super dealloc];
}

#pragma mark -
#pragma mark Class methods
+ (void)cacheProjects:(NSArray *)_projects {
	FMDatabase *db = [JiraPhoneAppDelegate sharedDB];	

	// clear
	NSString *updateString = @"delete from projects";
	[db executeUpdate:updateString];

	// insert
	for (Project *proj in _projects) {
		updateString = [NSString stringWithFormat:@"insert into projects (description, key, lead, project_url, url, name, user_id) values (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", 
						proj.description, proj.key, proj.lead, proj.projectUrl, proj.url, proj.name, [User loggedInUser].ID];
		[db executeUpdate:updateString];		
	}
}

+ (void)getCachedProjects:(NSMutableArray *)_projects {
	
	NSString *queryString = [NSString stringWithFormat: @"select * from projects where user_id = \"%@\"", [User loggedInUser].ID];
		
	FMDatabase *db = [JiraPhoneAppDelegate sharedDB];
	FMResultSet *rs = [db executeQuery:queryString];
	while ([rs next])
	{
		Project *project = [[Project alloc]init];
		[project fillFromResultSet:rs];
		[_projects addObject:project];
		[project release];
	}
	[rs close];
}

#pragma mark -
#pragma mark Private Methods
- (void)fillFromResultSet:(FMResultSet *)rs
{
	self.description = [rs stringForColumn: @"description"];
	self.key = [rs stringForColumn:@"key"];
	self.lead = [rs stringForColumn:@"lead"];
	self.projectUrl = [rs stringForColumn:@"project_url"];
	self.url = [rs stringForColumn:@"url"];
	self.name = [rs stringForColumn:@"name"];
}

@end
