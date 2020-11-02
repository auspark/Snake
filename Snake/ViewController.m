//
//  ViewController.m
//  Snake
//
//  Created by Jerry.Yang on 2020/11/2.
//  Copyright © 2020 Jerry.Yang. All rights reserved.
//

#import "ViewController.h"
#import "BackgroundView.h"
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.score.integerValue=0;
    [(BackgroundView *)self.view setScoreTextField:self.score];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}
- (IBAction)createFood:(id)sender {
    [(BackgroundView *)self.view newGame];
}


@end
