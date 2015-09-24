//
//  ViewController.h
//  theMazeRunner
//
//  Created by Jibei Zhao on 2015-06-05.
//  Copyright (c) 2015 Jibei Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Background.h"
#import "Individual.h"
#import "Population.h"

@class Population;
@interface ViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *generation;

@property (weak, nonatomic) IBOutlet Background *mazeBackground;
@property (weak, nonatomic) IBOutlet UITextField *maxGeneration;
@property (strong, nonatomic) NSMutableArray * theWallofMaze;
//@property (nonatomic, strong) Individual *theIndividual;

- (Population *) tonextGeneration:(Population *) popul;
- (Population *) setIndividualSortedFitness:(Population *)originPopulation;


//
//- (Individual *) mutation: (Individual *) individual;
//- (Individual *) crossover: (Individual *) firstIndividual :(Individual *)secondIndividual;
- (NSMutableArray *) detectTheWallofMaze;




@end

