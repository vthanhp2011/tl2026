local server_conf = {}
server_conf.server_ip = "103.36.62.50"
server_conf.gamedb = {
    host = "192.168.35.237",
    port = 27017,
    db_name = "admin",
    username = "root",
    password = "4L1jwpRuqmdy@gnB"
}

server_conf.logdb = {
    host = "192.168.35.237",
    port = 27017,
    db_name = "admin",
    username = "root",
    password = "4L1jwpRuqmdy@gnB"
}
server_conf.mysqldb = {
    host = "47.100.141.226",
    port = 3306,
    database = "cwwebpay",
    user = "testdb",
    password ="Db@mysql"
}
server_conf.proxy_notify = {
    host = "http://127.0.0.0.11:49101",
    url = "/notify/NDOSIILSDKJDKLKSccAIA"
}

server_conf.gm_tool_mqtt = {
    uri = "192.168.35.237",
    username = "tlmqtt",
    password = "tlmqtt",
    clean = true
}
server_conf.MAX_COPY_SCENE = 400
server_conf.MAX_SPAN_COPY_SCENE = 10
return server_conf