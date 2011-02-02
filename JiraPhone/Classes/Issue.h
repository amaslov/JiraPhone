//
//  Issue.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 12/10/10.
//  Copyright 2010 AMaslov. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AbstractEntity.h"
#import "Priority.h"

@class Project;
@class IssueType;
@interface Issue : AbstractEntity {
	NSString* _assignee;
	NSDate* _created;
	NSString* _description;
	NSDate* _duedate;
	NSString* _key;
	Priority* _priority;
	NSString* _project; // project key
	NSString* _reporter;
	NSString* _resolution;
	NSString* _status;
	NSString* _summary;
	IssueType* _type;
	NSDate* _updated;
}

@property (retain, nonatomic) NSString* assignee;
@property (retain, nonatomic) NSDate* created;
@property (retain, nonatomic) NSString* description;
@property (retain, nonatomic) NSDate* duedate;
@property (retain, nonatomic) NSString* key;
@property (retain, nonatomic) Priority* priority;
@property (retain, nonatomic) NSString* project;
@property (retain, nonatomic) NSString* reporter;
@property (retain, nonatomic) NSString* resolution;
@property (retain, nonatomic) NSString* status;
@property (retain, nonatomic) NSString* summary;
@property (retain, nonatomic) IssueType* type;
@property (retain, nonatomic) NSDate* updated;

+ (void)cacheIssues:(NSArray *)_issues ofProject:(Project *)_proj;
+ (void)getCachedIssues:(NSMutableArray *)_projects ofProject:(Project *)_proj;
@end
