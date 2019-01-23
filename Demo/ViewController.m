//
//  ViewController.m
//  Demo
//
//  Created by 党玉华 on 2019/1/23.
//  Copyright © 2019年 dangyuhua. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *string1 =@"http://tiantianyihuo.imwork.net/%3C#share%23%3Ename=%E5%8D%A2%E9%9B%AA%E7%9C%89%E9%82%80%E8%AF%B7%E6%82%A8%E5%9C%A8%E6%B5%8B%E8%AF%95%E9%83%A8%E8%90%BD0107%E5%BC%80%E5%BA%97@desc=%E5%8F%AF%E5%BF%AB%E9%80%9F%E5%BC%80%E5%BA%97,%20%E5%A2%9E%E5%8A%A0%E5%93%81%E7%89%8C%E5%AE%A3%E4%BC%A0%E5%8A%9B%E5%BA%A6%E4%BB%A5%E5%8F%8A%E5%95%86%E5%93%81%E5%B1%95%E7%A4%BA@link=http://tiantianyihuo.imwork.net/index.php/_BUSINESS/Navigation/technological/2933/557/41844@img=tribe_api/tribe/201901/154683212258.png";
    string1 = [QuickTools NSStringTranscodingWithText:string1];
    DLog(@"%@",string1);
}


@end
