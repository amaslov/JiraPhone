//
//  filterAttributes.h
//  JiraPhone
//
//  Created by Paul Dejardin on 2/11/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface filterAttributes : NSObject {
	NSString* search_reporter_type;
	NSString* search_reporter;
	NSString* search_assignee_type;
	NSString* search_assignee;
	BOOL** search_statuses;
	BOOL** search_resolutions;
	BOOL** search_priorities;
	NSString** search_labels;
}

@property(retain, nonatomic) NSString* search_reporter_type;
@property(retain, nonatomic) NSString* search_reporter;
@property(retain, nonatomic) NSString* search_assignee_type;
@property(retain, nonatomic) NSString* search_assignee;
@property BOOL** search_statuses;
@property BOOL** search_resolutions;
@property BOOL** search_priorities;
@property NSString** search_labels;

-(id)init;
-(id)initAllNil;

@end
