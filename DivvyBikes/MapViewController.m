//
//  MapViewController.m
//  DivvyBikes
//
//  Created by Thomas Orten on 5/30/14.
//  Copyright (c) 2014 Orten, Thomas. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>

@interface MapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    double latitude = [[self.selectedStation objectForKey:@"latitude"] doubleValue];
    double longitude = [[self.selectedStation objectForKey:@"longitude"] doubleValue];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    
    MKPointAnnotation *station = [[MKPointAnnotation alloc] init];
    station.coordinate = coordinate;
    station.title = [self.selectedStation objectForKey:@"location"];
    station.subtitle = [NSString stringWithFormat:@"Available: %@  Total: %@", [self.selectedStation objectForKey:@"availableDocks"], [self.selectedStation objectForKey:@"totalDocks"]];
    
    [self.mapView addAnnotation:station];
    
    [self.mapView showAnnotations:self.mapView.annotations animated:YES];
}

@end
