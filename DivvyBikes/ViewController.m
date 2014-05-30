//
//  ViewController.m
//  DivvyBikes
//
//  Created by Thomas Orten on 5/30/14.
//  Copyright (c) 2014 Orten, Thomas. All rights reserved.
//

#import "ViewController.h"
#import "MapViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *locationsTableView;
@property NSArray *stationsArray;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSURL *url = [NSURL URLWithString:@"http://www.divvybikes.com/stations/json/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
        self.stationsArray = [[NSArray alloc] initWithArray: [json objectForKey:@"stationBeanList"]];
        [self.locationsTableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.stationsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationCellID"];
    NSDictionary *station = [self.stationsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [station objectForKey:@"stationName"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Available: %@  Total: %@", [station objectForKey:@"availableDocks"], [station objectForKey:@"totalDocks"]];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MapViewController *destinationController = segue.destinationViewController;
    NSIndexPath *selectedRow = [self.locationsTableView indexPathForSelectedRow];
    destinationController.selectedStation = [self.stationsArray objectAtIndex:selectedRow.row];
}

@end
