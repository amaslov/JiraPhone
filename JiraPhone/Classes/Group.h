//
//  Group.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 3/15/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractNamedEntity.h"
#import "User.h"

@interface Group : AbstractNamedEntity {
	NSMutableArray *_users;
}
@property (retain, nonatomic) NSMutableArray *users;
//gets users for jira-users group
+ (void)getCachedGroup:(NSMutableArray *)_users;
@end
