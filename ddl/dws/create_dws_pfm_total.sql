-- =====================================================================
-- dwd层表：京东推广sku明细表
-- 表名：dwd_jd_pfm_sku
-- 数据来源：整合7张ods表 + 维度表关联
-- 分区字段：data_source
-- =====================================================================

drop table if exists ${spark.var.catalog.dwd}.ddm.dwd_jd_pfm_sku;

create table if not exists ${spark.var.catalog.dwd}.ddm.dwd_jd_pfm_sku
(
    -- ======================== 基础维度字段 ========================
    channel                 string      comment '一级触点',
    mapping_channel         string      comment 'Mapping表触点|二级触点',
    date_id                 string      comment '业务日期',
    shop_id                 string      comment '系统店铺id',
    shop_name               string      comment '系统店铺名称',
    plan_id                 string      comment '计划id',
    plan_name               string      comment '推广计划名称',
    unit_id                 string      comment '单元id',
    unit_name               string      comment '单元名称',
    creative_id             string      comment '创意id',
    creative_name           string      comment '推广创意名称',
    creative_title          string      comment '创意标题',
    pin_code                string      comment '授权pin',
    account_id              string      comment '账户id',
    account_name            string      comment '账户名称',
    oss_key                 string      comment '投放账户id',

    -- ======================== 基础流量指标字段 ========================
    impress_cnt             string      comment '展现数',
    clk_cnt                 string      comment '点击数',
    clk_rate                string      comment '点击率',
    cost                    string      comment '花费',
    impress_cpm             string      comment '千次展现成本',
    avg_clk_cost            string      comment '平均点击成本',

    -- ======================== 订单相关指标字段 ========================
    dir_pay_ord_cnt         string      comment '直接订单行',
    dir_pay_ord_amt         string      comment '直接订单金额',
    indir_pay_ord_cnt       string      comment '间接订单行',
    indir_pay_ord_amt       string      comment '间接订单金额',
    all_pay_ord_cnt         string      comment '总订单行',
    all_pay_ord_amt         string      comment '总订单金额',
    pre_pay_ord_cnt         string      comment '预售订单行',
    pre_pay_ord_amt         string      comment '预售订单金额',
    new_orders              string      comment '新客订单行',
    new_order_value         string      comment '新客订单金额',

    -- ======================== 加购相关指标字段 ========================
    dir_cart_cnt            string      comment '直接加购数',
    indir_cart_cnt          string      comment '间接加购数',
    all_cart_cnt            string      comment '总加购数',
    cart_rate               string      comment '加购率',
    cart_cost               string      comment '加购成本',
    cart_itm_cost           string      comment '加购商品成本',

    -- ======================== 转化与roi指标字段 ========================
    trans_rate              string      comment '转化率',
    roi                     string      comment '投产比',
    cpa                     string      comment '平均订单成本',

    -- ======================== 新客相关指标字段 ========================
    pay_newer_cnt           string      comment '下单新客数',
    new_customers           string      comment '新客数',
    new_customer_cost       string      comment '新客成本',

    -- ======================== 用户行为指标字段 ========================
    ad2vst_cnt              string      comment '广告访客数',
    stay_page_cnt           string      comment '访问页面数',
    avg_stay_time_len       string      comment '页面平均访问时长',
    deepth_enterslr_cnt     string      comment '深度进店数',
    flw_itm_cnt             string      comment '商品关注数',
    flw_slr_cnt             string      comment '店铺关注数',
    reserve_cnt             string      comment '预约数',
    get_ticket_cnt          string      comment '领券数',
    store_follow_cost       string      comment '店铺关注成本',
    product_follow_cost     string      comment '商品关注成本',

    -- ======================== 创意素材字段 ========================
    material_id             string      comment '素材id',
    material_name           string      comment '素材名称',
    creative_size           string      comment '创意尺寸',
    creative_width          string      comment '创意宽度',
    creative_height         string      comment '创意高度',
    img_url                 string      comment '图片url',
    img_flag                string      comment '图片标识',
    video_url               string      comment '视频url',
    land_page_url           string      comment '落地页地址',
    material_creative_type  string      comment '素材创意类型',
    ad_creative_type        string      comment 'ad创意类型',

    -- ======================== 视频播放相关指标字段 ========================
    video_views             string      comment '视频播放次数',
    valid_video_views       string      comment '视频有效播放量',
    valid_view_rate         string      comment '视频有效播放率',
    valid_view_cost         string      comment '有效播放成本',
    play_25per_vv           string      comment '25%进度播放数',
    play_50per_vv           string      comment '50%进度播放数',
    play_75per_vv           string      comment '75%进度播放数',
    play_100per_vv          string      comment '100%进度播放数',
    views_10pct             string      comment '10%进度播放数',
    views_95pct             string      comment '95%进度播放数',
    views_3s_complete       string      comment '3s播放完成量',
    views_5s_complete       string      comment '5s播放完成量',
    views_7s_complete       string      comment '7s播放完成量',
    completion_rate         string      comment '视频播完率',
    disinterest_clicks      string      comment '不感兴趣点击次数',

    -- ======================== 全站营销特有字段 ========================
    allsite_ord_amt         string      comment '全站交易额',
    allsite_ord_cnt         string      comment '全站订单行',
    allsite_ord_cost        string      comment '全站订单成本',
    allsite_fee_ratio       string      comment '全站费比',
    allsite_roi             string      comment '全站投产比',
    itm_dim                 string      comment '商品维度',

    -- ======================== 品牌合约特有字段 ========================
    order_id                string      comment '订单id',
    order_name              string      comment '订单名称',
    schedule_id             string      comment '排期id',
    schedule_name           string      comment '排期名称',
    ad_slot_id              string      comment '广告位id',
    ad_slot_name            string      comment '广告位名称',
    exp_pv                  string      comment '曝光数',
    exp_clk_cnt             string      comment '曝光点击数',
    exp_clk_rate            string      comment '曝光点击率',

    -- ======================== 直播推广特有字段 ========================
    start_time              string      comment '开始时间',
    expire_time             string      comment '到期时间',
    plan_type               string      comment '计划类型',
    market_scene            string      comment '营销场景',
    status                  string      comment '状态',
    item_sku                string      comment '商品sku',
    resource_slot           string      comment '资源位',

    -- ======================== 站内广告特有字段 ========================
    media_type              string      comment '媒体类型',
    placement               string      comment '投放位置',
    one_click_cost          string      comment '一键起量花费',

    -- ======================== 商品与业务维度字段 ========================
    old_category            string      comment '旧品类',
    old_sku_id              string      comment '旧商品id',
    sku_id                  string      comment '商品id',
    sku_name                string      comment '商品名称',
    bu                      string      comment 'bu',
    category                string      comment '品类',
    brand                   string      comment '品牌',
    product_line            string      comment '产品线',
    is_npd                  string      comment '是否新产品',
    fee_type                string      comment '费用类型',
    sku_type                string      comment 'sku类型',
    -- ======================== 业务规则控制字段 ========================
    trans_cycle             string      comment '转化周期',
    crt_or_pay              string      comment '下单订单/成交订单',
    in_no_zp                string      comment '含赠品/不含赠品',
    day_report              string      comment '分日报告',
    clk_or_crt              string      comment '点击/下单口径',
    dir_type                string      comment '定向方式',
    promote_device          string      comment '推广设备类型',

    -- ======================== 系统与技术字段 ========================
    ly_uuid                 string      comment '行标识',
    channel_id              string      comment '1级渠道id',
    channel_name            string      comment '1级渠道名称',
    platform_id             string      comment '渠道平台id',
    platform_name           string      comment '渠道平台名称',
    ea_id                   string      comment '企业id',
    ea_name                 string      comment '企业名称',
    file_id                 string      comment '系统唯一标识',
    file_name               string      comment '文件名',
    default_date            string      comment '日期',
    clk_date                string      comment '点击日期',
    clk_time                string      comment '点击时间',
    push_type               string      comment '投放类型',

    -- ======================== 六资相关字段 ========================
    liuzi_cost              string      comment '六资成本',
    liuzi_rate              string      comment '六资转化率',
    all_form_submit_cnt     string      comment '总表单提交量',

    -- ======================== 媒体口径字段 ========================
    total_orders_media      string      comment '总订单行_媒',
    total_value_media       string      comment '总订单金额_媒',
    conversion_rate_med     string      comment '转化率_媒',
    roi_media               string      comment '投产比_媒',
    avg_order_cost_med      string      comment '平均订单成本_媒',
    direct_orders_media     string      comment '直接订单行_媒',
    direct_value_media      string      comment '直接订单金额_媒',
    total_add_to_cart       string      comment '总加购数_媒',
    direct_add_to_cart      string      comment '直接加购数_媒',
    add_to_cart_cost        string      comment '加购成本_媒',

    -- ======================== 品牌合约成交口径字段 ========================
    total_order_lines_cg    string      comment '总订单行_成交口径',
    total_order_value_cg    string      comment '总订单金额_成交口径'
)
comment 'dwd层-京东推广sku明细表，整合全站营销、京东快车、直播推广、站内广告、品牌合约、智能投放、所有触点7张ods表数据'
partitioned by (
    data_source string comment '数据来源标识,一级触点',
    data_table_source string comment '数据来源标识,ods表名'
);
