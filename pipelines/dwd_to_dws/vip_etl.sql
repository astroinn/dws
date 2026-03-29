/*
 * 唯品会 (Vipshop) DWD → DWS ETL
 *
 * 以下唯品会 DWD 字段在当前 dws_pfm_total 表中无对应列，暂不写入（默认 NULL）：
 *
 * ## 基础维度
 *  - default_date              日期          (date_id 已映射 stat_date，此字段重复)
 *  - push_site                 投放站点       (无直接对应 DWS 列)
 *
 * ## ROI 指标（非成交 ROI）
 *  - crt_ord_roi_1d            24小时下单ROI
 *  - crt_ord_roi_14d           14天下单ROI
 *
 * ## 唤起 / 端 UV 指标
 *  - evoke_uv                  唤起UV
 *  - evoke_uv_cost             唤起UV成本
 *  - evoke_pv                  唤起PV
 *  - evoke_rate                唤起率
 *  - app_uv                    APP端UV
 *  - app_uv_cost               APP端UV成本
 *  - mini_app_uv               小程序UV
 *  - mini_app_uv_cost          小程序UV成本
 *  - idp_uv                    商品详情页UV
 *  - brd_uv                    品牌UV
 *
 * ## 24小时订单/成本指标（无 DWS 对应列）
 *  - crt_byr_cnt_1d            24小时下单客户数
 *  - crt_ord_cost_1d           24小时下单成本
 *  - cart_itm_cost_1d          24小时商品加购成本 (cart_cost_1d 已映射 cart_itm_cost)
 *
 * ## 24小时商品级指标
 *  - itm_crt_byr_cnt_1d        24小时商品下单客户数
 *  - itm_crt_ord_cnt_1d        24小时商品下单量
 *  - itm_crt_ord_cost_1d       24小时商品下单成本
 *  - itm_crt_ord_amt_1d        24小时商品订单额
 *  - itm_crt_ord_roi_1d        24小时商品下单ROI
 *  - itm_pay_byr_cnt_1d        24小时商品成交客户数
 *  - itm_pay_newer_cnt_1d      24小时商品成交新客数
 *  - itm_pay_ord_cnt_1d        24小时商品成交单量
 *  - itm_pay_ord_amt_1d        24小时商品销售额
 *  - itm_pay_ord_roi_1d        24小时商品成交ROI
 *
 * ## 14天汇总指标
 *  - clt_qty_14d               14天收藏数
 *  - cart_qty_14d              14天加购数
 *  - crt_byr_cnt_14d           14天下单客户数
 *  - crt_ord_cnt_14d           14天下单量
 *  - crt_ord_cost_14d          14天下单成本
 *  - crt_ord_amt_14d           14天订单额
 *  - pay_byr_cnt_14d           14天成交客户数
 *  - pay_newer_cnt_14d         14天成交新客数
 *  - pay_ord_cnt_14d           14天成交单量
 *  - pay_ord_amt_14d           14天销售额
 *  - pay_ord_roi_14d           14天成交ROI
 *
 * ## 14天商品级指标
 *  - clt_itm_qty_14d           14天商品收藏数
 *  - cart_itm_qty_14d          14天商品加购数
 *  - itm_crt_byr_cnt_14d       14天商品下单客户数
 *  - itm_crt_ord_cnt_14d       14天商品下单量
 *  - itm_crt_ord_cost_14d      14天商品下单成本
 *  - itm_crt_ord_amt_14d       14天商品订单额
 *  - itm_crt_ord_roi_14d       14天商品下单ROI
 *  - itm_pay_byr_cnt_14d       14天商品成交客户数
 *  - itm_pay_newer_cnt_14d     14天商品成交新客数
 *  - itm_pay_ord_cnt_14d       14天商品成交单量
 *  - itm_pay_ord_amt_14d       14天商品销售额
 *  - itm_pay_ord_roi_14d       14天商品成交ROI
 *
 * ## 新客（未购）指标 — 商家维度
 *  - new_cust_24hr_order_merchant   24小时下单历史未购新客数_商家
 *  - new_cust_24hr_sale_merchant    24小时成交历史未购新客数_商家
 *  - cost_24hr_order_new_cust_m     24小时下单_历史未购新客成本_商家
 *  - cost_24hr_sale_new_cust_m      24小时成交_历史未购新客成本_商家
 *  - new_cust_14d_order_merchant    14天下单历史未购新客数_商家
 *  - new_cust_14d_sale_merchant     14天成交历史未购新客数_商家
 *  - cost_14d_order_new_cust_m      14天下单_历史未购新客成本_商家
 *  - cost_14d_sale_new_cust_m       14天成交_历史未购新客成本_商家
 *
 * ## 新客（未购）指标 — 商品维度
 *  - new_cust_24hr_order_item       24小时下单历史未购新客数_商品
 *  - new_cust_24hr_sale_item        24小时成交历史未购新客数_商品
 *  - cost_24hr_order_new_cust_i     24小时下单_历史未购新客成本_商品
 *  - cost_24hr_sale_new_cust_i      24小时成交_历史未购新客成本_商品
 *  - new_cust_14d_order_item        14天下单历史未购新客数_商品
 *  - new_cust_14d_sale_item         14天成交历史未购新客数_商品
 *  - cost_14d_order_new_cust_i      14天下单_历史未购新客成本_商品
 *  - cost_14d_sale_new_cust_i       14天成交_历史未购新客成本_商品
 *
 * ## 广告投放属性
 *  - ad_format                 广告形式
 *  - bidding_type              竞价类型
 *  - delivery_mode             投放模式
 */

