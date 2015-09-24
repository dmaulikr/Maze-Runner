//
//  ViewController.m
//  theMazeRunner
//
//  Created by Jibei Zhao on 2015-06-05.
//  Copyright (c) 2015 Jibei Zhao. All rights reserved.
//

#import "ViewController.h"
#import "Background.h"
#import "Population.h"
#import "Individual.h"
#import "showingResultViewController.h"



@implementation ViewController

@synthesize theWallofMaze = _theWallofMaze;

#pragma mark - keyboard delegat


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
  
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动216个单位，以使下面腾出地方用于软键盘的显示
    
        self.view.frame = CGRectMake(0.0f, -216, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}


#pragma mark - explore route
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Explore Route"]) {
        showingResultViewController * showResultsVC = (showingResultViewController *)segue.destinationViewController;
        showResultsVC.showResultLabel.text =[NSString stringWithFormat:@"slkjdlksdjf"];
    }
}


- (NSMutableArray *) theWallofMaze
{
    if (_theWallofMaze != nil ) {
        return _theWallofMaze;
    }
    else{
        _theWallofMaze = [self detectTheWallofMaze];
        return  _theWallofMaze;
    }
}

- (Population *) tonextGeneration:(Population *)popu
{
    
    NSMutableArray *parentsArray = [[NSMutableArray alloc] init];
    NSMutableArray *sonsArray = [[NSMutableArray alloc] init];
    popu.allIndividuals = [NSMutableArray arrayWithArray:[popu sortPopulation]];
    popu = [self setIndividualSortedFitness:popu];
    NSLog(@"popu sorted fitness %f", [[popu.allIndividuals objectAtIndex:199] sortedFitness]);

    
    for (int i = 0; i< 80; i++) {
        
//        NSLog(@"the mate %i" , i);
        Individual * firstParent = [popu.allIndividuals objectAtIndex:[popu parentSelect]];
        Individual * secondParent = [popu.allIndividuals objectAtIndex:[popu parentSelect]];
        NSArray *sons = [NSArray arrayWithArray:[firstParent crossover:secondParent]];
//         NSLog(@"songs array %@",sons);
//        NSLog(@"firstparent,secondparent %@,%@",firstParent,secondParent);
        
        Individual * firstSon = [[Individual alloc]initWithGeneticCode];
        Individual * secondSon = [[Individual alloc]initWithGeneticCode];
        
       
        firstSon = [[sons objectAtIndex:0] mutation];
        secondSon = [[sons objectAtIndex:1] mutation];
        

        firstSon.theWall = self.theWallofMaze;
        secondSon.theWall =self.theWallofMaze;
//        NSLog(@"firstson, secondson%@,%@",firstSon,secondSon);
        [firstSon run];
        [secondSon run];

        
        parentsArray = popu.allIndividuals;
        
        [sonsArray addObject:firstSon];
        [sonsArray addObject:secondSon];
        
//         NSLog(@"next parrent array, sonsarray %@,%@",parentsArray,sonsArray);
        
    }
    
    [parentsArray addObjectsFromArray:sonsArray]; // parents merge with children
//     NSLog(@"next generation parentsarray array %@",parentsArray);
    NSLog(@"parent+son count %lu",(unsigned long)[parentsArray count]);
    
    popu.allIndividuals = parentsArray;
    parentsArray = [NSMutableArray arrayWithArray:[popu sortPopulation]];
//    NSLog(@" children has been sorted, array number %lu",(unsigned long)[parentsArray count]);
    sonsArray = [NSMutableArray arrayWithArray:[ parentsArray subarrayWithRange:NSMakeRange(160, 200)]] ;
    
    popu.allIndividuals = sonsArray;
    
    
//    sonsArray = nil;
//    parentsArray = nil;
//    NSLog(@"next generation array %@",popu);
    
    return popu;
    
    
    
}

- (NSMutableArray *) detectTheWallofMaze
{
    NSMutableArray * theWall = [[NSMutableArray alloc]init];
    CGPoint detectpoint;
    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(self.mazeBackground.mazeImage.CGImage));
    const UInt8* data = CFDataGetBytePtr(pixelData);
    
    for (int i=0; i<self.mazeBackground.mazeImage.size.height*self.mazeBackground.mazeImage.size.width; i++) {
        int pixelInfo = i*4;
        UInt8 alpha = data[pixelInfo + 3];
        if (alpha) {
            detectpoint.y = floor(i/self.mazeBackground.mazeImage.size.width);
            detectpoint.x = i % (int)self.mazeBackground.mazeImage.size.width;
            [theWall addObject:[NSValue valueWithCGPoint:detectpoint]];
//            NSLog(@"the wall %f, %f",detectpoint.x,detectpoint.y);
        }
    }
