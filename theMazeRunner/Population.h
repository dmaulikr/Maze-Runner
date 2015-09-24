//
//  Population.h
//  theMazeRunner
//
//  Created by Jibei Zhao on 2015-06-09.
//  Copyright (c) 2015 Jibei Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Individual.h"

@interface Population : NSObject


//@property (nonatomic,assign) int generations;
//@property (nonatomic,assign) int maxGene;
@property (nonatomic,strong) NSMutableArray *allIndividuals;
//@property (nonatomic,weak) NSMutableArray *theWal;

- (instancetype)initWithPopulation;

- (void) addIndividual:(id) individual;

- (NSArray *) sortPopulation;  //population.allIndividuals =[ population sortPopulation];

//- (Population *) nextGeneration;

- (int) parentSelect;



//- (Individual * ) parentsselection;

@end
