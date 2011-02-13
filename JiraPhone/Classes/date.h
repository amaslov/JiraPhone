//
//  date.h
//  JiraPhone
//
//  Created by Paul Dejardin on 2/12/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface date : NSObject {
	NSNumber* day;
	NSNumber* month;
	NSNumber* year;
}

@property (retain, nonatomic) NSNumber* day;
@property (retain, nonatomic) NSNumber* month;
@property (retain, nonatomic) NSNumber* year;

-(id)init;
-(id)initAllNil;
-(NSString*)formattedDate;

@end