//    NSLog(@"the wall it self %@",theWall);
    
    return theWall;

}

- (Population *) setIndividualSortedFitness:(Population *)originPopulation
{
    NSMutableArray * sorted = [[NSMutableArray alloc]initWithArray:[originPopulation sortPopulation]];
    originPopulation.allIndividuals = sorted;
    
    [[originPopulation.allIndividuals objectAtIndex:0] setSortedFitness:[[originPopulation.allIndividuals objectAtIndex:0] fitness] ] ;
    
    for (int i=1; i<200; i++) {
        [[originPopulation.allIndividuals objectAtIndex:i] setSortedFitness:([[originPopulation.allIndividuals objectAtIndex:i-1] sortedFitness]+[[originPopulation.allIndividuals objectAtIndex:i] fitness ])];
    }
//    for (Individual *indivi in originPopulation.allIndividuals) {
//        NSLog(@"the indiv sorted fitness is %f", indivi.sortedFitness);
//        NSLog(@"the indiv fitness is %f",indivi.fitness);
        
//    }
    
//    sorted = nil;
    
    return originPopulation;
}

- (IBAction)exploreMaze:(UIButton *)sender
{
    
//init population and individuals
    Population * originPopulation =[[Population alloc]initWithPopulation];
    for (int i=0; i<200; i++) {
        Individual * indiv = [[Individual alloc] initWithGeneticCode];
        indiv.theWall = self.theWallofMaze;
        [originPopulation.allIndividuals addObject:indiv];
          NSLog(@"the indiv %i fitness is %f", i,indiv.fitness);
          NSLog(@"the indiv %i fitness is %@", i,[NSValue valueWithCGPoint:[indiv run]]);
    }
    
    
    
    Population * nextGene =[[Population alloc] initWithPopulation];
    nextGene = originPopulation;
    nextGene = [self setIndividualSortedFitness:nextGene];
     
    
    
    for (int i= 0; i<30 ; i++) { //[self.maxGeneration.text intValue]
//        Population * middleGene =[[Population alloc] initWithPopulation];
//        middleGene = nextGene;
//        middleGene.allIndividuals = [NSMutableArray arrayWithArray:[middleGene sortPopulation]];
        
        nextGene = [self tonextGeneration:nextGene];
        NSLog(@"THIS IS THE %i GENERATION", i);
        NSLog(@"the biggest sortedfitness %f",[[nextGene.allIndividuals objectAtIndex:199] sortedFitness]);
        NSLog(@"the average fitness %f",([[nextGene.allIndividuals objectAtIndex:199] sortedFitness]/200) );
        NSLog(@"the best fitness %f",[[nextGene.allIndividuals objectAtIndex:199] fitness] );
        
//        nextGene = middleGene;

    }

//    originPopulation.maxGene = [self.maxGeneration.text intValue];
    
    

}


- (IBAction)runMaze:(UIButton *)sender
{
//CGAffineTransform transform = CGAffineTransformMakeTranslation(10, 10);
    
    
}

- (IBAction)restartGame:(UIButton *)sender
{
    
//    self.mazeBackground.addPacMan;
    
}



#pragma mark - genetic algorithm

//- (Individual *) parentsselection: (Population *) population
//{
//        Individual * firstIndividual;
//        Individual * secondIndividual;
//        return firstIndividual, secondIndividual;
//}
//
//- (Individual *) mutation: (Individual *) individual
//{
//    
//        return individual;
//}
//- (Individual *) crossover: (Individual *) firstIndividual :(Individual *)secondIndividual
//{
//        Individual * firstSon;
//        Individual * secondSon;
//        return firstSon, secondSon;
//}
//


- (void)viewDidLoad {
    [super viewDidLoad];

    //Drawing code
    
    
    self.mazeBackground.mazeImage = [UIImage imageNamed:@"Kids Maze 20"];
    [self.mazeBackground addPacMan];
//    NSLog(@"the frame size %f, %f", self.mazeBackground.frame.size.width,self.mazeBackground.frame.size.height);
    self.theWallofMaze = [self detectTheWallofMaze];
//    NSLog(@"the wallofmaze %@", self.theWallofMaze);
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.generation.delegate = self;
}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
 

@end
