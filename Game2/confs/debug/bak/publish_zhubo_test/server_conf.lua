local server_conf = {}
server_conf.server_ip = "116.62.128.124"
server_conf.gamedb = {
    host = "127.0.0.1",
    port = 27017,
    db_name = "admin",
    username = "tlbb-mongo-admin",
    password = "tlbb-mongo-admin-pwd"
}

server_conf.logdb = {
    host = "127.0.0.1",
    port = 27017,
    db_name = "admin",
    username = "tlbb-mongo-admin",
    password = "tlbb-mongo-admin-pwd"
}
server_conf.mysqldb = {
    host = "127.0.0.1",
    port = 3306,
    database = "tlbb",
    user = "tlbbgame",
    password = "tBthTh6VTe0sFqy6Yr"
}
server_conf.MAX_COPY_SCENE = 400
server_conf.MAX_SPAN_COPY_SCENE = 10
return server_conf