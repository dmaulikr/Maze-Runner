//
//  Background.h
//  theMazeRunner
//
//  Created by Jibei Zhao on 2015-06-15.
//  Copyright (c) 2015 Jibei Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Background : UIView
{
    
    CGPoint detectpoint;
    
}

@property (nonatomic,strong) UIImage * mazeImage;

//@property (nonatomic,strong) NSArray * theWall;
//
//- (NSArray *) theWallofMaze;

- (void)drawRect:(CGRect)rect;



- (void)addPacMan;

- (void)movePacMan:(UIImageView *)image duration:(NSTimeInterval)duration

             curve:(int)curve x:(CGFloat)x y:(CGFloat)y;
@end




//- (void)drawRect:(CGRect)rect;









//+(NSArray *) theWal;

//+(void) setTheWal:(NSArray *) array;

//+ (NSArray *) theWallofMaze;

//- (instancetype)initWithGraph;

//@property (nonatomic,strong)  UIImage * pacMan;



//-(BOOL)isWall:(UIImage *)image xCoordinate:(int)x yCoordinate:(int)y;


