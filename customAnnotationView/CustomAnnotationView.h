//
//  CustomAnnotationView.h
//  IphoneMapSdkDemo
//
//  Created by Li,Shutong(MP) on 2017/5/25.
//  Copyright © 2017年 Baidu. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "CustomPaopaotView.h"

@interface CustomAnnotationView : BMKAnnotationView 

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) UIImage *portrait;

@property (nonatomic, strong) UIView *calloutView;

//@property (nonatomic, readonly) CustomPaopaotView *paopaoView;

@end
