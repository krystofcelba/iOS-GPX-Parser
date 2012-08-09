//
//  UIColor+string.m
//  Databáze letišť
//
//  Created by Krystof Celba on 20.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIColor+named.h"


@implementation UIColor (named)


 -(id)copyWithZone:(NSZone *)zone 
{ 
	CGColorRef cgcopy = CGColorCreateCopy([self CGColor]);
	UIColor *copy = [[[self class] allocWithZone:zone] initWithCGColor:cgcopy];
	return copy; 
} 

+(UIColor *)colorNamed: (NSString *) name
{
	if ([name isEqualToString:@"DarkRed"]) {
		return RGB(139, 0, 0);
	}
	if ([name isEqualToString:@"DarkBlue"]) {
		return RGB(0, 0, 139);
	}
	if ([name isEqualToString:@"LightGray"]) {
		return RGB(211, 211, 211);
	}
	if ([name isEqualToString:@"DarkGray"]) {
		return RGB(47, 47, 79);
	}
	SEL colorSelector = NSSelectorFromString([NSString stringWithFormat:@"%@Color", [name lowercaseString]]);
	
    // Check if this is a valid color first
    if ([[UIColor class] respondsToSelector:colorSelector]) {
		
        // Dynamically invoke the class method
		#pragma clang diagnostic push
		#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [[UIColor class] performSelector:colorSelector];
		#pragma clang diagnostic pop  
    }
	return nil;
}

@end
