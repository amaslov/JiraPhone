//
//  IssueDetailsController.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 12/20/10.
//  Copyright 2010 AMaslov. All rights reserved.
//
#import <UIKit/UIKit.h>
//TODO: Update sections!!!!

// sections
#define ISSUE_DATA_SECTION	0
#define ISSUE_MAN_SECTION	1
#define ISSUE_DATE_SECTION	2

// rows
#define ISSUE_SUMMARY_ROW			0
#define ISSUE_TYPE_ROW				1
#define ISSUE_PRIORITY_ROW			2
#define ISSUE_AFFECT_VERSIONS_ROW	3
#define ISSUE_STATUS_ROW			4
#define ISSUE_RESOLUTION_ROW		5
//
//users - to change to a more detailed stuff
#define ISSUE_ASSIGNEE_ROW			0
#define ISSUE_REPORTER_ROW			1

//date rows
#define ISSUE_CREATED_ROW			0
#define ISSUE_UPDATED_ROW			1

@class Issue;
@interface IssueDetailsController : UITableViewController {
	Issue *issue;
}

- (id)initForIssue:(Issue *)_issue;
- (NSString *)titleForCellAtIndexPath:(NSIndexPath *)indexPath;
@end
