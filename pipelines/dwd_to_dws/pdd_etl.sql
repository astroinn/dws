INSERT INTO ${spark.var.catalog.dws}.ddm.dws_pfm_total
(
    data_source,                        -- 01. 数据来源渠道标识(如: tmall, jd, pdd)
    source_id,                          -- 02. 数据源id
    date_id,                            -- 03. 业务日期
    month,                              -- 04. 月份
    channel,                            -- 05. 原表一级触点/数据来源渠道
    site_name,                          -- 06. 站点名称
    sku_id,                             -- 07. SKU ID
    sku_name,                           -- 08. SKU名称
    brand,                              -- 09. 品牌
    category,                           -- 10. 品类
    sub_category,                       -- 11. 子分类
    tier,                               -- 12. 层级
    plan_name,                          -- 13. 计划名称
    plan_type,                          -- 14. 计划类型
    plan_page_name,                     -- 15. 投放页面名称
    spending_type,                      -- 16. 支出类型
    bidding_method,                     -- 17. 出价方式
    group_name,                         -- 18. 分组
    is_delete,                          -- 19. 是否已删除
    impression_cnt,                     -- 20. 展现量
    click_cnt,                          -- 21. 点击量
    click_rate,                         -- 22. 点击率
    click_buy_rate,                     -- 23. 点击购买率
    avg_clk_cost,                       -- 24. 平均点击花费/成本
    impress_cpm,                        -- 25. 千次展现花费/成本
    cost,                               -- 26. 花费/消耗
    total_site_promotion_ratio,         -- 27. 全站推广费比
    all_pay_ord_amt,                    -- 28. 总支付/下单金额
    dir_pay_ord_amt,                    -- 29. 直接支付金额
    indir_pay_ord_amt,                  -- 30. 间接支付金额
    per_direct_transaction_amount,      -- 31. 每笔直接成交金额
    per_indirect_transaction_amount,    -- 32. 每笔间接成交金额
    all_pay_ord_cnt,                    -- 33. 总支付订单/总订单行
    dir_pay_ord_cnt,                    -- 34. 直接支付订单笔数/行
    indir_pay_ord_cnt,                  -- 35. 间接支付订单笔数/行
    per_transaction_spending,           -- 36. 每笔成交花费
    per_transaction_amount,             -- 37. 每笔成交金额
    roi,                                -- 38. 投入产出比
    net_actual_roi,                     -- 39. 净实际投产比
    net_transaction_amount,             -- 40. 净交易额
    net_transaction_count,              -- 41. 净成交笔数
    per_net_transaction_spending,       -- 42. 每笔净成交花费
    net_transaction_ratio,              -- 43. 净交易额占比
    flw_uv,                             -- 44. 粉丝关注量
    all_clt_itm_cnt,                    -- 45. 总收藏/关注数
    favorites_spending,                 -- 46. 收藏花费
    avg_favorites_spending,             -- 47. 平均收藏成本
    focus_spending,                     -- 48. 关注花费
    avg_focus_spending,                 -- 49. 平均关注成本
    inquiry_spending,                   -- 50. 询单花费
    inquiry_count,                      -- 51. 询单量
    avg_inquiry_spending,               -- 52. 平均询单成本
    file_id,                            -- 53. 来源文件ID/系统唯一标识
    file_name                           -- 54. 来源文件名
)
SELECT
    'pdd' AS data_source,               -- 01. 数据来源渠道标识(如: tmall, jd, pdd)
    source_id,                          -- 02. 数据源id
    date_id,                            -- 03. 业务日期
    month,                              -- 04. 月份
    channel_name AS channel,            -- 05. 原表一级触点/数据来源渠道
    site_name,                          -- 06. 站点名称
    sku_id,                             -- 07. SKU ID
    sku_name,                           -- 08. SKU名称
    brand,                              -- 09. 品牌
    category_name AS category,          -- 10. 品类
    sub_category,                       -- 11. 子分类
    tier,                               -- 12. 层级
    plan_name,                          -- 13. 计划名称
    plan_type,                          -- 14. 计划类型
    plan_page_name,                     -- 15. 投放页面名称
    spending_type,                      -- 16. 支出类型
    bidding_method,                     -- 17. 出价方式
    group_name,                         -- 18. 分组
    is_delete,                          -- 19. 是否已删除
    impression AS impression_cnt,       -- 20. 展现量
    click AS click_cnt,                 -- 21. 点击量
    click_rate,                         -- 22. 点击率
    click_buy_rate,                     -- 23. 点击购买率
    cpc AS avg_clk_cost,                -- 24. 平均点击花费/成本
    cpm AS impress_cpm,                 -- 25. 千次展现花费/成本
    spending AS cost,                   -- 26. 花费/消耗
    total_site_promotion_ratio,         -- 27. 全站推广费比
    gmv AS all_pay_ord_amt,             -- 28. 总支付/下单金额
    direct_transaction_amount AS dir_pay_ord_amt,       -- 29. 直接支付金额
    indirect_transaction_amount AS indir_pay_ord_amt,   -- 30. 间接支付金额
    per_direct_transaction_amount,      -- 31. 每笔直接成交金额
    per_indirect_transaction_amount,    -- 32. 每笔间接成交金额
    orders AS all_pay_ord_cnt,          -- 33. 总支付订单/总订单行
    direct_transactions_count AS dir_pay_ord_cnt,       -- 34. 直接支付订单笔数/行
    indirect_transactions_count AS indir_pay_ord_cnt,   -- 35. 间接支付订单笔数/行
    per_transaction_spending,           -- 36. 每笔成交花费
    per_transaction_amount,             -- 37. 每笔成交金额
    roi,                                -- 38. 投入产出比
    net_actual_roi,                     -- 39. 净实际投产比
    net_transaction_amount,             -- 40. 净交易额
    net_transaction_count,              -- 41. 净成交笔数
    per_net_transaction_spending,       -- 42. 每笔净成交花费
    net_transaction_ratio,              -- 43. 净交易额占比
    followers_count AS flw_uv,          -- 44. 粉丝关注量
    favorites_count AS all_clt_itm_cnt, -- 45. 总收藏/关注数
    favorites_spending,                 -- 46. 收藏花费
    avg_favorites_spending,             -- 47. 平均收藏成本
    focus_spending,                     -- 48. 关注花费
    avg_focus_spending,                 -- 49. 平均关注成本
    inquiry_spending,                   -- 50. 询单花费
    inquiry_count,                      -- 51. 询单量
    avg_inquiry_spending,               -- 52. 平均询单成本
    file_id,                            -- 53. 来源文件ID/系统唯一标识
    file_name                           -- 54. 来源文件名
FROM ${spark.var.catalog.dwd}.ddm.dwd_pdd_pfm_data;
