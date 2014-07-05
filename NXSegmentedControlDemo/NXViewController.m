//
//  NXViewController.m
//  NXSegmentedControlDemo
//
//  Created by iNuoXia on 14-7-1.
//  Copyright (c) 2014年 NuoXia. All rights reserved.
//

#import "NXViewController.h"
#import "NXSegmentedControl.h"

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

@interface NXViewController ()

@end

@implementation NXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSArray *segments = [NSArray arrayWithObjects:@"店铺动态", @"达人导购", nil];
    UISegmentedControl *sc = [[UISegmentedControl alloc]initWithItems:segments];
    sc.frame = CGRectMake(20.f, 20.f, 280.f, 32.f);
    sc.tintColor = RGB(0x5f, 0x64, 0x6e);
    sc.selectedSegmentIndex = 0;
    [sc addTarget:self action:@selector(segmentSelected:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:sc];
    
    NXSegmentedControl *nxsc = [[NXSegmentedControl alloc]initWithItems:segments selectedSgementIndex:^(NSUInteger index) {
      NSLog(@"segment at %i did selected!", index);
    }];
    nxsc.frame = CGRectMake(20.f, 56.f, 280.f, 32.f);
    nxsc.selectedSegmentIndex = 0;
    nxsc.selectedSegmentColor = [UIColor blueColor];
    nxsc.unselectedSegmentColor = [UIColor brownColor];
    nxsc.selectedTextColor = [UIColor whiteColor];
    nxsc.unselectedTextColor = [UIColor whiteColor];
    nxsc.borderColor = [UIColor blackColor];
    nxsc.cornerRadius = 0.f;
    nxsc.borderWidth = 8.f;
    
    [nxsc insertSegmentTitle:@"3" atIndex:2];
    
    nxsc.fontSize = 12.f;
    
    [self.view addSubview:nxsc];
}

-(void)segmentSelected:(UISegmentedControl *)segment {
    NSLog(@"segment at %i did selected!", segment.selectedSegmentIndex);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
