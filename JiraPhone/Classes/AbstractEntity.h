//
//  AbstractEntity.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 11/24/10.
//  Copyright 2010 AMaslov. All rights reserved.
//
#import <Foundation/Foundation.h>


@interface AbstractEntity : NSObject {
	NSString *ID;
}
@property(nonatomic, retain) NSString *ID;

@end
