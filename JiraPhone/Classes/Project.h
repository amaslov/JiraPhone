//
//  Project.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 12/10/10.
//  Copyright 2010 AMaslov. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AbstractNamedEntity.h"

@interface Project : AbstractNamedEntity {	
	NSString* _description;
	NSString* _key;
	NSString* _lead;
	NSString* _projectUrl;
	NSString* _url;
	NSUInteger _hashCode;
}

@property (retain, nonatomic) NSString* description;
@property (retain, nonatomic) NSString* key;
@property (retain, nonatomic) NSString* lead;
@property (retain, nonatomic) NSString* projectUrl;
@property (retain, nonatomic) NSString* url;
@property NSUInteger hashCode;

// fill _projects with projects from local db
+ (void)getCachedProjects:(NSMutableArray *)_projects;

// save projects (_projects) in local db
+ (void)cacheProjects:(NSArray *)_projects;

@end