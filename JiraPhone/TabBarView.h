//
//  TabBarView.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 3/26/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TabBarView : UIViewController {

	IBOutlet UITabBarController *tabBarController;
}
@property (retain,nonatomic) IBOutlet UITabBarController *tabBarController;

@end
