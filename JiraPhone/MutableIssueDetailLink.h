//
//  MutableIssueDetailLink.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 2/23/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MutableIssueDetailLink : UITableViewCell {
	IBOutlet UILabel *title;
	IBOutlet UILabel *text;

}
@property (nonatomic, retain) IBOutlet UILabel *title;
@property (nonatomic, retain) IBOutlet UILabel *text;

@end
