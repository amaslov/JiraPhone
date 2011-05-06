//
//  Issue.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 12/10/10.
//  Copyright 2010 AMaslov. All rights reserved.
//
#import "Issue.h"
#import <sqlite3.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"
#import "JiraPhoneAppDelegate.h"
#import "Project.h"
#import "User.h"
#import "IssueType.h"

@interface Issue (Private)

- (void)fillFromResultSet:(FMResultSet *)rs;

@end


@implementation Issue
@synthesize assignee = _assignee;
@synthesize created = _created;
@synthesize description = _description;
@synthesize duedate = _duedate;
@synthesize key = _key;
@synthesize priority = _priority;
@synthesize project = _project;
@synthesize reporter = _reporter;
@synthesize resolution = _resolution;
@synthesize status = _status;
@synthesize summary = _summary;
@synthesize type = _type;
@synthesize updated = _updated;
@synthesize environment = _environment;
@synthesize userId=_userId;
//@synthesize hashCode=_hashCode;

- (void)dealloc {
	if(self.assignee != nil) { [self.assignee release]; }
	if(self.created != nil) { [self.created release]; }
	if(self.description != nil) { [self.description release]; }
	if(self.duedate != nil) { [self.duedate release]; }
	if(self.key != nil) { [self.key release]; }
	if(self.priority != nil) { [self.priority release]; }
	if(self.project != nil) { [self.project release]; }
	if(self.reporter != nil) { [self.reporter release]; }
	if(self.resolution != nil) { [self.resolution release]; }
	if(self.status != nil) { [self.status release]; }
	if(self.summary != nil) { [self.summary release]; }
	if(self.type != nil) { [self.type release]; }
	if(self.updated != nil) { [self.updated release]; }
	if(self.environment!=nil){[self.environment release];}
	[super dealloc];
}

#pragma mark -
#pragma mark Class methods
+ (void)cacheIssues:(NSArray *)_issues ofProject:(Project *)_proj {
	
	//TODO: change to support issue updating in the DB
	//NSString *updateString = [NSString stringWithFormat:@"delete from issues where project = \"%@\" and user_id = \"%@\"", _proj.key, [User loggedInUser].ID];	
	
	// clear
	//FMDatabase *db = [JiraPhoneAppDelegate sharedDB];
	//[db executeUpdate:updateString];
	FMDatabase *db = [JiraPhoneAppDelegate sharedDB];
		
	// insert
	for (Issue *issue in _issues) {
		/*NSString *updateString = [NSString stringWithFormat:@"select * from issues where project = \"%@\" and user_id = \"%@\" and key = \"%@\" and server = \"%@\"", _proj.key, [User loggedInUser].ID, issue.key, [User loggedInUser].server];
		
		FMResultSet *rs = [db executeQuery:updateString];
		if ([rs next])
		{
			updateString = [NSString stringWithFormat:@"update issues set assignee = \"%@\", created = \"%@\", description = \"%@\", due_date = \"%@\", priority = \"%@\", project = \"%@\", reporter = \"%@\", resolution = \"%@\", status = \"%@\", summary = \"%@\", type = \"%@\", updated = \"%@\", user_id = \"%@\" where project = \"%@\" and user_id = \"%@\" and key = \"%@\" and server = \"%@\"", 
							issue.assignee,
							issue.created,
							issue.description,
							issue.duedate,
							[NSString stringWithFormat: @"%i", issue.priority.number],
							issue.project,
							issue.reporter,
							issue.resolution,
							issue.status,
							issue.summary,
							[NSString stringWithFormat: @"%i", issue.type.number],
							issue.updated, 
							[User loggedInUser].ID,
							_proj.key, [User loggedInUser].ID, issue.key, [User loggedInUser].server];
			
			
			[db executeUpdate:updateString];
		}else{
			updateString = [NSString stringWithFormat:@"insert into issues (assignee, created, description, due_date, key, priority, project, reporter, resolution, status, summary, type, updated, user_id) values (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", 
							issue.assignee,
							issue.created,
							issue.description,
							issue.duedate,
							issue.key,
							[NSString stringWithFormat: @"%i", issue.priority.number],
							issue.project,
							issue.reporter,
							issue.resolution,
							issue.status,
							issue.summary,
							[NSString stringWithFormat: @"%i", issue.type.number],
							issue.updated, [User loggedInUser].ID];
			
							
			[db executeUpdate:updateString];	
		 }*/
		NSString *updateString = [NSString stringWithFormat:@"replace into issues (assignee, created, description, due_date, key, priority, project, reporter, resolution, status, summary, type, updated, user_id) values (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", 
						issue.assignee,
						issue.created,
						issue.description,
						issue.duedate,
						issue.key,
						[NSString stringWithFormat: @"%i", issue.priority.number],
						issue.project,
						issue.reporter,
						issue.resolution,
						issue.status,
						issue.summary,
						[NSString stringWithFormat: @"%i", issue.type.number],
						issue.updated, [User loggedInUser].ID];
		
		
		[db executeUpdate:updateString];
	}
	
	if ([db hadError]) {
		NSLog(@"db error: %@", [db lastErrorMessage]);
	}
}

