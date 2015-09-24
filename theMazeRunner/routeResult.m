//
//  routeResult.m
//  theMazeRunner
//
//  Created by Jibei Zhao on 2015-06-17.
//  Copyright (c) 2015 Jibei Zhao. All rights reserved.
//

#import "routeResult.h"

@implementation routeResult

@synthesize routeImage;

- (void)drawRect:(CGRect)rect {
    
    
    
    if(routeImage){
        
        
        
        CGRect imageRect =CGRectMake(0, 0, self.frame.size.width,self.frame.size.height);
        
        [routeImage drawInRect:imageRect];
        
        
        
        //        NSLog(@"%f,%f",self.frame.size.width,self.frame.size.height);
        
        //        NSLog(@"width %f, height %f",mazeImage.size.width,mazeImage.size.height);
        
    }
    
    
    
    
    
    
    
}


@end
