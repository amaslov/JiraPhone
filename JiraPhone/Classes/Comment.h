//
//  Comment.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 2/28/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Comment : NSObject {
	NSString* _Id;
	NSString* _author;
	NSString* _body;
	NSDate* _updated;
	NSDate* _created;
	//this one add manually!
	NSString* _issueId;
}
@property (nonatomic, retain) NSString* Id;
@property (nonatomic,retain) NSString* author;
@property (nonatomic, retain) NSString* body;
@property (nonatomic, retain) NSDate* updated;
@property (nonatomic, retain) NSDate* created;
@property (nonatomic,retain) NSString* issueId;

@end
