//
//  dateSet.h
//  JiraPhone
//
//  Created by Paul Dejardin on 2/12/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "date.h"
#import "range.h"


@interface dateSet : NSObject {
	date* search_after;
	date* search_before;
	range* search_from;
	range* search_to;
}

@property(retain, nonatomic) date* search_after;
@property(retain, nonatomic) date* search_before;
@property(retain, nonatomic) range* search_from;
@property(retain, nonatomic) range* search_to;

-(id)init;
-(id)initAllNil;

@end
