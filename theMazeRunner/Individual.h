//
//  Individual.h
//  theMazeRunner
//
//  Created by Jibei Zhao on 2015-06-09.
//  Copyright (c) 2015 Jibei Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import "Background.h"
#import "ViewController.h"



@interface Individual : NSObject


@property (nonatomic, strong) NSMutableString *geneSequence;
@property (nonatomic) float fitness;
@property (nonatomic) float sortedFitness;
//@property (nonatomic) CGPoint finalPosition;
//@property (nonatomic) CGPoint originalPosition;

@property (nonatomic, weak) NSMutableArray *theWall;

- (instancetype)initWithGeneticCode;


- (float) calculateFitness;
- (Individual *) mutation;
- (NSArray *) crossover: (Individual *) secondIndividual;
- (CGPoint) run;
- (BOOL) hitWall:(CGPoint) testedPoint;

@end
