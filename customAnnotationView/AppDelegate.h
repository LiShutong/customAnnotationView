//
//  AppDelegate.h
//  customAnnotationView
//
//  Created by Li,Shutong(MP) on 2017/5/25.
//  Copyright © 2017年 Li,Shutong(MP). All rights reserved.
//

#import <UIKit/UIKit.h>

#import <BaiduMapAPI_Base/BMKBaseComponent.h>

@interface AppDelegate : NSObject <UIApplicationDelegate, BMKGeneralDelegate> {
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

