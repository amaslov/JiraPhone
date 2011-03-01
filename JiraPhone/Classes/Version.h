//
//  Version.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 2/28/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Version : AbstractNamedEntity {
	NSDate* _releaseDate;
	NSInteger _sequence;
	Boolean _archived;
	Boolean _released;
}
@property (retain,nonatomic) NSDate* releaseDate;
@property (retain,nonatomic) NSInteger sequence;
@property (retain,nonatomic) Boolean archived;
@property (retain,nonatomic) Boolean released;


@end
