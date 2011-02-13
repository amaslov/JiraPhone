//
//  Filter.h
//  JiraPhone
//
//  Created by Paul Dejardin on 2/11/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractNamedEntity.h"
#import "filterProperties.h"
#import "filterAttributes.h"
#import "filterDates.h"
#import "filterWorkRatios.h"


@interface Filter : AbstractNamedEntity{
	filterProperties* search_properties;
	filterAttributes* search_attributes;
	filterDates* search_dates;
	filterWorkRatios* search_ratios;
	
}
@property (retain, nonatomic) filterProperties* search_properties;
@property (retain, nonatomic) filterAttributes* search_attributes;
@property (retain, nonatomic) filterDates* search_dates;
@property (retain, nonatomic) filterWorkRatios* search_ratios;

@end
