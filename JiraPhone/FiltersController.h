//
//  FiltersController.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 3/25/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectorDelegate.h"
#import "Filter.h"

@interface FiltersController : UITableViewController<ConnectorDelegate, UIActionSheetDelegate>  {
	NSMutableArray *filters;
	UIActivityIndicatorView *activityIndicator;

}

@end
