//
//  Individual.m
//  theMazeRunner
//
//  Created by Jibei Zhao on 2015-06-09.
//  Copyright (c) 2015 Jibei Zhao. All rights reserved.
//

#import "Individual.h"
#import "Background.h"



@implementation Individual

@synthesize geneSequence=_geneSequence;
//@synthesize finalPosition=_finalPosition;
//@synthesize originalPosition;
@synthesize fitness=_fitness;
@synthesize sortedFitness= _sortedFitness;
@synthesize theWall;

#pragma mark - init

-(NSMutableString *)geneSequence
{
    return _geneSequence;
}

-(void) setGeneSequence:(NSMutableString *)geneSequence
{
    if (!_geneSequence) {
        _geneSequence = geneSequence;
    }
}
- (instancetype)initWithGeneticCode
{
    
    NSMutableString *str = [[NSMutableString alloc]init];
        for (int i=0; i<500; i++) {
            [str appendFormat:@"%i",arc4random()%2];
        }
        self.geneSequence = str;
    str = nil;
//    originalPosition = CGPointMake(20, 230);
//        NSLog(@"self genesequence %@", self.geneSequence);
//     NSLog(@"individual fitness %f, final position %@", self.fitness,NSStringFromCGPoint(self.finalPosition));
    self.fitness = 0;
    
    
  return self;
}




#pragma mark - genetic algorithm

//- (CGPoint)finalPosition
//{
//    if (_finalPosition.x+_finalPosition.y) {
//        return _finalPosition;
//    }else{
//        _finalPosition = self.run;
//        return _finalPosition;
//    }
//}
//
//- (void)setFinalPosition:(CGPoint)finalPosition
//{
//    
//    _finalPosition = finalPosition;;
//}
//
- (float)fitness
{
    if (_fitness) {
        return _fitness;
    }
    else{
        _fitness = 2000-[self calculateFitness];
        if (_fitness >0) {
           return _fitness;
        }else{
        return _fitness=0;
        }
         }
    
}

-(void)setFitness:(float)fitness
{
    _fitness = fitness;
}


-(float)sortedFitness
{

    return _sortedFitness;
}

-(void)setSortedFitness:(float)sortedFitness
{
    _sortedFitness = sortedFitness;
}




- (float) calculateFitness
{
    float fit;
    CGPoint finalPosition = [self run];

    fit = sqrtf( powf(finalPosition.x-580,2.0f)+powf(finalPosition.y-20, 2.0f));
    
    return fit;
}

- (Individual *) mutation
{
    int bit = arc4random() % 250;
    NSRange range = NSMakeRange(bit, 1);
    if ([[self.geneSequence substringWithRange:range] intValue]) {
     [self.geneSequence replaceCharactersInRange:range withString:@"0"];
    }else{
     [self.geneSequence replaceCharactersInRange:range withString:@"1"];
    }
    return self;
}

- (NSArray *) crossover:(Individual *)secondIndividual
{
    
//     NSLog(@"crossover begin, %@ %@", self , secondIndividual);
    Individual * firstSon = [[Individual alloc] initWithGeneticCode];
    Individual * secondSon = [[Individual alloc] initWithGeneticCode];
    firstSon.geneSequence =self.geneSequence;
    secondSon.geneSequence =secondIndividual.geneSequence;
    
    int i=arc4random()%250;
    NSRange  range = NSMakeRange(i, (250-i));
   
    [firstSon.geneSequence replaceCharactersInRange:range withString:[secondIndividual.geneSequence substringWithRange:range]];
    [secondSon.geneSequence replaceCharactersInRange:range withString:[self.geneSequence substringWithRange:range]];
    
//    NSLog(@"crossover result, %@ %@", firstSon, secondSon);
    return [NSArray arrayWithObjects:firstSon, secondSon, nil];
    
}


#pragma mark - hitWall detection

- (BOOL) hitWall:(CGPoint)testedPoint
{
//        NSLog(@"thewallofmaze %@",self.theWall);
//     NSLog(@"the tested point %@",[NSValue valueWithCGPoint:testedPoint]);
    NSValue * testvalue = [NSValue valueWithCGPoint:testedPoint];
    bool flag = 0;
//    NSLog(@"the trying point %@", testvalue );
//    NSLog(@"the tested value %@",testvalue);
    for (int i=0 ; i < [self.theWall count]; i++) {
        NSValue * thewallvalue = [self.theWall objectAtIndex:i];
        if ([thewallvalue isEqual:testvalue] || testedPoint.x < 0 ||testedPoint.y < 0) {
            flag = 1;
        }
        
//        if ([[self.theWall objectAtIndex:i] X] == testedPoint.x && [[self.theWall objectAtIndex:i] Y] == testedPoint.y) {
//            flag = 1;
//        }
    }
    
//     NSLog(@"hitwall? is %i", flag);
    return flag;
}


