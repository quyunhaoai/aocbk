
//
//  LSDetainViewController.m
//  LSNewsDetailWebviewContainer
//
//  Created by liusong on 2018/12/15.
//  Copyright © 2018年 liusong. All rights reserved.
//

#import "LSDetainViewController.h"
#import "LSNewsDetailWebviewContainer.h"
#import "MJRefresh.h"

#import "Masonry.h"
@interface LSDetainViewController ()<UITableViewDataSource,UITableViewDelegate,WKNavigationDelegate>

@property (nonatomic,strong) NSMutableArray *datas;//底部tableview的数据
@property (nonatomic,weak) LSNewsDetailWebviewContainer *detailWebviewContainer;
@property (strong, nonatomic) UILabel *nameLab;
@property (strong, nonatomic) UIImageView *iconImage;
@property (strong, nonatomic) UILabel *titleLab;
@property (strong, nonatomic) UILabel *subLab;



@end

@implementation LSDetainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *rightBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [btn setImage:IMAGE_NAME(@"转发-1") forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES ;
        [btn addTarget:self action:@selector(rightBtAction:) forControlEvents:UIControlEventTouchUpInside];
        btn ;
    });
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [self customNavBarWithtitle:@"新闻详情" andLeftView:@"" andRightView:@[rightBtn]];
    self.navTitleView.splitView.backgroundColor = COLOR_e5e5e5;
    [self setupViews2];
    [self initData];
}
- (void)initData {
    XYWeakSelf;
    NSString *url = [NSString stringWithFormat:@"news/details/%@",self.classId];
    NSDictionary *params = @{};
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:url
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"status"] integerValue];
        NSString *msg = [[dic objectForKey:@"msg"] description];
        if(status == 200){
            NSDictionary *data = dic[@"data"];
            NSMutableString *content = data[@"content"];
//            [MBManager hideAlert];
//            [MBManager showLoading];
            [weakSelf.detailWebviewContainer loadHTMLString:content];
            weakSelf.nameLab.text = data[@"title"];
            weakSelf.titleLab.text = data[@"author"];
            weakSelf.subLab.text = data[@"add_time"];
            [weakSelf.iconImage sd_setImageWithURL:[NSURL URLWithString:data[@"author_pic"]]];
        }else{
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];
}
- (void)rightBtAction:(UIButton *)button {
    
}

//使用自己创建的WKWebview和UITableview
-(void)setupViews2
{
    LSNewsDetailWebviewContainer *container=[[LSNewsDetailWebviewContainer alloc]init];
    WKWebView *webview=[[WKWebView alloc]init];
    webview.backgroundColor=[UIColor whiteColor];
    
    UITableView *tableview=[[UITableView alloc]init];
    [container configueWebview:webview tableview:tableview];
    
    container.tableview.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    container.tableview.mj_footer.automaticallyChangeAlpha=YES;
    container.tableview.dataSource=self;
    container.tableview.delegate=self;
    container.tableview.tableFooterView=[UIView new];
    container.webview.navigationDelegate=self;
    self.detailWebviewContainer=container;
    [self.view addSubview:container];
    container.frame=CGRectMake(0, NAVIGATION_BAR_HEIGHT+100, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height-NAVIGATION_BAR_HEIGHT-100);
//    [self loadClick:nil];

    UILabel *nameLab = ({
        UILabel *view = [UILabel new];
        view.textColor =Color_2A2A2A;
        view.font = STFont(17);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.numberOfLines = 2;
        view ;
    });
    [self.view addSubview:nameLab];
    [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(12);
        make.size.mas_equalTo(CGSizeMake(Window_W-24, 34));
        make.top.mas_equalTo(self.view).mas_offset(10+NAVIGATION_BAR_HEIGHT);
    }];
    self.nameLab = nameLab;
    UIImageView *areaIcon = ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFill ;
        view.layer.masksToBounds = YES ;
        view.userInteractionEnabled = YES ;
        view;
    });
    self.iconImage = areaIcon;
    [self.view addSubview:areaIcon];
    [areaIcon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(12);
        make.size.mas_equalTo(CGSizeMake(39, 39));
        make.top.mas_equalTo(nameLab.mas_bottom).mas_offset(10);
    }];
    UILabel *addressLab = ({
        UILabel *view = [UILabel new];
        view.textColor =Color_2A2A2A;
        view.font = STFont(14);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.numberOfLines = 1;
        view ;
    });
    [self.view addSubview:addressLab];
    [addressLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(56);
        make.size.mas_equalTo(CGSizeMake(247, 14));
        make.top.mas_equalTo(nameLab.mas_bottom).mas_offset(10);
    }];
    self.titleLab = addressLab;
    UILabel *mobleNumberLab = ({
        UILabel *view = [UILabel new];
        view.textColor = COLOR_666666;
        view.font = STFont(12);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view ;
    });
    
    [self.view addSubview:mobleNumberLab];
    [mobleNumberLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(56);
        make.size.mas_equalTo(CGSizeMake(217, 14));
        make.top.mas_equalTo(addressLab.mas_bottom).mas_offset(8);
    }];
    self.subLab = mobleNumberLab;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    if (scrollView==self.detailWebviewContainer.scrollview) {
//        if (scrollView.contentOffset.y>=self.detailWebviewContainer.webview.scrollView.contentSize.height-self.view.frame.size.height+44+46) {
//            self.title=@"松哥博客";
//        }else{
//            self.title=@"";
//        }
//    }
}

