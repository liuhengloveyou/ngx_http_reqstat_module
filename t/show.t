use Test::Nginx::Socket 'no_plan';

run_tests();

__DATA__
=== TEST 1: testing req_status_show
--- http_config
req_status_zone server "$host,$server_addr:$server_port" 10M;
--- config
req_status server;
location /t {
    req_status_show;
}
location /test {
    content_by_lua_block {ngx.say("hi")}
}
--- request eval
["GET /test", "GET /t"]
--- response_body eval
["hi\n", "localhost,127.0.0.1:1984,0,0,1,1,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0\n"]
