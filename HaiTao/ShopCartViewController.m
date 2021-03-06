//
//  ShopCartViewController.m
//  HaiTao
//
//  Created by gtcc on 11/17/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "ShopCartViewController.h"
#import "ShopCartTableViewCell.h"
#import "DataLayer.h"
#import "Utility.h"
#import "SBJson/SBJson.h"
#import "PAImageView/PAImageView.h"
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
//        _cartItems = [[NSArray alloc] initWithObjects:
//                      [[NSArray alloc] initWithObjects:@"Happy Bob", [[NSArray alloc] initWithObjects:
//                                                                      [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"2014款xxxxx",@"name",
//                                                                          @"NO",@"checked",
//                                                                          @"550",@"price",
//                                                                          @"1", @"amount",
//                                                                          @"test0.png",@"pic",nil],
//                                                                      [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"2013款xxxxxy",@"name",
//                                                                       @"NO",@"checked",
//                                                                       @"430",@"price",
//                                                                       @"1", @"amount",
//                                                                       @"test1.png",@"pic",nil],nil],nil],
//                      [[NSArray alloc] initWithObjects:@"Sandy", [[NSArray alloc] initWithObjects:
//                                                                  [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"2014款xxxxx",@"name",
//                                                                   @"NO",@"checked",
//                                                                   @"430",@"price",
//                                                                   @"1", @"amount",
//                                                                   @"test3.png",@"pic",nil],nil],nil],
//                      nil];
        
        _cartItems = [[NSMutableArray alloc] init];
        
        NSMutableDictionary* result = [DataLayer GetMyCartList];
        NSString* returnCode = result[@"s"];
        if([returnCode isEqualToString:SUCCESS])
        {
            if(result[@"m"])
            {
                NSString* subItemsString = [NSString stringWithFormat:@"[%@]", result[@"m"][@"sub"]];
                //NSString* searchString = @"[{\"gn\":\"Chanel\",\"id\":8,\"p\":35000,\"gid\":3},{\"gn\":\"LV\",\"id\":9,\"p\":998,\"gid\":4}]";
                
                NSArray* subItems = [subItemsString JSONValue];
                
                NSMutableArray* seller = [[NSMutableArray alloc] initWithObjects:result[@"m"][@"s"],nil];
                NSMutableArray* goods = [[NSMutableArray alloc] init];
                for (NSDictionary* item in subItems) {
                    [goods addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:item[@"gn"],@"name", @"NO",@"checked",
                                     [NSString stringWithFormat:@"%d", [item[@"p"] intValue]],@"price",
                                     @"1", @"amount",
                                      [NSString stringWithFormat:@"%d", [item[@"id"] intValue]], @"id",     // 关联id, 删除靠它
                                     [NSString stringWithFormat:@"%d", [item[@"gid"] intValue]], @"gid", nil]];
                }
                [seller addObject:goods];
                [_cartItems addObject:seller];
            }
        }else
        {
            [Utility showErrorMessage:returnCode];
        }
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

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * tableIdentifier=@"shopcartcell";
    ShopCartTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if(cell==nil)
    {
        // first load
        cell=[[ShopCartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    [cell creat];
    NSString* item = self.cartItems[indexPath.section][1] [indexPath.row][@"name"];
    cell.lblGoodsName.text = item;
    cell.lblPrice.text = self.cartItems[indexPath.section][1] [indexPath.row][@"price"];
    
//    NSMutableDictionary* result =  [DataLayer GetGoodsInfo: self.cartItems[indexPath.section][1] [indexPath.row][@"gid"]];
//    if([result[@"s"] isEqualToString:SUCCESS])
//    {
//        CGFloat imageSize = 75.f;
//        PAImageView *avaterImageView = [[PAImageView alloc]initWithFrame:CGRectMake(20, 83, imageSize, imageSize) backgroundProgressColor:[UIColor whiteColor] progressColor:[UIColor lightGrayColor]];
//        [cell.imageGoods addSubview:avaterImageView];
//        
//        NSString* imageURL = [Utility getImageURL:result[@"m"][@"fpic"]];
//        [avaterImageView setImageURL:imageURL];
//    }
    
    NSMutableDictionary* dic = self.cartItems[indexPath.section][1][indexPath.row];
    if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
        [dic setObject:@"NO" forKey:@"checked"];
        [cell setChecked:NO];
        
    }else {
        [dic setObject:@"YES" forKey:@"checked"];
        [cell setChecked:YES];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ShopCartTableViewCell *cell = (ShopCartTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    NSMutableDictionary* dic = self.cartItems[indexPath.section][1][indexPath.row];
    if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
        [dic setObject:@"YES" forKey:@"checked"];
        [cell setChecked:YES];
    }else {
        [dic setObject:@"NO" forKey:@"checked"];
        [cell setChecked:NO];
    }
    
    [self updateUI];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 48.0;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 32.0;
//}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (editingStyle ==UITableViewCellEditingStyleDelete)
        {
            NSLog(@"%ld", (long)indexPath.row);
            
            // tell the server to delete the item
            NSMutableDictionary* result = [DataLayer RemoveGoodsfromCart:self.cartItems[indexPath.section][1] [indexPath.row][@"id"]];
            NSString* returnCode = result[@"s"];
            if([returnCode isEqualToString:SUCCESS])
            {
                [self.cartItems removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
            }else
            {
                [Utility showErrorMessage:returnCode];
            }
        }
}

#pragma table delegate
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v_headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 48)];//创建一个视图（v_headerView）
    UIImageView *v_headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 48, 48)];//创建一个UIimageView（v_headerImageView）
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

