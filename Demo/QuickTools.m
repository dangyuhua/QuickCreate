//
//  QuickTools.m
//  Shopping
//
//  Created by 党玉华 on 2018/7/11.
//  Copyright © 2018年 党玉华. All rights reserved.
//

#import "QuickTools.h"
#import "FPSLabel.h"

@interface QuickTools()

@property (nonatomic, strong)NSTimer *timer;

@property (nonatomic, assign)NSInteger second;

@end

@implementation QuickTools

+(SDWebImageManager *)shareManager{
    static SDWebImageManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(& onceToken, ^{
        if (manager == nil) {
            manager = [SDWebImageManager sharedManager];
        }
    });
    return manager;
}
#pragma mark UIButton
+(UIButton *)UIButtonWithFrame:(CGRect )frame backgroundColor:(UIColor *)backgroundColor title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage font:(CGFloat)font textColor:(UIColor *)textColor selectTextColor:(UIColor *)selectTextColor edgeInsets:(UIEdgeInsets )edgeInsets tag:(NSInteger)tag target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = backgroundColor;
    button.frame = frame;
    if (title != nil) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:textColor forState:UIControlStateNormal];
        [button setTitleColor:selectTextColor forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:font];
        button.titleEdgeInsets = edgeInsets;
    }else{
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
        button.imageEdgeInsets = edgeInsets;
    }
    button.tag = tag;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark 导航栏返回按钮
+(UIBarButtonItem *)UIBarButtonItemNavBackBarButtonItemWithTarget:(id)target action:(SEL)action{
    UIButton *button = [self UIButtonWithFrame:CGRectMake(0, 0, 28, 32) backgroundColor:[UIColor clearColor] title:nil image:@"general_back" selectImage:nil font:0 textColor:[UIColor clearColor] selectTextColor:[UIColor clearColor] edgeInsets:Edge(0, 0, 0, 8) tag:0 target:target action:action];
    UIBarButtonItem *backBar = [[UIBarButtonItem alloc]initWithCustomView:button];
    return backBar;
}

#pragma mark 导航栏按钮
+(UIBarButtonItem *)UIBarButtonItemBarButtonWithTarget:(id)target action:(SEL)action frame:(CGRect )frame title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage font:(CGFloat)font textColor:(UIColor *)textColor edgeInsets:(UIEdgeInsets)edgeInsets{
    UIButton *button = [self UIButtonWithFrame:frame backgroundColor:[UIColor clearColor] title:title image:image selectImage:selectImage font:font textColor:textColor selectTextColor:textColor edgeInsets:Edge(0, 0, 0, 0) tag:0 target:target action:action];
    if (title != nil) {
        button.titleEdgeInsets = edgeInsets;
    }else{
        button.imageEdgeInsets = edgeInsets;
    }
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    return barButton;
}

