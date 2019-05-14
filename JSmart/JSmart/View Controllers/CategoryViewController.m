//
//  CategoryViewController.m
//  JSmart
//
//  Created by whcl on 29/06/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()

@property NSMutableArray* categories;

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CellCategory" bundle:nil] forCellWithReuseIdentifier:@"CellCategory"];
    [self getCategory];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma Delegates

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.categories count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {    
    CellCategoryCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellCategory" forIndexPath:indexPath];
    id category = [self.categories objectAtIndex:[indexPath row]];
    cell.containerName.text = [category objectForKey:@"nama_kategori"];
    [cell.containerIcon sd_setImageWithURL:[category objectForKey:@"icon_kategori"]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = self.collectionView.frame.size.width / 300 * 93;
    CGFloat height = width + 30;
    return CGSizeMake(width, height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    id category = [self.categories objectAtIndex:[indexPath row]];
    [self lapor:category];
}

#pragma Connection

- (void)getCategory {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
        [self displayCategory:responseObject];
    };
    void (^failure)(NSURLSessionTask *operation, NSError *error) = ^void(NSURLSessionTask *operation, NSError *error) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [Helpers alertFailure:[error localizedDescription] viewController:self];
    };
    NSString* email = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    NSString* token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [Connection getCategory:email token:token success:success failure:failure];
}

#pragma

- (void)displayCategory:(id)responseObject {
    self.categories = [[responseObject objectForKey:@"data"] objectForKey:@"kategori"];
    [self.collectionView reloadData];
}

#pragma Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString* identifier = [segue identifier];
    if ([identifier isEqualToString:@"Lapor"]) {
        LaporViewController* vc = [segue destinationViewController];
        vc.category = [sender objectForKey:@"category"];
    }
}

- (void)lapor:(id)category {
    [self performSegueWithIdentifier:@"Lapor" sender:@{@"category" : category}];
}

#pragma IBActions

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