INSERT INTO ${spark.var.catalog.dws}.ddm.dws_pfm_total
(
    data_source,                  -- 01. 数据来源渠道标识(如: tmall, jd, vip)
    date_id,                      -- 02. 业务日期
    platform_id,                  -- 03. 平台ID/渠道平台id
    ea_id,                        -- 04. 企业账户ID
    shop_id,                      -- 05. 店铺ID
    shop_name,                    -- 06. 店铺名称|站点名称
    channel_id,                   -- 07. 一级渠道ID
    plan_name,                    -- 08. 计划名称
    creative_name,                -- 09. 创意名称
    sku_id,                       -- 10. SKU ID
    impression_cnt,               -- 11. 展现量
    click_cnt,                    -- 12. 点击量
    click_rate,                   -- 13. 点击率
    all_cart_itm_cnt,             -- 14. 总加购数
    cart_itm_cnt,                 -- 15. 宝贝/商品加购数
    all_clt_itm_cnt,              -- 16. 总收藏/关注数
    clt_itm_cnt,                  -- 17. 宝贝收藏数
    crt_ord_cnt,                  -- 18. 拍下订单笔数
    all_pay_ord_cnt,              -- 19. 总支付订单/总订单行
    ord_plc_amt,                  -- 20. 拍下订单金额
    all_pay_ord_amt,              -- 21. 总支付/下单金额
    pay_byr_cnt,                  -- 22. 成交人数/买家数
    pay_new_user_cnt,             -- 23. 新用户支付笔数
    cost,                         -- 24. 花费/消耗
    roi,                          -- 25. 投入产出比
    impress_cpm,                  -- 26. 千次展现花费/成本
    avg_clk_cost,                 -- 27. 平均点击花费/成本
    cart_itm_cost,                -- 28. 加购商品成本
    all_pay_ord_cost,             -- 29. 总成交成本
    uuid,                         -- 30. 唯一ID/行标识
    file_id,                      -- 31. 来源文件ID/系统唯一标识
    bidding_method,               -- 32. 出价方式
    resource_slot                 -- 33. 资源位
)
SELECT
    'vip' AS data_source,         -- 01. 数据来源渠道标识(如: tmall, jd, vip)
    stat_date AS date_id,         -- 02. 业务日期
    platform_id,                  -- 03. 平台ID/渠道平台id
    ea_id,                        -- 04. 企业账户ID
    shop_id,                      -- 05. 店铺ID
    shop_name,                    -- 06. 店铺名称|站点名称
    channel_id,                   -- 07. 一级渠道ID
    plan_name,                    -- 08. 计划名称
    ad_name AS creative_name,     -- 09. 创意名称
    item_id AS sku_id,            -- 10. SKU ID
    exp_cnt AS impression_cnt,    -- 11. 展现量
    clk_cnt AS click_cnt,         -- 12. 点击量
    clk_rate AS click_rate,       -- 13. 点击率
    cart_qty_1d AS all_cart_itm_cnt,  -- 14. 总加购数
    cart_itm_qty_1d AS cart_itm_cnt,  -- 15. 宝贝/商品加购数
    clt_qty_1d AS all_clt_itm_cnt,    -- 16. 总收藏/关注数
    clt_itm_qty_1d AS clt_itm_cnt,    -- 17. 宝贝收藏数
    crt_ord_cnt_1d AS crt_ord_cnt,    -- 18. 拍下订单笔数
    pay_ord_cnt_1d AS all_pay_ord_cnt, -- 19. 总支付订单/总订单行
    crt_ord_amt_1d AS ord_plc_amt,    -- 20. 拍下订单金额
    pay_ord_amt_1d AS all_pay_ord_amt, -- 21. 总支付/下单金额
    pay_byr_cnt_1d AS pay_byr_cnt,    -- 22. 成交人数/买家数
    pay_newer_cnt_1d AS pay_new_user_cnt, -- 23. 新用户支付笔数
    cost,                         -- 24. 花费/消耗
    pay_ord_roi_1d AS roi,        -- 25. 投入产出比
    exp_cpm AS impress_cpm,       -- 26. 千次展现花费/成本
    avg_clk_price AS avg_clk_cost, -- 27. 平均点击花费/成本
    cart_cost_1d AS cart_itm_cost, -- 28. 加购商品成本
    pay_ord_cost_1d AS all_pay_ord_cost, -- 29. 总成交成本
    ly_uuid AS uuid,              -- 30. 唯一ID/行标识
    file_id,                      -- 31. 来源文件ID/系统唯一标识
    bidding_method,               -- 32. 出价方式
    push_res AS resource_slot     -- 33. 资源位
FROM ${spark.var.catalog.dwd}.ddm.dwd_vip_pfm_sku;
