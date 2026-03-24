local server_conf = {}
server_conf.server_ip = "1.1.1.1"
server_conf.gamedb = {
    host = "127.0.0.1",
    port = 27017,
    db_name = "admin",
    username = "root",
    password = "123456"
}

server_conf.logdb = {
    host = "127.0.0.1",
    port = 27017,
    db_name = "admin",
    username = "root",
    password = "123456"
}
server_conf.mysqldb = {
    host = "127.0.0.1",
    port = 3306,
    database = "dl",
    user = "test",
    password ="test"
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
