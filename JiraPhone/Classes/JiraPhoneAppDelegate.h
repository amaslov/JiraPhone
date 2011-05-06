//
//  JiraPhoneAppDelegate.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 11/15/10.
//  Copyright 2010 AMaslov. All rights reserved.
//
#import <UIKit/UIKit.h>

#define appDelegate ((JiraPhoneAppDelegate *)[[UIApplication sharedApplication]delegate])

@class FMDatabase;
@interface JiraPhoneAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UIViewController *viewController;
}
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIViewController *viewController;

//+(NSMutableDictionary *)priorityImages;
+(UIImage *)getImageByPriority:(NSNumber *)_num;
+(void)initializePriorityImageMap;
+(NSString *)getStringByPriority:(NSNumber *)_num;
+(void)initializePriorityStringMap;
+(NSString *)getStringByStatus:(NSNumber *)_num;
+(void)initializeStatusStringMap;
+(UIImage *)getImageByStatus:(NSNumber *)_num;
+(void)initializeStatusImageMap;
// database managing
+ (FMDatabase *)sharedDB;
+ (void)allocAndOpenDatabase;

@end

