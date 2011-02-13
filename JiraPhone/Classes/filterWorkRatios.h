//
//  filterWorkRatios.h
//  JiraPhone
//
//  Created by Paul Dejardin on 2/11/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface filterWorkRatios : NSObject {
	NSNumber* min;
	NSNumber* max;
}

@property (retain, nonatomic) NSNumber* min;
@property (retain, nonatomic) NSNumber* max;

-(id)init;
-(id)initAllNil;

@end
