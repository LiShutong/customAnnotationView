//
//  AnnotationDemoViewController.m
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//
#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]
#import "AnnotationDemoViewController.h"
#import "CustomAnnotationView.h"

#define kCalloutViewMargin          -8

@interface AnnotationDemoViewController ()
{
    BMKCircle* circle;
    BMKPolygon* polygon;
    BMKPolygon* polygon2;
    BMKPolyline* polyline;
    BMKPolyline* colorfulPolyline;
    BMKArcline* arcline;
    BMKGroundOverlay* ground2;
    BMKPointAnnotation* pointAnnotation;
    BMKPointAnnotation* animatedAnnotation;
}
@end

@implementation AnnotationDemoViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (void)viewDidLoad {
    [super viewDidLoad];
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
//        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
    //设置地图缩放级别
    [_mapView setZoomLevel:11];
    //初始化segment
    segment.selectedSegmentIndex=0;    
    //添加内置覆盖物
    [self addOverlayView];

}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}
//segment进行切换
- (IBAction)segmentChanged:(UISegmentedControl *)sender {
    UISegmentedControl *tempSeg = (UISegmentedControl *)sender;
    //内置覆盖物
    if(tempSeg.selectedSegmentIndex == 0) {
        [_mapView removeOverlays:_mapView.overlays];
        [_mapView removeAnnotations:_mapView.annotations];
        //添加内置覆盖物
        [self addOverlayView];
        [self addAnimatedAnnotation];
        return;
    }
    //添加标注
    else if(tempSeg.selectedSegmentIndex == 1) {
        [_mapView removeOverlays:_mapView.overlays];
        [self addPointAnnotation];
        [self addAnimatedAnnotation];
        return;
    }
    //添加图片图层
    else if(tempSeg.selectedSegmentIndex == 2) {
        [_mapView removeOverlays:_mapView.overlays];
        [_mapView removeAnnotations:_mapView.annotations];
        [self addGroundOverlay];
    }
}

- (void)addGroundOverlay {
    //添加图片图层覆盖物
    if (ground2 == nil) {
        CLLocationCoordinate2D coords[2] = {0};
        coords[0].latitude = 39.910;
        coords[0].longitude = 116.370;
        coords[1].latitude = 39.950;
        coords[1].longitude = 116.430;
        
        BMKCoordinateBounds bound;
        bound.southWest = coords[0];
        bound.northEast = coords[1];
        ground2 = [BMKGroundOverlay groundOverlayWithBounds:bound icon:[UIImage imageNamed:@"test.png"]];
        ground2.alpha = 0.8;
    }
//    [_mapView addOverlay:ground2];
//    _mapView.zoomLevel = 14;
//    _mapView.centerCoordinate = CLLocationCoordinate2DMake(39.9255, 116.3995);
}

//添加内置覆盖物
- (void)addOverlayView {
    // 添加圆形覆盖物
    if (circle == nil) {
        CLLocationCoordinate2D coor;
        coor.latitude = 39.915;
        coor.longitude = 116.404;
        circle = [BMKCircle circleWithCenterCoordinate:coor radius:5000];
    }
//    [_mapView addOverlay:circle];

    // 添加多边形覆盖物
    if (polygon == nil) {
        CLLocationCoordinate2D coords[4] = {0};
        coords[0].latitude = 39.915;
        coords[0].longitude = 116.404;
        coords[1].latitude = 39.815;
        coords[1].longitude = 116.404;
        coords[2].latitude = 39.815;
        coords[2].longitude = 116.504;
        coords[3].latitude = 39.915;
        coords[3].longitude = 116.504;
        polygon = [BMKPolygon polygonWithCoordinates:coords count:4];
    }
//    [_mapView addOverlay:polygon];

    // 添加多边形覆盖物
    if (polygon2 == nil) {
        CLLocationCoordinate2D coords[5] = {0};
        coords[0].latitude = 39.965;
        coords[0].longitude = 116.604;
        coords[1].latitude = 39.865;
        coords[1].longitude = 116.604;
        coords[2].latitude = 39.865;
        coords[2].longitude = 116.704;
        coords[3].latitude = 39.905;
        coords[3].longitude = 116.654;
        coords[4].latitude = 39.965;
        coords[4].longitude = 116.704;
        polygon2 = [BMKPolygon polygonWithCoordinates:coords count:5];
    }
    [_mapView addOverlay:polygon2];

    //添加折线覆盖物
    if (polyline == nil) {
        CLLocationCoordinate2D coors[2] = {0};
        coors[1].latitude = 39.895;
        coors[1].longitude = 116.354;
        coors[0].latitude = 39.815;
        coors[0].longitude = 116.304;
        polyline = [BMKPolyline polylineWithCoordinates:coors count:2];
    }
//    [_mapView addOverlay:polyline];
    
    //添加折线(分段颜色绘制)覆盖物
    if (colorfulPolyline == nil) {
        CLLocationCoordinate2D coords[5] = {0};
        coords[0].latitude = 39.965;
        coords[0].longitude = 116.404;
        coords[1].latitude = 39.925;
        coords[1].longitude = 116.454;
        coords[2].latitude = 39.955;
        coords[2].longitude = 116.494;
        coords[3].latitude = 39.905;
        coords[3].longitude = 116.554;
        coords[4].latitude = 39.965;
        coords[4].longitude = 116.604;
        //构建分段颜色索引数组
        NSArray *colorIndexs = [NSArray arrayWithObjects:
                                [NSNumber numberWithInt:2],
                                [NSNumber numberWithInt:0],
                                [NSNumber numberWithInt:1],
                                [NSNumber numberWithInt:2], nil];
        
        //构建BMKPolyline,使用分段颜色索引，其对应的BMKPolylineView必须设置colors属性
        colorfulPolyline = [BMKPolyline polylineWithCoordinates:coords count:5 textureIndex:colorIndexs];
    }
//    [_mapView addOverlay:colorfulPolyline];
    
    // 添加圆弧覆盖物
    if (arcline == nil) {
        CLLocationCoordinate2D coords[3] = {0};
        coords[0].latitude = 40.065;
        coords[0].longitude = 116.124;
        coords[1].latitude = 40.125;
        coords[1].longitude = 116.304;
        coords[2].latitude = 40.065;
        coords[2].longitude = 116.404;
        arcline = [BMKArcline arclineWithCoordinates:coords];
    }
//    [_mapView addOverlay:arcline];

}

