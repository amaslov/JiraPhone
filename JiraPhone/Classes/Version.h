//
//  Version.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 2/28/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractNamedEntity.h"


@interface Version : AbstractNamedEntity {
	NSDate* _releaseDate;
	NSInteger _sequence;
}
@property (retain,nonatomic) NSDate* releaseDate;
@property (readwrite,assign)  NSInteger sequence;
- (void)fillFromResultSet:(FMResultSet *)rs;


@end
