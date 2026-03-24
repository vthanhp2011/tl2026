LUA_CLIB_PATH ?= luaclib
CSERVICE_PATH ?= cservice

SKYNET_INC = framework/skynet-src
LUA_INC = framework/3rd/lua

# ================== FLAGS FIX HOÀN TOÀN WARNING ==================
CFLAGS = -g -O0 -Wall -fPIC --shared \
         -Wno-unused-function -Wno-tautological-compare -Wno-unused-variable \
         -Wno-overflow -Wno-parentheses -Wno-memset-elt-size

CXXFLAGS = -g -fpermissive -std=c++17 -Wall -fPIC --shared \
           -Wno-write-strings -Wno-return-type -Wno-format-overflow \
           -Wno-tautological-compare -Wno-unused-variable -Wno-parentheses \
           -Wno-overflow -Wno-reorder -Wno-memset-elt-size \
           -Wno-unused-value -Wno-sign-compare

LUA_CLIB = netpack gbk map ldump laiscript lprofile lfs rax

all : $(foreach v, $(LUA_CLIB), $(LUA_CLIB_PATH)/$(v).so)

$(LUA_CLIB_PATH)/netpack.so : lualib-src/lua-netpack.c | $(LUA_CLIB_PATH)
	$(CC) $(CFLAGS) -I$(LUA_INC) -I$(SKYNET_INC) $< -o $@

$(LUA_CLIB_PATH)/gbk.so : lualib-src/gbk/lgbk.c | $(LUA_CLIB_PATH)
	$(CC) $(CFLAGS) -I$(LUA_INC) -I$(SKYNET_INC) $< -o $@

$(LUA_CLIB_PATH)/map.so : lualib-src/map/lmap.cc lualib-src/map/Map.cc lualib-src/map/PathFinder.cc | $(LUA_CLIB_PATH)
	$(CXX) $(CXXFLAGS) -I$(LUA_INC) -I$(SKYNET_INC) $^ -o $@

$(LUA_CLIB_PATH)/ldump.so : lualib-src/ldump.c | $(LUA_CLIB_PATH)
	$(CC) $(CFLAGS) -I$(LUA_INC) -I$(SKYNET_INC) $< -o $@

$(LUA_CLIB_PATH)/laiscript.so : lualib-src/laiscript.cc lualib-src/ai/AIBridge.cpp lualib-src/ai/AIScript.cpp lualib-src/ai/AIScriptFunction.cpp lualib-src/ai/Ini.cpp | $(LUA_CLIB_PATH)
	$(CXX) $(CXXFLAGS) -I$(LUA_INC) -I$(SKYNET_INC) -Ilualib-src/sol $^ -o $@

$(LUA_CLIB_PATH)/lprofile.so : lualib-src/profile/icallpath.c lualib-src/profile/imap.c lualib-src/profile/profile.c | $(LUA_CLIB_PATH)
	$(CC) $(CFLAGS) -I$(LUA_INC) -I$(SKYNET_INC) -DUSE_RDTSC $^ -o $@

$(LUA_CLIB_PATH)/lfs.so : lualib-src/lfs/lfs.c | $(LUA_CLIB_PATH)
	$(CC) $(CFLAGS) -I$(LUA_INC) -I$(SKYNET_INC) $< -o $@

$(LUA_CLIB_PATH)/rax.so : lualib-src/rax/lua_rax.c lualib-src/rax/rax.c | $(LUA_CLIB_PATH)
	$(CC) $(CFLAGS) -I$(LUA_INC) -I$(SKYNET_INC) $^ -o $@

$(LUA_CLIB_PATH) :
	mkdir -p $(LUA_CLIB_PATH)

clean :
	rm -f $(LUA_CLIB_PATH)/*.so
	