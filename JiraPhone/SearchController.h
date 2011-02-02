//
//  SearchController.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 1/10/11.
//  Copyright 2011 AMaslov. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "SearchCell.h"
#import "ConnectorDelegate.h"

@class Project;
@interface SearchController : UITableViewController<UISearchBarDelegate, ConnectorDelegate> {
	NSMutableArray *results;
	IBOutlet SearchCell *searchCell;
	Project *project;
	
	UIActivityIndicatorView *activityIndicator;
}
@property (nonatomic, retain) Project *project;
@property (nonatomic, retain) IBOutlet SearchCell *searchCell;

- (IBAction)cancelAction;
@end
