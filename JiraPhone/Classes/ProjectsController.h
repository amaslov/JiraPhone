//
//  ProjectsController.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 12/15/10.
//  Copyright 2010 AMaslov. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ConnectorDelegate.h"

@interface ProjectsController : UITableViewController <ConnectorDelegate> {
	// array of Project objects
	NSMutableArray *projects;
	UIActivityIndicatorView *activityIndicator;
}

@end
