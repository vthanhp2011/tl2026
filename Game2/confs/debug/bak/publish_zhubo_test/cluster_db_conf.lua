return {
    ["host_conf"] =
    {
        {id = 1, localip = "127.0.0.1", ip = "127.0.0.1", domain = "127.2.195.127", desc = "主播服-游戏", netid = 1},
        --{id = 2, localip = "172.31.124.206", ip = "47.111.165.152", domain = "47.111.165.152", desc = "二区太湖仙岛", netid = 1}
    },
    ["process_conf"] =
    {
        { id = 8, hostid = 1, desc = "集群服务", group = {2}, name = "Cluster_tlbb_8"},
        { id = 9, hostid = 1, desc = "数据服务", group = {2}, name = "DataCenter_tlbb_8"},
        { id = 2, hostid = 1, desc = "游戏服务-2", group = {2}, name = "Game_tlbb_2"},
        { id = 4, hostid = 1, desc = "天外服务-4", group = {2}, name = "Span_tlbb_4"},
        { id = 6, hostid = 1, desc = "工具服务-6", group = {2}, name = "Tool_tlbb_6"},
    },
    ["server_conf"] =
    {
        {id = 8001, name = "clusterd", alias = "clusterd", processid = 8, desc = "集群服务-clusted", port = 8888, ctor_args = {}, init_args = {true}, private = true},
        {id = 8002, name = "cfgdb", alias = ".CfgDB", processid = 8, desc = "配置服务-clusted", port = 0, ctor_args = {}, init_args = {true}, private = false},

        {id = 2001, name = "clusterd", alias = "clusterd", processid = 2, desc = "游戏-clusted", port = 2528, ctor_args = {}, init_args = {true}, private = true},
        {id = 2002, name = "debug_console", alias = "debug_console", processid = 2, desc = "游戏-debug_console", port = 6002, ctor_args = {}, init_args = {}, private = true},
        {id = 2003, name = "dbproxy", alias = ".db", processid = 2, desc = "世界数据源", port = 0, ctor_args = {}, init_args = { "gamedb", "world_10" }, private = true},
        {id = 2004, name = "dbproxy", alias = ".char_db", processid = 2, desc = "角色数据源", port = 0, ctor_args = {}, init_args = { "gamedb", "tlbb" }, private = true},
        {id = 2005, name = "dbproxy", alias = ".logdb", processid = 2, desc = "角色数据源", port = 0, ctor_args = {}, init_args = { "logdb", "tlbb_log" }, private = true},
        {id = 2006, name = "gen_serial", alias = ".gen_serial", processid = 2, desc = "物品GUID生成", port = 0, ctor_args = {}, init_args = { 10 }, private = true},
        {id = 2007, name = "agent_poll", alias = ".agent_poll", processid = 2, desc = "agent池", port = 0, ctor_args = {}, init_args = { true }, private = true},
        {id = 2008, name = "world", alias = ".world", processid = 2, desc = "游戏世界", port = 0, ctor_args = {}, init_args = { {server_id = 10} }, private = false},
        {id = 2009, name = "guildmanager", alias = ".Guildmanager", processid = 2, desc = "帮会管理", port = 0, ctor_args = {}, init_args = {true}, private = false},
        {id = 2010, name = "scenemanager", alias = ".SceneManager", processid = 2, desc = "场景管理服", port = 0, ctor_args = {}, init_args = { { world_id = 10} }, private = false},
        {id = 2011, name = "playermanager", alias = ".Playermanager", processid = 2, desc = "角色管理", port = 0, ctor_args = {}, init_args = {true}, private = false},
        {id = 2012, name = "copyscenemanager", alias = ".Copyscenemanager", processid = 2, desc = "副本场景管理", port = 0, ctor_args = {}, init_args = {{ world_id = 10}}, private = false},
        {id = 2013, name = "activity", alias = ".Activitymanager", processid = 2, desc = "活动管理", port = 0, ctor_args = {}, init_args = {true}, private = false},
        {id = 2014, name = "ybexchange", alias = ".Ybexchange", processid = 2, desc = "元宝交易所", port = 0, ctor_args = {}, init_args = {true}, private = false},
        {id = 2015, name = "dynamicscenemanager", alias = ".Dynamicscenemanager", processid = 2, desc = "动态场景管理", port = 0, ctor_args = {}, init_args = {{ world_id = 10}}, private = false},
        {id = 2016, name = "clusteragentproxy", alias = ".clusteragentproxy", processid = 2, desc = "集群玩家agent代理", port = 0, ctor_args = {}, init_args = {true}, private = false},
        {id = 2017, name = "gamed", alias = ".gamed", processid = 2, desc = "游戏服", port = 3731, ctor_args = {}, init_args = {{address = "0.0.0.0", maxclient = 4096, nodelay = true, server_id = 10}}, private = false},
        {id = 2018, name = "logind", alias = ".logind", processid = 2, desc = "登录服", port = 3733, ctor_args = {}, init_args = {{address = "0.0.0.0", maxclient = 1024, nodelay = true, server_id = 10}}, private = false},

        {id = 4001, name = "clusterd", alias = "clusterd", processid = 4, desc = "游戏-clusted", port = 2530, ctor_args = {}, init_args = {true}, private = true},
        {id = 4002, name = "debug_console", alias = "debug_console", processid = 4, desc = "游戏-debug_console", port = 6004, ctor_args = {}, init_args = {}, private = true},
        {id = 4003, name = "dbproxy", alias = ".db", processid = 4, desc = "世界数据源", port = 0, ctor_args = {}, init_args = { "gamedb", "world_10" }, private = true},
        {id = 4004, name = "dbproxy", alias = ".logdb", processid = 4, desc = "角色数据源", port = 0, ctor_args = {}, init_args = { "logdb", "tlbb_log" }, private = true},
        {id = 4005, name = "gen_serial", alias = ".gen_serial", processid = 4, desc = "物品GUID生成", port = 0, ctor_args = {}, init_args = { 8 }, private = true},
        {id = 4006, name = "spanscene", alias = ".SCENE_1297", processid = 4, desc = "天外-长春谷·不老殿", port = 0, ctor_args = {}, init_args = {{ id = 1297, world_id = 8 }}, private = false},
        {id = 4007, name = "spanscene", alias = ".SCENE_1298", processid = 4, desc = "天外-藏经阁", port = 0, ctor_args = {}, init_args = {{ id = 1298, world_id = 8 }}, private = false},
        {id = 4008, name = "spanscene", alias = ".SCENE_1299", processid = 4, desc = "天外-地宫4", port = 0, ctor_args = {}, init_args = {{ id = 1299, world_id = 8 }}, private = false},
        {id = 4009, name = "spancopyscenemanager", alias = ".Copyscenemanager", processid = 4, desc = "天外-副本场景管理", port = 0, ctor_args = {}, init_args = {{ world_id = 8}}, private = false},

        {id = 6001, name = "clusterd", alias = "clusterd", processid = 6, desc = "工具服务-clusted", port = 2532, ctor_args = {}, init_args = {true}, private = true},
        {id = 6002, name = "debug_console", alias = "debug_console", processid = 6, desc = "工具服务-debug_console", port = 6006, ctor_args = {}, init_args = {}, private = true},
        {id = 6003, name = "dbproxy", alias = ".char_db", processid = 6, desc = "角色数据源", port = 0, ctor_args = {}, init_args = {  "gamedb", "tlbb"  }, private = true},
        {id = 6004, name = "dbproxy", alias = ".admin_db", processid = 6, desc = "web管理", port = 0, ctor_args = {}, init_args = {  "gamedb", "web_admin"  }, private = true},
        {id = 6005, name = "register", alias = ".register", processid = 6, desc = "注册服务", port = 13010, ctor_args = {}, init_args = {true}, private = false},
        {id = 6006, name = "pay", alias = ".pay", processid = 6, desc = "订单服务", port = 13011, ctor_args = {}, init_args = {}, private = false},
        {id = 6007, name = "payend", alias = ".payend", processid = 6, desc = "支付回调服务", port = 13012, ctor_args = {}, init_args = {}, private = false},
        {id = 6008, name = "mysqldb", alias = ".mysqldb", processid = 6, desc = "mysql数据库服务", port = 0, ctor_args = {}, init_args = {true}, private = false},
        {id = 6009, name = "web", alias = ".web", processid = 6, desc = "mysql数据库服务", port = 0, ctor_args = {}, init_args = {{ protocol = 'http',port = 8000}}, private = false},
        {id = 6010, name = "ranking", alias = ".ranking", processid = 6, desc = "排行榜服务", port = 0, ctor_args = {}, init_args = {true}, private = false},
        {id = 6011, name = "dbproxy", alias = ".logdb", processid = 6, desc = "日志库", port = 0, ctor_args = {}, init_args = { "logdb", "tlbb_log" }, private = true},
        {id = 6012, name = "monitor", alias = ".monitor", processid = 6, desc = "游戏监控", port = 0, ctor_args = {}, init_args = {true}, private = false},
        {id = 6013, name = "textfilter_mgr", alias = ".textfilter", processid = 6, desc = "敏感词", port = 0, ctor_args = {}, init_args = {}, private = false},
        {id = 6014, name = "hs_admin", alias = ".hs_admin", processid = 6, desc = "admin服务", port = 13013, ctor_args = {}, init_args = {true}, private = false},

        {id = 9001, name = "clusterd", alias = "clusterd", processid = 9, desc = "数据中心-clusted", port = 2531, ctor_args = {}, init_args = {true}, private = true},
        {id = 9002, name = "debug_console", alias = "debug_console", processid = 9, desc = "数据中心-debug_console", port = 6009, ctor_args = {}, init_args = {}, private = true},
        {id = 9003, name = "clusterdatacenterd", alias = ".CDATACENTERD", processid = 9, desc = "数据中心服务", port = 0, ctor_args = {}, init_args = {}, private = false},

    }
}