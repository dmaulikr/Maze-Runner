//
//  showingResultViewController.h
//  theMazeRunner
//
//  Created by Jibei Zhao on 2015-06-16.
//  Copyright (c) 2015 Jibei Zhao. All rights reserved.
//

#import "ViewController.h"
#import "routeResult.h"

@interface showingResultViewController : ViewController
@property (weak, nonatomic) IBOutlet UILabel *showResultLabel;
@property (weak, nonatomic) IBOutlet routeResult *showRouteImage;


@end
