//
//  AbstractConstant.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 11/24/10.
//  Copyright 2010 AMaslov. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AbstractNamedEntity.h"

@interface AbstractConstant : AbstractNamedEntity {
	NSInteger number; // number representation of type
}
@property (nonatomic) NSInteger number;

- (NSString *)stringRepresentation;	// 2 => Critical

@end
