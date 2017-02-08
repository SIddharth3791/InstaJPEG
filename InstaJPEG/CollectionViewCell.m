//
//  CollectionViewCell.m
//  My Instagram App
//
//  Created by Vivian Aranha on 2/18/16.
//  Copyright © 2016 Vivian Aranha. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell () {
    UIImageView *imageView;
}

@end

@implementation CollectionViewCell


-(void) drawImage:(NSString *)theImage {
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    imageView.image = [UIImage imageNamed:@"default.jpg"];

    [self performSelectorInBackground:@selector(drawImageInBg:) withObject:theImage];

    [self addSubview:imageView];

}


-(void) drawImageInBg:(NSString *) img{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:img]];
    
    [self performSelectorOnMainThread:@selector(drawOnMain:) withObject:data waitUntilDone:YES];

}

-(void)drawOnMain:(NSData *) data {
    imageView.image = [UIImage imageWithData:data];
}



@end






