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
	NSString* _description;
	NSString* _server;
}
@property (retain, nonatomic) NSString* author;
@property (retain, nonatomic) NSString* description;
@property (retain, nonatomic) NSString* server;


+ (void)cacheFilters:(NSArray *)_filters;
+ (void)getCachedFilters:(NSMutableArray *)_filters;

@end
