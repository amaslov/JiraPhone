//
//  UserController.h
//  JiraPhone
//
//  Created by Matthew Gerrior on 4/8/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "ConnectorDelegate.h"


@interface UserController : UITableViewController <ConnectorDelegate>{
	User *user;
	NSString *username;
	UIActivityIndicatorView *activityIndicator;
}

@property(nonatomic, retain) User *user;
@property(nonatomic, retain) NSString *username;
- (id)initForUsername:(NSString *)_username;
@end;