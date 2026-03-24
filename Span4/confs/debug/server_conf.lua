local server_conf = {}
server_conf.server_ip = "192.168.1.250"
server_conf.gamedb = {
    host = "10.1.1.99",
    port = 3306,
    db_name = "admin",
    username = "tlbbus",
    password = "vietnam2020"
}

server_conf.logdb = {
    host = "10.1.1.99",
    port = 3306,
    db_name = "admin",
    username = "tlbbus",
    password = "vietnam2020"
}
server_conf.mysqldb = {
    host = "10.1.1.99",
    port = 3306,
    database = "tlbb",
    user = "tlbbus",
    password ="vietnam2020"
}

server_conf.gm_tool_mqtt = {
    uri = "127.0.0.1",
    username = "test",
    password = "123456",
    clean = true
}
server_conf.MAX_COPY_SCENE = 400
server_conf.MAX_SPAN_COPY_SCENE = 10
return server_conf
