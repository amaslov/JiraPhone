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
#import "CreateIssueDelegate.h"

@class Project;
@class Issue;
@interface ProjectDashboardController : UITableViewController <ConnectorDelegate, UIActionSheetDelegate, CreateIssueDelegate> {
	Project *project;
	bool cachedIssues;
	NSMutableArray *dueIssues;
	NSMutableArray *recentIssues;
	NSMutableArray *unresolvedAssignee;
	NSMutableArray *unresolvedPriority;
	NSMutableArray *statusList;
	UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) Project *project;
- (id)initForProject:(Project *)_project;
- (IBAction)showActionSheet:(id)sender;
- (void)didCreateNewIssue:(Issue *)_issue;
@end