//-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *v_footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 32)];
//    
//    UILabel *v_lblFotter = [[UILabel alloc] initWithFrame:CGRectMake(71, 8, 100, 21)];//创建一个UILable（v_headerLab）用来显示标题
//    v_lblFotter.backgroundColor = [UIColor clearColor];//设置v_headerLab的背景颜色
//    v_lblFotter.textColor = [UIColor grayColor];//设置v_headerLab的字体颜色
//    v_lblFotter.font = [UIFont fontWithName:@"Arial" size:13];//设置v_headerLab的字体样式和大小
//    v_lblFotter.shadowColor = [UIColor whiteColor];//设置v_headerLab的字体的投影
//    [v_lblFotter setShadowOffset:CGSizeMake(0, 1)];//设置v_headerLab的字体投影的位置
//    //设置每组的的标题
//    
//
//    NSMutableArray* goods = self.cartItems[section][1];
//    int count = 0;
//    for (NSMutableDictionary* item in goods) {
//        if([item[@"checked"] isEqualToString:@"YES"])
//        {
//            count++;
//        }
//    }
//    
//    v_lblFotter.text = [NSString stringWithFormat:@"已选择%d件商品", count] ;
//                        
//    [v_footerView addSubview:v_lblFotter];
//    
//    
//    UILabel *v_lblTotal = [[UILabel alloc] initWithFrame:CGRectMake(220, 8, 100, 21)];//创建一个UILable（v_headerLab）用来显示标题
//    v_lblTotal.backgroundColor = [UIColor clearColor];//设置v_headerLab的背景颜色
//    v_lblTotal.textColor = [UIColor grayColor];//设置v_headerLab的字体颜色
//    v_lblTotal.font = [UIFont fontWithName:@"Arial" size:13];//设置v_headerLab的字体样式和大小
//    v_lblTotal.shadowColor = [UIColor whiteColor];//设置v_headerLab的字体的投影
//    [v_lblTotal setShadowOffset:CGSizeMake(0, 1)];//设置v_headerLab的字体投影的位置
//    //设置每组的的标题
//    
//     if(section == 0)
//         v_lblTotal.text = @"总计: 980";
//    else
//        v_lblTotal.text = @"总计: 430";
//    [v_footerView addSubview:v_lblTotal];
//    
//    return v_footerView;//将视图（v_headerView）返回
    
//}
- (IBAction)selectAll:(id)sender {
    NSArray *anArrayOfIndexPath = [NSArray arrayWithArray:[self.table indexPathsForVisibleRows]];
    for (int i = 0; i < [anArrayOfIndexPath count]; i++) {
        NSIndexPath *indexPath= [anArrayOfIndexPath objectAtIndex:i];
        ShopCartTableViewCell *cell = (ShopCartTableViewCell*)[self.table cellForRowAtIndexPath:indexPath];
        NSUInteger row = [indexPath row];
        NSLog(@"%lu",(unsigned long)row);
        NSMutableDictionary *dic = self.cartItems[indexPath.section][1][row];
        if ([[[(UIButton*)sender titleLabel] text] isEqualToString:@"全选"]) {
            [dic setObject:@"YES" forKey:@"checked"];
            [cell setChecked:YES];
        }else {
            [dic setObject:@"NO" forKey:@"checked"];
            [cell setChecked:NO];
        }
    }
    if ([[[(UIButton*)sender titleLabel] text] isEqualToString:@"全选"]){
        for (id sellers in self.cartItems) {
            for (NSDictionary *dic in sellers[1]) {
                [dic setValue:@"YES" forKey:@"checked"];
            }
        }
        
        [(UIButton*)sender setTitle:@"取消" forState:UIControlStateNormal];
    }else{
        
        for (id sellers in self.cartItems) {
            for (NSDictionary *dic in sellers[1]) {
                [dic setValue:@"NO" forKey:@"checked"];
            }
        }
      
        [(UIButton*)sender setTitle:@"全选" forState:UIControlStateNormal];
    }

    [self updateUI];
}

-(void)updateUI
{
    [self UpdateTotalMoney];
    [self updateJieSuan];
}

-(void)UpdateTotalMoney
{
    self.lblTotal.text = [NSString stringWithFormat:@"¥%.2f",[self calculateMoney]];
    self.lblGoodsMoney.text = [NSString stringWithFormat:@"%.2f 元",[self calculateMoney]];
}

-(double)calculateMoney
{
    double total = 0;
    for (NSArray* seller in self.cartItems) {
        for (NSDictionary* goods in seller[1]) {
            if([goods[@"checked"] isEqualToString:@"YES"])
            {
                total += [goods[@"price"] doubleValue] * [goods[@"amount"] intValue];
            }
        }
    }
    return total;
}

-(void)updateJieSuan
{
    [self.btnJieSuan setTitle:[NSString stringWithFormat:@"结算(%d)",[self seletedGoodsCount]] forState:UIControlStateNormal];
}

-(int)seletedGoodsCount
{
    int count = 0;
    for (NSArray* seller in self.cartItems) {
        for (NSDictionary* goods in seller[1]) {
            if([goods[@"checked"] isEqualToString:@"YES"])
            {
                count++;
            }
        }
    }
    return count;
}
@end
