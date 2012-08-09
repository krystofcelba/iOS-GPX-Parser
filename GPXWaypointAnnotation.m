//
//  GPXWaypointAnnotation.m
//  Databáze letišť
//
//  Created by Krystof Celba on 20.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GPXWaypointAnnotation.h"

@implementation GPXWaypointAnnotation
@synthesize name = _name;
@synthesize desc = _desc;
@synthesize coordinate = _coordinate;
@synthesize imageName = _imageName;

- (id)initWithName:(NSString*)name desc:(NSString*)desc coordinate:(CLLocationCoordinate2D)coordinate 
{
    if ((self = [super init])) {
        _name = [name copy];
        _desc = [desc copy];
        _coordinate = coordinate;
    }
    return self;
}

- (NSString *)title {
	return _name;
}

- (NSString *)subtitle {
    return _desc;
}

@end