#pragma mark 上拉下拉tableview
+(UITableView *)UITableViewMJRefreshWithBackgroundColor:(UIColor *)color frame:(CGRect )frame separatorStyle:(UITableViewCellSeparatorStyle )separatorStyle style:(UITableViewStyle)style contentInset:(UIEdgeInsets )contentInset indicator:(BOOL)indicator isRefresh:(BOOL)isRefresh footerIsNeedDrag:(BOOL)footerIsNeedDrag mjheadBlock:(void (^)(void))mjheadBlock mjfootBlock:(void (^)(void))mjfootBlock{
    UITableView *tableView = [[UITableView alloc]initWithFrame:frame style:style];
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    tableView.showsVerticalScrollIndicator = indicator;
    //非常重要关闭预估高度，避免新系统UI刷新错位
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.separatorStyle = separatorStyle;
    tableView.backgroundColor = color;
    tableView.contentInset = contentInset;
    if (isRefresh) {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            mjheadBlock();
        }];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        tableView.mj_header = header;
        if (footerIsNeedDrag) {
            MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                mjfootBlock();
            }];
            footer.labelLeftInset = 0;
            [footer setTitle:@"" forState:MJRefreshStateIdle];
            [footer setTitle:@"" forState:MJRefreshStatePulling];
            [footer setTitle:@"" forState:MJRefreshStateRefreshing];
            [footer setTitle:@"" forState:MJRefreshStateWillRefresh];
            [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
            tableView.mj_footer = footer;
        }else{
            MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                mjfootBlock();
            }];
            footer.labelLeftInset = 0;
            [footer setTitle:@"" forState:MJRefreshStateIdle];
            [footer setTitle:@"" forState:MJRefreshStatePulling];
            [footer setTitle:@"" forState:MJRefreshStateRefreshing];
            [footer setTitle:@"" forState:MJRefreshStateWillRefresh];
            [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
            tableView.mj_footer = footer;
        }
    }
    return tableView;
}
#pragma mark 通过data获取image,可获取image大小
+(UIImage *)UIImageWithimageURL:(NSString *)imageURL{
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
    return image;
}
#pragma mark UICollectionView
+(UICollectionView *)UICollectionViewMJRefreshWithFrame:(CGRect)frame scrollDirection:(UICollectionViewScrollDirection )scrollDirection itemSize:(CGSize )itemSize minimumLineSpacing:(CGFloat )minimumLineSpacing minimumInteritemSpacing:(CGFloat )minimumInteritemSpacing backgroundColor:(UIColor *)backgroundColor scrollEnabled:(BOOL )scrollEnabled pagingEnabled:(BOOL )pagingEnabled showsScrollIndicator:(BOOL )showsScrollIndicator contentInset:(UIEdgeInsets )contentInset footerLabelLeftInset:(CGFloat)inset isRefresh:(BOOL)isRefresh footerIsNeedDrag:(BOOL)footerIsNeedDrag mjheadBlock:(void (^)(void))mjheadBlock mjfootBlock:(void (^)(void))mjfootBlock{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = scrollDirection;
    flowLayout.itemSize = itemSize;
    flowLayout.minimumLineSpacing = minimumLineSpacing;
    flowLayout.minimumInteritemSpacing = minimumInteritemSpacing;
    UICollectionView *collectionview = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    if (@available(iOS 11.0, *)) {
        collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    collectionview.backgroundColor = backgroundColor;
    collectionview.scrollEnabled = scrollEnabled;
    collectionview.pagingEnabled = pagingEnabled;
    if (scrollDirection == UICollectionViewScrollDirectionVertical) {
        collectionview.showsVerticalScrollIndicator = showsScrollIndicator;
    }else{
        collectionview.showsHorizontalScrollIndicator = showsScrollIndicator;
    }
    collectionview.contentInset = contentInset;
    if (isRefresh) {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            mjheadBlock();
        }];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        collectionview.mj_header = header;
        if (footerIsNeedDrag) {
            MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                mjfootBlock();
            }];
            footer.labelLeftInset = 0;
            [footer setTitle:@"" forState:MJRefreshStateIdle];
            [footer setTitle:@"" forState:MJRefreshStatePulling];
            [footer setTitle:@"" forState:MJRefreshStateRefreshing];
            [footer setTitle:@"" forState:MJRefreshStateWillRefresh];
            [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
            collectionview.mj_footer = footer;
        }else{
            MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                mjfootBlock();
            }];
            footer.labelLeftInset = 0;
            [footer setTitle:@"" forState:MJRefreshStateIdle];
            [footer setTitle:@"" forState:MJRefreshStatePulling];
            [footer setTitle:@"" forState:MJRefreshStateRefreshing];
            [footer setTitle:@"" forState:MJRefreshStateWillRefresh];
            [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
            collectionview.mj_footer = footer;
        }
    }
    return collectionview;
}
#pragma mark 解决含有UICollectionView的vc手势返回冲突
+(UICollectionView *)UICollectionViewConflictWithVCBack:(UICollectionView *)collectionview vc:(UIViewController *)vc{
    NSArray *gestureArray = vc.navigationController.view.gestureRecognizers;
    for (UIGestureRecognizer *gestureRecognizer in gestureArray) {
        if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
            [collectionview.panGestureRecognizer requireGestureRecognizerToFail:gestureRecognizer];
        }
    }
    return collectionview;
}

