//
//  GPXWaypointAnnotation.h
//  Databáze letišť
//
//  Created by Krystof Celba on 20.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mapkit/Mapkit.h>

@interface GPXWaypointAnnotation : NSObject <MKAnnotation>

@property (copy) NSString *name;
@property (copy) NSString *desc;
@property (copy) NSString *imageName;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

-(id)initWithName:(NSString*)name desc:(NSString*)desc coordinate:(CLLocationCoordinate2D)coordinate;

@end
