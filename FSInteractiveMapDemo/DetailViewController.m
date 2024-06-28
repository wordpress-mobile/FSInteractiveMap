//
//  DetailViewController.m
//  FSInteractiveMap
//
//  Created by Arthur GUIBERT on 28/12/2014.
//  Copyright (c) 2014 Arthur GUIBERT. All rights reserved.
//

#import "DetailViewController.h"
#import "FSInteractiveMapView.h"

@interface DetailViewController ()

@property (nonatomic, weak) CAShapeLayer* oldClickedLayer;
@property (nonatomic, strong) FSInteractiveMapView *map;
@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, strong) NSArray *colors;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.title = self.detailItem;
        self.detailDescriptionLabel.text = @"";
    }

    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = [UIColor systemBackgroundColor];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    if([self.detailItem isEqualToString:@"Example 1"]) {
        [self initExample1];
    } else if([self.detailItem isEqualToString:@"Example 2"]) {
        [self initExample2];
    } else if([self.detailItem isEqualToString:@"Example 3"]) {
        [self initExample3];
    } else if([self.detailItem isEqualToString:@"Example 4"]) {
        [self initExample4];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Examples

- (void)initExample1
{
    _data = @{ @"asia" : @12,
               @"australia" : @2,
               @"north_america" : @5,
               @"south_america" : @14,
               @"africa" : @5,
               @"europe" : @20 };
    
    _map = [[FSInteractiveMapView alloc] initWithFrame:CGRectMake(16, 96, self.view.frame.size.width - 32, self.view.frame.size.height)];
    
    [_map loadMap:@"world-continents-low" withData:_data colorAxis:@[[UIColor lightGrayColor], [UIColor darkGrayColor]]];
    
    __weak typeof(self) weakSelf = self;
    [_map setClickHandler:^(NSString* identifier, CAShapeLayer* layer) {
        weakSelf.detailDescriptionLabel.text = [NSString stringWithFormat:@"Continent clicked: %@", identifier];
    }];
    
    [self.view addSubview:_map];
}

- (void)initExample2
{
    _data = @{ @"fr" : @12,
               @"it" : @2,
               @"de" : @9,
               @"pl" : @24,
               @"uk" : @17 };
    _colors = @[[UIColor blueColor], [UIColor greenColor], [UIColor yellowColor], [UIColor redColor]];
    
    _map = [[FSInteractiveMapView alloc] initWithFrame:CGRectMake(-1, 64, self.view.frame.size.width + 2, 500)];
    [self example2BasicColors];
    [_map loadMap:@"europe" withData:_data colorAxis:_colors];
    
    [self.view addSubview:_map];
}

- (void)initExample3
{
    _map = [[FSInteractiveMapView alloc] initWithFrame:CGRectMake(16, 96, self.view.frame.size.width - 32, 500)];
    [_map loadMap:@"usa-low" withColors:nil];
    
    __weak typeof(self) weakSelf = self;
    [_map setClickHandler:^(NSString* identifier, CAShapeLayer* layer) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if(strongSelf.oldClickedLayer) {
            strongSelf.oldClickedLayer.zPosition = 0;
            strongSelf.oldClickedLayer.shadowOpacity = 0;
        }
        
        strongSelf.oldClickedLayer = layer;
        
        // We set a simple effect on the layer clicked to highlight it
        layer.zPosition = 10;
        layer.shadowOpacity = 0.5;
        layer.shadowColor = [UIColor blackColor].CGColor;
        layer.shadowRadius = 5;
        layer.shadowOffset = CGSizeMake(0, 0);
    }];
    
    [self.view addSubview:_map];
}
    
- (void)initExample4
{
    _data = @{ @"fr" : @12 };
    
    _map = [[FSInteractiveMapView alloc] initWithFrame:CGRectMake(-1, 64, self.view.frame.size.width + 2, 500)];
    [_map loadMap:@"europe" withData:_data colorAxis:@[[UIColor blueColor], [UIColor greenColor], [UIColor yellowColor], [UIColor redColor]]];
    
    [self.view addSubview:_map];
}

- (void)example2BasicColors
{
    if (@available(iOS 13.0, *)) {
        self.map.fillColor = [UIColor systemGray5Color];
        self.map.strokeColor = [UIColor systemBackgroundColor];
        self.map.backgroundColor = self.map.strokeColor;
    }
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    [super traitCollectionDidChange:previousTraitCollection];

    if([self.detailItem isEqualToString:@"Example 2"]) {
        if (@available(iOS 13.0, *)) {
            [self example2BasicColors];
            [_map setData:_data colorAxis:_colors];
        }
    }
}

@end