#pragma mark UIScrollView
+ (UIScrollView *)UIScrollViewWithFrame:(CGRect )frame backgroundColor:(UIColor *)bgcolor size:(CGSize )size isPagingEnable:(BOOL )isPage isBounces:(BOOL )isBounces scrollEnabled:(BOOL )scrollEnabled isShowVerticalIndicator:(BOOL )isShowVIndicator isShowsHorizontalScrollIndicator:(BOOL )isShowHIndicator{
    
    UIScrollView *scrollview = [[UIScrollView alloc]initWithFrame:frame];
    scrollview.backgroundColor = bgcolor;
    scrollview.contentSize = size;
    scrollview.pagingEnabled = isPage;
    scrollview.bounces = isBounces;
    scrollview.scrollEnabled = scrollEnabled;
    scrollview.showsVerticalScrollIndicator = isShowVIndicator;
    scrollview.showsHorizontalScrollIndicator = isShowHIndicator;
    return scrollview;
}
#pragma mark 解决含有scrollview的vc手势返回冲突
+(UIScrollView *)UIScrollViewConflictWithVCBack:(UIScrollView *)scrollview vc:(UIViewController *)vc{
    NSArray *gestureArray = vc.navigationController.view.gestureRecognizers;
    for (UIGestureRecognizer *gestureRecognizer in gestureArray) {
        if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
            [scrollview.panGestureRecognizer requireGestureRecognizerToFail:gestureRecognizer];
        }
    }
    return scrollview;
}
#pragma mark UILabel
+(UILabel *)UILabelWithFrame:(CGRect )frame backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor text:(NSString *)text numberOfLines:(NSInteger)numberOfLines textAlignment:(NSTextAlignment )textAlignment font:(CGFloat)fontSize{
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = backgroundColor;
    label.text = text;
    label.frame = frame;
    label.textColor = textColor;
    label.numberOfLines = numberOfLines;
    label.textAlignment = textAlignment;
    label.font = [UIFont systemFontOfSize:fontSize];
    return label;
}
#pragma mark UIControl
+(UIControl *)UIControlFrame:(CGRect )frame backgroundColor:(UIColor *)backgroundColor tag:(int)tag target:(id)target action:(SEL)action{
    UIControl *control = [[UIControl alloc]initWithFrame:frame];
    control.backgroundColor = backgroundColor;
    control.tag = tag;
    [control addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return control;
}
#pragma mark UIView
+(UIView *)UIViewWithFrame:(CGRect )frame backgroundColor:(UIColor *)backgroundColor{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = backgroundColor;
    view.frame = frame;
    return view;
}
#pragma mark UITextView
+(UITextView *)UITextViewithFrame:(CGRect )frame backgroundColor:(UIColor *)backgroundColor content:(NSString *)content font:(CGFloat)fontSize textColor:(UIColor *)textColor{
    UITextView *textview = [[UITextView alloc]init];
    textview.backgroundColor = backgroundColor;
    textview.frame = frame;
    textview.scrollEnabled = NO;
    textview.showsVerticalScrollIndicator = NO;
    textview.showsHorizontalScrollIndicator = NO;
    textview.text = content;
    textview.font = [UIFont systemFontOfSize:fontSize];
    textview.textColor = textColor;
    textview.editable = NO;
    textview.userInteractionEnabled = NO;
    return textview;
}
#pragma mark UIImageView
+(UIImageView *)UIImageViewWithFrame:(CGRect )frame image:(id)image{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = frame;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.masksToBounds = YES;
    if ([image isKindOfClass:[NSString class]]) {
        imageView.image = [UIImage imageNamed:image];
    }else if ([image isKindOfClass:[UIImage class]]) {
        imageView.image = image;
    }
    return imageView;
}
#pragma mark UITextField
+(UITextField *)UITextFieldWithFrame:(CGRect )frame cornerRadius:(CGFloat )r font:(CGFloat)font borderStyle:(UITextBorderStyle )borderStyle backgroundColor:(UIColor *)bgcolor placeholder:(NSString *)placeholder attributes:(NSDictionary<NSAttributedStringKey, id> *)attrs returnKeyType:(UIReturnKeyType)returnKeyType leftview:(UIView *)leftview rightView:(UIView *)rightView clearButtonMode:(UITextFieldViewMode )clearButtonMode keyboardType:(UIKeyboardType )keyboardType{
    UITextField *tf = [[UITextField alloc]initWithFrame:frame];
    tf.layer.cornerRadius = r;
    tf.font = [UIFont systemFontOfSize:font];
    tf.backgroundColor = bgcolor;
    tf.placeholder = placeholder;
    tf.attributedPlaceholder = [[NSAttributedString alloc]initWithString:placeholder attributes:attrs];
    tf.borderStyle = borderStyle;
    leftview.layer.cornerRadius = r;
    tf.leftView = leftview;
    rightView.layer.cornerRadius = r;
    tf.rightView = rightView;
    tf.returnKeyType = returnKeyType;
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.rightViewMode = UITextFieldViewModeAlways;
    tf.clearButtonMode = clearButtonMode;
    tf.keyboardType = keyboardType;
    return tf;
}
#pragma mark UISearchController
+(UISearchController *)UISearchControllerWithSearchResultsController:(UIViewController *)searchResultsController frame:(CGRect )frame{
    UISearchController *searchController = [[UISearchController alloc]initWithSearchResultsController:searchResultsController];
    searchController.searchBar.frame = frame;
    //设置UISearchController的显示属性，以下3个属性默认为YES
    //搜索时，背景变暗色
    searchController.dimsBackgroundDuringPresentation = NO;
    //搜索时，背景变模糊
    if (@available(iOS 9.1, *)) {
        searchController.obscuresBackgroundDuringPresentation = NO;
    } else {
        // Fallback on earlier versions
    }
    //隐藏导航栏
    searchController.hidesNavigationBarDuringPresentation = YES;
    
    return searchController;
}
#pragma mark UIActivityIndicatorView
+(UIActivityIndicatorView *)UIActivityIndicatorViewWithFrame:(CGRect )frame activityIndicatorViewStyle:(UIActivityIndicatorViewStyle) activityIndicatorViewStyle{
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc]initWithFrame:frame];
    indicatorView.activityIndicatorViewStyle = activityIndicatorViewStyle;
    return indicatorView;
}
#pragma mark NSAttributedString
+(NSAttributedString *)NSAttributedStringWithIndex1:(NSInteger )index1 index2:(NSInteger )index2 string:(NSString *)string color:(UIColor *)color font:(CGFloat)font{
    NSString *str1 = string;
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString: str1];
    [str2 addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(index1,index2)];
    [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(index1,index2)];
    return str2;
}
#pragma mark 尚未确定
+(UIControl *)TopImageBottomStringWithFrame:(CGRect)frame image:(NSString *)image imageurl:(NSString *)imageurl placeholderImage:(NSString *)placeholderImage name:(NSString *)name font:(CGFloat)font textColor:(UIColor *)textColor tag:(NSInteger)tag target:(id)target action:(SEL)action{
    UIControl *control = [[UIControl alloc]init];
    control.backgroundColor = [UIColor clearColor];
    UIImageView *imageview = [self UIImageViewWithFrame:Frame(0, frame.size.height/10, frame.size.width, frame.size.width) image:image];
    if (image == nil) {
        imageview = [self SDWebImageSetImage:imageview url:imageurl placeholderImage:placeholderImage];
    }
    [control addSubview:imageview];
    UILabel *label = [self UILabelWithFrame:Frame(0, frame.size.width+frame.size.height/10, frame.size.width, 15) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] text:name numberOfLines:0 textAlignment:NSTextAlignmentCenter font:font];
    [control addSubview:label];
    control.tag = tag;
    [control addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return control;
}
#pragma mark 数字字符串转成时间字符串
+(NSString *)NumberTimeChangeString:(NSString *)time{
    
    NSInteger num = [time integerValue];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    NSDate * confromTime = [NSDate dateWithTimeIntervalSince1970:num];
    NSString * comfromTimeStr = [formatter stringFromDate:confromTime];
    return comfromTimeStr;
}
#pragma mark 获得目前时间
+(NSString *)getCurrentDateFormatter:(NSString *)dateFormat{
    
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = dateFormat;//@"yyyy-MM-dd HH:mm:ss"
    NSString *dayStr = [formatDay stringFromDate:now];
    
    return dayStr;
}
#pragma mark 获取某个时间与现在时间差
+(NSInteger)getTimeDifferenceWithNowTime:(NSString*)nowTime endTime:(NSString*)endTime {
    
    NSInteger timeDifference = 0;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yy-MM-dd HH:mm:ss"];
    NSDate *nowDate = [formatter dateFromString:nowTime];
    NSDate *deadline = [formatter dateFromString:endTime];
    NSTimeInterval oldTime = [nowDate timeIntervalSince1970];
    NSTimeInterval newTime = [deadline timeIntervalSince1970];
    timeDifference = newTime - oldTime;
    
    return timeDifference;
}
#pragma mark string时间转数字时间戳
+(NSString *)StringDateToNSIntergeTime:(NSString*)time{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yy-MM-dd HH:mm:ss"];
    NSDate *nowDate = [formatter dateFromString:time];
    NSInteger numtime = nowDate.timeIntervalSince1970;
    NSString *numtimestr = [NSString stringWithFormat:@"%ld",(long)numtime];
    return numtimestr;
}
#pragma mark 下载图片
+(UIImageView *)SDWebImageSetImage:(UIImageView *)imageview url:(NSString *)imageURL placeholderImage:(NSString *)placeholderImage{
    
    [imageview sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:placeholderImage]];
    return imageview;
}
#pragma mark 下载图片(需要获取frame的)
+(UIImageView *)SDWebImageNeedFrame:(UIImageView *)imageview url:(NSString *)imageURL placeholderImage:(NSString *)placeholderImage{
    [imageview sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:placeholderImage] options:SDWebImageRetryFailed completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        CGSize size = image.size;
        CGFloat w = size.width;
        CGFloat h = size.height;
        imageview.frame = CGRectMake(0, 0, w, h);
    }];
    return imageview;
}
#pragma mark 截取字符串
+(NSString *)cutoutNSString:(NSString *)str range:(NSInteger )index{
    str = [str substringToIndex:index];
    return str;
}

