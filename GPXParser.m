//
//  GPXParser.m
//  Databáze letišť
//
//  Created by Krystof Celba on 20.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GPXParser.h"
#import "TBXML.h"
#import "GPXWaypointAnnotation.h"
#import "GPXTrackPolyLine.h"
#import "UIColor+named.h"


@implementation GPXParser

-(id) initWithGPXFile: (NSString *) file
{
	if (self = [super init]) {
		tbxml = [TBXML tbxmlWithXMLFile:file error:nil];
	}
	return self;
}

-(NSArray *) getWaypoints
{
	NSMutableArray *wpts = [[NSMutableArray alloc] init];
    TBXMLElement *root = tbxml.rootXMLElement;
    if (root) 
	{
		TBXMLElement *wpt = [TBXML childElementNamed:@"wpt" parentElement:root];
		while (wpt) 
		{
			TBXMLElement *nameEl = [TBXML childElementNamed:@"name" parentElement:wpt];
			TBXMLElement *descEl = [TBXML childElementNamed:@"desc" parentElement:wpt];
			TBXMLElement *symEl = [TBXML childElementNamed:@"sym" parentElement:wpt];
			
			NSString *lat = [TBXML valueOfAttributeNamed:@"lat" forElement:wpt];
			NSString *lon = [TBXML valueOfAttributeNamed:@"lon" forElement:wpt];
			NSString *name = @"";
			if (nameEl) 
			{
				name = [TBXML textForElement:nameEl];
			}
			NSString *desc;
			if (descEl) 
			{
				desc = [TBXML textForElement:descEl];
			}
			NSString *image = @"";
			if (symEl) 
			{
				image = [[TBXML textForElement:symEl] stringByReplacingOccurrencesOfString:@" " withString:@"_"];
			}
			
			GPXWaypointAnnotation *ann = [[GPXWaypointAnnotation alloc] initWithName:name desc:desc coordinate:CLLocationCoordinate2DMake([lat doubleValue], [lon doubleValue])];
			ann.imageName = image;
			[wpts addObject:ann];
			
			wpt = [TBXML nextSiblingNamed:@"wpt" searchFromElement:wpt];
        }
    }
	
	return wpts;
}


-(NSArray *) getTracks
{
	NSMutableArray *tracks = [[NSMutableArray alloc] init];
    TBXMLElement *root = tbxml.rootXMLElement;
    if (root) 
	{
		TBXMLElement *trk = [TBXML childElementNamed:@"trk" parentElement:root];
		while (trk) 
		{
			//[self traverseElement:trk];
			TBXMLElement *nameEl = [TBXML childElementNamed:@"name" parentElement:trk];
			TBXMLElement *segEl = [TBXML childElementNamed:@"trkseg" parentElement:trk];
			TBXMLElement *extEl = [TBXML childElementNamed:@"gpxx:TrackExtension" parentElement:[TBXML childElementNamed:@"extensions" parentElement:trk]];
			NSString *name = @"";
			if (nameEl) 
			{
				name = [TBXML textForElement:nameEl];
			}
			
			UIColor *color = nil;
			if (extEl) 
			{
				TBXMLElement *colorEl = [TBXML childElementNamed:@"gpxx:DisplayColor" parentElement:extEl];
				if (colorEl) 
				{
					color = [UIColor colorNamed:[TBXML textForElement:colorEl]];
				}
			}
			NSMutableArray *trackPoints = [[NSMutableArray alloc] init];
			if (segEl)
			{
				TBXMLElement *pointEl = [TBXML childElementNamed:@"trkpt" parentElement:segEl];
				while (pointEl) 
				{
					NSString *lat = [TBXML valueOfAttributeNamed:@"lat" forElement:pointEl];
					NSString *lon = [TBXML valueOfAttributeNamed:@"lon" forElement:pointEl];
					
					CLLocation *loc = [[CLLocation alloc] initWithLatitude:[lat floatValue] longitude:[lon floatValue]];
					[trackPoints addObject:loc];
					pointEl = [TBXML nextSiblingNamed:@"trkpt" searchFromElement:pointEl];
				}

				
				CLLocationCoordinate2D coords[[trackPoints count]];
				for(int i = 0; i < trackPoints.count; i++) 
				{        
					CLLocation* location = [trackPoints objectAtIndex:i];     
					CLLocationCoordinate2D c;
					c.latitude = location.coordinate.latitude;
					c.longitude = location.coordinate.longitude;        
					coords[i] = c; 
				}
				GPXTrackPolyLine *poly = (GPXTrackPolyLine *)[GPXTrackPolyLine polylineWithCoordinates:coords count:trackPoints.count];
				poly.color = [UIColor redColor];
				if (color) 
				{
					poly.color = color;
				}
				poly.title = name;
				[tracks addObject:poly];
			}
			trk = [TBXML nextSiblingNamed:@"trk" searchFromElement:trk];
        }
    }
	
	return tracks;
}

@end
