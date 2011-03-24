//
//  Filter.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 3/24/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractNamedEntity.h"


@interface Filter : AbstractNamedEntity{
	NSString* _author;
	NSDate* _created;
	
}
@property (retain, nonatomic) NSString* assignee;
@property (retain, nonatomic) NSDate* created;

@end
