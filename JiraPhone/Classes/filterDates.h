//
//  filterDates.h
//  JiraPhone
//
//  Created by Paul Dejardin on 2/12/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "dateSet.h"


@interface filterDates : NSObject {
	dateSet* search_created;
	dateSet* search_updated;
	dateSet* search_due;
	dateSet* search_resolved;
}

@property(retain, nonatomic) dateSet* search_created;
@property(retain, nonatomic) dateSet* search_updated;
@property(retain, nonatomic) dateSet* search_due;
@property(retain, nonatomic) dateSet* search_resolved;

-(id)init;
-(id)initAllNil;

@end
