//
//  ProjectDashboardController.h
//  JiraPhone
//
//  Created by Matthew Gerrior on 3/19/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ConnectorDelegate.h"

@class Project;
@class Issue;
@interface ProjectDashboardController : UITableViewController <ConnectorDelegate, UIActionSheetDelegate> {
	Project *project;
	NSMutableArray *dueIssues;
	NSMutableArray *recentIssues;
	NSMutableArray *unresolvedIssues;
	UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) Project *project;
- (id)initForProject:(Project *)_project;
- (IBAction)showActionSheet:(id)sender;
@end
