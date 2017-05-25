//
//  ViewController.m
//  customAnnotationView
//
//  Created by Li,Shutong(MP) on 2017/5/25.
//  Copyright © 2017年 Li,Shutong(MP). All rights reserved.
//

#import "ViewController.h"
#import "AnnotationDemoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BMKMapView *mapView = [[BMKMapView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:mapView];
    UIButton *pushButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 100, 50)];
    pushButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:pushButton];
    [pushButton addTarget:self action:@selector(pushView) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void) pushView {
    AnnotationDemoViewController *annotationDemo = [[AnnotationDemoViewController alloc] init];
    [self.navigationController pushViewController:annotationDemo animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
