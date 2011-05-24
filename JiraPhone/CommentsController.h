//
//  CommentsController.h
//  JiraPhone
//
//  Created by Matthew Gerrior on 5/24/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectorDelegate.h"

@class Issue;
@interface CommentsController : UITableViewController <ConnectorDelegate, UITableViewDelegate>{
	Issue *issue;
	NSMutableArray *comments;
	UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) Issue *issue;
- (id)initForIssue:(Issue *)_issue;
@end
