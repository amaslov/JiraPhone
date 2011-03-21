//
//  ProjectActivityController.h
//  JiraPhone
//
//  Created by Matthew Gerrior on 3/19/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"

@interface ProjectActivityController : UITableViewController <NSXMLParserDelegate>{
	Project *project;
	UIActivityIndicatorView *activityIndicator;
	NSXMLParser *rssParser;
	NSMutableArray *entries;
	NSMutableDictionary *item;
	NSString *currentElement;
	NSMutableString *currentTitle;
	NSMutableString *currentSummary;
}

@property (nonatomic, retain) Project *project;
- (id)initForProject:(Project *)_project;
- (void)parseXMLFileAtURL:(NSString *)URL;
@end
