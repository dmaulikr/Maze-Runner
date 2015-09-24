//
//  GeneticAlgo.h
//  theMazeRunner
//
//  Created by Jibei Zhao on 2015-06-08.
//  Copyright (c) 2015 Jibei Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Individual.h"
#import "Population.h"

@interface GeneticAlgo : NSObject

//@property (nonatomic, readonly, assign) NSInteger generations;
//@property (nonatomic, readonly, strong) NSString *result;
//@property (nonatomic, strong) NSMutableArray *population;
//@property (nonatomic, copy) NSString *targetSequence;
//
//
//- (void)populate;
//- (void)run;
//- (void)breedNextGeneration;
//- (void)shufflePopulation;
//- (void)analyzePopulation;

- (Individual *) parentsselection: (Population *) population;
- (Individual *) mutation: (Individual *) individual;
- (Individual *) crossover: (Individual *) firstIndividual :(Individual *)secondIndividual;


@end
