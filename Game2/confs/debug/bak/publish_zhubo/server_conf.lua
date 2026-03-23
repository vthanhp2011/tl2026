local server_conf = {}
server_conf.server_ip = "127.2.176.133"
server_conf.gamedb = {
    host = "172.20.184.17",
    port = 3717,
    db_name = "admin",
    username = "root",
    password = "eRh7ssy2dDqJdd7!j5L"
}

server_conf.logdb = {
    host = "172.20.184.17",
    port = 3717,
    db_name = "admin",
    username = "root",
    password = "eRh7ssy2dDqJdd7!j5L"
}
server_conf.mysqldb = {
    host = "172.20.68.145",
    port = 3306,
    database = "tlbb",
    user = "tlbbgame",
    password ="tBthTh6VTe0sFqy6Yr"
}

server_conf.proxy_notify = {
    host = "http://122.228.84.176:49001",
    url = "/notify/NDOSIILSDKJDKLKSccAIA"
}
server_conf.password_salt = "LgJ7Cz6y0h4fDGI&0x"
server_conf.mqtt = {
    uri = "122.228.84.176",
    username = "tl920028tl",
    password = "d8299030ttl",
    clean = true
}
server_conf.gm_tool_mqtt = {
    uri = "122.228.84.176",
    username = "tl920028tl",
    password = "d8299030ttl",
    clean = true
}
server_conf.MAX_COPY_SCENE = 400
server_conf.MAX_SPAN_COPY_SCENE = 10
return server_conf