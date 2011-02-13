//
//  range.h
//  JiraPhone
//
//  Created by Paul Dejardin on 2/12/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface range : NSObject {
	NSNumber* weeks;
	NSNumber* days;
	NSNumber* hours;
	NSNumber* minutes;
	NSNumber* past_or_future; //0 if past 1 if future;
}

@property (retain, nonatomic) NSNumber* weeks;
@property (retain, nonatomic) NSNumber* days;
@property (retain, nonatomic) NSNumber* hours;
@property (retain, nonatomic) NSNumber* minutes;
@property (retain, nonatomic) NSNumber* past_or_future;

-(id)init;
-(id)initAllNil;

@end
