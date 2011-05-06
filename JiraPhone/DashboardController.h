//
//  DashboardController.h
//  JiraPhone
//
//  Created by Matthew Gerrior on 2/26/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ConnectorDelegate.h"

@class Project;
@class Issue;
@class User;
@class Filter;
@interface DashboardController : UITableViewController <ConnectorDelegate> {
	Project *project;
	NSMutableArray *issues;
	NSMutableArray *filters;
	User *currentUser;
	UIActivityIndicatorView *activityIndicator;
}

@property(nonatomic,retain) User *currentUser;
- (id)initForUser:(User *)_user;
@end
