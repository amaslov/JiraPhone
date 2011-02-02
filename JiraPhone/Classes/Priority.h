//
//  Priority.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 12/11/10.
//  Copyright 2010 AMaslov. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AbstractConstant.h"

@interface Priority : AbstractConstant {
	
}

// overrides string representation method of AbstractConstant
- (NSString *)stringRepresentation;

@end
