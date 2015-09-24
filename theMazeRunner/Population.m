//
//  Population.m
//  theMazeRunner
//
//  Created by Jibei Zhao on 2015-06-09.
//  Copyright (c) 2015 Jibei Zhao. All rights reserved.
//

#import "Population.h"


@implementation Population

//@synthesize generations;
//@synthesize theWal;
//@synthesize maxGene;
//@synthesize allIndividuals;


- (instancetype)initWithPopulation
{
//    self.generations = 0;
//    NSMutableArray *populArray =
//    for (int i=0; i<200; i++) {
//       Individual * indiv = [[Individual alloc] initWithGeneticCode];
//        indiv.theWall = self.theWal;
//        NSLog(@"the population wall is %@", self.theWal);
//       [populArray addObject:indiv];
//        
//    }
//    self.allIndividuals = populArray;
    self.allIndividuals = [[NSMutableArray alloc] init];
    return self;
}

- (void) addIndividual:(Individual *) individual
{
    [self.allIndividuals addObject:individual];
    
}


- (NSArray *) sortPopulation
{
   
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"fitness" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray =[self.allIndividuals sortedArrayUsingDescriptors:descriptors];
//    NSLog(@"sorted array %@", sortedArray.description);
    sortDescriptor = nil;
    descriptors = nil;
    return sortedArray;
}

- (int) parentSelect
{
    
//    NSLog(@"the parentselect is %@",self.allIndividuals);
    self.allIndividuals = [NSMutableArray arrayWithArray:[self sortPopulation]];
    
    double sum = [[self.allIndividuals objectAtIndex:199] sortedFitness];
       int chosen = arc4random()% (int)floor(sum);
// for (Individual *indivi in self.allIndividuals) {
    int parentSelected = 0;
 
    for (int i=0; i<199; i++) {
        if ([[self.allIndividuals objectAtIndex:i] sortedFitness] >= chosen ) {
            parentSelected = i;
            break;
        }
    }
//    NSLog(@"enter parentselect %i ", parentSelected);
    return parentSelected;
}


//- (Individual *) parentsselection
//{
//     __block  NSMutableArray* selectedPopulation = [NSMutableArray arrayWithCapacity:150];
// 
//    Individual * firstIndividual;
////    Individual * secondIndividual;
//    int i = arc4random()%200;
//    firstIndividual = selectedPopulation[i];
////    int j = arc4random()%200;
////    if (i !=j) {
////        secondIndividual = selectedPopulation[j];
////    }
////    else{
////        j = (i +30)%200;
////        
////    }
//    
////    NSLog(@"parentselection %@ %@", firstIndividual, secondIndividual);
//    return firstIndividual;
//}

    

@end

