return {
    MANAGER_NODE = {
        name = "manager_tlbb_8",
        constr = "172.20.68.146:8888",
        servers = {
            {name = "cluster_mgr", alias = ".cluster_mgr"},
            {name = "cluster_db_mgr", alias = ".cluster_db_mgr"},
            {name = "cfgdb", alias = ".CfgDB"}
        }
    }
}