//添加标注
- (void)addPointAnnotation
{
    if (pointAnnotation == nil) {
        pointAnnotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = 39.915;
        coor.longitude = 116.404;
        pointAnnotation.coordinate = coor;
        pointAnnotation.title = @"天安门";
        pointAnnotation.subtitle = @"东长安街";
    }
    [_mapView addAnnotation:pointAnnotation];
}

// 添加动画Annotation
- (void)addAnimatedAnnotation {
    if (animatedAnnotation == nil) {
        animatedAnnotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = 40.115;
        coor.longitude = 116.404;
        animatedAnnotation.coordinate = coor;
        animatedAnnotation.title = @"我是title";
        animatedAnnotation.subtitle = @"我是subtitle!";
    }
    [_mapView addAnnotation:animatedAnnotation];
}


#pragma mark -
#pragma mark implement BMKMapViewDelegate

//根据overlay生成对应的View
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
	if ([overlay isKindOfClass:[BMKCircle class]])
    {
        BMKCircleView* circleView = [[BMKCircleView alloc] initWithOverlay:overlay];
        circleView.fillColor = [[UIColor alloc] initWithRed:1 green:0 blue:0 alpha:0.5];
        circleView.strokeColor = [[UIColor alloc] initWithRed:0 green:0 blue:1 alpha:0.5];
        circleView.lineWidth = 5.0;

		return circleView;
    }
    
    if ([overlay isKindOfClass:[BMKPolyline class]])
    {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        if (overlay == colorfulPolyline) {
            polylineView.lineWidth = 5;
            /// 使用分段颜色绘制时，必须设置（内容必须为UIColor）
            polylineView.colors = [NSArray arrayWithObjects:
                                   [[UIColor alloc] initWithRed:0 green:1 blue:0 alpha:1],
                                   [[UIColor alloc] initWithRed:1 green:0 blue:0 alpha:1],
                                   [[UIColor alloc] initWithRed:1 green:1 blue:0 alpha:0.5], nil];
        } else {
            polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:1];
            polylineView.lineWidth = 20.0;
            [polylineView loadStrokeTextureImage:[UIImage imageNamed:@"texture_arrow.png"]];
        }
		return polylineView;
    }
	
	if ([overlay isKindOfClass:[BMKPolygon class]])
    {
        BMKPolygonView* polygonView = [[BMKPolygonView alloc] initWithOverlay:overlay];
        polygonView.strokeColor = [[UIColor alloc] initWithRed:0.0 green:0 blue:0.5 alpha:1];
        polygonView.fillColor = [[UIColor alloc] initWithRed:0 green:1 blue:1 alpha:0.2];
        polygonView.lineWidth = YES;
        polygonView.lineDash = (overlay == polygon2);
		return polygonView;
    }
    if ([overlay isKindOfClass:[BMKGroundOverlay class]])
    {
        BMKGroundOverlayView* groundView = [[BMKGroundOverlayView alloc] initWithOverlay:overlay];
		return groundView;
    }
    if ([overlay isKindOfClass:[BMKArcline class]]) {
        BMKArclineView *arclineView = [[BMKArclineView alloc] initWithArcline:overlay];
        arclineView.strokeColor = [UIColor blueColor];
        arclineView.lineDash = YES;
        arclineView.lineWidth = 6.0;
        return arclineView;
    }
	return nil;
}