- (IBAction)loadClick:(id)sender {
    
//    [MBManager showBriefAlert:@"正在加载" inView:self.view];
//    if (self.firstConfigute) {
//        [self.detailWebviewContainer loadRequest];
//    }else{
//        NSData *data = [NSData dataWithContentsOfURL:[[NSBundle mainBundle]URLForResource:@"1.json" withExtension:nil]];
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        [self.detailWebviewContainer loadHTMLString:@"<p class=\"art_p\">新型肺炎疫情令本就“遇冷“的家电行业遭受严重冲击，以格力电器、美的集团及海信集团等行业巨头均于近期采取高管冻薪、裁员及多次股份回购等措施，以提振公司业绩发展。虽然疫情之下难见曙光，但随着“五一小长假”、“618”电商促销等节日到来，可以预期的是，折扣力度加大，价格战一触即发，行业竞争也将持续加剧。</p>\r\n<p class=\"art_p\">《投资者网》戴昊彤</p>\r\n<p class=\"art_p\">2020年年初的新冠疫情，给家电行业带来了不小的冲击与挑战。受疫情冲击，一季度行业巨头营收净利出现大幅下滑，海信、美的及格力近期纷纷出现裁员、高管冻薪以及大幅度亏损的现象。家电行业承压进一步加剧，无可避免地迎来“多事之秋“。</p>\r\n<p class=\"art_p\">在多家家电企业公布2019年业绩报告的同时，其第一季度的业绩增速普遍大幅度下降，产品销售停滞为不少公司带来经营压力。一季度的亏损已成不可挽回的局面，那么，对于接下来第二季度、第三季度内，各大家电企业能否通过推出新品、加大折扣力度等途径来刺激销售量，以及提升业绩等，都成为投资者最为关注的问题。</p>\r\n<p class=\"art_p\"><strong>海信裁员求生</strong></p>\r\n<p class=\"art_p\">4月15日，海信家电集团股份有限公司（以下简称”海信集团“，000921.SZ、00921.HK）发布了2020年第一季度业绩预告显示，一季度预计净利润约0万元-1.26亿元，同比下降70.0%~100.0%，上年同期为盈利4.22亿元；预计基本每股收益为0元/股-0.09元/股，上年同期为0.31元/股。</p>\r\n<p class=\"art_p\">对于业绩下降的主要原因，海信集团在报告解释称，受报告期内新冠肺炎疫情对消费市场造成严重影响和冲击，公司营业收入大幅下滑，规模不足导致毛利额大幅下降，费用率大幅上升，从而导致公司经营业绩大幅下降。</p>\r\n<p class=\"art_p\">在此之前，4月10日，海信集团被曝计划大规模裁员一万人，而集团优胜劣汰的信息随即引发市场热议。4月12日，海信集团回应称，目前网络已有的关于海信定量裁员的信息，</p>\r\n<p class=\"art_p\">其中数据并不属实。</p>\r\n\r\n<figure class=\"art_img_mini j_p_gallery\">\r\n<img class=\"art_img_mini_img j_fullppt_cover\"  src='https://n.sinaimg.cn/tech/transform/41/w630h1011/20200429/0925-isuiksp3155731.jpg' alt=\"图片来源：海信集团官方微博\" />\r\n<h2 class=\"art_img_tit\">图片来源：海信集团官方微博</h2>\r\n</figure>\r\n\r\n<p class=\"art_p\">海信集团表示，“受全球疫情影响，集团海外业务收入占整体收入已超过40%，经营形势更加严峻，故采取高管带头降薪、通过末位淘汰加速员工队伍优胜劣汰等措施，激发全体员工斗志，层层传递压力、提高系统效率，以稳住业绩”。但是，关于末位淘汰比例及预计淘汰人数等细节，海信集团未在相关说明中提及。</p>\r\n<p class=\"art_p\">其实，海信集团的裁员行动已经率先在国外有所开展。4月23日，据路透社报道，海信集团位于斯洛文尼亚的欧洲部门表示，该公司年底前将在欧洲裁员23%约2200人，以应对新冠疫情导致的需求下降。</p>\r\n<p class=\"art_p\">除裁员之外，新冠疫情其实对整个家电行业的股价冲击都较为明显，《投资者网》查询自1月23日疫情爆发后至4月25日知名家电股走势如下：</p>\r\n\r\n<figure class=\"art_img_mini j_p_gallery\">\r\n<img class=\"art_img_mini_img j_fullppt_cover\"  src='https://n.sinaimg.cn/tech/transform/183/w630h353/20200429/a1fb-isuiksp3155960.png' alt=\"图片来源：Wind金融终端\" />\r\n<h2 class=\"art_img_tit\">图片来源：Wind金融终端</h2>\r\n</figure>\r\n\r\n<p class=\"art_p\">不过，相比海信集团的裁员及未来发展，海通证券认为，“短期看海信集团受疫情冲击增长受到一定影响，但中长期看，公司背靠集团资源支持，家电业务规模有望继续扩大。伴随成本及汇率端的压力减弱，自身盈利能力有望强势回升。中央空调业务成长性良好，持续为公司增厚业绩，海通证券判断，2020 年前三季度公司整体收入端将继续得益于其并表而所有增厚。”</p>\r\n<p class=\"art_p\">事实上，据《投资者网》查询2019年报及今年一季度报发现，海信集团今年继续面临承压，净利润波动较大。尽管公司2019年营收和净利润都实现双增长，其中，2019年营收达374.53亿元，同比增长3.98%，实现归属于上市公司股东的净利润17.94亿元，同比增长30.22%。但若按可比口径计算，其主营业务收入同比下降4.07%。从产品线来看，空调与冰洗业务是营收的两大“主力军“ 。</p>\r\n<p class=\"art_p\">2019年内，海信集团的空调业务营收达163.69亿元，占总营收比重为43.71%，同比增长9.92%；冰洗业务营收为161.28亿元，占总营收比重为43.06%，同比增长0.34%。</p>\r\n<div sax-type=\"proxy\" class=\"j_native_hij200429 box\" style=\"margin:20px 0\"></div><p class=\"art_p\">然而，值得注意的是，海信集团的空调业务自2019年下半年开始已经出现创收乏力的现象。2019年下半年，公司的空调业务营收为74.54亿元，环比下降16.38%；同期，利润总额5.55亿元，环比下降28.57%。</p>\r\n<p class=\"art_p\"><strong>美的高管“冻薪”</strong></p>\r\n<p class=\"art_p\">与海信集团同样背负较大经营压力，还有美的电器与格力电器这两大行业巨头。在海信计划削减成本之际，美的集团也开始实行冻薪等措施以降低经营压力。</p>\r\n<p class=\"art_p\">4月14日，网络上流传一份美的集团股份有限公司（以下简称“美的集团“，000333.SZ）下发《关于冻结高管部分薪酬的通知》，称鉴于当前全球严峻经济形势，为进一步传递经营压力，促进集团整体经营目标实现，决定对高管部分薪酬实施冻结措施。冻结标准为30%月度工资发放，此部分年底根据集团整体及单位业绩达成情况再确定是否返还，执行时间暂定为2020年3月到12月。</p>\r\n\r\n<figure class=\"art_img_mini j_p_gallery\">\r\n<img class=\"art_img_mini_img j_fullppt_cover\"  src='https://n.sinaimg.cn/tech/transform/201/w600h401/20200429/abf4-isuiksp3155577.jpg' alt=\"\" />\r\n<h2 class=\"art_img_tit\"></h2>\r\n</figure>\r\n\r\n<p class=\"art_p\">除高管冻薪以外，值得一提是，从今年开始至今，美的集团还实施多次股份回购。2月21日，美的集团发布晚间公告称，公司已耗资32亿元完成去年2月启动的回购计划，同时宣布拿出不超过52亿元开启新一轮回购。</p>\r\n<p class=\"art_p\">2月26日，美的集团再次发布公告称，拟发行总额不超过200亿元（含）的债务融资工具，包括超短期融资券不超过100亿元、中期票据不超过100亿元。募集资金将用于满足公司生产经营需要，包括不限于偿还债务、调整债务结构、补充流动资金、项目投资或重要支付等。针对本次发行债券的目的，美的集团表示，此次200亿元的债务融资是为了更好的把握债务融资产品的发行时机。本次申请注册发行超短期融资券和中期票据，有利于公司优化资金结构和降低融资成本，满足公司后续发展资金需求，保证公司产业规划有序实施。</p>\r\n<p class=\"art_p\">然而，回购股份也会存在一定风险。天风证券在研报中指出，在市场化行为中，回购周期与企业的盈利周期是相对一致的。当业绩向好和现金流充裕的时候，企业更有能力进行大规模回购，这时也往往对应股票市场表现较好的阶段。但若公司采取激进式方式，甚至通过举债加杠杆来分红或回购，则将有可能导致债务违约风险上升。</p>\r\n<p class=\"art_p\"><strong>格力老板“带货”</strong></p>\r\n<p class=\"art_p\">反观另一家行业翘楚格力电器，在业绩不振之下，其董事长董明珠也开始了“卖货”尝试。4月24日晚，董明珠开启了直播首秀，尝试线上销售格力产品。在直播结束后，董明珠在采访中表示，因受疫情影响，格力电器一季度损失了300亿元。但即使再困难，公司也不会采取裁员计划。</p>\r\n<p class=\"art_p\">4月27日，格力电器发布澄清公告称，所谓的亏损300多个亿是董明珠口中所表述的是公司 2020 年第一季度销售收入未达预期，比预期目标少 300 多亿元，指的是减少了 300亿的销售额，而并非亏损 300 亿元。</p>\r\n<p class=\"art_p\">据格力电器2019年业绩快报及2020年第一季度业绩预告显示，2019年格力电器实现营业收入2005.08亿元，同比微增0.24%；实现净利润为246.72亿元，同比下滑5.84%。 预计2020年一季度营收为207-229亿元，同比下降44-50%；净利润为13.3-17.1亿元，同比下降70%-77%。</p>\r\n<p class=\"art_p\">根据奥维云网数据显示，整体上看，白电行业一季度零售额降幅大约为45%，其中，冰箱市场零售量为469万台，零售额为130亿元，同比分别下降22.5%和28.0%；洗衣机市场零售量为600万台，零售额为105亿元，同比分别下降27.8%和35.9%；空调市场零售量为524万台，零售额为149.2亿元，同比分别下降46.4%和58.1%。</p>\r\n<p class=\"art_p\">家电行业分析人士刘步尘告诉《投资者网》，“在业绩增速下滑的情况下，加上疫情在全球蔓延，将进一步加剧今年家电企业业绩的不确定性。” 刘步尘认为，预计今年大部分家电企业营收出现负增长也是具较大可能性。</p>\r\n<p class=\"art_p\">对企业而言，疫情过后，在新一轮消费者政策刺激下，家电仍有机会提振销售，尤其是时间较近的”五一小长假“、”618“等各大电商的促销节点。可以预期的是，折扣力度加大，价格战一触即发，虽然行业竞争今年有望持续加剧，但行业机会也在悄然而至_。（思维财经出品）</p>"];
//        [self.detailWebviewContainer loadHTMLString:dict[@"data"]];
//    }
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
//    self.emptyView.hidden=YES;
    self.datas=[NSMutableArray array];
    //一般新闻评论每页数据都是20条
//    for (int i=0; i<20; i++) {
//        [self.datas addObject:@"1"];
//    }
//    [self.detailWebviewContainer.tableview reloadData];
    [MBManager hideAlert];
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
//    self.emptyView.hidden=NO;
    [MBManager hideAlert];
}

//- (IBAction)commentClick:(id)sender {
//    [self.detailWebviewContainer scrollToWebviewOrTableView];
//}
//
//- (IBAction)starClick:(UIButton*)sender {
//    sender.selected=!sender.selected;
//}
//- (IBAction)shareClick:(UIButton*)sender {
//
//    UIViewController *vc=[[UIViewController alloc]init];
//    vc.view.backgroundColor=[UIColor whiteColor];
//    vc.title=@"转发";
//    [self.navigationController pushViewController:vc animated:YES];
//}


-(void)loadMoreData
{
    //延迟模拟网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        for (int i=0; i<20; i++) {
//            [self.datas addObject:@"1"];
//        }
//        if (self.datas.count>=60) {
//            [self.detailWebviewContainer.tableview.mj_footer endRefreshingWithNoMoreData];
//        }else{
//            [self.detailWebviewContainer.tableview.mj_footer endRefreshing];
//        }
//        [self.detailWebviewContainer.tableview reloadData];
    });
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc=[[UIViewController alloc]init];
    vc.title=@"评论详情";
    vc.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
