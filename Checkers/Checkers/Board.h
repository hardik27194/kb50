//
//  Board.h
//  Checkers
//
//  Created by Allard Soeters on 09-09-13.
//  Copyright (c) 2013 HHS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Square.h"

@interface Board : NSObject
{
    int size;
    NSMutableArray *squares;
}
@property(nonatomic) int size;
@property(nonatomic,retain) NSMutableArray *squares;

-(id)initWithSize:(int)size;
-(int)checkWinConditions;
-(void)setup;
-(void)draw;
-(void)addNeighboringSquares;

-(Square *)getSquareAtRow:(int)aRow Column:(int)aColumn;

@end
