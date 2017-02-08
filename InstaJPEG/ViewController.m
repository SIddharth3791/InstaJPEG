//
//  ViewController.m
//  InstaJEPG
//
//  Created by Siddharth Patel on 2/7/17.
//  Copyright © 2017 Siddharth Patel. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#define Access_Token @"5f9365e9f1054aa991726d731c65aa02"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>{
    
    NSMutableArray *arrayOfImages;
    
    NSString *nextURL;
    BOOL isDownloading;
    
    
    
}

@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return arrayOfImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor lightGrayColor];
    
    NSString *theImageUrl = [[[[arrayOfImages objectAtIndex:indexPath.row] objectForKey:@"images"] objectForKey:@"thumbnail"]objectForKey:@"url"];
    
    [cell drawImage:theImageUrl];
    
    return cell;
    
}


- (IBAction)searchImages:(id)sender {
    
    NSString *str = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent/?access_token=%@", self.searchField.text, Access_Token];
    
    [arrayOfImages removeAllObjects];
    
    [self performSelectorInBackground:@selector(downloadImages:) withObject:str];
    
}

-(void) downloadImages:(NSString *) theURL {
    
    isDownloading = YES;
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:theURL]];
    
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    [arrayOfImages addObjectsFromArray:[dataDictionary objectForKey:@"data"]];
    
    nextURL = [[dataDictionary objectForKey:@"pagination"] objectForKey:@"next_url"];
    
    [self.collectionView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    
    isDownloading = NO;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    isDownloading = NO;
    
    
    arrayOfImages = [[NSMutableArray alloc] init];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
        if(!isDownloading){
            [self downloadImages:nextURL];
        }
    }
}



@end











