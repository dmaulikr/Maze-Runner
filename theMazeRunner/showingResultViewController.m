//
//  showingResultViewController.m
//  theMazeRunner
//
//  Created by Jibei Zhao on 2015-06-16.
//  Copyright (c) 2015 Jibei Zhao. All rights reserved.
//

#import "showingResultViewController.h"
#import "routeResult.h"


@interface showingResultViewController ()

@property (nonatomic,strong) NSArray * averageFitness;


@end

@implementation showingResultViewController
@synthesize showResultLabel;


- (void)viewDidLoad
{
    
}

//- (void) setShowRouteImage:(UIView *)showRouteImage
//{
//    CGRect imageRect =CGRectMake(0, 0, self.showRouteImage.frame.size.width,self.showRouteImage.frame.size.height);
//    
//    [showRouteImage drawInRect:imageRect];
//
//}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
     self.showRouteImage.routeImage = [UIImage imageNamed:@"Kids Maze result"];
    [self updateUI];
}


- (void) updateUI
{
    self.showResultLabel.text = [NSString stringWithFormat:@"the best result is 00001000101011010101111111101110101101010101010010001001001010101010101010101010101010"];
}
@end
