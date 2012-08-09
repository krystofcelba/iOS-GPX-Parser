//
//  GPXParser.h
//  Databáze letišť
//
//  Created by Krystof Celba on 20.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TBXML;

@interface GPXParser : NSObject
{
	TBXML *tbxml;
}

-(id) initWithGPXFile: (NSString *) file;
-(NSArray *) getWaypoints;
-(NSArray *) getTracks;
@end