#pragma mark 计算字符串高度
+(CGFloat)calculatedStringHeight:(NSString *)string WithSize:(CGSize)size font:(CGFloat)fontSize{
    CGFloat h = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size.height;
    return h;
}
#pragma mark 计算字符串宽度
+(CGFloat)calculatedStringWidth:(NSString *)string WithSize:(CGSize)size font:(CGFloat)fontSize{
    CGFloat h = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size.width;
    return h;
}
#pragma mark 计算字符串长高度
+(CGSize)calculatedString:(NSString *)string WithSize:(CGSize)size font:(CGFloat)fontSize{
    CGSize s = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    return s;
}

#pragma mark 根据图片url获取图片尺寸
+(CGSize)getImageSizeWithURL:(id)imageURL
{
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)return CGSizeZero;// url不正确返回CGSizeZero
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size =  [self getPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"])
    {
        size =  [self getGIFImageSizeWithRequest:request];
    }
    else{
        size = [self getJPGImageSizeWithRequest:request];
    }
    if(CGSizeEqualToSize(CGSizeZero, size))                    // 如果获取文件头信息失败,发送异步请求请求原图
    {
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage* image = [UIImage imageWithData:data];
        if(image)
        {
            size = image.size;
        }
    }
    return size;
}
#pragma mark 获取PNG图片的大小
+(CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
#pragma mark  获取gif图片的大小
+(CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
#pragma mark 获取jpg图片的大小
+(CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}
#pragma mark 获取目前的VC
+ (UIViewController *)getCurrentVC{
    UITabBarController *tab = (UITabBarController *)WIN.rootViewController;
    UINavigationController *nav = (UINavigationController *)tab.selectedViewController;
    return nav.topViewController;
}
#pragma mark 用途比如推送跳转
+ (UINavigationController *)getCurrentNav{
    UITabBarController *tab = (UITabBarController *)WIN.rootViewController;
    UINavigationController *nav = (UINavigationController *)tab.selectedViewController;
    return nav;
}
#pragma mark 设置NSAttributedString颜色
+(NSMutableAttributedString *)NSMutableAttributedStringColorConfigText:(NSString *)text textColor:(UIColor *)textColor range:(NSRange)range{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text];
    [attr setAttributes:@{NSForegroundColorAttributeName : textColor} range:range];
    return attr;
}
#pragma mark image转data
+(NSData *)UIImageExchangeNSData:(UIImage *)image{
    NSData *data = UIImagePNGRepresentation(image);
    return data;
}
#pragma mark data转image
+(UIImage *)NSDataExchangeUIImage:(NSData *)data{
    UIImage *image = [UIImage imageWithData: data];
    return image;
}
#pragma mark 点按
+(UITapGestureRecognizer *)UITapGestureRecognizerWithTarget:(id)target action:(SEL)action{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    return tap;
}
#pragma mark 长按
+(UILongPressGestureRecognizer *)UILongPressGestureRecognizerWithTarget:(id)target action:(SEL)action{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:action];
    return longPress;
}
#pragma mark 轻扫
+(UISwipeGestureRecognizer *)UISwipeGestureRecognizerWithTarget:(id)target action:(SEL)action direction:(UISwipeGestureRecognizerDirection)direction{
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:action];
    swipe.direction = direction;
    return swipe;
}
#pragma mark 旋转
+(UIRotationGestureRecognizer *)UIRotationGestureRecognizerWithTarget:(id)target action:(SEL)action{
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:target action:action];
    return rotation;
}
#pragma mark 捏合
+(UIPinchGestureRecognizer *)UIPinchGestureRecognizerWithTarget:(id)target action:(SEL)action{
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:target action:action];
    return pinch;
}
#pragma mark 拖拽
+(UIPanGestureRecognizer *)UIPanGestureRecognizerWithTarget:(id)target action:(SEL)action{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:action];
    return pan;
}
#pragma mark FPS检测 //流畅度检测，数值越低越卡，越高越流畅
+(void)FPSLabel{
    FPSLabel *fpsLabel = [[FPSLabel alloc]initWithFrame:Frame(ScreenW-100, TopBarHeight+20, 80, 30)];
    [WIN addSubview:fpsLabel];
}

