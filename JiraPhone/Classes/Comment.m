//
//  Comment.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 2/28/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "Comment.h"


@implementation Comment
@synthesize Id=_Id;
@synthesize author=_author;
@synthesize body=_body;
@synthesize updated=_updated;
@synthesize created=_created;
@synthesize issueId=_issueId;

- (void)dealloc {
	// free up memory
	if (self.Id!=nil){[self.Id release];}
	if (self.author!=nil){[self.author release];}
	if (self.body!=nil){[self.body release];}
	if (self.updated!=nil){[self.updated release];}
	if (self.created!=nil){[self.created release];}
	if (self.issueId!=nil){[self.issueId release];}
	[super dealloc];
}

- (NSComparisonResult)compareCreatedDate:(Comment*)_comment {
	//Compare comments so they are in chronological order
	return [self.created compare:_comment.created];
}

@end
