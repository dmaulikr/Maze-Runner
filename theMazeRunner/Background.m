//

//  Background.m

//  theMazeRunner

//

//  Created by Jibei Zhao on 2015-06-05.

//  Copyright (c) 2015 Jibei Zhao. All rights reserved.

//



#import "Background.h"







@implementation Background





@synthesize mazeImage;

//@synthesize theWall=_theWall;

//@synthesize pacMan;

/*
 
 Only override drawRect: if you perform custom drawing.
 
 An empty implementation adversely affects performance during animation.*/



//-(UIImage *)pacMan

//{

//    if (!pacMan) {

//        pacMan =[UIImage imageNamed:@"pacMan"];

//    }

//    return pacMan;

//}



//+ (NSArray *) theWallofMaze

//{

//    NSMutableArray * theWall = [[NSMutableArray alloc]init];

//    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(mazeImage.CGImage));

//    const UInt8* data = CFDataGetBytePtr(pixelData);

//

//    for (int i=0; i<mazeImage.size.height*mazeImage.size.width; i++) {

//        int pixelInfo = i*4;

//        UInt8 alpha = data[pixelInfo + 3];

//        if (alpha) {

//            detectpoint.y = floor(i/mazeImage.size.width);

//            detectpoint.x = i % (int)mazeImage.size.width;

//            [theWall addObject:[NSValue valueWithCGPoint:detectpoint]];

//            NSLog(@"the wall %f, %f",detectpoint.x,detectpoint.y);

//        }

//

//    }

//    return theWall;

//

//}





//- (NSArray *)theWallofMaze
//
//{
//    
//    NSMutableArray * theWall = [[NSMutableArray alloc]init];
//    
//    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(mazeImage.CGImage));
//    
//    const UInt8* data = CFDataGetBytePtr(pixelData);
//    
//    
//    
//    for (int i=0; i<mazeImage.size.height*mazeImage.size.width; i++) {
//        
//        int pixelInfo = i*4;
//        
//        UInt8 alpha = data[pixelInfo + 3];
//        
//        if (alpha) {
//            
//            detectpoint.y = floor(i/mazeImage.size.width);
//            
//            detectpoint.x = i % (int)mazeImage.size.width;
//            
//            [theWall addObject:[NSValue valueWithCGPoint:detectpoint]];
//            
//            NSLog(@"the wall %f, %f",detectpoint.x,detectpoint.y);
//            
//        }
//        
//        
//        
//    }
//    
//       return theWall;
//    
//}
//




-(void)addPacMan

{
    
    UIImageView *imageToMove =
    
    [[UIImageView alloc] initWithImage:[UIImage
                                        
                                        imageNamed:@"pacMan"]];
    
    //    NSLog(@"%f", self.frame.size.height);
    
    
    
    imageToMove.frame = CGRectMake(0, 75.6, 16, 16);
    
    [self addSubview:imageToMove];
    
    //    [self bringSubviewToFront:imageToMove];
    
    
    
}



- (void)movePacMan:(UIImageView *)image duration:(NSTimeInterval)duration

             curve:(int)curve x:(CGFloat)x y:(CGFloat)y

{
    
    // Setup the animation
    
    [UIView beginAnimations:nil context:NULL];
    
    [UIView setAnimationDuration:duration];
    
    [UIView setAnimationCurve:curve];
    
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    
    
    // The transform matrix
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(x, y);
    
    image.transform = transform;
    
    
    
    // Commit the changes
    
    [UIView commitAnimations];
    
    
    
    //    调用方法
    
    //    [self moveImage:imageToMove duration:3.0
    
    //              curve:UIViewAnimationCurveLinear x:50.0 y:50.0];
    
    
    
}



- (void)drawRect:(CGRect)rect {
    
    
    
    if(mazeImage){
        
        
        
        CGRect imageRect =CGRectMake(0, 0, self.frame.size.width,self.frame.size.height);
        
        [mazeImage drawInRect:imageRect];
        
        
        
        //        NSLog(@"%f,%f",self.frame.size.width,self.frame.size.height);
        
//        NSLog(@"width %f, height %f",mazeImage.size.width,mazeImage.size.height);
        
    }
    
    
    
    
    
    
    
}



//-(instancetype)initWithGraph

//{

//  

//    self.theWall = [self theWallofMaze];

//    return self;

//}





@end

