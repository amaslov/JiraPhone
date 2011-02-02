//
//  ConnectorDelegate.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 11/20/10.
//  Copyright 2010 AMaslov. All rights reserved.
//
#import <UIKit/UIKit.h>


@protocol ConnectorDelegate<NSObject>

// called on success
- (void)didReceiveData:(id)result;

// called on failure (no internet connection, has no permission etc). Maybe NSError or SoapFault
- (void)didFailWithError:(id )error;

@end