//
//// 根据anntation生成对应的View
//- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
//{
//    //普通annotation
//    if (annotation == pointAnnotation) {
//        NSString *AnnotationViewID = @"renameMark";
//        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
//        if (annotationView == nil) {
//            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
//            // 设置颜色
//            annotationView.pinColor = BMKPinAnnotationColorPurple;
//            // 从天上掉下效果
//            annotationView.animatesDrop = YES;
//            // 设置可拖拽
//            annotationView.draggable = YES;
//        }
//        return annotationView;
//    }
//    
//    //动画annotation
//    NSString *AnnotationViewID = @"AnimatedAnnotation";
//    MyAnimatedAnnotationView *annotationView = nil;
//    if (annotationView == nil) {
//        annotationView = [[MyAnimatedAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
//    }
//    NSMutableArray *images = [NSMutableArray array];
//    for (int i = 1; i < 4; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"poi_%d.png", i]];
//        [images addObject:image];
//    }
//    annotationView.image = images[0];
//    return annotationView;
//    
//}
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:reuseIndetifier];
            annotationView.canShowCallout = NO;
        }
        
        annotationView.portrait = [UIImage imageNamed:@"poi_3.png"];
        annotationView.name = @"annotationView";
        return annotationView;
    }
    return nil;
}
//    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
//        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
//        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView   dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
//        if (annotationView == nil) {
//            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
//        }
//        annotationView.image = [UIImage imageNamed:@"poi_1.png"];
//        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
//        annotationView.centerOffset = CGPointMake(0, -18);
//        annotationView.pinColor = BMKPinAnnotationColorPurple;
//        annotationView.canShowCallout= YES;      //设置气泡可以弹出，默认为NO
//        annotationView.animatesDrop=YES;         //设置标注动画显示，默认为NO
//        annotationView.draggable = YES;          //设置标注可以拖动，默认为NO
//        return annotationView;
//    }
//    return nil;
//}


- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
    /* Adjust the map center in order to show the callout view completely. */
    if ([view isKindOfClass:[CustomAnnotationView class]]) {
        CustomAnnotationView *cusView = (CustomAnnotationView *)view;
        CGRect frame = [cusView convertRect:cusView.paopaoView.frame toView:_mapView];
        
        frame = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(kCalloutViewMargin, kCalloutViewMargin, kCalloutViewMargin, kCalloutViewMargin));
        
        if (!CGRectContainsRect(_mapView.frame, frame))
        {
            /* Calculate the offset to make the callout view show up. */
            CGSize offset = [self offsetToContainRect:frame inRect:_mapView.frame];
            
            CGPoint theCenter = _mapView.center;
            theCenter = CGPointMake(theCenter.x - offset.width, theCenter.y - offset.height);
            
            CLLocationCoordinate2D coordinate = [_mapView convertPoint:theCenter toCoordinateFromView:_mapView];
            
            [_mapView setCenterCoordinate:coordinate animated:YES];
        }
        
    }
}
- (CGSize)offsetToContainRect:(CGRect)innerRect inRect:(CGRect)outerRect
{
    CGFloat nudgeRight = fmaxf(0, CGRectGetMinX(outerRect) - (CGRectGetMinX(innerRect)));
    CGFloat nudgeLeft = fminf(0, CGRectGetMaxX(outerRect) - (CGRectGetMaxX(innerRect)));
    CGFloat nudgeTop = fmaxf(0, CGRectGetMinY(outerRect) - (CGRectGetMinY(innerRect)));
    CGFloat nudgeBottom = fminf(0, CGRectGetMaxY(outerRect) - (CGRectGetMaxY(innerRect)));
    return CGSizeMake(nudgeLeft ?: nudgeRight, nudgeTop ?: nudgeBottom);
}

// 当点击annotation view弹出的泡泡时，调用此接口
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view;
{
    NSLog(@"paopaoclick");
}

- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi *)mapPoi {
    NSLog(@"clickPoi");
}
//- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
//    NSLog(@"clickMapBlank");
//}

- (void) mapView:(BMKMapView *)mapView onClickedBMKOverlayView:(BMKOverlayView *)overlayView {
    NSLog(@"click overlay");
}
@end
