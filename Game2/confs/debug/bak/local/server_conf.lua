local server_conf = {}

server_conf.server_ip = "127.0.0.1"
server_conf.MAX_COPY_SCENE = 1
server_conf.MAX_SPAN_COPY_SCENE = 1
server_conf.gamedb = {
    host = "localhost",
    port = 27017,
    db_name = "admin",
    username = "tlbb-mongo-admin",
    password = "tlbb-mongo-admin-pwd"
}

server_conf.logdb = {
    host = "localhost",
    port = 27017,
    db_name = "admin",
    username = "tlbb-mongo-admin",
    password = "tlbb-mongo-admin-pwd"
}
server_conf.mysqldb = {
    host = "127.0.0.1",
    port = 3306,
    database = "tlbb",
    user = "root",
    password = "tlbb_mysql_password_231117"
}
server_conf.mqtt = {
    uri = "122.228.84.176",
    username = "tl920028tl",
    password = "d8299030ttl",
    clean = true
}

return server_conf