- (CGPoint) run
{
    CGPoint position = CGPointMake(20, 230);
//    NSValue *positionValue =[NSValue valueWithCGPoint:position];
//    NSLog(@"run position %@",positionValue);
    CGPoint positionMiddle;
    CGPoint hit ;
    
    for (int i=0; i<250; i = i+2) {
        
        NSRange range = {i, 2};
//       NSLog(@"range ,%@",NSStringFromRange(range));
        NSString *direction = [self.geneSequence substringWithRange:range];
//        NSLog(@"genecode ,%@",self.geneSequence);

//        NSLog(@"direction ,%@",direction);
//        NSLog(@"the tested point %@",[NSValue valueWithCGPoint:position]);
        if (!(position.x = 580 && position.y ==20)) {
       
        if ([direction  isEqual: @"00"]) {
//            NSLog(@"00");
            positionMiddle = position;
            hit = positionMiddle;
            positionMiddle.y -= 35;
            hit.y -= 17;
            if (![self hitWall:hit] ) {
                position = positionMiddle;
//                 NSLog(@"hitwall? is %i", [self hitWall:hit]);
//                NSLog(@"distancpoint is %@", [NSValue valueWithCGPoint:hit]);
            }
            
        }else if ([direction  isEqual: @"01"])
        {
//            NSLog(@"01");
            positionMiddle = position;
            hit = positionMiddle;
            positionMiddle.x -= 35;
            hit.x -= 17;
            if (![self hitWall:hit]) {
                position = positionMiddle;
//                 NSLog(@"hitwall? is %i", [self hitWall:hit]);
//                NSLog(@"distancpoint is %@", [NSValue valueWithCGPoint:hit]);
            }
        }else if (([direction  isEqual: @"10"]))
        {
//            NSLog(@"10");
            positionMiddle = position;
            hit = positionMiddle;
            positionMiddle.x += 35;
            
            hit.x += 17;
            if (![self hitWall:hit]) {
                position = positionMiddle;
                
//                NSLog(@"distancpoint is %@", [NSValue valueWithCGPoint:hit]);

            }
            
        }else if (([direction  isEqual: @"11"]))
        {
//            NSLog(@"11");
            positionMiddle = position;
            hit = positionMiddle;
            positionMiddle.y += 35;
            hit.y += 17;
            
            if (![self hitWall:hit]) {
                position = positionMiddle;
//                 NSLog(@"hitwall? is %i", [self hitWall:hit]);
//                NSLog(@"distancpoint is %@", [NSValue valueWithCGPoint:hit]);

            }
        }
        }else
        {
            ;
        }
//        NSLog(@"the hit point %@",[NSValue valueWithCGPoint:hit]);
//        NSLog(@"hitwall %hhd",[self hitWall:hit]);
//        NSLog(@"the result point %@",[NSValue valueWithCGPoint:position]);

//        switch (direction) {
//            case "00":
//                positionMiddle = position;
//                hit = positionMiddle;
//                positionMiddle.y -= 35;
//                hit.y -= 17;
//                if (![self hitWall:hit]) {
//                    position = positionMiddle;
//                }
//                
//                break;
//            case "01":
//                positionMiddle = position;
//                hit = positionMiddle;
//                positionMiddle.x -= 35;
//                hit.x -= 17;
//                if (![self hitWall:hit]) {
//                    position = positionMiddle;
//                }
//                break;
//            case "10":
//                positionMiddle = position;
//                positionMiddle.x += 35;
//                hit = positionMiddle;
//                hit.x += 17;
//                if (![self hitWall:hit]) {
//                    position = positionMiddle;
//                }
//                break;
//            case "11":
//                positionMiddle = position;
//                hit = positionMiddle;
//                positionMiddle.y += 35;
//                hit.y += 17;
//                
//                if (![self hitWall:hit]) {
//                    position = positionMiddle;
//                }
//                break;
//            default:
//                break;
//        }
//        NSLog(@"hit position,%@",NSStringFromCGPoint(hit));
//        NSLog(@"sectionposition,%@",NSStringFromCGPoint(position));
    }
    
//    NSLog(@"finalposition,%@",NSStringFromCGPoint(self.finalPosition));
    return position;
}


@end
