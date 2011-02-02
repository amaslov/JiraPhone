//
//  AbstractNamedEntity.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 11/24/10.
//  Copyright 2010 AMaslov. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AbstractEntity.h"

@interface AbstractNamedEntity : AbstractEntity {
	NSString *name;
}
@property (nonatomic, retain) NSString *name;

@end
