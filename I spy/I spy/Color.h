//
//  Color.h
//  I spy
//
//  Created by Julian Profas on 27/10/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Color : NSObject
@property NSString *colorName;
@property UIColor *colorData;
@property NSString *hsv;

#pragma mark - Initialization Methods
- initWithColor:(UIColor *)aColor;

#pragma mark - Methods for debugging
-(NSString *)fillStringWithHSV:(UIColor *)aColor;
@end
