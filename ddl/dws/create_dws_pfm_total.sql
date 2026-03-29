DROP TABLE IF EXISTS ${spark.var.catalog.dws}.ddm.dws_pfm_total;

CREATE TABLE IF NOT EXISTS ${spark.var.catalog.dws}.ddm.dws_pfm_total
(
    -- =====================================================================
    -- 1. 系统溯源与底层标识域 (System & Lineage)
    -- =====================================================================
    data_source            STRING       COMMENT '数据来源渠道标识(如: tmall, jd)',
    date_id                 STRING       COMMENT '业务日期',
    channel                 STRING       COMMENT '原表一级触点/数据来源渠道',
    mapping_channel         STRING       COMMENT 'Mapping表触点|二级触点(京东特有)',

    
    -- =====================================================================
    -- 2. 核心维度域：组织、架构与商品 (Dimensions)
    -- =====================================================================
    -- 平台与企业
    platform_id             STRING       COMMENT '平台ID/渠道平台id',
    platform_name           STRING       COMMENT '平台名称',
    ea_id                   STRING       COMMENT '企业账户ID',
    ea_name                 STRING       COMMENT '企业账户名称',
    shop_id                 STRING       COMMENT '店铺ID',
    shop_name               STRING       COMMENT '店铺名称',
    account_id              STRING       COMMENT '账户id(京东)',
    account_name            STRING       COMMENT '账户名称(京东)',
    oss_key                 STRING       COMMENT '投放账户id(京东)',
    pin_code                STRING       COMMENT '授权pin(京东)',
    
    -- 广告推广架构
    channel_id              STRING       COMMENT '一级渠道ID',
    channel_name            STRING       COMMENT '一级渠道名称',
    plan_id                 STRING       COMMENT '计划ID',
    plan_name               STRING       COMMENT '计划名称',
    scene_id                STRING       COMMENT '场景ID(天猫)',
    scene_name              STRING       COMMENT '场景名称(天猫)',
    scene_id_oldlv2         STRING       COMMENT '历史二级场景ID(天猫)',
    scene_name_oldlv2       STRING       COMMENT '历史二级场景名称(天猫)',
    dim_name                STRING       COMMENT '维度名称',
    
    -- 创意与物料
    creative_id             STRING       COMMENT '创意ID',
    creative_name           STRING       COMMENT '创意名称',
    creative_title          STRING       COMMENT '创意标题(京东)',
    material_id             STRING       COMMENT '素材id(京东)',
    material_name           STRING       COMMENT '素材名称(京东)',
    creative_size           STRING       COMMENT '创意尺寸(京东)',
    creative_width          STRING       COMMENT '创意宽度(京东)',
    creative_height         STRING       COMMENT '创意高度(京东)',
    img_url                 STRING       COMMENT '图片url',
    img_flag                STRING       COMMENT '图片标识',
    video_url               STRING       COMMENT '视频url',
    land_page_url           STRING       COMMENT '落地页地址',
    material_creative_type  STRING       COMMENT '素材创意类型',
    ad_creative_type        STRING       COMMENT 'ad创意类型',
    
    -- 商品与载体
    main_id                 STRING       COMMENT '主体ID|词包ID(天猫)',
    main_name               STRING       COMMENT '主体名称|词包名称(天猫)',
    main_type               STRING       COMMENT '主体类型|商品类型(天猫)',
    bu                      STRING       COMMENT 'BU',    
    category                STRING       COMMENT '品类',
    old_category            STRING       COMMENT '旧品类(京东)',
    brand                   STRING       COMMENT '品牌',
    product_line            STRING       COMMENT '产品线/系列',
    sku_id                  STRING       COMMENT 'SKU ID',
    old_sku_id              STRING       COMMENT '旧商品id(京东)',
    sku_name                STRING       COMMENT 'SKU名称(京东sku_name对齐天猫sku)',
    sku_type                STRING       COMMENT 'sku类型(京东)',
    is_npd                  STRING       COMMENT '是否新品',
    itm_dim                 STRING       COMMENT '商品维度(京东)',
    
    -- 人群与归因规则
    crowd_name              STRING       COMMENT '人群名称(天猫)',
    attribution_model       STRING       COMMENT '归因模型(天猫)',
    unify_type              STRING       COMMENT '归因口径(天猫)',
    dir_type                STRING       COMMENT '定向方式(京东)',
    promote_device          STRING       COMMENT '推广设备类型(京东)',
    fee_type                STRING       COMMENT '费用类型(京东)',
    trans_cycle             STRING       COMMENT '转化周期',
    crt_or_pay              STRING       COMMENT '下单订单/成交订单(京东)',
    in_no_zp                STRING       COMMENT '含赠品/不含赠品(京东)',
    day_report              STRING       COMMENT '分日报告(京东)',
    clk_or_crt              STRING       COMMENT '点击/下单口径(京东)',
    push_type               STRING       COMMENT '投放类型(京东)',

    -- =====================================================================
    -- 3. 过程流量与互动指标 (Traffic & Interaction)
    -- =====================================================================
    -- 曝光与点击 (天猫京东合并)
    impression_cnt          BIGINT       COMMENT '展现量(京东impress_cnt合入)',
    click_cnt               BIGINT       COMMENT '点击量(京东clk_cnt合入)',
    click_rate              DECIMAL(18,6) COMMENT '点击率(京东clk_rate合入)',
    avg_display_rank        DECIMAL(18,6) COMMENT '平均展现排名(天猫)',
    clk_uv                  BIGINT       COMMENT '点击访客数',
    touch_uv                BIGINT       COMMENT '触达访客数',
    
    -- 访问深度与时长
    vst_pv                  BIGINT       COMMENT '观看次数/访问页面数(京东stay_page_cnt合入)',
    vst_uv                  BIGINT       COMMENT '访客数(京东ad2vst_cnt合入)',
    vst_rate                DECIMAL(18,6) COMMENT '观看率',
    avg_vst_interval        DECIMAL(18,6) COMMENT '平均观看时长(京东avg_stay_time_len合入)',
    avg_vst_page_cnt        DECIMAL(18,6) COMMENT '平均访问页面数',
    depth_vst_pv            BIGINT       COMMENT '深度访问量',
    deepth_enterslr_cnt     BIGINT       COMMENT '深度进店数(京东)',
    stay_time_len           BIGINT       COMMENT '访问时长总计(天猫)',
    valid_vst_pv            BIGINT       COMMENT '有效观看量',
    valid_vst_rate          DECIMAL(18,6) COMMENT '有效观看率',
    avg_valid_vst_interval  DECIMAL(18,6) COMMENT '平均有效观看时长',
    
    -- 互动/进店/搜索
    inav_pv                 BIGINT       COMMENT '互动量',
    inav_rate               DECIMAL(18,6) COMMENT '互动率',
    clk_inav_pv             BIGINT       COMMENT '互动点击量',
    clk_jump_pv             BIGINT       COMMENT '跳转点击量',
    clk_jump_rate           DECIMAL(18,6) COMMENT '跳转点击率',
    act_uv                  BIGINT       COMMENT '行动访客数',
    enterslr_pv             BIGINT       COMMENT '进店量',
    enterslr_rate           DECIMAL(18,6) COMMENT '进店率',
    enterslr_uv             BIGINT       COMMENT '进店访客数',
    search_pv               BIGINT       COMMENT '搜索访客量',
    search_uv               BIGINT       COMMENT '搜索访客数',
    research_impress_cnt    BIGINT       COMMENT '回搜展现量',
    research_clk_pv         BIGINT       COMMENT '回搜点击量',
    research_clk_uv         BIGINT       COMMENT '回搜点击访客数',
    research_touch_uv       BIGINT       COMMENT '回搜触达访客数',
    clk_module_cnt          BIGINT       COMMENT '组件点击数',
    ww_cslt_vlm             BIGINT       COMMENT '旺旺咨询量',
    reserve_cnt             BIGINT       COMMENT '预约数(京东)',
    get_ticket_cnt          BIGINT       COMMENT '领券数(京东)',
    
    -- 视频/直播专属
    live_pv                 BIGINT       COMMENT '直播观看量',
    live_like_pv            BIGINT       COMMENT '直播点赞量',
    live_share_pv           BIGINT       COMMENT '直播分享量',
    live_cmt_cnt            BIGINT       COMMENT '直播评论量',
    gd2live_total_vst_pv    BIGINT       COMMENT '引流直播间总观看次数',
    vdo2live_trans_ratio    DECIMAL(18,6) COMMENT '视频引流直播观看占比',
    video_views             BIGINT       COMMENT '视频播放次数(京东)',
    valid_video_views       BIGINT       COMMENT '视频有效播放量(京东)',
    valid_view_rate         DECIMAL(18,6) COMMENT '视频有效播放率(京东)',
    play_25per_vv           BIGINT       COMMENT '25%进度播放数(京东)',
    play_50per_vv           BIGINT       COMMENT '50%进度播放数(京东)',
    play_75per_vv           BIGINT       COMMENT '75%进度播放数(京东)',
    play_100per_vv          BIGINT       COMMENT '100%进度播放数(京东)',
    views_10pct             BIGINT       COMMENT '10%进度播放数(京东)',
    views_95pct             BIGINT       COMMENT '95%进度播放数(京东)',
    views_3s_complete       BIGINT       COMMENT '3s播放完成量(京东)',
    views_5s_complete       BIGINT       COMMENT '5s播放完成量(京东)',
    views_7s_complete       BIGINT       COMMENT '7s播放完成量(京东)',
    completion_rate         DECIMAL(18,6) COMMENT '视频播完率(京东)',
    disinterest_clicks      BIGINT       COMMENT '不感兴趣点击次数(京东)',

    -- 引导平台访问
    gd_vst_pv               BIGINT       COMMENT '引导平台访问pv',
    gd_vst_uv               BIGINT       COMMENT '引导平台访问uv',
    gd_vst_rate             DECIMAL(18,6) COMMENT '引导平台访问率',
    gd_ptnler_vst_uv        BIGINT       COMMENT '平台访问潜客数',
    gd_ptnler_vst_rate      DECIMAL(18,6) COMMENT '平台访问潜客占比',
    natural_flow_trans_exp  BIGINT       COMMENT '自然流量增量曝光',

    -- =====================================================================
    -- 4. 转化指标域：收藏/关注与加购 (Add to Cart & Favorite)
    -- =====================================================================
    -- 加购 (天猫京东合并)
    all_cart_itm_cnt        BIGINT       COMMENT '总加购数(京东all_cart_cnt合入)',
    dir_cart_itm_cnt        BIGINT       COMMENT '直接加购数(京东dir_cart_cnt合入)',
    indir_cart_itm_cnt      BIGINT       COMMENT '间接加购数(京东indir_cart_cnt合入)',
    cart_itm_cnt            BIGINT       COMMENT '宝贝/商品加购数',
    cart_itm_uv             BIGINT       COMMENT '宝贝加购访客数',
    cart_rate               DECIMAL(18,6) COMMENT '加购率',
    
    -- 收藏/关注 (天猫clt对齐京东flw)
    all_clt_itm_cnt         BIGINT       COMMENT '总收藏/关注数',
    dir_clt_itm_cnt         BIGINT       COMMENT '直接收藏宝贝数',
    indir_clt_itm_cnt       BIGINT       COMMENT '间接收藏宝贝数',
    clt_itm_cnt             BIGINT       COMMENT '宝贝收藏数(京东flw_itm_cnt合入)',
    clt_slr_cnt             BIGINT       COMMENT '店铺收藏数(京东flw_slr_cnt合入)',
    clt_itm_uv              BIGINT       COMMENT '宝贝收藏访客数',
    clt_slr_uv              BIGINT       COMMENT '店铺收藏访客数',
    flr_uv                  BIGINT       COMMENT '关注访客数(天猫)',
    flw_uv                  BIGINT       COMMENT '粉丝关注量(天猫)',
    clt_itm_rate            DECIMAL(18,6) COMMENT '宝贝收藏率',
    
    -- 收藏+加购(双加)
    all_clt_cart_itm_cnt    BIGINT       COMMENT '总收藏加购数',
    clt_cart_itm_cnt        BIGINT       COMMENT '宝贝收藏加购数',
    clt_cart_itm_rate       DECIMAL(18,6) COMMENT '宝贝收藏加购率',

    -- =====================================================================
    -- 5. 结果指标域：订单与金额 (Orders & GMV)
    -- =====================================================================
    -- 漏斗转化率
    trans_rate              DECIMAL(18,6) COMMENT '转化率',
    clk_trans_rate          DECIMAL(18,6) COMMENT '点击转化率',
    pay_trans_rate          DECIMAL(18,6) COMMENT '成交转化率',
    se2enterslr_trans_rate  DECIMAL(18,6) COMMENT '搜索进店率',
    enterslr2act_trans_rate DECIMAL(18,6) COMMENT '进店行动率',
    act2pay_trans_rate      DECIMAL(18,6) COMMENT '行动成交率',
    trans_effect            DECIMAL(18,6) COMMENT '转化效果',
    
    -- 订单笔数/行数
    crt_ord_cnt             BIGINT       COMMENT '拍下订单笔数',
    all_pay_ord_cnt         BIGINT       COMMENT '总支付订单/总订单行',
    dir_pay_ord_cnt         BIGINT       COMMENT '直接支付订单笔数/行',
    indir_pay_ord_cnt       BIGINT       COMMENT '间接支付订单笔数/行',
    all_pre_ord_cnt         BIGINT       COMMENT '总预售成交笔数(京东pre_pay_ord_cnt合入)',
    dir_pre_ord_cnt         BIGINT       COMMENT '直接预售成交笔数',
    indir_pre_ord_cnt       BIGINT       COMMENT '间接预售成交笔数',
    
    -- 订单金额
    ord_plc_amt             DECIMAL(18,6) COMMENT '拍下订单金额',
    all_pay_ord_amt         DECIMAL(18,6) COMMENT '总支付/下单金额',
    dir_pay_ord_amt         DECIMAL(18,6) COMMENT '直接支付金额',
    indir_pay_ord_amt       DECIMAL(18,6) COMMENT '间接支付金额',
    all_pre_ord_amt         DECIMAL(18,6) COMMENT '总预售订单金额(京东pre_pay_ord_amt合入)',
    dir_pre_ord_amt         DECIMAL(18,6) COMMENT '直接预售订单金额',
    indir_pre_ord_amt       DECIMAL(18,6) COMMENT '间接预售订单金额',
    natural_flow_trans_pay  DECIMAL(18,6) COMMENT '自然流量增量成交',
    
    -- 人均及其他
    avg_pay_ord_cnt         DECIMAL(18,6) COMMENT '人均成交笔数',
    avg_pay_ord_amt         DECIMAL(18,6) COMMENT '人均成交金额',
    pay_byr_cnt             BIGINT       COMMENT '成交人数/买家数',
    rc_gwj_cnt              BIGINT       COMMENT '购物金充值笔数',
    rc_gwj_amt              DECIMAL(18,6) COMMENT '购物金充值金额',
    coupon_rdmpt_cnt        BIGINT       COMMENT '优惠券领取量',

    -- =====================================================================
    -- 6. 客户圈层域：新客与会员 (Newer & Member)
    -- =====================================================================
    -- 新客
    pay_new_user_cnt        BIGINT       COMMENT '新用户支付笔数(京东pay_newer_cnt合入)',
    pay_new_user_rate       DECIMAL(18,6) COMMENT '新用户支付转化率',
    new_customers           BIGINT       COMMENT '新客数(京东)',
    new_orders              BIGINT       COMMENT '新客订单行(京东)',
    new_order_value         DECIMAL(18,6) COMMENT '新客订单金额(京东)',
    touch_newer_cnt         BIGINT       COMMENT '新客触达数',
    vst_newer_pv            BIGINT       COMMENT '新客观看次数',
    newer_cover_rate        DECIMAL(18,6) COMMENT '新客覆盖率',
    newer_pay_trans_rate    DECIMAL(18,6) COMMENT '新客成交转化率',
    enterslr_newer_uv       BIGINT       COMMENT '进店新客人数',
    inav_newer_uv           BIGINT       COMMENT '互动新客人数',
    ntl_trf_exp             BIGINT       COMMENT '新流量曝光',
    ntl_trf_cvr_amt         DECIMAL(18,6) COMMENT '新流量转化金额',
    dir_pay_ord_amt_ratio   DECIMAL(18,6) COMMENT '新客直接引导成交金额占比',
    dir_pre_ord_amt_ratio   DECIMAL(18,6) COMMENT '新客直接引导预售成交金额占比',
    
    -- 会员
    mbr_cnt                 BIGINT       COMMENT '会员数',
    mbr_rate                DECIMAL(18,6) COMMENT '会员转化率',
    mbr_uv                  BIGINT       COMMENT '入会量',
    mbr_first_purchase_cnt  BIGINT       COMMENT '会员首购人数',
    mbr_pay_ord_cnt         BIGINT       COMMENT '会员成交笔数',
    mbr_pay_ord_amt         DECIMAL(18,6) COMMENT '会员成交金额',
    
    -- 种草追投
    zc_crowd_retarget_gd_pay_amt DECIMAL(18,6) COMMENT '种草人群追投引导成交金额',

    -- =====================================================================
    -- 7. 财务考核域：消耗、成本与ROI (Cost & ROI)
    -- =====================================================================
    -- 整体花费与ROI
    cost                    DECIMAL(18,6) COMMENT '花费/消耗',
    roi                     DECIMAL(18,6) COMMENT '投入产出比',
    dir_pay_ord_roi         DECIMAL(18,6) COMMENT '直接支付roi',
    newer_roi               DECIMAL(18,6) COMMENT '新客投入产出比',
    return_rate             DECIMAL(18,6) COMMENT '回报率',
    zc_pay_roi              DECIMAL(18,6) COMMENT '种草引导成交ROI',
    zc_crowd_retarget_roi   DECIMAL(18,6) COMMENT '种草人群追投roi',
    
    -- 曝光/点击成本
    impress_cpm             DECIMAL(18,6) COMMENT '千次展现花费/成本',
    cost_per_tosd_impres    DECIMAL(18,6) COMMENT '每次展示成本',
    avg_clk_cost            DECIMAL(18,6) COMMENT '平均点击花费/成本',
    avg_cost_per_clk        DECIMAL(18,6) COMMENT '平均点击成本(天猫专用)',
    clk_unit_amt            DECIMAL(18,6) COMMENT '点击单价',
    jump2clk_unit_amt       DECIMAL(18,6) COMMENT '跳转点击单价',
    
    -- 过程行为成本
    vst_cost                DECIMAL(18,6) COMMENT '观看成本',
    valid_vst_cpm           DECIMAL(18,6) COMMENT '千次有效观看成本',
    valid_view_cost         DECIMAL(18,6) COMMENT '有效播放成本(京东)',
    itm_fvt_cost            DECIMAL(18,6) COMMENT '商品收藏成本',
    clt_itm_cost            DECIMAL(18,6) COMMENT '宝贝收藏成本',
    clt_slr_cost            DECIMAL(18,6) COMMENT '店铺收藏成本',
    store_follow_cost       DECIMAL(18,6) COMMENT '店铺关注成本(京东)',
    product_follow_cost     DECIMAL(18,6) COMMENT '商品关注成本(京东)',
    cart_itm_cost           DECIMAL(18,6) COMMENT '加购商品成本',
    cart_cost               DECIMAL(18,6) COMMENT '加购成本(京东)',
    clt_cart_itm_cost       DECIMAL(18,6) COMMENT '宝贝收藏加购成本',
    all_clt_cart_itm_cost   DECIMAL(18,6) COMMENT '总收藏加购成本',
    shop_clt_cost           DECIMAL(18,6) COMMENT '店铺客户成本',
    
    -- 拉新/转化成本
    all_pay_ord_cost        DECIMAL(18,6) COMMENT '总成交成本(京东cpa合入)',
    laxin_cost              DECIMAL(18,6) COMMENT '拉新成本',
    inc_fans_cost           DECIMAL(18,6) COMMENT '新增粉丝成本',
    touch_newer_cost        DECIMAL(18,6) COMMENT '新客触达成本',
    new_customer_cost       DECIMAL(18,6) COMMENT '新客成本(京东)',
    zc_pay_ord_cost         DECIMAL(18,6) COMMENT '种草引导成交成本',
    zc_crowd_retarget_cost  DECIMAL(18,6) COMMENT '种草人群追投消耗',
    
    -- =====================================================================
    -- 8. 渠道特有业务扩展域 (Exclusive Ext)
    -- =====================================================================
    -- 全站营销特有(京东)
    allsite_ord_amt         DECIMAL(18,6) COMMENT '全站交易额',
    allsite_ord_cnt         BIGINT       COMMENT '全站订单行',
    allsite_ord_cost        DECIMAL(18,6) COMMENT '全站订单成本',
    allsite_fee_ratio       DECIMAL(18,6) COMMENT '全站费比',
    allsite_roi             DECIMAL(18,6) COMMENT '全站投产比',
    
    -- 品牌合约特有(京东)
    order_id                STRING       COMMENT '订单id',
    order_name              STRING       COMMENT '订单名称',
    schedule_id             STRING       COMMENT '排期id',
    schedule_name           STRING       COMMENT '排期名称',
    ad_slot_id              STRING       COMMENT '广告位id',
    ad_slot_name            STRING       COMMENT '广告位名称',
    exp_pv                  BIGINT       COMMENT '曝光数(合约)',
    exp_clk_cnt             BIGINT       COMMENT '曝光点击数(合约)',
    exp_clk_rate            DECIMAL(18,6) COMMENT '曝光点击率(合约)',
    
    -- 直播推广特有(京东)
    start_time              STRING       COMMENT '开始时间',
    expire_time             STRING       COMMENT '到期时间',
    plan_type               STRING       COMMENT '计划类型',
    market_scene            STRING       COMMENT '营销场景',
    status                  STRING       COMMENT '状态',
    item_sku                STRING       COMMENT '商品sku(直播)',
    resource_slot           STRING       COMMENT '资源位',
    
    -- 站内广告特有(京东)
    media_type              STRING       COMMENT '媒体类型',
    placement               STRING       COMMENT '投放位置',
    one_click_cost          DECIMAL(18,6) COMMENT '一键起量花费',
    
    -- 补充系统时间域
    clk_date                STRING       COMMENT '点击日期(京东)',
    clk_time                STRING       COMMENT '点击时间(京东)',

    -- =====================================================================
    -- 9. 
    -- =====================================================================
    uuid                    STRING       COMMENT '唯一ID/行标识(京东ly_uuid对齐至此)',
    file_id                 STRING       COMMENT '来源文件ID/系统唯一标识',
    file_name               STRING       COMMENT '来源文件名'
)


;