/* + (void)cacheAllIssues:(NSArray *)_issues {
	
	//TODO: change to support issue updating in the DB
	NSString *updateString = [NSString stringWithFormat:@"delete from issues where user_id = \"%@\"", [User loggedInUser].ID];	
	
	// clear
	FMDatabase *db = [JiraPhoneAppDelegate sharedDB];
	[db executeUpdate:updateString];
	
	// insert
	for (Issue *issue in _issues) {
		updateString = [NSString stringWithFormat:@"insert into issues (assignee, created, description, due_date, key, priority, project, reporter, resolution, status, summary, type, updated, user_id) values (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", 
						issue.assignee,
						issue.created,
						issue.description,
						issue.duedate,
						issue.key,
						[NSString stringWithFormat: @"%i", issue.priority.number],
						issue.project,
						issue.reporter,
						issue.resolution,
						issue.status,
						issue.summary,
						[NSString stringWithFormat: @"%i", issue.type.number],
						issue.updated, [User loggedInUser].ID];
		
		
		[db executeUpdate:updateString];		
	}
	
	if ([db hadError]) {
		NSLog(@"db error: %@", [db lastErrorMessage]);
	}
}
*/
+ (void)getCachedIssuesForUser:(NSMutableArray *)_issues {
	NSString *queryString = [NSString stringWithFormat:@"select * from issues where assignee = \"%@\" limit 3",[User loggedInUser].name];
	
	FMDatabase *db = [JiraPhoneAppDelegate sharedDB];
	FMResultSet *rs = [db executeQuery:queryString];
	while ([rs next])
	{
		Issue *issue = [[Issue alloc] init];
		[issue fillFromResultSet:rs];
		[_issues addObject:issue];
		[issue release];
	}
	[rs close];
	if ([db hadError]) {
		NSLog(@"db error: %@",[db lastErrorMessage]);
	}
}

+ (void)getCachedIssues:(NSMutableArray *)_issues ofProject:(Project *)_proj {

	NSString *queryString = [NSString stringWithFormat:@"select * from issues where project = \"%@\" and user_id = \"%@\"", _proj.key, [User loggedInUser].ID];
	
	FMDatabase *db = [JiraPhoneAppDelegate sharedDB];
	FMResultSet *rs = [db executeQuery:queryString];
	while ([rs next])
	{
		Issue *issue = [[Issue alloc]init];
		[issue fillFromResultSet:rs];
		[_issues addObject: issue];
		[issue release];
	}
	[rs close];
	if ([db hadError]) {
		NSLog(@"db error: %@", [db lastErrorMessage]);
	}
	
}

#pragma mark -
#pragma mark Private Methods
- (void)fillFromResultSet:(FMResultSet *)rs
{
	self.assignee = [rs stringForColumn:@"assignee"];
	self.created = [rs dateForColumn:@"created"];
	self.description = [rs stringForColumn:@"description"];
	self.duedate = [rs dateForColumn:@"due_date"];
	self.key = [rs stringForColumn:@"key"];
	
	Priority *p = [[Priority alloc] init];
	p.number = [[rs stringForColumn:@"priority"] intValue];
	self.priority = p;
	[p release];
	
	self.project = [rs stringForColumn:@"project"];
	self.reporter = [rs stringForColumn:@"reporter"];
	self.resolution = [rs stringForColumn:@"resolution"];
	self.status = [rs stringForColumn:@"status"];
	self.summary = [rs stringForColumn:@"summary"];

	IssueType *t = [[IssueType alloc] init];
	t.number = [[rs stringForColumn:@"type"] intValue];
	self.type = t;
	[t release];
	
	self.updated = [rs dateForColumn:@"updated"];
}

- (NSComparisonResult)compareUpdatedDate:(Issue*)_issue {
	//Compare reverse comparison to get Most recent items first
	return [_issue.updated compare:self.updated];
}
- (NSComparisonResult)compareKey:(Issue*)_issue {
	// Sort keys alphabetically
	return [self.key compare:_issue.key];
}
- (NSComparisonResult)comparePriority:(Issue*)_issue {
	// Sort keys by priority in ascending order (most critical issues first)
	NSNumber *selfPriority = [NSNumber numberWithInteger:self.priority.number];
	NSNumber *otherPriority = [NSNumber numberWithInteger:_issue.priority.number];
	return [selfPriority compare:otherPriority];
}
@end
