//
//  ShopCartViewController.m
//  HaiTao
//
//  Created by gtcc on 11/17/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "ShopCartViewController.h"
#import "ShopCartTableViewCell.h"
@interface ShopCartViewController () <UITableViewDataSource,UITableViewDelegate>

@end
@implementation ShopCartViewController
@synthesize cartItems =_cartItems;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"购物车";
}

-(NSArray*)cartItems
{
    if(!_cartItems)
    {
        _cartItems = [[NSArray alloc] initWithObjects:
                      [[NSArray alloc] initWithObjects:@"Happy Bob", [[NSArray alloc] initWithObjects:@"2014款xxxxx",@"2013款xxxxx",nil],nil],
                      [[NSArray alloc] initWithObjects:@"Sandy", [[NSArray alloc] initWithObjects:@"2015款xxxxx",nil],nil],
                      nil];
    }
    
    return _cartItems;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.cartItems count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cartItems[section][1] count];
}

-(ShopCartTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * tableIdentifier=@"shopcartcell";
    ShopCartTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if(cell==nil)
    {
        // first load
        cell=[[ShopCartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    NSString* item = self.cartItems[indexPath.section][1] [indexPath.row];
    cell.lblGoodsName.text = item;
    NSString* url = [NSString stringWithFormat:@"http://localhost/pic/test%d.png",(int)indexPath.row];
    NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    cell.imageGoods.image = [UIImage imageWithData:data];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 48.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 32.0;
}


#pragma table delegate
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v_headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 48)];//创建一个视图（v_headerView）
    UIImageView *v_headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];//创建一个UIimageView（v_headerImageView）
    NSString* imageName = [NSString stringWithFormat:@"fans%d.png",(int)section];
    v_headerImageView.image = [UIImage imageNamed:imageName];//给v_headerImageView设置图片
    [v_headerView addSubview:v_headerImageView];//将v_headerImageView添加到创建的视图（v_headerView）中
    UILabel *v_headerLab = [[UILabel alloc] initWithFrame:CGRectMake(71, 8, 100, 21)];//创建一个UILable（v_headerLab）用来显示标题
    v_headerLab.backgroundColor = [UIColor clearColor];//设置v_headerLab的背景颜色
    v_headerLab.textColor = [UIColor grayColor];//设置v_headerLab的字体颜色
    v_headerLab.font = [UIFont fontWithName:@"Arial" size:13];//设置v_headerLab的字体样式和大小
    v_headerLab.shadowColor = [UIColor whiteColor];//设置v_headerLab的字体的投影
    [v_headerLab setShadowOffset:CGSizeMake(0, 1)];//设置v_headerLab的字体投影的位置
    //设置每组的的标题
    
    v_headerLab.text = self.cartItems[section][0];
    
    [v_headerView addSubview:v_headerLab];//将标题v_headerLab添加到创建的视图（v_headerView）中
    return v_headerView;//将视图（v_headerView）返回
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v_footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 32)];
    
    UILabel *v_lblFotter = [[UILabel alloc] initWithFrame:CGRectMake(71, 8, 100, 21)];//创建一个UILable（v_headerLab）用来显示标题
    v_lblFotter.backgroundColor = [UIColor clearColor];//设置v_headerLab的背景颜色
    v_lblFotter.textColor = [UIColor grayColor];//设置v_headerLab的字体颜色
    v_lblFotter.font = [UIFont fontWithName:@"Arial" size:13];//设置v_headerLab的字体样式和大小
    v_lblFotter.shadowColor = [UIColor whiteColor];//设置v_headerLab的字体的投影
    [v_lblFotter setShadowOffset:CGSizeMake(0, 1)];//设置v_headerLab的字体投影的位置
    //设置每组的的标题
    
    v_lblFotter.text = @"已选择1件商品";
    [v_footerView addSubview:v_lblFotter];
    
    
    UILabel *v_lblTotal = [[UILabel alloc] initWithFrame:CGRectMake(220, 8, 100, 21)];//创建一个UILable（v_headerLab）用来显示标题
    v_lblTotal.backgroundColor = [UIColor clearColor];//设置v_headerLab的背景颜色
    v_lblTotal.textColor = [UIColor grayColor];//设置v_headerLab的字体颜色
    v_lblTotal.font = [UIFont fontWithName:@"Arial" size:13];//设置v_headerLab的字体样式和大小
    v_lblTotal.shadowColor = [UIColor whiteColor];//设置v_headerLab的字体的投影
    [v_lblTotal setShadowOffset:CGSizeMake(0, 1)];//设置v_headerLab的字体投影的位置
    //设置每组的的标题
    
    v_lblTotal.text = @"总计: 980";
    [v_footerView addSubview:v_lblTotal];
    
    return v_footerView;//将视图（v_headerView）返回
    
}
@end