#pragma mark 返回虚线image的方法
+(UIImage *)drawLineByImageView:(UIImageView *)imageView lineColor:(UIColor *)color{
    UIGraphicsBeginImageContext(imageView.frame.size); //开始画线 划线的frame
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    //设置线条终点形状
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    // 5是每个虚线的长度 1是高度
    CGFloat lengths[] = {5,1.0};
    CGContextRef line = UIGraphicsGetCurrentContext();
    // 设置颜色
    CGContextSetStrokeColorWithColor(line, color.CGColor);
    CGContextSetLineDash(line, 0, lengths, 0.5); //画虚线
    CGContextMoveToPoint(line, 0.0, 1.0); //开始画线
    CGContextAddLineToPoint(line, ScreenW - 10, 1.0);
    
    CGContextStrokePath(line);
    // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
    return UIGraphicsGetImageFromCurrentImageContext();
}
#pragma mark 字典转Json字符串
+(NSString *)dictionaryToJsonString:(NSDictionary *)dict{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}
#pragma mark JSON字符串转化为字典
+ (NSDictionary *)jsonStringToWithDictionary:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error){
        DLog(@"json解析失败：%@",error);
        return nil;
    }
    return dic;
}
#pragma mark 替换去除字符
+(NSString *)removeStrWithContent:(NSString *)content removeStr:(NSString *)removeStr replaceStr:(NSString *)replaceStr{
    content = [content stringByReplacingOccurrencesOfString:removeStr withString:replaceStr];
    return content;
}
#pragma mark 获取启动图
+(UIImage *)getLaunchImage{
    UIImage *lauchImage  = nil;
    NSString *viewOrientation = nil;
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if(orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        viewOrientation = @"Landscape";
    }else{
        viewOrientation = @"Portrait";
    }
    NSArray *imagesDictionary = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dict in imagesDictionary) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            lauchImage = [UIImage imageNamed:dict[@"UILaunchImageName"]];
        }
    }
    return lauchImage;
}
#pragma mark 文字转码(中文)
+(NSString *)NSStringTranscodingWithText:(NSString *)text{
    return [text stringByRemovingPercentEncoding];
}
@end





