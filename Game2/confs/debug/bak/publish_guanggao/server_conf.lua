local server_conf = {}
server_conf.server_ip = "127.2.160.97"
server_conf.gamedb = {
    host = "172.31.39.45",
    port = 3717,
    db_name = "admin",
    username = "tlbb-mongo-admin",
    password = "tlbb-mongo-admin-pwd"
}

server_conf.logdb = {
    host = "172.31.39.45",
    port = 3717,
    db_name = "admin",
    username = "tlbb-mongo-admin",
    password = "tlbb-mongo-admin-pwd"
}
server_conf.mysqldb = {
    host = "172.31.39.45",
    port = 3306,
    database = "tlbb",
    user = "tlbbgame",
    password = "EK0+tTEuCZJb4iJ8Fu_n"
}
server_conf.MAX_COPY_SCENE = 200
server_conf.MAX_SPAN_COPY_SCENE = 10
return server_conf