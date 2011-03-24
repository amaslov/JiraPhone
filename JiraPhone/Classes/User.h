//
//  User.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 12/12/10.
//  Copyright 2010 AMaslov. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AbstractNamedEntity.h"

@interface User : AbstractNamedEntity {
//	NSString* _server; // server name
	NSString* _name;
	NSString* _fullName;
	NSString* _email;
	NSString *_password;
	NSUInteger _hashcode;
	
}
//@property (nonatomic, retain) NSString* server;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* fullName;
@property (nonatomic, retain) NSString* email;
@property (nonatomic, retain) NSString* password;
@property NSUInteger hashcode;
// returns logged in User;
+ (User *)loggedInUser;

// insert or get logged in users data from local db
+ (void)setLoggedInUser:(User *)_user;
@end
