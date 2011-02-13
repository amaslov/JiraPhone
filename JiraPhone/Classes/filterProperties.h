//
//  filterProperties.h
//  JiraPhone
//
//  Created by Paul Dejardin on 2/11/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface filterProperties : NSObject {
	NSString** search_queries;
	BOOL** search_areas;
	BOOL** search_projects;
	BOOL** search_issuetypes;
}

@property NSString** search_queries;
@property BOOL** search_areas;
@property BOOL** search_issuetypes;
@property BOOL** search_projects;

-(id)init;
-(id)initAllNil;

@end
