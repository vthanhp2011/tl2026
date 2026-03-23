local gbk = require "gbk"
--local crypt = require "skynet.crypt"
local define = require "define"
local iostream = require "iostream"
local bistream = iostream.bistream
local bostream = iostream.bostream

local packet = {}
packet.INVAILD_XYID = 0
packet.XYID_CG_CONNECT = 656
packet.XYID_GC_CONNECT = 643
packet.XYID_KEY_EXCHANGE = 67
packet.XYID_GC_USEGEMRESULT = 794
packet.XYID_GC_REMOVEGEMRESULT = 384
packet.XYID_GC_TEAM_ERROR = 229
packet.XYID_GC_MSG_BALL = 624
packet.XYID_CG_RONGYU = 889
packet.XYID_CG_LOG_SUBMIT = 26
packet.XYID_CG_CTU_GABRIEL_CMD_RET = 846
--packet.XYID_CG_ASK_CHANGE_SCENE = 12
packet.XYID_CG_LOCK_TARGET = 115
packet.XYID_CG_ChAR_ASK_BASE_ATTR_IB = 154
packet.XYID_CG_ChAR_ASK_IMPACT_LIST = 659
packet.XYID_CG_CHAR_POSITION_WARP = 557
packet.XYID_CG_CHAR_MOOD_STATE = 795
packet.XYID_CG_CHANGE_PK_MODE_REQ = 157
packet.XYID_CG_ANTAGONIS_REQ = 622
packet.XYID_CG_CHARMOVE = 561
packet.XYID_CG_CHARJUMP = 642
packet.XYID_CG_CHARASKEQUIPMENT = 802
packet.XYID_CG_CHARUSESKILL = 153
packet.XYID_CG_USEABILITY = 239
packet.XYID_CG_CHARFLY = 672
packet.XYID_CG_CHARDEFAULTEVENT = 773
packet.XYID_CG_CHAT = 690
packet.XYID_GC_CHAT = 148
packet.XYID_CG_ENTER_SCENE = 21
packet.XYID_GC_ENTER_SCENE = 88
packet.XYID_CG_ASK_DYNAMIC_REGION = 892
packet.XYID_GC_ASK_DYNAMIC_REGION_RESULT = 893
packet.XYID_CG_SHOP_CLOSE = 409
packet.XYID_CG_EXECUTE_SCRIPT = 66
packet.XYID_GC_NEW_MONSTER = 321
packet.XYID_GC_NEW_PLAYER = 33
packet.XYID_GC_CHAT_DECRYPTION = 1025
packet.XYID_GC_UI_COMMAND = 176
packet.XYID_GC_NOTIFY_MAIL = 633
packet.XYID_WGC_CTU_GABRIEL_COMMOND = 845
packet.XYID_GC_CHAR_BASE_ATTRIB = 756
packet.XYID_CG_ENV_REQUEST = 3
packet.XYID_CG_ASK_DETAIL_ABILITY_INFO = 303
packet.XYID_CG_WUHUN_WG = 896
packet.XYID_CG_ASK_DETAIL_SKILL_LIST = 447
packet.XYID_CG_AUTO_CREATE_TEAM = 1011
packet.XYID_CG_CITY_ASK_ATTR = 126
packet.XYID_CG_CHAR_ALL_TITLES = 487
packet.XYID_CG_GUILD = 204
packet.XYID_CG_MAC_NOTIFY = 594
packet.XYID_CG_MS_SHOP_BUY_INFO_REQ = 860
packet.XYID_CG_MINOR_PASSWD = 139
packet.XYID_CG_ASK_DETAIL_EQUIP_LIST = 89
packet.XYID_CG_ASK_MY_BAG_SIZE = 23
packet.XYID_CG_ASK_MISSION_LIST = 371
packet.XYID_CG_ASK_SETTING = 719
packet.XYID_CG_FRIEND_GROUP_NAME = 1024
packet.XYID_CG_BANK_MONEY = 95
packet.XYID_CG_ASK_MAIL = 386
packet.XYID_CG_MAIL = 414
packet.XYID_CGW_ASK_ALADDIN_TOKEN = 971
packet.XYID_CG_STOP_PEDDING = 397
packet.XYID_CG_LOGIN_ACC = 778
packet.XYID_GC_CHAR_IMPACT_LIST_UPDATE = 138
packet.XYID_GC_WORLD_TIME = 277
packet.XYID_GC_RMB_CHAT_FACE_INFO = 679
packet.XYID_GC_DOUBLE_EXP_INFO = 675
packet.XYID_GC_JVQING_POINT = 689
packet.XYID_GC_DETAIL_ATTRIB = 320
packet.XYID_GC_COLL_DOWN_UPDATE = 584
packet.XYID_GC_DETAIL_ABILITY_INFO = 553
packet.XYID_GC_DETAIL_XINFA_LIST = 429
packet.XYID_GC_DETAIL_XIULIAN_LIST = 655
packet.XYID_GC_SEC_DETAIL = 981
packet.XYID_GC_WUHUN_WG = 897
packet.XYID_GC_DETAIL_SKILL_LIST = 314
packet.XYID_GC_CHAR_ALL_TITLES = 237
packet.XYID_GC_MS_SHOP_BUY_INFO = 861
packet.XYID_GC_DIGONG_SHOP_INFO = 965
packet.XYID_GC_ASK_FASHION_DEPOT_DATA = 1028
packet.XYID_GC_ASK_SERVER_TIME = 334
packet.XYID_GC_MINOR_PASSWD = 242
packet.XYID_GC_DETAIL_EQUIP_LIST = 772
packet.XYID_GC_BAG_SIZE_CHANGE = 697
packet.XYID_GC_MY_BAG_LIST = 340
packet.XYID_GC_MISSION_LIST = 464
packet.XYID_GC_RET_SETTING = 40
packet.XYID_GC_RELATION = 434
packet.XYID_GC_GROUPING_NAME_RET = 636
packet.XYID_GC_BANK_MONEY = 428
packet.XYID_GC_OPEN_WORLD_REFERENCE = 513
packet.XYID_GC_RET_GS_CHIT_CGAT_INFO = 1077
packet.XYID_GC_STOP_PEDDING = 443
packet.XYID_GC_MISSION_MODIFY = 473
packet.XYID_GC_EXTERIOR_INFO = 982
packet.XYID_CG_ASK_SERVER_TIME = 104
packet.XYID_GC_LEVEL_UP_LOCK = 1072
packet.XYID_GC_VIRTUAL_NPC_INFO = 1049
packet.XYID_GC_DETAIL_ATTRIB_PET = 281
packet.XYID_GC_NEW_PLAYER_MOVE = 247
packet.XYID_GC_DEL_OBJECT = 144
packet.XYID_CG_ASK_DOUBLE_EXP = 709
packet.XYID_CG_ASK_JVQING_POINT = 555
packet.XYID_CG_ASK_DETAIL_ATTRIB = 251
packet.XYID_CG_ASK_DETAIL_XINFA_LIST = 191
packet.XYID_CG_ASK_TEAM_INFO = 421
packet.XYID_GC_CHEDIFULU_DATA = 1091
packet.XYID_CG_MAC_NOTIFY = 595
packet.XYID_CG_EXTERIOR_REQUEST = 983
packet.XYID_CG_ASK_FASHION_DEPOT_DATA = 1029
packet.XYID_CG_ASK_MY_BAG_LIST = 729
packet.XYID_CG_RELATION = 415
packet.XYID_CG_ASK_GS_CHIT_CHAT_INFO = 1076
packet.XYID_CG_CHAR_EQUIPMENT = 639
packet.XYID_UNKNOW_440 = 1088
packet.XYID_GC_TEAM_LIST = 564
packet.XYID_WGC_AlADDIN_TOKEN = 972
packet.XYID_GC_RET_NET_DELAY = 252
packet.XYID_GC_CTU_GABRIEL_CMD_RET = 846
packet.XYID_GC_CHAR_STOP_LOGIC = 336
packet.XYID_CG_MODIFY_SETTING = 676
packet.XYID_GC_NEW_PET_MOVE = 63
packet.XYID_GC_RET_ASK_QUIT = 29
packet.XYID_CG_ASK_QUIT = 623
packet.XYID_CG_NET_DELAY = 304
packet.XYID_CG_UNKNOW_0431 = 1073
packet.XYID_CG_HEART_BEAT = 378
packet.XYID_GC_DETAIL_IMPACT_LIST_UPDATE = 416
packet.XYID_GC_UNKNOW_1093 = 1093
packet.XYID_GC_NEW_PET = 348
packet.XYID_GC_SHOW_MONSTER_TAPS = 1105
packet.XYID_CG_PACKAGE_SWAP_ITEM = 784
packet.XYID_GC_PACKAGE_SWAP_ITEM = 423
packet.XYID_CG_ASK_ITEM_INFO = 210
packet.XYID_GC_ITEM_INFO = 732
packet.XYID_CG_USE_EQUIP = 630
packet.XYID_GC_USE_EQUIP_RESULT = 610
packet.XYID_CG_UN_EQUIP = 267
packet.XYID_GC_UN_EQUIP_RESULT = 165
packet.XYID_CG_PACKUP_PACKET = 195
packet.XYID_GC_PACKUP_PACKET = 61
packet.XYID_CG_USE_ITEM = 221
packet.XYID_GC_USE_ITEM_RESULT = 248
packet.XYID_GC_SCRIPT_COMMAND = 765
packet.XYID_CG_SHOW_FASHION_DEPOT_DATA = 1032
--packet.XYID_GC_SHOW_FASHION_DEPOT_DATA = 1031
packet.XYID_CG_EVENT_REQUEST = 224
packet.XYID_GC_NOTIFY_CHANGE_SCENE = 287
packet.XYID_CG_ASK_CHANGE_SCENE = 107
packet.XYID_GC_RET_CHANGE_SCENE = 515
packet.XYID_GC_CHAR_SKILL_GATHER = 335
packet.XYID_GC_CHAR_SKILL_SEND = 298
packet.XYID_GC_CHAR_BUFF = 32
packet.XYID_GC_CHAR_DETAIL_BUFF = 363
packet.XYID_GC_TARGET_LIST_AND_HIT_FLAGS = 496
packet.XYID_GC_CHAR_MOVE_RESULT = 360
packet.XYID_GC_DETAIL_HEALS_AND_DAMAGES = 739
packet.XYID_GC_CHAR_DIRECT_IMPACT = 611
packet.XYID_GC_CHAR_SKILL_MISSED = 71
packet.XYID_GC_NEW_ITEM_BOX = 550
packet.XYID_GC_FASHION_DEPOT_OPERATION = 1030
packet.XYID_GC_DETAIL_EXP = 482
packet.XYID_GC_CHAR_STOP_ACTION = 279
packet.XYID_CG_OPEN_ITEM_BOX = 52
packet.XYID_GC_ITEM_BOX_LIST = 163
packet.XYID_GC_PICK_RESULT = 558
packet.XYID_CG_PICK_BOX_ITEM = 172
packet.XYID_GC_NEW_MONSTER_MOVE = 6
packet.XYID_GC_CHAR_MOVE = 86
packet.XYID_GC_OBJECT_TELEPORT = 297
packet.XYID_CG_DISPEL_BUFF_REQ = 2
packet.XYID_GC_LEVEL_UP_RESULT = 356
packet.XYID_GC_LEVEL_UP = 431
packet.XYID_GC_ARRIVE = 790
packet.XYID_GC_OPERATE_RESULT = 663
packet.XYID_GC_XINFA_STUDY_INFO = 119
packet.XYID_CG_ASK_STUDY_XINFA = 803
packet.XYID_GC_STUDY_XINFA = 455
packet.XYID_GC_ADD_SKILL = 556
packet.XYID_CG_REQ_LEVEL_UP = 602
packet.XYID_GC_CHAR_SKILL_LEAD = 720
packet.XYID_GC_SHOP_MERCHANDISE_LIST = 412
packet.XYID_GC_SHOP_SOLD_LIST = 275
packet.XYID_CG_SHOP_BUY = 563
packet.XYID_GC_SHOP_BUY = 585
packet.XYID_GC_NOTIFY_EQUIP = 131
packet.XYID_CG_USE_GEM = 393
packet.XYID_CG_REMOVE_GEM = 168
packet.XYID_CG_GEM_COMPOUND = 725
packet.XYID_CG_DISPLACE_GEM = 856
packet.XYID_GC_ABILITY_LEVEL = 760
packet.XYID_GC_PRESCRIPTION = 703
packet.XYID_GC_ABILITY_RESULT = 533
packet.XYID_GC_ABILITY_ACTION = 812
packet.XYID_GC_ABILITY_SUCC = 70
packet.XYID_CG_SPLIT_ITEM = 453
packet.XYID_GC_SPLIT_ITEM_RESULT = 174
packet.XYID_CG_TEAM_INVITE = 64
packet.XYID_CG_DISCARD_ITEM = 291
packet.XYID_CG_DISCARD_ITEM_RESULT = 701
packet.XYID_CG_TEAM_DISMISS = 151
packet.XYID_GC_TEAM_RESULT = 793
packet.XYID_GC_TEAM_ASK_INVITE = 456
packet.XYID_CG_TEAM_RET_INVITE = 127
packet.XYID_CG_ASK_TEAM_MEMBER_INFO = 696
packet.XYID_GC_TEAM_MEMBER_INFO = 90
packet.XYID_CG_TEAM_LEAVE = 580
packet.XYID_GC_BANK_BEGIN = 266
packet.XYID_CG_BANK_ACQUIRE_LIST = 205
packet.XYID_GC_BANK_ACQUIRE_LIST = 238
packet.XYID_GC_BANK_INFO = 460
packet.XYID_CG_BANK_SWAP_ITEM = 467
packet.XYID_GC_BANK_SWAP_ITEM = 99
packet.XYID_CG_BANK_ADD_ITEM = 692
packet.XYID_GC_BANK_ADD_ITEM = 647
packet.XYID_CG_BANK_REMOVE_ITEM = 109
packet.XYID_GC_BANK_REMOVE_ITEM = 538
packet.XYID_CG_PACK_UP_BANK = 862
packet.XYID_GC_PACK_UP_BANK = 863
packet.XYID_GC_PlAYER_DIE = 445
packet.XYID_CG_PlAYER_DIE_RESULT = 628
packet.XYID_GC_PlAYER_RELIVE = 472
packet.XYID_CG_PET_BANK_ADD_PET = 961
packet.XYID_GC_PET_BANK_ADD_PET = 962
packet.XYID_GC_PET_BANK_LIST_UPDATA = 963
packet.XYID_GC_PACKET_STREAM = 387
packet.XYID_CG_SHOP_SELL = 22
packet.XYID_GC_SHOP_SELL = 232
packet.XYID_CG_REQ_MANUAL_ATTR = 20
packet.XYID_GC_MANUAL_ATTR_RESULT = 235
packet.XYID_GC_CHAR_FLY = 741
packet.XYID_CG_FASHION_DEPOT_OPERATION = 1031
packet.XYID_CG_MANIPULATE_PET = 449
packet.XYID_GC_MANIPULATE_PET_RET = 50
packet.XYID_CG_SET_PET_ATTRIB = 227
packet.XYID_GC_REMOVE_PET = 730
packet.XYID_GC_DARK_RESULT = 706
packet.XYID_GC_REFRESH_DARK_SKILL = 1012
packet.XYID_CG_ASK_DARK_ADJUST = 646
packet.XYID_CG_PET_USE_EQUIP = 491
packet.XYID_GC_PET_USE_EQUIP_RESULT = 528
packet.XYID_CG_PET_UN_EQUIP = 328
packet.XYID_GC_PET_UN_EQUIP_RESULT = 309
packet.XYID_CG_MISSION_SUBMIT = 180
packet.XYID_GC_COMB_SKILL_OPERATION = 1092
packet.XYID_GC_SPECIAL_OBJ_ACT_NOW = 530
packet.XYID_GC_NEW_SPECIAL = 135
packet.XYID_GC_SPECIAL_OBJ_FADE_OUT = 25
packet.XYID_GC_CHAR_JUMP = 383
packet.XYID_CG_KFS_OPERATE = 396
packet.XYID_GC_REFRESH_KFS_SKILL = 1014
packet.XYID_CG_ASK_PRIVATE_INFO = 306
packet.XYID_GC_PRIVATE_INFO = 809
packet.XYID_CG_FINGER = 579
packet.XYID_GC_FINGER = 286
packet.XYID_GC_PET_SOUL_XI_SHU_XING = 1039
packet.XYID_CG_PET_SOUL_XI_SHU_XING = 1048
packet.XYID_CG_LOOK_UP_OTHER = 197
packet.XYID_GC_LOOK_UP_OTHER = 418
packet.XYID_GC_CHAR_CHARGE = 712
packet.XYID_CG_CHALLENGE = 209
packet.XYID_GC_GAME_COMMOND = 137
packet.XYID_CG_STALL_APPLY = 666
packet.XYID_GC_STALL_APPLY = 806
packet.XYID_CG_STALL_ESTABLISH = 222
packet.XYID_GC_STALL_ESTABLISH = 436
packet.XYID_CG_STALL_OPEN = 290
packet.XYID_CG_STALL_ADD_ITEM = 186
packet.XYID_GC_STALL_ADD_ITEM = 75
packet.XYID_GC_STALL_OPEN = 459
packet.XYID_CG_STALL_ITEM_PRICE = 495
packet.XYID_GC_STALL_ITEM_PRICE = 664
packet.XYID_CG_STALL_REMOVE_ITEM = 757
packet.XYID_GC_STALL_REMOVE_ITEM = 156
packet.XYID_CG_STALL_CLOSE = 347
packet.XYID_GC_STALL_CLOSE = 713
packet.XYID_CG_STALL_BUY = 792
packet.XYID_GC_STALL_BUY = 799
packet.XYID_CG_STALL_SHOP_NAME = 11
packet.XYID_CG_BBS_APPLY = 56
packet.XYID_GC_BBS_MESSSAGES = 724
packet.XYID_CG_BBS_SYCH_MESSAGE = 4
packet.XYID_GC_STALL_ERROR = 574
packet.XYID_CG_MISSION_ABANDON = 510
packet.XYID_GC_MISSION_REMOVE = 190
packet.XYID_CG_MISSION_ACCEPT = 575
packet.XYID_GC_MISSION_ADD = 708
packet.XYID_CG_MISSION_CONTINUE = 373
packet.XYID_GC_MAIL = 273
packet.XYID_CG_REMOVE_DRESS_GEM = 189
packet.XYID_GC_GUILD_APPLY = 177
packet.XYID_CG_GUILD_APPLY = 813
packet.XYID_GC_GUILD_RETURN = 604
packet.XYID_GC_GUILD = 9
packet.XYID_CG_GUILD_JOIN = 110
packet.XYID_CG_CGW_PACKET = 508
packet.XYID_GC_NEW_PLATFORM = 175
packet.XYID_GC_REFRESH_SUPER_ATTR = 1013
packet.XYID_GC_CHAR_MODIFY_ACTION = 134
packet.XYID_CG_MISSION_CHECK = 183
packet.XYID_CG_ASK_TEAM_FOLLOW = 502
packet.XYID_GC_RETURN_TEAM_FOLLOW = 346
packet.XYID_GC_ASK_TEAM_FOLLOW = 179
packet.XYID_CG_STOP_TEAM_FOLLOW = 100
packet.XYID_GC_TEAM_FOLLOW_LIST = 547
packet.XYID_CG_RETURN_TEAM_FOLLOW = 196
packet.XYID_GC_TEAM_FOLLOW_ERR = 480
packet.XYID_CG_TEAM_KICK = 97
packet.XYID_CG_TEAM_APPLY = 488
packet.XYID_CG_TEAM_RET_APPLY = 559
packet.XYID_CG_TEAM_LEADER_RET_APPLY = 200
packet.XYID_GC_TEAM_ASK_APPLY = 644
packet.XYID_CG_TEAM_APPOINT = 30
packet.XYID_CG_EXCHANGE_APPLY_I = 125
packet.XYID_GC_EXCHANGE_ERROR = 463
packet.XYID_GC_EXCHANGE_APPLY_I = 69
packet.XYID_GC_EXCHANGE_ESTABLISH_I = 665
packet.XYID_GC_EXCHANGE_NOTIFY_SERIAL = 682
packet.XYID_GC_EXCHANGE_REPLY_I = 292
packet.XYID_CG_EXCHANGE_SYNC_ITEM_II = 268
packet.XYID_CG_EXCHANGE_CANCEL = 420
packet.XYID_CG_EXCHANGE_SYNCH_LOCK = 613
packet.XYID_CG_EXCHANGE_OK_III = 783
packet.XYID_CG_EXCHANGE_SYNC_MONEY_II = 791
packet.XYID_GC_EXCHANGE_SYNCH_LOCK = 788
packet.XYID_GC_EXCHANGE_SYNCH_CONFIRM_II = 714
packet.XYID_GC_EXCHANGE_SUCCESS_III = 390
packet.XYID_GC_EXCHANGE_CANCEL = 211
packet.XYID_GC_EXCHANGE_SYNC_II = 124
packet.XYID_GC_PLAYER_SHOP_ACQUIRE_SHOP_LIST = 578
packet.XYID_GC_PLAYER_SHOP_ERROR = 207
packet.XYID_GC_PLAYER_SHOP_APPLY = 128
packet.XYID_CG_PLAYER_SHOP_ESTABLISH = 501
packet.XYID_CG_PLAYER_SHOP_ON_SALE = 293
packet.XYID_CG_PLAYER_SHOP_MONEY = 587
packet.XYID_CG_PLAYER_SHOP_BUY_ITEM = 94
packet.XYID_CG_PLAYER_SHOP_OPEN_STALL = 761
packet.XYID_CG_PLAYER_SHOP_DESC = 687
packet.XYID_CG_PLAYER_SHOP_NAME = 389
packet.XYID_CG_PLAYER_SHOP_SALE_SOUT = 391
packet.XYID_CG_PLAYER_SHOP_BUY_SHOP = 705
packet.XYID_CG_PLAYER_SHOP_PARTNER = 782
packet.XYID_CG_PLAYER_SHOP_ASK_FOR_RECORD = 233
packet.XYID_CG_PLAYER_SHOP_SHOP_SIZE = 7
packet.XYID_CG_PLAYER_SHOP_TYPE = 143
packet.XYID_CG_PLAYER_SHOP_FAVORITE = 517
packet.XYID_CG_PLAYER_SHOP_SALE_SHOP_OPT = 285
packet.XYID_CG_PLAYER_SHOP_SALE_SHOP_ASK_INFO = 753
packet.XYID_CG_PLAYER_SHOP_APPLY = 117
packet.XYID_CG_PLAYER_SHOP_ACQUIRE_SHOP_LIST = 27
packet.XYID_GC_PLAYER_SHOP_ESTABLISH = 457
packet.XYID_GC_PLAYER_SHOP_MONEY = 327
packet.XYID_GC_PLAYER_SHOP_OPEN_STALL = 375
packet.XYID_GC_PLAYER_SHOP_SALE_OUT = 609
packet.XYID_GC_PLAYER_SHOP_BUY_SHOP = 185
packet.XYID_GC_PLAYER_SHOP_RECORD_LIST = 607
packet.XYID_GC_PLAYER_SHOP_UPDATE_PARTNERS = 649
packet.XYID_GC_PLAYER_SHOP_UPDATE_FAVORITE = 288
packet.XYID_GC_PLAYER_SHOP_TYPE = 212
packet.XYID_GC_PLAYER_SHOP_STALL_STATUS = 198
packet.XYID_GC_OPEN_PLAYER_SHOP = 401
packet.XYID_GC_PLAYER_SHOP_SALE_SHOP_INFO = 392
packet.XYID_GC_PLAYER_SHOP_OPT_RESULT = 276
packet.XYID_CG_PLAYER_SHOP_ACQUIRE_ITEM_LIST = 437
packet.XYID_GC_ITEM_LIST = 160
packet.XYID_CG_ITEM_SYNCH = 419
packet.XYID_GC_ITEM_SYNCH = 337
packet.XYID_GC_PLAYER_SHOP_ON_SALE = 603
packet.XYID_CG_CREATE_GUILD_LEAGUE = 263
packet.XYID_GC_CHALLENGE_LIST_INFO = 957
packet.XYID_GC_CHALLENGE = 146
packet.XYID_CG_SECT_OPER = 980
packet.XYID_CG_ASK_CAMPAIGN_COUNT = 877
packet.XYID_CG_ASK_SEC_KILL_NUM = 870
packet.XYID_CG_ASK_SEC_KILL_DATA = 872
packet.XYID_GC_RET_SEC_KILL_DATA = 873
packet.XYID_GC_RET_CAMPAIGN_COUNT = 876
packet.XYID_GC_RET_SEC_KILL_NUM = 871
packet.XYID_CG_EXTERIOR_COUPLE_FASHION = 1211
packet.XYID_GC_EXTERIOR_COUPLE_FASHION = 1212
packet.XYID_GC_SET_DYNAMIC_REGION = 894
packet.XYID_GC_NPC_TALK = 884
packet.XYID_CG_ZDZD_REQUEST = 855
packet.XYID_GC_ZHOU_HUOYUE_INFO = 900
packet.XYID_GC_SHENG_WANG_INFO = 1166
packet.XYID_CG_CHAR_UPDATE_CUR_TITLE = 435
packet.XYID_CGW_GUILD_LEAGUE_LIST = 461
packet.XYID_WGC_GUILD_LEAGUE_LIST = 728
packet.XYID_WGC_GUILD_LEAGUE_INFO = 332
packet.XYID_CGW_GUILD_LEAGUE_INFO = 199
packet.XYID_CGW_GUILD_LEAGUE_ASK_ENTER = 58
packet.XYID_CGW_GUILD_LEAGUE_QUIT = 48
packet.XYID_CGW_GUILD_LEAGUE_MEMBER_APPLY_LIST = 338
packet.XYID_WGC_GUILD_LEAGUE_MEMBER_APPLY_LIST = 518
packet.XYID_CGW_GUILD_LEAGUE_ANSWER_ENTER = 294
packet.XYID_WGC_RET_QUERY_XBW_RANK_CHARTS = 1002
packet.XYID_GC_MONSTER_SPEAK = 93
packet.XYID_GC_AUCTION_SEARCH = 704
packet.XYID_CG_AUCTION_SEARCH = 54
packet.XYID_CG_AUCTION_SELL = 87
packet.XYID_CG_AUCTION_BOX_LIST = 85
packet.XYID_CG_AUCTION_TAKE_BACK = 612
packet.XYID_GC_AUCTION_CHANGE_STATUS = 358
packet.XYID_GC_AUCTION_BOX_LIST = 816
packet.XYID_CG_AUCTION_BUY = 736
packet.XYID_CG_AUCTION_MULTI_BUY_ITEM = 1108
packet.XYID_CG_AUCTION_GET_YB = 361
packet.XYID_CG_AUCTION_MODIFY = 372
packet.XYID_CG_AUCTION_EXPIRE_BACK = 349
packet.XYID_CG_AUCTION_CHANGE_MONEY = 511
packet.XYID_CG_AUCTION_ERROR = 213
packet.XYID_GC_BY_NAME = 13
packet.XYID_CG_BY_NAME = 282
packet.XYID_GC_NEW_BUS = 444
packet.XYID_GC_NEW_BUS_MOVE = 59
packet.XYID_GC_BUS_MOVE = 598
packet.XYID_GC_BUS_ADD_PASSENGER = 446
packet.XYID_GC_BUS_REMOVE_ALL_PASSENGER = 674
packet.XYID_GC_CITY_LIST = 694
packet.XYID_GC_PHOENIX_PLAIN_WAR_SCORE = 785
packet.XYID_GC_PHOENIX_PLAIN_WAR_FLAG_POS = 5
packet.XYID_GC_PHOENIX_PLAIN_WAR_CRYSTAL_POS = 226
packet.XYID_GC_PHOENIX_PLAIN_WAR_CAMP_INFO = 103
packet.XYID_WGC_PACKET = 402
packet.XYID_GC_CITY_ATTR = 507
packet.XYID_GC_TEAM_LEADER_ASK_INVITE = 746
packet.XYID_GC_NOTIFY_GOOD_BAD = 19
packet.XYID_GC_GUILD_ERROR = 42
packet.XYID_CG_EXCHANGE_YUANBAO_PIAO = 145
packet.XYID_CG_SEC_KILL_REMOVE_ITEM = 874
packet.XYID_GC_SEC_KILL_REMOVE_ITEM = 875
packet.XYID_GC_MISSION_HAVE_DONE_FLAG = 657
packet.XYID_CG_ASK_DIGONG_SHOP_INFO = 966
packet.XYID_GC_JIYUAN_SHOP_INFO = 1106
packet.XYID_CG_ASK_TARGET_ES_PLAN = 1167
packet.XYID_GC_TAR_EXTERIOR_SHARE_PLAN = 1168
packet.XYID_CG_SET_MOOD_TO_HEAD = 545
packet.XYID_CG_TEAM_CHANGE_OPTION = 1
packet.XYID_TEAM_OPTION_CHANGED = 214
packet.XYID_GC_PET_SOUL_RANSE = 1266
packet.XYID_GC_RMB_CHAT_ACTION_INFO = 236
packet.XYID_CG_ASK_CHEDIFULU_DATA = 1090
packet.XYID_CG_PET_EXTERIOR_COLLECTION_REQUEST = 1264
packet.XYID_GC_PET_EXTERIOR_COLLECTION_INFO = 1265
packet.XYID_GC_TJC_PVP_CMN_DATA = 1169
packet.XYID_GC_ABILITY_EXP = 425
packet.XYID_CG_REPORT_WAIGUA = 462
packet.XYID_WGC_RET_QUERY_QINGRENJIE_TOP_LIST = 1021
packet.XYID_GC_SECWEAPON_ADDSKILLLIST = 1263
--packet.XYID_GC_REFRESH_EQUIP_ATTR = 1302
packet.XYID_GC_REFRESH_EQUIP_ATTR = 1305
packet.XYID_GC_DIAOWEN_FEATURESKILL = 1340
packet.XYID_CG_ORNAMENTSOPERATION = 1348
packet.XYID_GC_ORNAMENTSOPERATION = 1349
packet.XYID_CGW_NORMALRANKLIST = 9031
packet.XYID_WGC_RET_NORMALRANKLIST = 9032
--团队
packet.XYID_CGAskRaiInfo = 1250
packet.XYID_CGRaidCreate = 1220
packet.XYID_CGRaidAppoint = 1218
packet.XYID_CGRaidKick = 1225
packet.XYID_CGRaidRetInvite = 1251
packet.XYID_GCRetRaidModifyMemberPosition = 1252
packet.XYID_CGRaidModifyMemberPosition = 1253
packet.XYID_CGRaidInvite = 1222
packet.XYID_CGRaidApply = 1248
packet.XYID_GCRaidAskApply = 1226
packet.XYID_GCRaidList = 1219
packet.XYID_GCRaidMemberInfo = 1227
packet.XYID_GCRaidError = 1249
packet.XYID_GCRaidResult = 1256
packet.XYID_CGRaidLeave = 1229
packet.XYID_CGAskRaidMemberInfo = 1221
packet.XYID_CGRaidRetApply = 1224
packet.XYID_GCRaidAskInvite = 1228

--enum RAID_POISTION
--{
--	RAID_POISTION_LEADER = 0,	//团长
--	RAID_POISTION_ASSISTANT,	//助理
--	RAID_POISTION_MEMBER,		//普通团员
--};
--有新的团队邀请
packet.GCRaidAskInvite = {
    xy_id = packet.XYID_GCRaidAskInvite,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCRaidAskInvite })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_ZoneWorldID = -1
        self.member_list = {}
		self.m_uLeaderLevel = 1		--团队团长等级
    end,
    bis = function(self, buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.guid)
        self.nickname = gbk.fromutf8(self.nickname)
        stream:write(self.nickname, 0x1E)
        stream:writeshort(self.m_ZoneWorldID)
        stream:writeint(self.m_uLeaderLevel)
		
		stream:writeshort(0)
		stream:writeint(0)
        return stream:get()
    end 
}
--团队申请回复
packet.CGRaidRetApply = {
    xy_id = packet.XYID_CGRaidRetApply,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGRaidRetApply })
        o:ctor()
        return o
    end,
    ctor = function(self)
		self.return_type = 0
		self.source_guid = -1
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.return_type = stream:readuchar()
        self.source_guid = stream:readint()
		stream:readint()
    end
}
--请求团队成员信息
packet.CGAskRaidMemberInfo = {
    xy_id = packet.XYID_CGAskRaidMemberInfo,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGAskRaidMemberInfo })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readint()
        self.guid = stream:readint()
        self.sceneid = stream:readshort()
    end
}
--离开团队
packet.CGRaidLeave = {
    xy_id = packet.XYID_CGRaidLeave,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGRaidLeave })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.guid = stream:readint()
    end
}
--团队操作结果
--enum RAID_RESULT
--{
--	RAID_RESULT_MEMBERENTER = 0,		//成员加入团队
--	RAID_RESULT_MEMBERLEAVE,			//成员离开团队
--	RAID_RESULT_LEADERLEAVE,			//团长离开团队
--	RAID_RESULT_KICK,					//踢除成员
--	RAID_RESULT_APPOINT,				//任命新职务
--	RAID_RESULT_STARTCHANGESCENE,		//开始切换场景
--	RAID_RESULT_ENTERSCENE,				//团队成员进入新场景
--	RAID_RESULT_REFRESH,				//重新请求团队信息的回复
--	RAID_RESULT_MEMBEROFFLINE,			//玩家离线
--	RAID_RESULT_DISMISS,				//团队解散
--	RAID_RESULT_NUMBER ,				//团队结果类型的最大值
--};
packet.GCRaidResult = {
    xy_id = packet.XYID_GCRaidResult,
    new = function()
        local o = o or {}
        setmetatable(o, { __index = packet.GCRaidResult })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_7 = define.INVAILD_ID
    end,
    bis = function(self, buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        self.name = gbk.fromutf8(self.name)
        self.name_size = string.len(self.name)
        stream:writeuchar(self.return_type)
        stream:writeint(self.guid)
		stream:writeushort(self.raid_id)
        stream:writeint(self.guid_ex)
		stream:writeint(self.m_objID)
		
        stream:writeshort(self.sceneid)
        stream:writeshort(self.client_res)
		
        stream:writeuchar(self.name_size)
        if self.name_size > 0 and self.name_size <= 0x1E then
            stream:write(self.name, self.name_size)
        end
        stream:writeuint(self.portrait_id)
        stream:writeushort(self.sex)
		stream:writechar(0)
		stream:writechar(self.m_Position)		--调整职务后要更新这里
		stream:writeuint(self.m_SquadIdx)		--团队小队ID
		stream:writeuint(self.m_MemberIdx)		--团队小队位置
		stream:writeushort(self.m_ZoneWorldID)	--归属服务器id
		stream:writeuint(self.m_iFightScore)	--战斗评分
		--帮会名
		local m_uGuildNameSize = string.len(self.GuildName)
		stream:writeshort(m_uGuildNameSize)
		if m_uGuildNameSize < 32 then
			stream:write(self.GuildName, m_uGuildNameSize)
		end
        stream:writeint(0)
		
        return stream:get()
    end
}
--团队错误信息
--error_code
--enum RAID_ERROR
--{
--	RAID_ERROR_INVITEDESTHASRAID=0 ,		//邀请对象已经加入一个团队
--	RAID_ERROR_INVITEDHASINRAID,			//您邀请的玩家已经在您的团队中
--	RAID_ERROR_INVITEDTARGETNOTONLINE,		//您只能邀请在线的玩家加入团队
--	RAID_ERROR_RAID_NOTEXIST_OR_LEADEROUT,	//该团队已解散，或团长已离团。
--	RAID_ERROR_INVITEREFUSE,				//对方拒绝了你的邀请
--	RAID_ERROR_FULL,						//团队已满。
--	RAID_ERROR_FULL_CANTINVITE,				//团队已满，无法加入新成员。
--
--	RAID_RESERVER,
--
--	RAID_ERROR_KICKNOTLEADER,				//只有团长或助理才能踢人
--	RAID_ERROR_KICKLEADER,					//不能请离团长！
--	RAID_ERROR_KICK_ASSISTANT,				//不能请离和你同职位的助理！	
--
--	RAID_ERROR_TARGET_IN_OTHERRAID,			//对方已经加入一个团队
--	RAID_ERROR_TARGET_NOT_IN_RAID,			//对方不属于某个团队
--	RAID_ERROR_APPLYLEADERREFUSE,			//团长拒绝你加入团队
--	RAID_ERROR_APPLY_FULL,					//团队已满。
--	RAID_ERROR_APPOINTSOURNOLEADER,			//团长已换人，请重新申请入团。	
--	RAID_ERROR_NOT_IN_RAID,					//你不在团队中。
--	RAID_ERROR_TARGET_NOT_IN_YOUR_RAID,		//对方不在你的团队中。	
--	RAID_ERROR_TARGET_NOT_IN_YOUR_RAID_2,	//对方不在你的团队中。	
--	RAID_ERROR_NOT_LEADER,					//你已不是团长了。	
--	RAID_ERROR_ASSISTANT_MAX,				//团长助理的名额最多为2人，无法继续任命团长助理。	
--	RAID_ERROR_APPOINT_FAIL,				//任命失败
--	RAID_ERROR_APPLYLEADERCANTANSWER,		//团长目前无法答复
--
--	RAID_RESERVER_2,
--	RAID_RESERVER_3,
--	RAID_ERROR_FULL_CANTAPPLY,				//团队已满，无法加入新成员。
--	RAID_ERROR_TARGETNOTONLINE,				//对方已经离线，加入失败。
--	RAID_ERROR_APPLYTOOMUCH,				//已有太多人向该玩家提出了申请入团，请稍等。
--	RAID_ERROR_INVITETOOMUCH,				//已有太多人向该玩家提出了入团邀请，请稍等。
--	RAID_ERROR_APPLYALREADYIN,				//你已经对该玩家提出了申请入团，请稍等。
--	RAID_ERROR_INVITEALREADYIN,				//你已经对该玩家提出了入团邀请，请稍等。
--	RAID_ERROR_ADDMEMFAILED,				//申请入队的玩家处于异常状态，添加团员失败！
--	RAID_ERROR_ADDMEMFAILED_INVITEERR,		//邀请人异常，加入团队失败
--	RAID_ERROR_CHANGE_POISTION_1,			//调整团员位置失败。
--	RAID_ERROR_CHANGE_POISTION_2,			//调整团员位置失败。
--	RAID_ERROR_CHANGE_POISTION_3,			//调整团员位置失败。
--	RAID_ERROR_CHANGE_POISTION_4,			//调整团员位置失败。
--
--	RAID_RESERVER_4,
--	RAID_RESERVER_5,
--	RAID_RESERVER_6,
--	RAID_RESERVER_7,
--
--	RAID_ERROR_NUMBER ,						//团队功能错误号的最大值
--};
packet.GCRaidError = {
    xy_id = packet.XYID_GCRaidError,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCRaidError})
        o:ctor()
        return o
    end,
    ctor = function(self) self.error_code = 0 end,
    bis = function(self, buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.error_code)
        return stream:get()
    end
}

--返回团队成员信息
packet.GCRaidMemberInfo = {
	xy_id = packet.XYID_GCRaidMemberInfo,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCRaidMemberInfo })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_19 = 0
        self.flag = 0
        self.data_index = 0
		self.m_RaidID = -1		--团队ID
    end,
    set_menpai = function(self, menpai)
        self.menpai = menpai
        self.flag = menpai and self.flag | 0x1 or self.flag & ~0x1
    end,
    set_level = function(self, level)
        self.level = level
        self.flag = level and self.flag | 0x2 or self.flag & ~0x2
    end,
    set_world_pos = function(self, world_pos)
        self.world_pos = world_pos
        self.flag = world_pos and self.flag | 0x4 or self.flag & ~0x4
    end,
    set_hp = function(self, hp)
        self.hp = hp
        self.flag = hp and self.flag | 0x8 or self.flag & ~0x8
    end,
    set_hp_max = function(self, hp_max)
        self.hp_max = hp_max
        self.flag = hp_max and self.flag | 0x10 or self.flag & ~0x10
    end,
    set_mp = function(self, mp)
        self.mp = mp
        self.flag = mp and self.flag | 0x20 or self.flag & ~0x20
    end,
    set_mp_max = function(self, mp_max)
        self.mp_max = mp_max
        self.flag = mp_max and self.flag | 0x40 or self.flag & ~0x40
    end,
    set_rage = function(self, rage)
        self.rage = rage
        self.flag = rage and self.flag | 0x80 or self.flag & ~0x80
    end,
    set_offline = function(self, offline)
        self.offline = offline and 1 or 0
        self.flag = offline and self.flag | 0x8000 or self.flag & ~0x8000
    end,
    set_is_die = function(self, is_die)
        self.is_die = is_die and 1 or 0
        self.flag = is_die and self.flag | 0x10000 or self.flag & ~0x10000
    end,
    set_hair_id = function(self, hair_id)
        self.hair_id = hair_id
        self.flag = hair_id and self.flag | 0x40000 or self.flag & ~0x40000
    end,
    set_hair_color = function(self, hair_color)
        self.hair_color = hair_color
        self.flag = hair_color and self.flag | 0x80000 or self.flag & ~0x80000
    end,
    set_portrait_id = function(self, portrait_id)
        self.portrait_id = portrait_id
        self.flag = portrait_id and self.flag | 0x200000 or self.flag & ~0x200000
    end,
    set_weapon = function(self, weapon)
		if weapon then
			self.weapon = weapon
			self.flag = self.flag | 0x200
		else
			self.flag = self.flag & ~0x200
		end
    end,
    set_cap = function(self, cap)
		if cap then
			self.cap = cap
			self.flag = self.flag | 0x400
		else
			self.flag = self.flag & ~0x400
		end
    end,
    set_armour = function(self, armour)
		if armour then
			self.armour = armour
			self.flag = self.flag | 0x800
		else
			self.flag = self.flag & ~0x800
		end
    end,
    set_cuff = function(self, cuff)
		if cuff then
			self.cuff = cuff
			self.flag = self.flag | 0x1000
		else
			self.flag = self.flag & ~0x1000
		end
    end,
    set_foot = function(self, foot)
		if foot then
			self.foot = foot
			self.flag = self.flag | 0x2000
		else
			self.flag = self.flag & ~0x2000
		end
    end,
    set_fashion = function(self, fashion)
		if fashion then
			self.fashion = fashion
			self.flag = self.flag | 0x100000
		else
			self.flag = self.flag & ~0x100000
		end
    end,
    bis = function(self, buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.guid)
		stream:writeshort(self.m_RaidID)
        stream:writeuint(self.data_index)
        stream:writeint(self.flag)
        if self.flag & 0x1 == 0x1 then
            stream:writeint(self.menpai)
        end
        if self.flag & 0x2 == 0x2 then
            stream:writeint(self.level)
        end
        if self.flag & 0x4 == 0x4 then
            stream:writefloat(self.world_pos.x)
            stream:writefloat(self.world_pos.y)
        end
        if self.flag & 0x8 == 0x8 then
            stream:writeuint(self.hp)
        end
        if self.flag & 0x10 == 0x10 then
            stream:writeuint(self.hp_max)
        end
        if self.flag & 0x20 == 0x20 then
            stream:writeuint(self.mp)
        end
        if self.flag & 0x40 == 0x40 then
            stream:writeuint(self.mp_max)
        end
        if self.flag & 0x80 == 0x80 then
            stream:writeuint(self.rage)
        end
		if self.flag & 0x2000000 == 0x2000000 then
            stream:writeuint(0)		--空
        end
		if self.flag & 0x100 == 0x100 then
            stream:writeuint(0)		--空
        end
        if self.flag & 0x200 == 0x200 then
            stream:writeint(self.weapon[define.WG_KEY_A])
            stream:writeint(self.weapon[define.WG_KEY_B])
            stream:writeshort(self.weapon[define.WG_KEY_C])
        end
        if self.flag & 0x400 == 0x400 then
            stream:writeint(self.cap[define.WG_KEY_A])
            stream:writeint(self.cap[define.WG_KEY_B])
            stream:writeshort(self.cap[define.WG_KEY_C])
        end
        if self.flag & 0x800 == 0x800 then
            stream:writeint(self.armour[define.WG_KEY_A])
            stream:writeint(self.armour[define.WG_KEY_B])
            stream:writeshort(self.armour[define.WG_KEY_C])
        end
        if self.flag & 0x1000 == 0x1000 then
            stream:writeint(self.cuff[define.WG_KEY_A])
            stream:writeint(self.cuff[define.WG_KEY_B])
            stream:writeshort(self.cuff[define.WG_KEY_C])
        end
        if self.flag & 0x2000 == 0x2000 then
            stream:writeint(self.foot[define.WG_KEY_A])
            stream:writeint(self.foot[define.WG_KEY_B])
            stream:writeshort(self.foot[define.WG_KEY_C])
        end
        if self.flag & 0x8000 == 0x8000 then
            stream:writeuchar(self.offline)	--离线标记
        end
		if self.flag & 0x10000 == 0x10000 then
            stream:writeuchar(self.is_die)		--死亡标记
        end
		--face_id ??
        if self.flag & 0x40000 == 0x40000 then
            stream:writeuint(self.hair_id)	--发型ID  hair_id
        end
        if self.flag & 0x80000 == 0x80000 then
            stream:writeint(self.hair_color)		--发色   hair_color
        end
		
        if self.flag & 0x100000 == 0x100000 then
            stream:writeint(self.fashion[define.WG_KEY_A])
            stream:writeint(self.fashion[define.WG_KEY_D])
            stream:writeint(self.fashion[define.WG_KEY_E])
            stream:writeint(self.fashion[define.WG_KEY_F])
            stream:writeshort(self.fashion[define.WG_KEY_C])
        end
        if self.flag & 0x200000 == 0x200000 then
            stream:writeuint(self.portrait_id)		--头像  portrait_id
        end
        return stream:get()
    end
}

--通知客户端当前团队列表
packet.GCRaidList = {
    xy_id = packet.XYID_GCRaidList,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCRaidList})
        o:ctor()
        return o
    end,
    ctor = function(self) 
		--enum RAID_EVENT_ID
--		{
--			RAID_EVENT_CREATE = 0,			//转为团队
--			RAID_EVENT_ADD_NEWMEM = 1,		//加入一个新团队
--			RAID_EVENT_RET_RAIDINFO = 2,	//返回团队信息
--
--			RAID_EVENT_NUMBER,
--		};
		self.m_nEventID = 0
		self.m_TeamID = -1	--组队ID
		self.m_RaidID = -1	--团队ID
		self.m_bLeaveRaid = 0	--离开团队
		self.m_nMemberCount = 0	--团队成员数量，最大30
		--【注意】member_list来自队伍的member_list，请自行适配
		self.member_list = {}
	end,
    bis = function(self, buffer)
    end,
    bos = function(self)
		local text,text_size
		local stream = bostream.new()
		stream:writeuint(self.m_nEventID)
		stream:writeshort(self.m_TeamID)
		stream:writeshort(self.m_RaidID)
		stream:writeuint(self.m_bLeaveRaid)
		stream:writeuchar(self.m_nMemberCount)
		for tid,team in ipairs(self.member_list) do
			for mid,mb in ipairs(team) do
				stream:writeuint(mb.guid)
				stream:writeushort(mb.sceneid)
				stream:writeushort(mb.client_res)
				stream:writeint(mb.m_objID)
				text = gbk.fromutf8(mb.name)
				text_size = string.len(text)
				stream:writeuchar(text_size)
				if text_size <= 0x1E then
					stream:write(text, text_size)
				end
				stream:writeuint(mb.portrait_id)
				stream:writeushort(mb.model)
				--团队内职务
				stream:writeuchar(mb.m_Position)
				--团队小队序号
				stream:writeuint(tid - 1)
				--团队小队位置
				stream:writeuint(mid - 1)
				stream:writeshort(mb.m_ZoneWorldID)
				--空 战斗评分-经典
				stream:writeuint(mb.m_iFightScore)
				--帮会名
				text = gbk.fromutf8(mb.GuildName)
				text_size = string.len(text)
				stream:writeshort(text_size)
				if text_size <= 32 then
					stream:write(text, text_size)
				end
				stream:writeint(-1)
			end
		end
        return stream:get()
    end
}

--通知客户端有团队申请
packet.GCRaidAskApply = {
    xy_id = packet.XYID_GCRaidAskApply,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCRaidAskApply})
        o:ctor()
        return o
    end,
    ctor = function(self) 
		self.m_SourGUID = -1		--申请人GUID
		self.SourceName = ""		--申请人名
		self.m_uFamily = 9			--申请人门派
		self.sceneid = -1
		self.m_Level = 0
		self.m_DetailFlag = 0
		self.m_uDataID = 0			--性别
		self.m_nDefEquip = 0
		self.m_ZoneWorldID = 0
		self.m_iFightScore = 0		--空
		self.GuildName = ""
		self.m_OperateKey = 0		--操作key 无用
	end,
    bis = function(self, buffer)
    end,
    bos = function(self)
		local stream = bostream.new()
		stream:writeuint(self.m_SourGUID)
		self.SourceName = gbk.fromutf8(self.SourceName)
		local SourceSize = string.len(self.SourceName)
        stream:writeuchar(SourceSize)
        if SourceSize < 30 then
            stream:write(self.SourceName, SourceSize)
        end
		stream:writeuint(self.m_uFamily)
		stream:writeshort(self.sceneid)
		stream:writeuint(self.m_Level)
		stream:writechar(self.m_DetailFlag)
		stream:writeushort(self.m_uDataID)
		stream:writeuint(self.m_nDefEquip)
		stream:writeshort(self.m_ZoneWorldID)
		stream:writeuint(self.m_iFightScore)
		self.GuildName = gbk.fromutf8(self.GuildName)
		local m_uGuildNameSize = string.len(self.GuildName)
		stream:writeshort(m_uGuildNameSize)
		if m_uGuildNameSize < 32 then
			stream:write(self.GuildName, m_uGuildNameSize)
		end
		--【注意】uinfo来自队伍的uinfo，请自行适配
		if self.m_DetailFlag > 0 then
			stream:writeint(self.weapon[define.WG_KEY_A])
            stream:writeint(self.weapon[define.WG_KEY_B])
            stream:writeushort(self.weapon[define.WG_KEY_C])
			
            stream:writeint(self.cap[define.WG_KEY_A])
            stream:writeint(self.cap[define.WG_KEY_B])
            stream:writeushort(self.cap[define.WG_KEY_C])

            stream:writeint(self.armour[define.WG_KEY_A])
            stream:writeint(self.armour[define.WG_KEY_B])
            stream:writeushort(self.armour[define.WG_KEY_C])

            stream:writeint(self.cuff[define.WG_KEY_A])
            stream:writeint(self.cuff[define.WG_KEY_B])
            stream:writeushort(self.cuff[define.WG_KEY_C])

            stream:writeint(self.foot[define.WG_KEY_A])
            stream:writeint(self.foot[define.WG_KEY_B])
            stream:writeushort(self.foot[define.WG_KEY_C])
			--脸型ID
			stream:writeuint(self.face_id)
			--发型ID
			stream:writeuint(self.hair_id)
			--发色
			stream:writeuint(self.hair_color)
			--时装ID
			stream:writeint(self.fashion[define.WG_KEY_A])
			--点缀
			stream:writeint(self.fashion[define.WG_KEY_D])
			stream:writeint(self.fashion[define.WG_KEY_E])
			stream:writeint(self.fashion[define.WG_KEY_F])
			-- stream:writeint(self.fashion[define.WG_KEY_A])
			stream:writeuint(self.fashion[define.WG_KEY_C])
			--预留
			stream:writeint(-1)
			stream:writeint(-1)
			stream:writeint(-1)
			
			stream:writeushort(0)
			stream:writeushort(0)
			
			stream:writeint(-1)
			stream:writeint(-1)
			
		end
		stream:writeint(self.m_OperateKey)
        return stream:get()
    end
}

--通知客户端团队成员位置调整
packet.GCRetRaidModifyMemberPosition = {
    xy_id = packet.XYID_GCRetRaidModifyMemberPosition,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCRetRaidModifyMemberPosition})
        o:ctor()
        return o
    end,
    ctor = function(self) 
		self.m_yOk = 0
		self.raid_id = -1
		self.m_OperateGUID = -1		--操作GUID
		self.m_sSquadIndex = -1		--源小队ID
		self.m_sMemIndex = -1		--源小队内位置
		
		self.m_dSquadIndex = -1
		self.m_dMemIndex = -1
	end,
    bis = function(self, buffer)
    end,
    bos = function(self)
		local stream = bostream.new()
		stream:writechar(self.m_yOk)
		stream:writeint(self.m_OperateGUID)
		stream:writeshort(self.raid_id)
		
		stream:writeshort(self.m_sSquadIndex)
		stream:writeint(self.m_sMemIndex)
		
		stream:writeshort(self.m_dSquadIndex)
		stream:writeint(self.m_dMemIndex)
		
        return stream:get()
    end
}

--调整团队成员位置
packet.CGRaidModifyMemberPosition = {
    xy_id = packet.XYID_CGRaidModifyMemberPosition,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGRaidModifyMemberPosition})
        o:ctor()
        return o
    end,
    ctor = function(self) 
		self.m_OperateGUID = -1		--操作GUID
		self.m_sSquadIndex = -1		--源小队ID
		self.m_sMemIndex = -1		--源小队内位置
		
		self.m_dSquadIndex = -1
		self.m_dMemIndex = -1
	end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
		self.m_OperateGUID = stream:readuint()
		stream:readshort()
		
		self.m_sSquadIndex = stream:readshort()
		self.m_sMemIndex = stream:readint()
		
		self.m_dSquadIndex = stream:readshort()
		self.m_dMemIndex = stream:readint()
    end,
    bos = function(self)
    end
}
--回应邀请操作
packet.CGRaidRetInvite = {
    xy_id = packet.XYID_CGRaidRetInvite,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGRaidRetInvite})
        o:ctor()
        return o
    end,
    ctor = function(self) 
		self.m_Return = 0
		self.m_GUID = -1		--对象GUID
	end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
		self.m_Return = stream:readchar()
		self.m_GUID = stream:readuint()
		--空
		stream:readuint()
    end,
    bos = function(self)
    end
}
--踢出团队
packet.CGRaidKick = {
    xy_id = packet.XYID_CGRaidKick,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGRaidKick})
        o:ctor()
        return o
    end,
    ctor = function(self) 
		self.m_OperateGUID = -1		--人操作GUID
		self.m_TargetGUID = -1		--对象GUID
	end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_OperateGUID = stream:readuint()
		self.m_TargetGUID = stream:readuint()
    end,
    bos = function(self)
    end
}
--团队任命
packet.CGRaidAppoint = {
    xy_id = packet.XYID_CGRaidAppoint,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGRaidAppoint})
        o:ctor()
        return o
    end,
    ctor = function(self) 
		self.m_OperateGUID = -1		--人操作GUID
		self.m_TargetGUID = -1		--对象GUID
		self.m_Position = 0			--任命的职务
	end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_OperateGUID = stream:readuint()
		self.m_TargetGUID = stream:readuint()
		self.m_Position = stream:readchar()
    end,
    bos = function(self)
    end
}
--创建团队
packet.CGRaidCreate = {
    xy_id = packet.XYID_CGRaidCreate,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGRaidCreate})
        o:ctor()
        return o
    end,
    ctor = function(self) 
		self.m_CreateGUID = -1
		self.m_CreateTeamId = -1
		self.nCountInRaid = 0
		self.m_aPlayerInRaid = {}
	end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_CreateGUID = stream:readuint()
		--空
		stream:readuint()
		self.m_CreateTeamId = stream:readshort()
		self.nCountInRaid = stream:readint()
		if self.nCountInRaid > 30 then
			self.nCountInRaid = 30
		end
		for i = 1,self.nCountInRaid do
			self.m_aPlayerInRaid[i] = stream:readint()
		end
    end,
    bos = function(self)
    end
}
--请求团队信息
packet.CGAskRaiInfo = {
    xy_id = packet.XYID_CGAskRaiInfo,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGAskRaiInfo})
        o:ctor()
        return o
    end,
    ctor = function(self) self.m_objID = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
    end,
    bos = function(self)
    end
}

--申请进入团队
packet.CGRaidApply = {
    xy_id = packet.XYID_CGRaidApply,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGRaidApply})
        o:ctor()
        return o
    end,
    ctor = function(self) 
		self.m_SourGUID = -1		--操作guid
		self.m_DestName = ""
		self.m_ZoneWorldID = -1
	end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
		self.m_SourGUID = stream:readuint()
		local m_DestNameSize = stream:readuchar()
		if m_DestNameSize > 0 and m_DestNameSize < 30 then
			self.m_DestName = gbk.toutf8(stream:read(m_DestNameSize)) 
		end
		self.m_ZoneWorldID = stream:readshort()
    end,
    bos = function(self)
    end
}

--邀请进入团队
packet.CGRaidInvite = {
    xy_id = packet.XYID_CGRaidInvite,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGRaidInvite})
        o:ctor()
        return o
    end,
    ctor = function(self) 
		self.m_SourObjID = -1		--操作obj
		self.m_DestName = ""
		self.m_ZoneWorldID = -1
	end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
		self.m_SourObjID = stream:readuint()
		local m_DestNameSize = stream:readuchar()
		if m_DestNameSize > 0 and m_DestNameSize < 30 then
			self.m_DestName = gbk.toutf8(stream:read(m_DestNameSize)) 
		end
		self.m_ZoneWorldID = stream:readshort()
    end,
    bos = function(self)
    end
}

--请求排行榜内容
packet.CGWNormalRankingList = {
	xy_id = packet.XYID_CGW_NORMALRANKLIST,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGWNormalRankingList})
        o:ctor()
        return o
    end,
    ctor = function(self)
        
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
		--需要测试打印
		-- local skynet = require "skynet"
		local nDataCount = stream:readint()	--max=10
		-- skynet.logi("data 1",nDataCount)
		-- skynet.logi("data 2",stream:readint())
		-- skynet.logi("data 3",stream:readint())
		-- skynet.logi("data 4",stream:readint())
		-- skynet.logi("data 5",stream:readint())
		-- for i = 1,nDataCount do
			-- skynet.logi("for data",stream:readint())
		-- end
    end,
    bos = function(self)
    end
}
--返回排行榜内容
packet.WGCRetNormalRankList = {
    xy_id = packet.XYID_WGC_RET_NORMALRANKLIST,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.WGCRetNormalRankList})
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
		--本次包含数据数量 最大10
		local nCurCount = 4
		stream:writeuint(nCurCount)
		--三个疑似预留数据，需要调试看UI表现
		stream:writeuint(11)
		stream:writeshort(22)
		stream:writeuint(33)
		--对应lua内的LevelupMessageType 可能是能否领奖，测试看UI表现
		stream:writechar(1)
		--对应ui的CurRankType
		stream:writeint(1)	
		--预留数据，需要调试看UI表现
		stream:writeuint(44)
		for i = 1,nCurCount do
			--该榜单的rank type
			stream:writeuint(i)
			--需要调试看UI表现 默认0
			stream:writechar(9)
			stream:writechar(8)
			--榜单内含玩家数量
			local nPlayerCount = 10
			stream:writeint(nPlayerCount)	
			for j = 1,nPlayerCount do
				--排名
				stream:writeuint(j)
				--上榜时间
				--2025年5月11日23点59分
				stream:writeuint(2505112359)
				--需要调试看UI表现
				stream:writeuint(100 + j)
				--需要调试看UI表现
				stream:writechar(1)
				--玩家GUID
				stream:writeuint(j)
				--玩家门派
				stream:writechar(11)
				--玩家名
				local name = "测试数据 "..j
				stream:write(name, string.len(name))
			end
			--nreward 这里三个参数对应UI界面的函数 local nInsert, nreward,nIndex,nGetBouns = DataPool:lua_GetNormalRankPlayerRewardInfo(rankType)
			stream:writechar(0)
			--nInsert
			stream:writechar(1)
			--nIndex
			stream:writechar(2)
		end
		
        return stream:get()
    end
}

--雕纹纹刻效果显示
packet.GCDiaowenFeatureSkill = {
    xy_id = packet.XYID_GC_DIAOWEN_FEATURESKILL,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCDiaowenFeatureSkill})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.objId = -1
		self.effect_id = -1	--对应DWJinJieTeXing.txt内的第一列
    end,
    bis = function(self, buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
		stream:writeuint(self.objId)
		stream:writeuint(self.effect_id)
        return stream:get()
    end
}

--头饰&背饰交互
--server call client
packet.GCOrnamentsDataUpdate = {
	xy_id = packet.XYID_GC_ORNAMENTSOPERATION,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCOrnamentsDataUpdate})
        o:ctor()
        return o
    end,
    ctor = function(self)
		--op_code->
		--1:全量数据更新 
		--2:打开背饰UI
		--3:打开头饰UI
		self.op_code = 0		
		self.op_target = 0
		--背饰数据
		self.OrnamentsBackUnitNum = 0;
		-- local OrnamentsBackUnit = {}
--		INVALID	= 0,							-- 无效
--		EMPTY	= 1,							-- 空闲
--		TIME	= 2,							-- 限时
--		TIMEOUT	= 3,							-- 过期
--		FOREVER	= 4,							-- 永久
		-- for i = 1,100 do
			-- OrnamentsBackUnit[i] = {}
			-- OrnamentsBackUnit[i].id = -1
			-- OrnamentsBackUnit[i].x = 128
			-- OrnamentsBackUnit[i].y = 128
			-- OrnamengtsBackUnit[i].z = 128
			-- OrnamentsBackUnit[i].state = 4
			-- OrnamentsBackUnit[i].tip = 0
		-- end
		self.OrnamentsBackUnit = {}
		--头饰数据
		self.OrnamentsHeadUnitNum = 0
		-- local OrnamentsHeadUnit = {}
		-- for i = 1,100 do
			-- OrnamentsHeadUnit[i] = {}
			-- OrnamentsHeadUnit[i].id = -1
			-- OrnamentsHeadUnit[i].x = 128
			-- OrnamentsHeadUnit[i].y = 128
			-- OrnamentsHeadUnit[i].z = 128
			-- OrnamentsHeadUnit[i].state = 4
			-- OrnamentsHeadUnit[i].tip = 0
		-- end
		self.OrnamentsHeadUnit = {}
		--当前背饰数据			--Pos  4294967295  默认传上来的值为这个 需转成 8421504
		self.CurOrnamentsBackId = -1
		self.CurOrnamentsBackPos = 0
		-- self.nBackPosX = 0
		-- self.nBackPosY = 0
		-- self.nBackPosZ = 0
		-- self.CurOrnamentsBackPos = (self.nBackPosZ << 16) | (self.nBackPosY << 8) | self.nBackPosX
		--当前头饰数据			--Pos  4294967295  默认传上来的值为这个 需转成 8421504
		self.CurOrnamentsHeadId = -1
		-- self.nBackHeadX = 0
		-- self.nBackHeadY = 0
		-- self.nBackHeadZ = 0
		-- self.CurOrnamentsHeadPos = (self.nBackHeadZ << 16) | (self.nBackHeadY << 8) | self.nBackHeadX
		self.CurOrnamentsHeadPos = 0
	end,
    bis = function(self, buffer)
    end,
    bos = function(self)
		local stream = bostream.new()
		stream:writechar(self.op_code)
		stream:writechar(self.op_target)
		
		if self.op_code == 1 then
			--unit num max 100
			stream:writeuint(self.OrnamentsBackUnitNum)
			--unit num max 20	
			stream:writeuint(0)
			--unit num max 100
			stream:writeuint(self.OrnamentsHeadUnitNum)
			--unit num max 20	
			stream:writeuint(0)
			--nidx,x,y,z,state,tip [7]
			for i = 1,self.OrnamentsBackUnitNum do
				stream:writeshort(self.OrnamentsBackUnit[i].id)
				stream:writeuchar(self.OrnamentsBackUnit[i].x)
				stream:writeuchar(self.OrnamentsBackUnit[i].y)
				stream:writeuchar(self.OrnamentsBackUnit[i].z)
				stream:writeuchar(self.OrnamentsBackUnit[i].state)
				stream:writeuchar(self.OrnamentsBackUnit[i].tip)
			end
			--? [10]
			--nidx[2],x[1],y[1],z[1],state[1],tip[1]
			for i = 1,self.OrnamentsHeadUnitNum do
				stream:writeshort(self.OrnamentsHeadUnit[i].id)
				stream:writeuchar(self.OrnamentsHeadUnit[i].x)
				stream:writeuchar(self.OrnamentsHeadUnit[i].y)
				stream:writeuchar(self.OrnamentsHeadUnit[i].z)
				stream:writeuchar(self.OrnamentsHeadUnit[i].state)
				stream:writeuchar(self.OrnamentsHeadUnit[i].tip)
			end
			--? [10]
			--当前背饰
			stream:writeshort(self.CurOrnamentsBackId)
			stream:writeint(self.CurOrnamentsBackPos)
			--当前头饰
			stream:writeshort(self.CurOrnamentsHeadId)
			stream:writeint(self.CurOrnamentsHeadPos)
			
			
		elseif self.op_code == 2 then
			--unit num max 100
			stream:writeuint(self.OrnamentsBackUnitNum)
			--unit num max 20	
			stream:writeuint(0)
			--nidx,x,y,z,state,tip [7]
			for i = 1,self.OrnamentsBackUnitNum do
				stream:writeshort(self.OrnamentsBackUnit[i].id)
				stream:writeuchar(self.OrnamentsBackUnit[i].x)
				stream:writeuchar(self.OrnamentsBackUnit[i].y)
				stream:writeuchar(self.OrnamentsBackUnit[i].z)
				stream:writeuchar(self.OrnamentsBackUnit[i].state)
				stream:writeuchar(self.OrnamentsBackUnit[i].tip)
			end
			--? [10]
			--当前背饰
			stream:writeshort(self.CurOrnamentsBackId)
			stream:writeint(self.CurOrnamentsBackPos)
			--当前头饰
			stream:writeshort(self.CurOrnamentsHeadId)
			stream:writeint(self.CurOrnamentsHeadPos)
		elseif self.op_code == 3 then
			--unit num max 100
			stream:writeuint(self.OrnamentsHeadUnitNum)
			--unit num max 20	
			stream:writeuint(0)
			--nidx[2],x[1],y[1],z[1],state[1],tip[1]
			for i = 1,self.OrnamentsHeadUnitNum do
				stream:writeshort(self.OrnamentsHeadUnit[i].id)
				stream:writeuchar(self.OrnamentsHeadUnit[i].x)
				stream:writeuchar(self.OrnamentsHeadUnit[i].y)
				stream:writeuchar(self.OrnamentsHeadUnit[i].z)
				stream:writeuchar(self.OrnamentsHeadUnit[i].state)
				stream:writeuchar(self.OrnamentsHeadUnit[i].tip)
			end
			--? [10]
			
			--当前背饰
			stream:writeshort(self.CurOrnamentsBackId)
			stream:writeint(self.CurOrnamentsBackPos)
			--当前头饰
			stream:writeshort(self.CurOrnamentsHeadId)
			stream:writeint(self.CurOrnamentsHeadPos)
		end
		return stream:get()
    end
}

--client call server
packet.CGOrnamentsOperation = {
	xy_id = packet.XYID_CG_ORNAMENTSOPERATION,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGOrnamentsOperation})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.op_code = 0		--1 ask info 2:remove tips 4:take off 其余需要打点探测
		self.op_target = 0		--0背饰 1头饰
		self.exteriorId = -1
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.op_code = stream:readchar()
		self.op_target = stream:readchar()
		if self.op_code == 2 or self.op_code == 3 then
			self.exteriorId = stream:readshort();
		end
    end,
    bos = function(self)
    end
}

packet.GCSecWeaponAddSkillList = {
    xy_id = packet.XYID_GC_SECWEAPON_ADDSKILLLIST,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCSecWeaponAddSkillList})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.selfId = 0
		self.skillId = {-1,-1,-1,-1,-1,-1,-1}	--对应七情刃的7个技能
		self.commonskillA = -1	--通法上卷技能
		self.commonskillB = -1	--通法下卷技能
		self.is_hide = 0		--进入副武器技能周期开写0，周期结束写1
		self.is_update = 1		--一直保持为TRUE
    end,
    bis = function(self, buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
		stream:writeuint(self.selfId)
		for i = 1,7 do
			stream:writeint(self.skillId[i])
		end
		stream:writeshort(self.commonskillA)
		stream:writeshort(self.commonskillB)
		stream:writechar(self.is_hide)
		stream:writechar(self.is_update)
        return stream:get()
    end
}

packet.CGConnect = {
    xy_id = packet.XYID_CG_CONNECT,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGConnect})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.key = 0
        self.guid = 0
        self.unknow = 0 -- 2u
        self.unknow_1 = "" -- 32u
        self.unknow_2 = 0
        self.unknow_3 = 0
        self.unknow_4 = 0
        self.unknow_5 = 0
        self.version = "" -- 20u
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.key = stream:readuint()
        self.guid = stream:readuint()
        self.unknow = stream:readushort()
        self.unknow_1 = stream:read(0x32)
        self.unknow_2 = stream:readuint()
        self.unknow_3 = stream:readuint()
        self.unknow_4 = stream:readuint()
        self.unknow_5 = stream:readuint()
        self.version = stream:read(0x20)
    end
}

packet.GCConnect = {
    xy_id = packet.XYID_GC_CONNECT,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCConnect})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.result = 0
        self.sceneid = 0
        self.position = {}
        self.unknow = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.result = stream:readushort()
        self.sceneid = stream:readushort()
        self.position.x = stream:readfloat()
        self.position.y = stream:readfloat()
        self.unknow = stream:readushort()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeushort(self.result)
        stream:writeushort(self.sceneid)
        stream:writefloat(self.position.x)
        stream:writefloat(self.position.y)
        stream:writeushort(self.unknow)
        return stream:get()
    end
}

packet.KeyExchange = {
    xy_id = packet.XYID_KEY_EXCHANGE,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.KeyExchange})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.len = 0
        self.data = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.len = stream:readushort()
        for i = 1, self.len do self.data[i] = stream:readuchar() end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeushort(#self.data)
        for _, d in ipairs(self.data) do stream:writeuchar(d) end
        return stream:get()
    end
}

packet.GCUseGemResult = {
    xy_id = packet.XYID_GC_USEGEMRESULT,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCUseGemResult})
        o:ctor()
        return o
    end,
    ctor = function(self) self.result = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.result = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.result)
        return stream:get()
    end
}

packet.GCRemoveGemResult = {
    xy_id = packet.XYID_GC_REMOVEGEMRESULT,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCRemoveGemResult})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.result = 0
        self.gem_index = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.result = stream:readuint()
        self.gem_index = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.result)
        stream:writeuint(self.gem_index)
        return stream:get()
    end
}

packet.GCTeamError = {
    xy_id = packet.XYID_GC_TEAM_ERROR,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCTeamError})
        o:ctor()
        return o
    end,
    ctor = function(self) self.error_code = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.error_code = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.error_code)
        return stream:get()
    end
}

packet.CGRongYu = {
    xy_id = packet.XYID_CG_RONGYU,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGRongYu})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = 0
        self.unknow_2 = 0
        self.unknow_3 = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readuint()
        if self.unknow_1 ~= 0 then
            self.unknow_2 = stream:readuint()
            self.unknow_3 = stream:readuint()
        end
    end
}

packet.CGLogSubmit = {
    xy_id = packet.XYID_CG_LOG_SUBMIT,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGLogSubmit})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.len = 0
        self.log = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.len = stream:readuint()
        if self.len ~= 0 and self.len < 3000 then
            self.log = stream:read(self.len)
        end
    end
}

--[[
packet.CGAskChangeScene = {
    xy_id = packet.XYID_CG_ASK_CHANGE_SCENE,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGAskChangeScene})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = 0
        self.unknow_2 = 0
        self.unknow_3 = 0
        self.unknow_4 = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readushort()
        self.unknow_1 = stream:readushort()
        self.unknow_1 = stream:readuint()
        self.unknow_1 = stream:readuint()
    end
}]]

packet.CGLockTarget = {
    xy_id = packet.XYID_CG_LOCK_TARGET,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGLockTarget})
        o:ctor()
        return o
    end,
    ctor = function(self) self.target_id = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.target_id = stream:readint()
    end
}

packet.CGCharAskBaseAttrib = {
    xy_id = packet.XYID_CG_ChAR_ASK_BASE_ATTR_IB,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGCharAskBaseAttrib})
        o:ctor()
        return o
    end,
    ctor = function(self) self.m_objID = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
    end
}

packet.CGCharAskImpactList = {
    xy_id = packet.XYID_CG_ChAR_ASK_IMPACT_LIST,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGCharAskImpactList})
        o:ctor()
        return o
    end,
    ctor = function(self) self.m_objID = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
    end
}

packet.CGCharPositionWarp = {
    xy_id = packet.XYID_CG_CHAR_POSITION_WARP,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGCharPositionWarp})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_objID = 0
        self.server_pos = {}
        self.client_pos = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.server_pos.x = stream:readfloat()
        self.server_pos.y = stream:readfloat()
        self.client_pos.x = stream:readfloat()
        self.client_pos.y = stream:readfloat()
    end
}

packet.CGCharMoodState = {
    xy_id = packet.XYID_CG_CHAR_MOOD_STATE,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGCharMoodState})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_objID = 0
        self.mode_state = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.mode_state = stream:readuchar()
    end
}

packet.CGChangePkModeReq = {
    xy_id = packet.XYID_CG_CHANGE_PK_MODE_REQ,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGChangePkModeReq})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.pk_mode = 0
        self.unknow_2 = ""
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.pk_mode = stream:readuchar()
        self.unknow_2 = stream:read(0x1F)
    end
}

packet.CGAntagonistReq = {
    xy_id = packet.XYID_CG_ANTAGONIS_REQ,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGAntagonistReq})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = 0
        self.unknow_2 = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readuchar()
        self.m_objID = stream:readuint()
    end
}

packet.CGCharMove = {
    xy_id = packet.XYID_CG_CHARMOVE,
    MAX_CHAR_PATH_NODE_NUMBER = 16,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGCharMove})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_objID = 0
        self.handleID = 0
        self.posWorld = {x = 0, y = 0}
        self.numTargetPos = 0
        self.targetPos = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.handleID = stream:readuint()
        self.m_objID = stream:readuint()
        self.posWorld.x = stream:readfloat()
        self.posWorld.y = stream:readfloat()
        self.numTargetPos = stream:readuchar()
        self.unknow = stream:readchar()
        if self.numTargetPos > 0 and self.numTargetPos <= self.MAX_CHAR_PATH_NODE_NUMBER then
            for i = 1, self.numTargetPos do
                local pos = {x = 0, y = 0}
                pos.x = stream:readfloat()
                pos.y = stream:readfloat()
                table.insert(self.targetPos, pos)
            end
        end
    end
}

packet.CGCharJump = {
    xy_id = packet.XYID_CG_CHARJUMP,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGCharJump})
        o:ctor()
        return o
    end,
    ctor = function(self) self.objID = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
    end
}

packet.CGCharAskEquipment = {
    xy_id = packet.XYID_CG_CHARASKEQUIPMENT,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGCharAskEquipment})
        o:ctor()
        return o
    end,
    ctor = function(self) self.m_objID = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
    end
}

packet.CGCharUseSkill = {
    xy_id = packet.XYID_CG_CHARUSESKILL,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGCharUseSkill})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_objID = 0
        self.skillID = 0
        self.guidTarget = 0
        self.targetObjID = 0
        self.posTarget = {x = 0, y = 0}
        self.dir = 0.0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.dir = stream:readfloat()
        self.skillID = stream:readint()
        self.target = stream:readint()
        self.m_objID = stream:readuint()
        self.targetObjID = stream:readint()
        self.posTarget.x = stream:readfloat()
        self.posTarget.y = stream:readfloat()
    end
}
packet.CGUseAbility = {
    xy_id = packet.XYID_CG_USEABILITY,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGUseAbility})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.ability = 0
        self.prescription = 0
        self.platform = 0
        self.mat_index = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.ability = stream:readushort()
        self.prescription = stream:readint()
        self.platform = stream:readuint()
        self.mat_index = stream:readuchar()
    end
}

packet.CGCharFly = {
    xy_id = packet.XYID_CG_CHARFLY,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGCharFly})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_objID = 0
        self.skill_id = 0
        self.from = {x = 0, y = 0}
        self.to = {x = 0, y = 0}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.skill_id = stream:readuint()
        self.from.x = stream:readfloat()
        self.from.y = stream:readfloat()
        self.to.x = stream:readfloat()
        self.to.y = stream:readfloat()
    end
}

packet.CGCharDefaultEvent = {
    xy_id = packet.XYID_CG_CHARDEFAULTEVENT,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGCharDefaultEvent})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_objID = 0
        self.targetID = 0
    end,
    equal = function(self, other)
        return self.m_objID == other.m_objID and self.targetID == other.targetID
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.targetID = stream:readuint()
    end
}

packet.CGChat = {
    xy_id = packet.XYID_CG_CHAT,
    CHAT_TYPE = {
        CHAT_TYPE_INVALID   = -1,
        CHAT_TYPE_NORMAL    = 0, --普通消息
        CHAT_TYPE_TEAM      = 1, -- //队聊消息
        CHAT_TYPE_SCENE     = 2, -- //场景消息
        CHAT_TYPE_TELL      = 3, -- //私聊消息
        CHAT_TYPE_SYSTEM    = 4, -- //系统消息
        CHAT_TYPE_CHANNEL   = 5, -- //自建频道聊天
        CHAT_TYPE_GUILD     = 6, -- //帮派消息
        CHAT_TYPE_MENPAI    = 7, -- //门派消息
        CHAT_TYPE_SELF      = 8, -- //仅客户端使用的消息
        CHAT_RAID     		= 14, -- //团队
        CHAT_RAID_TEAM      = 15, -- //团队小队
        CHAT_TYPE_CITY      = 11,
        CHAT_TYPE_MAIL      = 18,
    },
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGChat})
        o:ctor()
        return o
    end,
    ctor = function(self)
        -- 聊天消息类型 enum CHAT_TYPE
        self.ChatType = 0
        -- 聊天内容
        self.ContexSize = 0
        self.Contex = ""
        -- 私聊对象的角色色名字，仅在CHAT_TYPE_TELL时有效
        self.TargetSize = 0
        self.TargetName = ""
        -- 队伍号，仅在队伍聊天时有效
        self.teamID = 0
        -- 频道号，自建聊天频道
        self.ChannelID = 0
        -- 帮派号，仅属于此帮派的成员有效
        self.GuildID = 0
        -- 门派值，仅门派内
        self.MenpaiID = 0

        self.unknow_1 = 0
        self.unknow_2 = 0
        self.unknow_3 = 0
        self.unknow_4 = 0
        self.uts = {}
        self.item_guids = {}
        self.pet_guids = {}
		self.raidID = 0
    end,
    bis = function(self, buffer)
        local stream    = bistream.new()
        stream:attach(buffer)
        self.ChatType = stream:readuchar()
        self.ContexSize = stream:readuint()
        self.Contex = stream:read(self.ContexSize)
        self.unknow_6 = stream:readuchar()
        self.unknow_7 = stream:read(self.unknow_6)
        self.unknow_8 = stream:readuint()
        self.unknow_9 = stream:readuchar()
        self.unknow_10 = stream:readuint()
        if self.ChatType == self.CHAT_TYPE.CHAT_TYPE_NORMAL then
            self.unknow_2 = stream:readushort()
        elseif self.ChatType == self.CHAT_TYPE.CHAT_TYPE_TEAM then
            self.teamID = stream:readushort()
        elseif self.ChatType == self.CHAT_TYPE.CHAT_TYPE_TELL then
            self.TargetSize = stream:readuchar()
            self.TargetName = gbk.toutf8(stream:read(self.TargetSize)) 
            self.unknow_2 = stream:readushort()
        elseif self.ChatType == self.CHAT_TYPE.CHAT_TYPE_CHANNEL then
            self.unknow_3 = stream:readushort()
        elseif self.ChatType == self.CHAT_TYPE.CHAT_TYPE_GUILD then
            self.unknow_4 = stream:readushort()
        elseif self.ChatType == self.CHAT_TYPE.CHAT_TYPE_MENPAI then
            self.unknow_5 = stream:readuchar()
        elseif self.ChatType == self.CHAT_TYPE.CHAT_TYPE_MAIL then
            self.dest_guid = stream:readint()
        elseif self.ChatType == define.ENUM_CHAT_TYPE.CHAT_TYPE_LEAGUE then
            self.unknow_2 = stream:readushort()
        elseif self.ChatType == define.ENUM_CHAT_TYPE.CHAT_TYPE_CITY then
            self.city = stream:readint()
        elseif self.ChatType == self.CHAT_TYPE.CHAT_RAID then
            self.raidID = stream:readushort()
        elseif self.ChatType == self.CHAT_TYPE.CHAT_RAID_TEAM then
            self.raidID = stream:readushort()
		-- else
            -- self.raidID = stream:readushort()
        end
        for i = 1, 3 do
            self.uts[i] = stream:readuchar()
        end
        for i = 1, 4 do
            local ut = self.uts[i]
            if ut == 1 then
                local guid = {}
                guid.world = stream:readchar()
                guid.server = stream:readchar()
                guid.series = stream:readint()
                self.item_guids[i] = guid
            elseif ut == 2 then
                local guid = packet.PetGUID.new()
                guid:bis(stream)
                self.pet_guids[i] = guid
            end
        end
    end
}

packet.GCChat = {
    xy_id = packet.XYID_GC_CHAT,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCChat})
        o:ctor()
        return o
    end,
    ctor = function(self)
        -- 聊天消息类型 enum CHAT_TYPE
        self.ChatType = 0
        -- 聊天内�?�数�?
        self.ContexSize = 0
        self.Contex = ""
        -- 私聊对象的�?�色名字，仅在CHAT_TYPE_TELL时有�?
        self.SourceSize = 0
        self.SourceName = ""
        self.Sourceid = 0

        self.unknow_1 = 0
        self.unknow_2 = 0
        self.unknow_3 = 0
        self.unknow_4 = -1
        self.unknow_5 = 0
        self.DestSize = 0
    end,
    set_source_name = function(self, srouce_name)
        self.SourceName = gbk.fromutf8(srouce_name)
        self.SourceSize = string.len(self.SourceName)
    end,
    set_dest_name = function(self, dest_name)
        self.DestName = gbk.fromutf8(dest_name)
        self.DestSize = string.len(self.DestName)
    end,
    set_content = function(self, content)
        self.Contex = content
        self.ContexSize = string.len(self.Contex)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.ChatType = stream:readuchar()
        self.ContexSize = stream:readuint()
        if self.ContexSize <= 320 then
            self.Contex = stream:read(self.ContexSize)
        end
        self.SourceSize = stream:readuchar()
        if self.SourceSize > 0 and self.SourceSize < 0x1E then
            self.SourceName = stream:read(self.SourceSize)
        end
        self.unknow_1 = stream:readuint()
        self.unknow_2 = stream:readuchar()
        self.unknow_3 = stream:readuint()
        self.unknow_4 = stream:readshort()
        self.unknow_5 = stream:readuint()
        self.DestSize = stream:readuchar()
        if self.DestSize < 0x1E then
            self.DestName = stream:read(self.DestSize)
        end
        if self.ChatType == 0 then
            self.Sourceid = stream:readuint()
            self.unknow_10 = stream:readshort()
        end
        if self.ChatType == 18 or self.ChatType == 24 then
            self.Sourceid = stream:readuint()
            self.mood_size = stream:readuchar()
            if self.mood_size > 0 and self.mood_size <= 0x20 then
                self.mood = stream:read(self.mood)
            end
            self.Destid = stream:readint()
        end
        self.unknow_11 = stream:readint()
        self.unknow_12 = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.ChatType)
        stream:writeuint(self.ContexSize)
        if self.ContexSize > 0 and self.ContexSize <= 320 then
            stream:write(self.Contex, self.ContexSize)
        end
        local SourceSize = string.len(self.SourceName)
        stream:writeuchar(SourceSize)
        if SourceSize < 0x1E then
            stream:write(self.SourceName, SourceSize)
        end
        stream:writeuint(self.unknow_1)
        stream:writeuchar(self.unknow_2)
        stream:writeuint(self.unknow_3)
        stream:writeshort(self.unknow_4)
        stream:writeuint(self.unknow_5)
        stream:writeuchar(self.DestSize)
        if self.DestSize > 0 and self.DestSize < 0x1E then
            stream:write(self.DestName, self.DestSize)
        end
        if self.ChatType == 0 then
            stream:writeuint(self.Sourceid)
            stream:writeshort(self.unknow_10 or 0)
        end
        if self.ChatType == 18 or self.ChatType == 24 then
            stream:writeuint(self.Sourceid)
            self.mood = gbk.fromutf8(self.mood or "")
            local len = string.len(self.mood)
            stream:writeuchar(len)
            if len <= 0x20 then
                stream:write(self.mood, len)
            end
            stream:writeint(self.Destid or define.INVAILD_ID)
        end
        stream:writeint(self.unknow_11 or 0)
        stream:writeuchar(self.unknow_12 or 0)
        return stream:get()
    end
}

packet.CGEnterScene = {
    xy_id = packet.XYID_CG_ENTER_SCENE,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGEnterScene})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_byEnterType = 0 -- 进入类型
        self.m_nSceneID = 0 -- 场景ID
        self.m_posWorld = {x = 0, y = 0} -- 进入点的X,Z坐标�?
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_nSceneID = stream:readushort()
        self.m_byEnterType = stream:readuchar()
        self.m_posWorld.x = stream:readfloat()
        self.m_posWorld.y = stream:readfloat()
    end
}

packet.GCEnterScene = {
    xy_id = packet.XYID_GC_ENTER_SCENE,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCEnterScene})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_byEnterType = 0
        self.sceneid = 0
        self.client_res = 0
        self.m_posWorld = {x = 0, y = 0}
        self.m_objID = 0
        self.unknow_4 = 0
        self.unknow_5 = 0
        self.unknow_6 = 0
        self.server_time = 0
        self.is_t_server = 0
        self.unknow_9 = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_byEnterType = stream:readuchar()
        self.sceneid = stream:readushort()
        self.client_res = stream:readushort()
        self.m_posWorld.x = stream:readfloat()
        self.m_posWorld.y = stream:readfloat()
        self.m_objID = stream:readuint()
        self.is_city = stream:readuchar()
        self.unknow_5 = stream:readuchar()
        self.unknow_6 = stream:readuint()
        self.server_time = stream:readuint()
        self.is_t_server = stream:readuint()
        self.server_id = stream:readushort()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.m_byEnterType)
        stream:writeushort(self.sceneid)
        stream:writeushort(self.client_res)
        stream:writefloat(self.m_posWorld.x)
        stream:writefloat(self.m_posWorld.y)
        stream:writeuint(self.m_objID)
        stream:writeuchar(self.is_city)
        stream:writeuchar(self.unknow_5)
        stream:writeuint(self.unknow_6)
        stream:writeuint(self.server_time)
        stream:writeuint(self.is_t_server)
        stream:writeushort(self.server_id)
        return stream:get()
    end
}

packet.CGAskDynamicRegion = {
    xy_id = packet.XYID_CG_ASK_DYNAMIC_REGION,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGAskDynamicRegion})
        o:ctor()
        return o
    end,
    ctor = function(self) self.unknow_1 = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readushort()
    end
}

packet.GCAskDynamicRegionResult = {
    xy_id = packet.XYID_GC_ASK_DYNAMIC_REGION_RESULT,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCAskDynamicRegionResult})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.size = 0
        self.list = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.size = stream:readuint()
        if self.size > 0 and self.size < 65 then
            for i = 1, self.size do
                local l = {}
                l.unknow_1 = stream:readuint()
                l.unknow_2 = stream:readuint()
                l.unknow_3 = stream:readuint()
                l.unknow_4 = stream:readuint()
                table.insert(self.list, l)
            end
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.size)
        if self.size > 0 and self.size < 65 then
            for i = 1, self.size do
                local l = self.list[i] or
                              {
                        unknow_1 = 0,
                        unknow_2 = 0,
                        unknow_3 = 0,
                        unknow_4 = 0
                    }
                stream:writeuint(l.unknow_1)
                stream:writeuint(l.unknow_2)
                stream:writeuint(l.unknow_3)
                stream:writeuint(l.unknow_4)
            end
        end
        return stream:get()
    end
}

packet.CGShopClose = {
    xy_id = packet.XYID_CG_SHOP_CLOSE,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGShopClose})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end
}

packet.CGExecuteScript = {
    xy_id = packet.XYID_CG_EXECUTE_SCRIPT,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGExecuteScript})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_ScriptID = 0
        self.m_uFunNameSize = 0
        self.m_szFunName = ""
        self.m_uParamCount = 0
        self.m_aParam = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_ScriptID = stream:readuint()
        self.m_uFunNameSize = stream:readuchar()
        if self.m_uFunNameSize > 0 and self.m_uFunNameSize <= 0x40 then
            self.m_szFunName = stream:read(self.m_uFunNameSize)
        end
        self.m_uParamCount = stream:readuchar()
        if self.m_uParamCount > 0 then
            for i = 1, self.m_uParamCount do
                self.m_aParam[i] = stream:readint()
            end
        end
    end
}

packet.GCNewMonster = {
    xy_id = packet.XYID_GC_NEW_MONSTER,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCNewMonster})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.world_pos = {}
        self.unknow_25 = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.unknow_1 = stream:readuint()
        self.unknow_2 = stream:readuint()
        self.unknow_3 = stream:readuint()
        self.unknow_4 = stream:readuint()
        self.guid = stream:readint()
        self.unknow_6 = stream:readuint()
        self.unknow_7 = stream:readuint()
        self.unknow_8 = stream:readuint()
        self.unknow_9 = stream:readuint()
        self.world_pos.x = stream:readfloat()
        self.world_pos.y = stream:readfloat()
        self.unknow_10 = stream:readuint()
        self.unknow_11 = stream:readuint()
        self.unknow_12 = stream:readuint()
        self.unknow_13 = stream:readuint()
        self.dir = stream:readfloat()
        self.unknow_15 = stream:readuint()
        self.unknow_16 = stream:readuint()
        self.unknow_17 = stream:readuint()
        self.unknow_18 = stream:readuint()
        self.speed = stream:readfloat()
        self.unknow_20 = stream:readuint()
        self.unknow_21 = stream:readuint()
        self.unknow_22 = stream:readuint()
        self.unknow_23 = stream:readuint()
        self.unknow_24 = stream:readint()
        for i = 1, 8 do self.unknow_25[i] = stream:readuchar() end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        stream:writeuint(self.unknow_1)
        stream:writeuint(self.unknow_2)
        stream:writeuint(self.unknow_3)
        stream:writeuint(self.unknow_4)
        stream:writeint(self.guid)
        stream:writeuint(self.unknow_6)
        stream:writeuint(self.unknow_7)
        stream:writeuint(self.unknow_8)
        stream:writeuint(self.unknow_9)
        stream:writefloat(self.worldPos.x)
        stream:writefloat(self.worldPos.y)
        stream:writeuint(self.unknow_10)
        stream:writeuint(self.unknow_11)
        stream:writeuint(self.unknow_12)
        stream:writeuint(self.unknow_13)
        stream:writefloat(self.dir)
        stream:writeuint(self.unknow_15)
        stream:writeuint(self.unknow_16)
        stream:writeuint(self.unknow_17)
        stream:writeuint(self.unknow_18)
        stream:writefloat(self.speed)
        stream:writeuint(self.unknow_20)
        stream:writeuint(self.unknow_21)
        stream:writeuint(self.unknow_22)
        stream:writeuint(self.unknow_23)
        stream:writeint(self.unknow_24)
        for i = 1, 8 do stream:writeuchar(self.unknow_25[i] or 0) end
        return stream:get()
    end
}

packet.GCNewPlatform = {
    xy_id = packet.XYID_GC_NEW_PLATFORM,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.GCNewPlatform})
        o:ctor()
        return o
    end, 
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream    = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readint()
        self.world_pos = {}
        self.world_pos.x = stream:readfloat()
        self.world_pos.y = stream:readfloat()
        self.dir = stream:readfloat()
        self.class = stream:readuchar()
        local size = stream:readuchar()
        if size > 0 and size < 0x20 then
            self.desc = stream:read(size)
        end
        self.desc = gbk.toutf8(self.desc)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.m_objID)
        stream:writefloat(self.world_pos.x)
        stream:writefloat(self.world_pos.y)
        stream:writefloat(self.dir)
        stream:writeuchar(self.class)
        self.desc = gbk.fromutf8(self.desc)
        local len = string.len(self.desc)
        stream:writeuchar(len)
        stream:write(self.desc, len)
        return stream:get()
    end
}

packet.GCNewPlayer = {
    xy_id = packet.XYID_GC_NEW_PLAYER,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCNewPlayer})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_objID = 0 -- ObjID
        self.unknow_1 = 0
        self.m_posWorld = {x = 0, y = 0} -- 位置
        self.m_fDir = 0 -- 方向
        self.m_wEquipVer = 0 --  玩�?�的装�?�版�?�?
        self.m_fMoveSpeed = 0 -- 移动速度
        self.unknow_2 = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.unknow_1 = stream:readuint()
        self.m_posWorld.x = stream:readfloat()
        self.m_posWorld.y = stream:readfloat()
        self.m_fDir = stream:readfloat()
        self.m_fMoveSpeed = stream:readfloat()
        self.m_wEquipVer = stream:readuint()
        self.unknow_2 = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        stream:writeuint(self.unknow_1)
        stream:writefloat(self.m_posWorld.x)
        stream:writefloat(self.m_posWorld.y)
        stream:writefloat(self.m_fDir)
        stream:writefloat(self.m_fMoveSpeed)
        stream:writeuint(self.m_wEquipVer)
        stream:writeuint(self.unknow_2)

        return stream:get()
    end
}

packet.GCChatDecryption = {
    xy_id = packet.XYID_GC_CHAT_DECRYPTION,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCChatDecryption})
        o:ctor()
        return o
    end,
    ctor = function(self) self.key = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.key = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.key)
        return stream:get()
    end
}

packet.GCUICommand = {
    xy_id = packet.XYID_GC_UI_COMMAND,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCUICommand})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_Param = {
            m_IntCount = 0,
            m_StrCount = 0,
            m_aIntValue = {},
            m_aStrOffset = {}
        }
        self.m_nUIIndex = 0
        self.unknow = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_Param.m_IntCount = stream:readuchar()
        self.m_Param.m_StrCount = stream:readuchar()
        if self.m_Param.m_IntCount > 0 and self.m_Param.m_IntCount < 0x10 then
            for i = 1, self.m_Param.m_IntCount do
                self.m_Param.m_aIntValue[i] = stream:readint()
            end
        end
        if self.m_Param.m_StrCount > 0 and self.m_Param.m_StrCount < 0x10 then
            for i = 1, self.m_Param.m_StrCount do
                self.m_Param.m_aStrOffset[i] = stream:readushort()
            end
            for i = 1, self.m_Param.m_StrCount do
                local len = self.m_Param.m_aStrOffset[i] - (self.m_Param.m_aStrOffset[i - 1] or 0)
                self.m_Param.m_aStrValue[i] = stream:read(len)
            end
            stream:read(1)
        end
        self.m_nUIIndex = stream:readuint()
        self.unknow = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.m_Param.m_IntCount)
        stream:writeuchar(self.m_Param.m_StrCount)
        if self.m_Param.m_IntCount > 0 and self.m_Param.m_IntCount < 0x10 then
            for i = 1, self.m_Param.m_IntCount do
                stream:writeint(self.m_Param.m_aIntValue[i])
            end
        end
        if self.m_Param.m_StrCount > 0 and self.m_Param.m_StrCount < 0x10 then
            local len = 0
            for i = 1, self.m_Param.m_StrCount do
                stream:writeushort(self.m_Param.m_aStrOffset[i])
                len = self.m_Param.m_aStrOffset[i]
            end
            stream:write(self.m_Param.m_aStrValue, len + 1)
        end
        stream:writeuint(self.m_nUIIndex)
        stream:writeuint(self.unknow)
        return stream:get()
    end
}

packet.GCNotifyMail = {
    xy_id = packet.XYID_GC_NOTIFY_MAIL,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCNotifyMail})
        o:ctor()
        return o
    end,
    ctor = function(self) self.m_MailCount = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_MailCount = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        self.m_MailCount = self.m_MailCount > define.UCHAR_MAX and define.UCHAR_MAX or self.m_MailCount
        stream:writeuchar(self.m_MailCount)
        return stream:get()
    end
}

packet.WGCCTUGabrielCommond = {
    xy_id = packet.XYID_WGC_CTU_GABRIEL_COMMOND,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.WGCCTUGabrielCommond})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = 0
        self.len = 0
        self.data = ""
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readushort()
        self.len = stream:readushort()
        self.data = stream:read(self.len)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeushort(self.unknow_1)
        stream:writeushort(self.len)
        stream:write(self.data, self.len)
        return stream:get()
    end
}

packet.GCCharBaseAttrib = {
    xy_id = packet.XYID_GC_CHAR_BASE_ATTRIB,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCCharBaseAttrib})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_uFlags = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
        self.data_id = 1
        self.unknow_14 = 0xffffffff
        self.stall_is_open = 0
        self.stall_name_len = 0
        self.stall_name = ""
        self.unknow_24 = 0xffffffff
        self.new_player_set = 0
        self.unknow_27 = 0
        self.unknow_28 = 0xffffffff --双骑
        self.unknow_3 = -1
        self.bus_id = -1
        self.is_in_team = 0
        self.is_team_leader = 0
        self.unknow_33 = 0
        self.unknow_34 = 0
        self.unknow_35 = 0xffffffff
        self.guild_id = -1
        self.unknow_39 = 571
        self.unknow_4 = 0
        self.pk_mode = 0
        self.pk_value = 0
        self.unknow_43 = -1
        self.confederate_id = -1
        self.unknow_53 = 0
        self.unknow_54 = 0
        self.server_id = 1
        self.guild_name = ""
        self.pet_soul_melting_model = -1
        self.unknow_8 = 1
        self.unknow_10 = 0xff
        self.attackers = {}
        self.pk_declaration_list = {}
        self.unknow_53 = 1
        self.unknow_56 = 0
        self.raid_id = -1
        self.unknow_64 = -1
        self.unknow_68 = 0
        self.have_raid = 0
        self.position_0 = 0
        self.position_1 = 0
        self.raid_is_full = 0
        self.team_occipant_guid = define.INVAILD_ID
        self.raid_occipant_guid = define.INVAILD_ID
		self.wegame_limited = 0
		self.unkown_73 = 0
		self.huayulu_speed = 0
		self.luomajian_sub = 0	--落马剑抵御速度
		--背饰
		self.exterior_back_id = 0
		self.exterior_back_pos = 0
		--头饰
		self.exterior_head_id = 0
		self.exterior_head_pos = 0
		--无用
		self.unkown_74 = 0
		--背饰位置
		self.OrnamentsBackX = 0
		self.OrnamentsBackY = 0
		self.OrnamentsBackZ = 0
		--头饰位置
		self.OrnamentsHeadX = 0
		self.OrnamentsHeadY = 0
		self.OrnamentsHeadZ = 0
    end,
    set_new_player_set = function(self, set)
        self.new_player_set = set
        self.m_uFlags[3] = self.m_uFlags[3] | 0x80
    end,
    set_name = function(self, name)
        if name then
            self.m_szName = gbk.fromutf8(name)
            self.m_byNameSize = string.len(self.m_szName)
            self.m_uFlags[1] = self.m_uFlags[1] | 0x2
            print("set_name m_szName =", self.m_szName, ";m_byNameSize =",
                  self.m_byNameSize)
        else
            self.m_uFlags[1] = self.m_uFlags[1] & ~0x2
        end
    end,
    set_title = function(self, title)
        if title then
            self.m_szTitle = gbk.fromutf8(title.str or "")
            self.m_byTitleSize = string.len(self.m_szTitle)
            self.m_TitleType = title.id or 0
            self.new_title_id = title.new_title_id or define.INVAILD_ID
            self.remain_time = 0
            self.m_uFlags[1] = self.m_uFlags[1] | 0x4
            self.title_is_hide = title.is_hide and 1 or 0
        else
            self.m_uFlags[1] = self.m_uFlags[1] & ~0x4
        end
    end,
    set_ride_model = function(self, ridermodel)
        if ridermodel then
            self.m_uFlags[2] = self.m_uFlags[2] | 0x20
            self.ride_model = ridermodel
        else
            self.m_uFlags[2] = self.m_uFlags[2] & ~0x20
        end
    end,
    set_speed = function(self, speed)
        if speed then
            self.speed = speed
            self.m_uFlags[2] = self.m_uFlags[2] | 0x2
        else
            self.m_uFlags[2] = self.m_uFlags[2] & (~0x2)
        end
    end,
    set_data_id = function(self, data_id)
        self.data_id = data_id
    end,
    set_hp = function()
    end,
    set_mp = function()
    end,
    set_hp_max = function()
    end,
    set_mp_max = function()
    end,
    set_hp_percent = function(self, percent)
        self.hp_percent = percent
        self.m_uFlags[1] = self.m_uFlags[1] | 0x10
    end,
    set_portrait_id = function(self, id)
        self.portrait_id  = id
        self.m_uFlags[2] = self.m_uFlags[2] | 0x8
    end,
    set_model_id = function(self, model_id)
        if model_id then
            self.m_uFlags[2] = self.m_uFlags[2] | 0x10
            self.model_id = model_id
        end
    end,
    set_occupant_guid = function(self, guid)
        self.occupant_guid = guid
        self.m_uFlags[3] = self.m_uFlags[3] | 0x10
    end,
    set_mp_percent = function(self, percent)
        self.mp_percent = percent
        self.m_uFlags[1] = self.m_uFlags[1] | 0x20
    end,
    set_rage = function(self, rage)
        self.rage = rage
        self.m_uFlags[1] = self.m_uFlags[1] | 0x40
    end,
    set_stealth_level = function(self, stealth_level)
        self.stealth_level = stealth_level
        self.m_uFlags[1] = self.m_uFlags[1] | 0x80
    end,
    set_is_sit = function(self, is_sit)
        self.is_sit = is_sit
        self.m_uFlags[2] = self.m_uFlags[2] | 0x1
    end,
    set_attack_speed = function(self, attack_speed)
        self.attack_speed = attack_speed
        self.m_uFlags[2] = self.m_uFlags[2] | 0x4
    end,
    set_pk_mode = function(self, pk_mode)
        self.pk_mode = pk_mode
        self.m_uFlags[5] = self.m_uFlags[5] | 0x8
    end,
    set_reputation = function(self, reputation)
        self.reputation = reputation
        self.m_uFlags[5] = self.m_uFlags[5] | 0x40
    end,
    set_model = function(self, model)
        self.model = model
        self.m_uFlags[1] = self.m_uFlags[1] | 0x1
    end,
    set_face_style = function(self, face_style)
        self.face_style = face_style
        self.m_uFlags[2] = self.m_uFlags[2] | 0x80
    end,
    set_hair_style = function(self, hair_style)
        self.hair_style = hair_style
        self.m_uFlags[3] = self.m_uFlags[3] | 0x1
    end,
    set_hair_color = function(self, color)
        self.hair_color = color
        self.m_uFlags[3] = self.m_uFlags[3] | 0x2
    end,
    set_guid = function(self, guid)
        self.guid = guid
        self.m_uFlags[5] = self.m_uFlags[5] | 0x4
    end,
    set_level = function(self, level)
        self.level = level
        self.m_uFlags[1] = self.m_uFlags[1] | 0x8
    end,
    set_owner_id = function(self, owner_id)
        self.owner_id = owner_id
        self.m_uFlags[3] = self.m_uFlags[3] | 0x20
    end,
    set_team_id = function(self, team_id)
        self.team_id = team_id
        self.m_uFlags[4] = self.m_uFlags[4] | 0x40
    end,
    set_pet_soul_melting_model = function(self, soul_melting_model)
        self.pet_soul_melting_model = soul_melting_model
        self.m_uFlags[7] = self.m_uFlags[7] | 0x40
    end,
    set_is_in_team = function(self, in_team)
        self.is_in_team = in_team
        self.m_uFlags[4] = self.m_uFlags[4] | 0x4
    end,
    set_is_team_leader = function(self, is_team_leader)
        self.is_team_leader = is_team_leader
        self.m_uFlags[4] = self.m_uFlags[4] | 0x4
    end,
    set_camp_id = function(self, camp_id)
        self.camp_id = camp_id
        self.m_uFlags[5] = self.m_uFlags[5] | 0x20
    end,
    set_stall_is_open = function(self, is_open)
        self.stall_is_open = is_open and 1 or 0
        self.m_uFlags[3] = self.m_uFlags[3] | 0x4
    end,
    set_stall_name = function(self, name)
        self.stall_name = gbk.fromutf8(name)
        self.stall_name_len = string.len(self.stall_name)
        self.m_uFlags[3] = self.m_uFlags[3] | 0x8
    end,
    set_attackers_list = function(self, list)
        self.attackers = {}
        for guid, time in pairs(list) do
            table.insert(self.attackers, { guid = guid, time = time})
        end
        self.m_uFlags[5] = self.m_uFlags[5] | 0x80
    end,
    set_pk_declaration_list = function(self, list)
        self.pk_declaration_list = {}
        for guid, time in pairs(list) do
            table.insert(self.pk_declaration_list, { guid = guid, time = time})
        end
        self.m_uFlags[6] = self.m_uFlags[6] | 0x8
    end,
    set_pet_soul_item_index = function(self, item_index)
        self.pet_soul_item_index = item_index
        self.m_uFlags[8] = self.m_uFlags[8] | 0x40
    end,
    set_guild_name = function(self, guild_name)
        self.guild_name = guild_name
        self.m_uFlags[7] = self.m_uFlags[7] | 0x04
    end,
    set_guild_id = function(self, guild_id)
        self.guild_id = guild_id
        self.m_uFlags[5] = self.m_uFlags[5] | 0x80
    end,
    set_confederate_id = function(self, confederate_id)
        self.confederate_id = confederate_id
        self.m_uFlags[7] = self.m_uFlags[7] | 0x1
    end,
    set_raid_id = function(self, raid_id)
        self.raid_id = raid_id
        self.m_uFlags[7] = self.m_uFlags[7] | 0x8
		if raid_id ~= -1 then
			self.have_raid = 1
		else
			self.have_raid = 0
		end
		self.m_uFlags[7] = self.m_uFlags[7] | 0x10
    end,
    set_raid_position = function(self, raid_position)
		if raid_position == define.RAID_POISTION.RAID_POISTION_LEADER then
			self.position_0 = 1
			self.position_1 = 0
		elseif raid_position == define.RAID_POISTION.RAID_POISTION_ASSISTANT then
			self.position_0 = 0
			self.position_1 = 1
		else
			self.position_0 = 0
			self.position_1 = 0
		end
        self.m_uFlags[7] = self.m_uFlags[7] | 0x10
    end,
    set_raid_is_full = function(self, raid_is_full)
        self.raid_is_full = raid_is_full
        self.m_uFlags[7] = self.m_uFlags[7] | 0x10
    end,
    set_server_id = function(self, server_id)
        self.server_id = server_id
        self.m_uFlags[8] = self.m_uFlags[8] | 0x20
    end,
    set_team_occipant_guid = function(self, team_occipant_guid)
        self.team_occipant_guid = team_occipant_guid
        self.m_uFlags[8] = self.m_uFlags[8] | 0x40
    end,
    set_raid_occipant_guid = function(self, raid_occipant_guid)
        self.raid_occipant_guid = raid_occipant_guid
        self.m_uFlags[8] = self.m_uFlags[8] | 0x80
    end,
    set_pk_value = function(self, pk_value)
        self.pk_value = pk_value
        self.m_uFlags[5] = self.m_uFlags[5] | 0x10
    end,
    set_bus_id = function(self, bus_id)
        self.bus_id = bus_id
        self.m_uFlags[4] = self.m_uFlags[4] | 0x2
    end,
    set_wild_war_guilds = function(self, wild_war_guilds)
        self.wild_war_guilds = {}
        for id in pairs(wild_war_guilds) do
            table.insert(self.wild_war_guilds, { id = id})
        end
        self.m_uFlags[6] = self.m_uFlags[6] | 0x2
    end,
    set_current_title = function(self, current_title)
        self.current_title = current_title
        self.m_uFlags[6] = self.m_uFlags[6] | 0x40
    end,
	--下面的头饰、背饰数据任何人请求的时候都要发送
	set_exterior_back_id = function(self,exterior_back_id)
		self.exterior_back_id = exterior_back_id
        self.m_uFlags[10] = self.m_uFlags[10] | 0x4
	end,
	set_exterior_back_pos = function(self,exterior_back_pos)
		self.exterior_back_pos = exterior_back_pos
		self.m_uFlags[10] = self.m_uFlags[10] | 0x4
	end,
	set_exterior_head_id = function(self,exterior_head_id)
		self.exterior_head_id = exterior_head_id
        self.m_uFlags[10] = self.m_uFlags[10] | 0x8
	end,
	set_exterior_head_pos = function(self,exterior_head_pos)
		self.exterior_head_pos = exterior_head_pos
		self.m_uFlags[10] = self.m_uFlags[10] | 0x8
	end,
	
	
	
	--设置背饰数据
	-- set_OrnamentsBack = function(self, backExteriorId,backPos)
        -- self.OrnamentsBack = backExteriorId
		-- self.OrnamentsBack_Param = backPos
        -- self.m_uFlags[10] = self.m_uFlags[10] | 0x4
    -- end,
	--设置头饰数据
	-- set_OrnamentsHead = function(self, headExteriorId,headPos)
        -- self.OrnamentsHead = headExteriorId
		-- self.OrnamentsHead_Param = headPos
        -- self.m_uFlags[10] = self.m_uFlags[10] | 0x8
    -- end,
	
	
    bis = function(self, buffer)
        
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        stream:writeuchar(self.data_id)
        for i = 1, 11 do stream:writeuchar(self.m_uFlags[i]) end
        if self.m_uFlags[1] & 0x1 == 0x1 then
            stream:writeuint(self.model)
        end
        if self.m_uFlags[1] & 0x2 == 0x2 then
            stream:writeuchar(self.m_byNameSize)
            if self.m_byNameSize > 0 and self.m_byNameSize < 0x1E then
                stream:write(self.m_szName, self.m_byNameSize)
            end
        end
        if self.m_uFlags[1] & 0x4 == 0x4 then
            stream:writeuchar(self.m_byTitleSize)
            if self.m_byTitleSize > 0 and self.m_byTitleSize < 0x22 then
                stream:write(self.m_szTitle, self.m_byTitleSize)
            end
            stream:writeuint(self.m_TitleType)
            stream:writeint(self.new_title_id or define.INVAILD_ID)
            stream:writeuint(self.title_is_hide)
        end

        if self.m_uFlags[1] & 0x8 == 0x8 then
            self.level = self.level > define.UCHAR_MAX and define.UCHAR_MAX or self.level
            stream:writeuchar(self.level)
        end
        if self.m_uFlags[1] & 0x10 == 0x10 then
            stream:writeuchar(self.hp_percent)
        end
        if self.m_uFlags[1] & 0x20 == 0x20 then
            stream:writeuchar(self.mp_percent)
        end
        if self.m_uFlags[1] & 0x40 == 0x40 then
            stream:writeuint(self.rage)
        end
        if self.m_uFlags[1] & 0x80 == 0x80 then
            stream:writeuint(self.stealth_level)
        end
        if self.m_uFlags[2] & 0x1 == 0x1 then
            stream:writeint(self.is_sit)
            stream:writeint(define.INVAILD_ID)
        end
        if self.m_uFlags[2] & 0x2 == 0x2 then
            stream:writefloat(self.speed)
        end
        if self.m_uFlags[2] & 0x4 == 0x4 then
            stream:writefloat(self.attack_speed)
        end
        if self.m_uFlags[2] & 0x8 == 0x8 then
            stream:writeuint(self.portrait_id)
        end
        if self.m_uFlags[2] & 0x10 == 0x10 then
            stream:writeint(self.model_id)
        end
        if self.m_uFlags[2] & 0x20 == 0x20 then
            stream:writeint(self.ride_model)
        end
        if self.m_uFlags[2] & 0x40 == 0x40 then
            stream:writeint(self.ai_type)
        end
        if self.m_uFlags[2] & 0x80 == 0x80 then
            stream:writeushort(self.face_style)
        end
        if self.m_uFlags[3] & 0x1 == 0x1 then
            stream:writeushort(self.hair_style)
        end
        if self.m_uFlags[3] & 0x2 == 0x2 then
            stream:writeint(self.hair_color)
        end
        if self.m_uFlags[3] & 0x4 == 0x4 then
            stream:writeuchar(self.stall_is_open)
        end
        if self.m_uFlags[3] & 0x8 == 0x8 then
            stream:writeuchar(self.stall_name_len)
            if self.stall_name_len > 0 then
                stream:write(self.stall_name, self.stall_name_len)
            end
        end
        if self.m_uFlags[3] & 0x10 == 0x10 then
            stream:writeint(self.occupant_guid)
        end
        if self.m_uFlags[3] & 0x20 == 0x20 then
            stream:writeint(self.owner_id)
        end
        if self.m_uFlags[3] & 0x40 == 0x40 then
            stream:writeint(self.owner_id)
        end
        if self.m_uFlags[3] & 0x80 == 0x80 then
            stream:writeuint(self.new_player_set)
        end
        if self.m_uFlags[4] & 0x1 == 0x1 then
            stream:writeuchar(self.unknow_27)
            stream:writeuint(self.unknow_28)
        end
        if self.m_uFlags[5] & 0x4 == 0x4 then
            stream:writeint(self.guid)
        end
        if self.m_uFlags[4] & 0x2 == 0x2 then
            stream:writeint(self.bus_id)
        end
        if self.m_uFlags[4] & 0x4 == 0x4 then
            stream:writeuchar(self.is_in_team)
            stream:writeuchar(self.is_team_leader)
            stream:writeuchar(self.unknow_33)
        end
        if self.m_uFlags[4] & 0x20 == 0x20 then
            stream:writeuint(self.unknow_34)
        end
        if self.m_uFlags[5] & 0x2 == 0x2 then
            stream:writeuint(self.unknow_35)
        end
        if self.m_uFlags[4] & 0x40 == 0x40 then
            stream:writeshort(self.team_id)
        end
        if self.m_uFlags[4] & 0x8 == 0x8 then
            stream:writeuint(self.unknow_37)
        end
        if self.m_uFlags[4] & 0x80 == 0x80 then
            stream:writeshort(self.guild_id)
        end
        if self.m_uFlags[6] & 0x80 == 0x80 then
            stream:writeuint(self.unknow_39)
        end
        if self.m_uFlags[5] & 0x1 == 0x1 then
            stream:writeushort(self.menpai)
        end
        if self.m_uFlags[5] & 0x8 == 0x8 then
            stream:writeuchar(self.pk_mode)
        end
        if self.m_uFlags[5] & 0x10 == 0x10 then
            stream:writeint(self.pk_value)
        end
        if self.m_uFlags[5] & 0x20 == 0x20 then
            stream:writeshort(self.camp_id or define.INVAILD_ID)
        end
        if self.m_uFlags[5] & 0x40 == 0x40 then
            stream:writeshort(self.reputation)
        end
        if self.m_uFlags[5] & 0x80 == 0x80 then
            if self.m_uFlags[7] & 0x80 == 0x80 then

            else
                table.sort(self.attackers, function(a1, a2)
                    return a1.time > a2.time
                end)
                for i = 1, 30 do
                    local a = self.attackers[i] or {}
                    stream:writeint(a.guid or define.INVAILD_ID)
                    stream:writeuint(a.time or 0)
                end
            end
        end
        if self.m_uFlags[6] & 0x1 == 0x1 then
            if self.m_uFlags[8] & 0x1 == 0x1 then
                -- sub_4596B0(v2 + 500);
            else
                stream:write(self.unknow_46, 0x28)
            end
        end
        if self.m_uFlags[6] & 0x2 == 0x2 then
            if self.m_uFlags[8] & 0x2 == 0x2 then
                -- sub_4596B0(v2 + 540);
            else
                for i = 1, 5 do
                    local wild_war = self.wild_war_guilds[i] or { id = -1, unknow = 0}
                    stream:writeint(wild_war.id)
                    stream:writeint(wild_war.unknow or 0)
                end
            end
        end
        if self.m_uFlags[6] & 0x4 == 0x4 then
            if self.m_uFlags[8] & 0x4 == 0x4 then
                -- sub_4596B0(v2 + 540);
            else
                stream:write(self.unknow_48, 0x28)
            end
        end
        if self.m_uFlags[6] & 0x8 == 0x8 then
            if self.m_uFlags[8] & 0x8 == 0x8 then
                -- sub_4596E0(v2 + 620);
            else
                for i = 1, 6 do
                    local d = self.pk_declaration_list[i] or {}
                    stream:writeint(d.guid or define.INVAILD_ID)
                    stream:writeuint(d.time or 0)
                end
            end
        end
        if self.m_uFlags[6] & 0x20 == 0x20 then
            stream:writeuint(self.unknow_50)
        end
        if self.m_uFlags[6] & 0x40 == 0x40 then
            stream:writeint(self.current_title or define.INVAILD_ID)
        end
        if self.m_uFlags[7] & 0x1 == 0x1 then
            stream:writeshort(self.confederate_id)
        end
        if self.m_uFlags[7] & 0x2 == 0x2 then
            stream:writeuchar(self.unknow_53)
        end
        if self.m_uFlags[8] & 0x10 == 0x10 then
            stream:writeint(self.unknow_56)
        end
        if self.m_uFlags[8] & 0x20 == 0x20 then
            stream:writeshort(self.server_id)
        end
        if self.m_uFlags[8] & 0x40 == 0x40 then
            stream:writeshort(self.team_occipant_guid)
        end
        if self.m_uFlags[8] & 0x80 == 0x80 then
            stream:writeshort(self.raid_occipant_guid)
        end
        if self.m_uFlags[9] & 0x1 == 0x1 then
            stream:writeint(self.unknow_63)
        end
        if self.m_uFlags[7] & 0x4 == 0x4 then
            self.guild_name = gbk.fromutf8(self.guild_name)
            stream:write(self.guild_name, 0x18)
        end
        if self.m_uFlags[7] & 0x20 == 0x20 then
            stream:writeint(self.unknow_64)
        end
        if self.m_uFlags[7] & 0x40 == 0x40 then
            stream:writeshort(self.pet_soul_melting_model)
        end
        if self.m_uFlags[9] & 0x2 == 0x2 then
            stream:writeint(self.unknow_65)
        end
        if self.m_uFlags[9] & 0x4 == 0x4 then
            stream:writechar(self.unknow_66)
        end
        if self.m_uFlags[9] & 0x20 == 0x20 then
            stream:writeint(self.unknow_67)
        end
        if self.m_uFlags[9] & 0x8 == 0x8 then
            stream:writechar(self.unknow_68)
        end
        if self.m_uFlags[7] & 0x8 == 0x8 then
			--团队ID
            stream:writeshort(self.raid_id)
        end
        if self.m_uFlags[7] & 0x10 == 0x10 then
			--是否拥有团队
            stream:writechar(self.have_raid)
			--是否团长
            stream:writechar(self.position_0)
			--是否小队长
            stream:writechar(self.position_1)
			--团队是否满
            stream:writechar(self.raid_is_full)
        end
		if self.m_uFlags[9] & 0x40 == 0x40 then
			stream:writechar(self.wegame_limited)
        end
		if self.m_uFlags[9] & 0x80 == 0x80 then
			stream:writeint(self.unkown_73)
        end
		if self.m_uFlags[10] & 0x1 == 0x1 then
			stream:writeshort(self.huayulu_speed)
        end
		if self.m_uFlags[10] & 0x2 == 0x2 then
			stream:writeshort(self.luomajian_sub)
        end
		if self.m_uFlags[10] & 0x4 == 0x4 then
			stream:writeshort(self.exterior_back_id)
			stream:writeint(self.exterior_back_pos)
        end
		if self.m_uFlags[10] & 0x8 == 0x8 then
			stream:writeshort(self.exterior_head_id)
			stream:writeint(self.exterior_head_pos)
        end
		if self.m_uFlags[10] & 0x10 == 0x10 then
			stream:writeint(self.unkown_74)
        end
		if self.m_uFlags[10] & 0x20 == 0x20 then
			stream:writeint(self.OrnamentsBackX)
        end
		if self.m_uFlags[10] & 0x40 == 0x40 then
			stream:writeint(self.OrnamentsBackY)
        end
		if self.m_uFlags[10] & 0x80 == 0x80 then
			stream:writeint(self.OrnamentsBackZ or -1)
        end
		if self.m_uFlags[11] & 0x1 == 0x1 then
			stream:writeint(self.OrnamentsHeadX or -1)
        end
		if self.m_uFlags[11] & 0x2 == 0x2 then
			stream:writeint(self.OrnamentsHeadY or -1)
        end
		if self.m_uFlags[11] & 0x4 == 0x4 then
			stream:writeint(self.OrnamentsHeadZ or -1)
        end
        return stream:get()
    end
}


-- Todo
packet.GCDetailAttrib = {
    xy_id = packet.XYID_GC_DETAIL_ATTRIB,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCDetailAttrib})
        o:ctor()
        return o
    end,
    set_hp = function(self, hp)
        self.flags[1] = self.flags[1] or 0
        if hp then
            self.flags[1] =  self.flags[1] | 0x2
            self.hp = hp
        else
            self.flags[1] = self.flags[1] & ~0x2
        end
    end,
    set_mp = function(self, mp)
        self.flags[1] = self.flags[1] or 0
        if mp then
            self.flags[1] =  self.flags[1] | 0x4
            self.mp = mp
        else
            self.flags[1] = self.flags[1] & ~0x4
        end
    end,
    set_ride_model = function(self, ride_model)
        self.flags[8] = self.flags[8] or 0
        if ride_model then
            self.flags[8] =  self.flags[8] | 0x8
            self.ride_model = ride_model
        else
            self.flags[8] = self.flags[8] & ~0x8
        end
    end,
    set_exterior_face_style_index = function(self, id)
        self.flags[15] = self.flags[15] or 0
        if id then
            self.flags[15] =  self.flags[15] | 0x80
            self.exterior_face_style_index = id
        else
            self.flags[15] = self.flags[15] & ~0x80
        end
    end,
    set_exterior_hair_style_index = function(self, id)
        self.flags[16] = self.flags[16] or 0
        if id then
            self.flags[16] =  self.flags[16] | 0x1
            self.exterior_hair_style_index = id
        else
            self.flags[16] = self.flags[16] & ~0x1
        end
    end,
    set_exterior_portrait_index = function(self, id)
        self.flags[16] = self.flags[16] or 0
        if id then
            self.flags[16] =  self.flags[16] | 0x2
            self.exterior_portrait_index = id
        else
            self.flags[16] = self.flags[16] & ~0x2
        end
    end,
    set_fashion_depot_index = function(self, index)
        self.flags[16] = self.flags[16] or 0
        if index then
            self.flags[16] =  self.flags[16] | 0x4
            self.fashion_depot_index = index
        else
            self.flags[16] = self.flags[16] & ~0x4
        end
    end,
    set_exterior_weapon_visual_id = function(self, index)
        self.flags[16] = self.flags[16] or 0
        if index then
            self.flags[16] =  self.flags[16] | 0x20
            self.exterior_weapon_visual_id = index
        else
            self.flags[16] = self.flags[16] & ~0x20
        end
    end,
    set_exterior_weapon_selcet_level = function(self, index)
        self.flags[16] = self.flags[16] or 0
        if index then
            self.flags[16] =  self.flags[16] | 0x40
            self.exterior_weapon_selcet_level = index
        else
            self.flags[16] = self.flags[16] & ~0x40
        end
    end,
    set_exp = function(self, exp)
        if exp then
            self.flags[1] =  self.flags[1] | 0x8
            self.exp = exp
        else
            self.flags[1] =  self.flags[1] & ~0x8
        end
    end,
    set_attrib_att_magic = function(self, attrib_att_magic)
        if attrib_att_magic then
            self.flags[2] =  self.flags[2] | 0x20
            self.attrib_att_magic = attrib_att_magic
        end
    end,
    set_attrib_att_physics = function(self, attrib_att_physics)
        if attrib_att_physics then
            self.flags[2] =  self.flags[2] | 0x8
            self.attrib_att_physics = attrib_att_physics
        end
    end,
    set_attrib_def_magic = function(self, attrib_def_magic)
        if attrib_def_magic then
            self.flags[2] =  self.flags[2] | 0x40
            self.attrib_def_magic = attrib_def_magic
        end
    end,
    set_attrib_def_physics = function(self, attrib_def_physics)
        if attrib_def_physics then
            self.flags[2] =  self.flags[2] | 0x10
            self.attrib_def_physics = attrib_def_physics
        end
    end,
    set_attrib_hit = function(self, attrib_hit)
        if attrib_hit then
            self.flags[3] =  self.flags[3] | 0x8
            self.attrib_hit = attrib_hit
        end
    end,
    set_attrib_miss = function(self, attrib_miss)
        if attrib_miss then
            self.flags[3] =  self.flags[3] | 0x10
            self.attrib_miss = attrib_miss
        end
    end,
    set_hp_max = function(self, hp_max)
        if hp_max then
            self.flags[2] =  self.flags[2] | 0x80
            self.hp_max = hp_max
        end
    end,
    set_mp_max = function(self, mp_max)
        if mp_max then
            self.flags[3] =  self.flags[3] | 0x1
            self.mp_max = mp_max
        end
    end,
    set_level = function(self, level)
        if level then
            self.flags[1] =  self.flags[1] | 0x1
            self.level = level
        end
    end,
    set_ride = function(self, ride)
        if ride then
            self.flags[15] =  self.flags[15] | 0x40
            self.ride = ride
        end
    end,
    set_point_remain = function(self, point_remain)
        if point_remain then
            self.flags[2] =  self.flags[2] | 0x4
            self.point_remain = point_remain
        end
    end,
    set_mind_attack = function(self, mind_attack)
        if mind_attack then
            self.flags[3] =  self.flags[3] | 0x20
            self.mind_attack = mind_attack
        end
    end,
    set_mind_defend = function(self, mind_defend)
        if mind_defend then
            self.flags[3] =  self.flags[3] | 0x40
            self.mind_defend = mind_defend
        end
    end,
    set_rage = function(self, rage)
        if rage then
            self.flags[5] =  self.flags[5] | 0x4
            self.rage = rage
        end
    end,
    set_strike_point = function(self, strike_point)
        if strike_point then
            self.flags[5] =  self.flags[5] | 0x8
            self.strike_point = strike_point
        end
    end,
    set_datura_flower = function(self, datura_flower)
        if datura_flower then
            self.flags[16] =  self.flags[16] | 0x80
            self.datura_flower = datura_flower
        end
    end,
    set_att_cold = function(self, att_cold)
        if att_cold then
            self.flags[5] =  self.flags[5] | 0x40
            self.att_cold = att_cold
        end
    end,
    set_def_cold = function(self, def_cold)
        if def_cold then
            self.flags[5] =  self.flags[5] | 0x80
            self.def_cold = def_cold
        end
    end,
    set_reduce_def_cold = function(self, reduce_def_cold)
        if reduce_def_cold then
            self.flags[6] =  self.flags[6] | 0x1
            self.reduce_def_cold = reduce_def_cold
        end
    end,
    set_reduce_def_cold_low_limit = function(self, reduce_def_cold_low_limit)
        if reduce_def_cold_low_limit then
            self.flags[6] =  self.flags[6] | 0x2
            self.reduce_def_cold_low_limit = reduce_def_cold_low_limit
        end
    end,
    set_att_fire = function(self, att_fire)
        if att_fire then
            self.flags[6] =  self.flags[6] | 0x4
            self.att_fire = att_fire
        end
    end,
    set_def_fire = function(self, def_fire)
        if def_fire then
            self.flags[6] =  self.flags[6] | 0x8
            self.def_fire = def_fire
        end
    end,
    set_reduce_def_fire = function(self, reduce_def_fire)
        if reduce_def_fire then
            self.flags[6] =  self.flags[6] | 0x10
            self.reduce_def_fire = reduce_def_fire
        end
    end,
    set_reduce_def_fire_low_limit = function(self, reduce_def_fire_low_limit)
        if reduce_def_fire_low_limit then
            self.flags[6] =  self.flags[6] | 0x20
            self.reduce_def_fire_low_limit = reduce_def_fire_low_limit
        end
    end,
    set_att_light = function(self, att_light)
        if att_light then
            self.flags[6] =  self.flags[6] | 0x40
            self.att_light = att_light
        end
    end,
    set_def_light = function(self, def_light)
        if def_light then
            self.flags[6] =  self.flags[6] | 0x80
            self.def_light = def_light
        end
    end,
    set_reduce_def_light= function(self, reduce_def_light)
        if reduce_def_light then
            self.flags[7] =  self.flags[7] | 0x1
            self.reduce_def_light = reduce_def_light
        end
    end,
    set_reduce_def_light_low_limit= function(self, reduce_def_light_low_limit)
        if reduce_def_light_low_limit then
            self.flags[7] =  self.flags[7] | 0x2
            self.reduce_def_light_low_limit = reduce_def_light_low_limit
        end
    end,
    set_att_poison = function(self, att_poison)
        if att_poison then
            self.flags[7] =  self.flags[7] | 0x4
            self.att_poison = att_poison
        end
    end,
    set_def_poison = function(self, def_poison)
        if def_poison then
            self.flags[7] =  self.flags[7] | 0x8
            self.def_poison = def_poison
        end
    end,
    set_reduce_def_poison = function(self, reduce_def_poison)
        if reduce_def_poison then
            self.flags[7] =  self.flags[7] | 0x10
            self.reduce_def_poison = reduce_def_poison
        end
    end,
    set_reduce_def_poison_low_limit = function(self, reduce_def_poison_low_limit)
        if reduce_def_poison_low_limit then
            self.flags[7] =  self.flags[7] | 0x20
            self.reduce_def_poison_low_limit = reduce_def_poison_low_limit
        end
    end,
    set_menpai = function(self, menpai)
        if menpai then
            self.flags[7] =  self.flags[7] | 0x40
            self.menpai = menpai
        end
    end,
    set_speed = function(self, speed)
        if speed then
            self.flags[5] =  self.flags[5] | 0x10
            self.speed = speed
        end
    end,
    set_pk_mode = function(self, pk_mode)
        if pk_mode then
            self.flags[11] =  self.flags[11] | 0x2
            self.pk_mode = pk_mode
        end
    end,
    set_yuanbao = function(self, yuanbao)
        if yuanbao then
            self.flags[12] =  self.flags[12] | 0x10
            self.yuanbao = yuanbao
        end
    end,
    set_zengdian = function(self, zengdian)
        if zengdian then
            self.flags[15] =  self.flags[15] | 0x8
            self.zengdian = zengdian
        end
    end,
    set_bind_yuanbao = function(self, bind_yuanbao)
        if bind_yuanbao then
            self.flags[12] =  self.flags[12] | 0x20
            self.bind_yuanbao = bind_yuanbao
        end
    end,
    set_str = function(self, str)
        if str then
            self.flags[1] =  self.flags[1] | 0x20
            self.str = str
        end
    end,
    set_spr = function(self, spr)
        if spr then
            self.flags[1] =  self.flags[1] | 0x40
            self.spr = spr
        end
    end,
    set_con = function(self, con)
        if con then
            self.flags[1] =  self.flags[1] | 0x80
            self.con = con
        end
    end,
    set_int = function(self, int)
        if int then
            self.flags[2] =  self.flags[2] | 0x1
            self.int = int
        end
    end,
    set_dex = function(self, dex)
        if dex then
            self.flags[2] =  self.flags[2] | 0x2
            self.dex = dex
        end
    end,
    set_money = function(self, money)
        if money then
            self.flags[1] =  self.flags[1] | 0x10
            self.money = money
        end
    end,
    set_jiaozi = function(self, jiaozi)
        if jiaozi then
            self.flags[14] =  self.flags[14] | 0x4
            self.jiaozi = jiaozi
        end
    end,
    set_vigor_max = function(self, vigor_max)
        if vigor_max then
            self.flags[9] =  self.flags[9] | 0x4
            self.vigor_max = vigor_max
        end
    end,
    set_vigor = function(self, vigor)
        if vigor then
            self.flags[9] =  self.flags[9] | 0x2
            self.vigor = vigor
        end
    end,
    set_stamina = function(self, stamina)
        if stamina then
            self.flags[9] =  self.flags[9] | 0x8
            self.stamina = stamina
        end
    end,
    set_stamina_max = function(self, stamina_max)
        if stamina_max then
            self.flags[9] =  self.flags[9] | 0x10
            self.stamina_max = stamina_max
        end
    end,
    set_model_id = function(self, model_id)
        if model_id then
            self.flags[8] =  self.flags[8] | 0x4
            self.model_id = model_id
        end
    end,
    set_pet_guid = function(self, pet_guid)
        if pet_guid then
            self.pet_guid = pet_guid
            self.flags[8] =  self.flags[8] | 0x10
        end
    end,
    set_soul_melting_pet_guid = function(self, soul_melting_pet_guid)
        if soul_melting_pet_guid then
            self.soul_melting_pet_guid = soul_melting_pet_guid
            self.flags[8] =  self.flags[8] | 0x20
        end
    end,
    set_change_pk_mode_delay = function(self, delay)
        if delay then
            self.change_pk_mode_delay = delay
            self.flags[13] =  self.flags[13] | 0x1
        end
    end,
    set_xiulian_str = function(self, str)
        if str then
            self.xiulian_str = str
            self.flags[3] =  self.flags[3] | 0x80
        end
    end,
    set_xiulian_spr = function(self, spr)
        if spr then
            self.xiulian_spr = spr
            self.flags[4] =  self.flags[4] | 0x1
        end
    end,
    set_xiulian_con = function(self, con)
        if con then
            self.xiulian_con = con
            self.flags[4] =  self.flags[4] | 0x2
        end
    end,
    set_xiulian_int = function(self, int)
        if int then
            self.xiulian_int = int
            self.flags[4] =  self.flags[4] | 0x4
        end
    end,
    set_xiulian_dex = function(self, dex)
        if dex then
            self.xiulian_dex = dex
            self.flags[4] =  self.flags[4] | 0x8
        end
    end,
    set_xiulian_attrib_att_physics= function(self, xiulian_attrib_att_physics)
        if xiulian_attrib_att_physics then
            self.xiulian_attrib_att_physics = xiulian_attrib_att_physics
            self.flags[4] =  self.flags[4] | 0x40
        end
    end,
    set_xiulian_attrib_att_magic= function(self, xiulian_attrib_att_magic)
        if xiulian_attrib_att_magic then
            self.xiulian_attrib_att_magic = xiulian_attrib_att_magic
            self.flags[5] =  self.flags[5] | 0x1
        end
    end,
    set_xiulian_attrib_def_physics= function(self, xiulian_attrib_def_physics)
        if xiulian_attrib_def_physics then
            self.xiulian_attrib_def_physics = xiulian_attrib_def_physics
            self.flags[4] =  self.flags[4] | 0x80
        end
    end,
    set_xiulian_attrib_def_magic= function(self, xiulian_attrib_def_magic)
        if xiulian_attrib_def_magic then
            self.xiulian_attrib_def_magic = xiulian_attrib_def_magic
            self.flags[5] =  self.flags[5] | 0x2
        end
    end,
    set_xiulian_attrib_hit= function(self, xiulian_attrib_hit)
        if xiulian_attrib_hit then
            self.xiulian_attrib_hit = xiulian_attrib_hit
            self.flags[4] =  self.flags[4] | 0x10
        end
    end,
    set_xiulian_attrib_miss= function(self, xiulian_attrib_miss)
        if xiulian_attrib_miss then
            self.xiulian_attrib_miss = xiulian_attrib_miss
            self.flags[4] =  self.flags[4] | 0x20
        end
    end,
    set_team_id = function(self, team_id)
        if team_id then
            self.team_id = team_id
            self.flags[10] =  self.flags[10] | 0x80
        end
    end,
    set_can_action_1 = function()
    end,
    set_can_action_2 = function()
    end,
    set_can_move = function(self, can_move)
        self.limit_move = can_move == 1 and 0 or 1
        self.flags[8] =  self.flags[8] | 0x40
    end,
	set_wuhun_yy_flag = function(self,wuhun_yy_flag)
        self.wuhun_yy_flag = wuhun_yy_flag or 0
        self.flags[15] =  self.flags[15] | 0x1
    end,
    set_huanhun_qian_index = function(self, huanhun_qian_index)
        self.huanhun_qian_index = huanhun_qian_index
        self.flags[15] =  self.flags[15] | 0x2
    end,
    set_huanhun_kun_index = function(self, huanhun_kun_index)
        self.huanhun_kun_index = huanhun_kun_index
        self.flags[15] =  self.flags[15] | 0x4
    end,
    set_pk_min_level = function(self, pk_min_level)
        self.pk_min_level = pk_min_level
        self.flags[11] =  self.flags[11] | 0x4
    end,
    set_pvp_rule = function(self, pvp_rule)
        self.pvp_rule = pvp_rule
        self.flags[11] =  self.flags[11] | 0x8
    end,
    set_camp_id = function(self, camp_id)
        self.camp_id = camp_id
        self.flags[11] =  self.flags[11] | 0x10
    end,
    set_reputation= function(self, reputation)
        self.reputation = reputation
        self.flags[11] =  self.flags[11] | 0x20
    end,
    set_unbreakable = function()
    end,
    set_attackers_list = function(self, list)
        -- print("set_attackers_list list =", table.tostr(list))
        self.attackers = {}
        for guid, time in pairs(list) do
            table.insert(self.attackers, { guid = guid, time = time})
        end
        self.flags[11] = self.flags[11] | 0x40
    end,
    set_pk_declaration_list = function(self, list)
        -- print("set_pk_declaration_list list =", table.tostr(list))
        self.pk_declaration_list = {}
        for guid, time in pairs(list) do
            table.insert(self.pk_declaration_list, { guid = guid, time = time})
        end
        self.flags[12] = self.flags[12] | 0x4
    end,
    set_is_fear = function(self, is)
        self.is_fear = is
        self.flags[10] = self.flags[10] | 0x4
    end,
    set_guild_id = function(self, guild_id)
        self.guild_id = guild_id
        self.flags[7] = self.flags[7] | 0x80
    end,
    set_confederate_id = function(self, confederate_id)
        self.confederate_id = confederate_id
        self.flags[13] = self.flags[13] | 0x10
    end,
    set_gongli = function(self, gongli)
        self.gongli = gongli
        self.flags[9] = self.flags[9] | 0x20
    end,
    set_cur_attacker = function(self, cur_attacker)
        self.cur_attacker = cur_attacker
        self.flags[13] = self.flags[13] | 0x2
    end,
    set_today_kill_monster_count = function(self, today_kill_monster_count)
        self.today_kill_monster_count = math.floor(today_kill_monster_count)
        self.flags[14] = self.flags[14] | 0x10
    end,
    set_pet_num_extra = function(self, pet_num_extra)
        self.pet_num_extra = pet_num_extra
        self.flags[13] = self.flags[13] | 0x40
    end,
    set_good_bad_value = function(self, good_bad_value)
        self.good_bad_value = good_bad_value
        self.flags[9] = self.flags[9] | 0x80
    end,
    set_exterior_pet_soul_id = function(self, exterior_pet_soul_id)
        self.exterior_pet_soul_id = exterior_pet_soul_id
        self.flags[16] = self.flags[16] | 0x8
    end,
    set_menghui = function(self, menghui)
        self.menghui = menghui
        self.flags[18] = self.flags[18] | 0x4
    end,
	--设置拥有的雕纹绘刻数据
	set_Features_list = function(self, list)
        self.FeaturesNum = 0
		self.FeaturesData = {}
        for _,nFeaturesId in pairs(list) do
            table.insert(self.FeaturesData, nFeaturesId)
			self.FeaturesNum = self.FeaturesNum + 1
        end
		if self.FeaturesNum > 39 then
			self.FeaturesNum = 39
		end
        self.flags[18] = self.flags[18] | 0x40
    end,
	--下面的头饰、背饰数据仅自己请求自己数据的时候才予以发送
	
	set_exterior_back_id = function(self,exterior_back_id)
		self.exterior_back_id = exterior_back_id
        self.flags[18] = self.flags[18] | 0x80
	end,
	set_exterior_back_pos = function(self,exterior_back_pos)
		self.exterior_back_pos = exterior_back_pos
		self.flags[18] = self.flags[18] | 0x80
	end,
	set_exterior_head_id = function(self,exterior_head_id)
		self.exterior_head_id = exterior_head_id
        self.flags[19] = self.flags[19] | 0x1
	end,
	set_exterior_head_pos = function(self,exterior_head_pos)
		self.exterior_head_pos = exterior_head_pos
		self.flags[19] = self.flags[19] | 0x1
	end,
	--设置背饰数据
	-- set_OrnamentsBack = function(self, backExteriorId,backPos)
        -- self.OrnamentsBack = backExteriorId
		-- self.OrnamentsBack_Param = backPos
        -- self.flags[18] = self.flags[18] | 0x80
    -- end,
	--设置头饰数据
	-- set_OrnamentsHead = function(self, headExteriorId,headPos)
        -- self.OrnamentsHead = headExteriorId
		-- self.OrnamentsHead_Param = headPos
        -- self.flags[19] = self.flags[19] | 0x1
    -- end,
	
    ctor = function(self)
        self.flags = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
        self.unknow_100 = 0
        self.unknow_101 = 0
        self.unknow_102 = { 55, 53, 57, 53, 57, 49, 51, 56, 55, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
        self.unknow_105 = 1
        self.unknow_106 = 0
        self.unknow_107 = 80000000
        self.unknow_110 = 0
        self.unknow_111 = 10000
        self.unknow_112 = 0
        self.unknow_113 = 0
        self.wuhun_yy_flag = 0
        self.unknow_117 = 7
        self.unknow_118 = 0
        self.unknow_125 = 65535
        self.unknow_127 = 0
        self.nLYDoTime = 0
        self.unknow_129 = 65280
        self.n69Kaji = 255
		self.n89Kaji = 255
--        self.unknow_131 = 0
        self.nYueKaExpRate = 0
        self.unknow_133 = 26112
        self.unknow_135 = 0
        self.today_huoyue = 0
        self.unknow_15 = 0
        self.unknow_16 = 0
        self.unknow_37 = 100
        self.unknow_66 = 1
        self.unknow_67 = 1
        self.nIbPower = 0
        self.unknow_76 = 0
        self.unknow_77 = 0
        self.unknow_78 = {}
        self.unknow_79 = ""
        self.unknow_80 = -1
        self.unknow_81 = 0
        self.unknow_89 = {}
        self.unknow_90 = { 255, 255, 255, 255, 0, 0, 0, 0, 255, 255, 255, 255, 0, 0, 0, 0, 255, 255, 255, 255, 0, 0, 0, 0, 255, 255, 255, 255, 0, 0, 0, 0, 255, 255, 255, 255, 0, 0, 0, 0 }
        self.unknow_91 = {}
        self.unknow_92 = { 255, 255, 255, 255, 0, 0, 0, 0, 255, 255, 255, 255, 0, 0, 0, 0, 255, 255, 255, 255, 0, 0, 0, 0, 255, 255, 255, 255, 0, 0, 0, 0, 255, 255, 255, 255, 0, 0, 0, 0 }
        self.unknow_94 = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
        self.unknow_98 = 1
        self.unknow_109 = 0
        self.good_bad_value = 0
        self.pk_mode = 0
        self.pet_num_extra = 0
        self.jiaozi = 0
        self.today_kill_monster_count = 0
        self.huanhun_qian_index = 0
        self.huanhun_kun_index = 0
        self.ride = 0
        self.exterior_face_style_index = 0
        self.exterior_hair_style_index = 0
        self.exterior_portrait_index = 0
        self.fashion_depot_index = 0
        self.exterior_pet_soul_id = 0
        self.exterior_weapon_visual_id = 0
        self.datura_flower = 0
        self.exterior_weapon_selcet_level = 0
        self.exterior_pet_soul_id = 0
        self.exterior_portrait_index = 0
        self.limit_move = 0
        self.menpai_contribute_value = 0
        self.reputation = 0
        self.menpai_contribute_value = 0
        self.reputation = 0
        self.unknow_81 = 0xffffffff
        self.cur_attacker = -1
        self.team_id = -1
        self.unknow_118 = 0xffffffff
        self.attackers = {}
        self.pk_declaration_list = {}
        self.guild_name = ""
		--背饰
		self.exterior_back_id = 0
		self.exterior_back_pos = 0
		--头饰
		self.exterior_head_id = 0
		self.exterior_head_pos = 0
		--背饰位置【确定不是，可能是某些活动的使用参数】
		self.OrnamentsBackX = 0
		self.OrnamentsBackY = 0
		self.OrnamentsBackZ = 0
		--头饰位置【确定不是】
		self.OrnamentsHeadX = 0
		self.OrnamentsHeadY = 0
		self.OrnamentsHeadZ = 0
		--雕纹纹刻
		self.FeaturesNum = 39
		self.FeaturesData = {}
		for i = 1,self.FeaturesNum do
			self.FeaturesData[i] = 0
		end
    end,

    bis = function(self, buffer)
       
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        for i = 1, 0x13 do stream:writeuchar(self.flags[i]) end
        if self.flags[1] & 0x1 == 0x1 then stream:writeuint(self.level) end
        if self.flags[1] & 0x2 == 0x2 then stream:writeuint(self.hp) end
        if self.flags[1] & 0x4 == 0x4 then stream:writeuint(self.mp) end
        if self.flags[2] & 0x80 == 0x80 then
            stream:writeuint(self.hp_max)
        end
        if self.flags[3] & 0x1 == 0x1 then stream:writeuint(self.mp_max) end
        if self.flags[5] & 0x10 == 0x10 then
            stream:writefloat(self.speed)
        end
        if self.flags[1] & 0x8 == 0x8 then
            stream:writeuint(self.exp)
        end
        if self.flags[1] & 0x10 == 0x10 then
            stream:writeuint(self.money)
        end
        if self.flags[1] & 0x20 == 0x20 then stream:writeuint(self.str) end
        if self.flags[1] & 0x40 == 0x40 then stream:writeuint(self.spr) end
        if self.flags[1] & 0x80 == 0x80 then stream:writeuint(self.con) end
        if self.flags[2] & 0x1 == 0x1 then stream:writeuint(self.int) end
        if self.flags[2] & 0x2 == 0x2 then stream:writeuint(self.dex) end
        if self.flags[2] & 0x4 == 0x4 then
            stream:writeuint(self.point_remain)
        end
        if self.flags[3] & 0x2 == 0x2 then
            stream:writeuint(self.hp_re_speed)
        end
        if self.flags[3] & 0x4 == 0x4 then
            stream:writeuint(self.mp_re_speed)
        end
        if self.flags[2] & 0x8 == 0x8 then
            stream:writeuint(self.attrib_att_physics)
        end
        if self.flags[2] & 0x20 == 0x20 then
            stream:writeuint(self.attrib_att_magic)
        end
        if self.flags[2] & 0x10 == 0x10 then
            stream:writeuint(self.attrib_def_physics)
        end
        if self.flags[2] & 0x40 == 0x40 then
            stream:writeuint(self.attrib_def_magic)
        end
        if self.flags[3] & 0x8 == 0x8 then
            stream:writeuint(self.attrib_hit)
        end
        if self.flags[3] & 0x10 == 0x10 then
            stream:writeuint(self.attrib_miss)
        end
        if self.flags[3] & 0x20 == 0x20 then
            stream:writeuint(self.mind_attack)
        end
        if self.flags[3] & 0x40 == 0x40 then
            stream:writeuint(self.mind_defend)
        end
        if self.flags[3] & 0x80 == 0x80 then
            stream:writeuint(self.xiulian_str)
        end
        if self.flags[4] & 0x1 == 0x1 then
            stream:writeuint(self.xiulian_spr)
        end
        if self.flags[4] & 0x2 == 0x2 then
            stream:writeuint(self.xiulian_con)
        end
        if self.flags[4] & 0x4 == 0x4 then
            stream:writeuint(self.xiulian_int)
        end
        if self.flags[4] & 0x8 == 0x8 then
            stream:writeuint(self.xiulian_dex)
        end
        if self.flags[4] & 0x10 == 0x10 then
            stream:writeuint(self.xiulian_attrib_hit)
        end
        if self.flags[4] & 0x20 == 0x20 then
            stream:writeuint(self.xiulian_attrib_miss)
        end
        if self.flags[4] & 0x40 == 0x40 then
            stream:writeuint(self.xiulian_attrib_att_physics)
        end
        if self.flags[4] & 0x80 == 0x80 then
            stream:writeuint(self.xiulian_attrib_def_physics)
        end
        if self.flags[5] & 0x1 == 0x1 then
            stream:writeuint(self.xiulian_attrib_att_magic)
        end
        if self.flags[5] & 0x2 == 0x2 then
            stream:writeuint(self.xiulian_attrib_def_magic)
        end
        if self.flags[5] & 0x4 == 0x4 then stream:writeuint(self.rage) end
        if self.flags[5] & 0x8 == 0x8 then
            stream:writeuint(self.strike_point)
        end
        if self.flags[5] & 0x20 == 0x20 then
            stream:writeuint(self.unknow_37)
        end
        if self.flags[5] & 0x40 == 0x40 then
            stream:writeuint(self.att_cold)
        end
        if self.flags[5] & 0x80 == 0x80 then
            stream:writeint(self.def_cold)
        end
        if self.flags[6] & 0x1 == 0x1 then
            stream:writeuint(self.reduce_def_cold)
        end
        if self.flags[6] & 0x2 == 0x2 then
            stream:writeuint(self.reduce_def_cold_low_limit)
        end
        if self.flags[6] & 0x4 == 0x4 then
            stream:writeuint(self.att_fire)
        end
        if self.flags[6] & 0x8 == 0x8 then
            stream:writeint(self.def_fire)
        end
        if self.flags[6] & 0x10 == 0x10 then
            stream:writeuint(self.reduce_def_fire)
        end
        if self.flags[6] & 0x20 == 0x20 then
            stream:writeuint(self.reduce_def_fire_low_limit)
        end
        if self.flags[6] & 0x40 == 0x40 then
            stream:writeuint(self.att_light)
        end
        if self.flags[6] & 0x80 == 0x80 then
            stream:writeint(self.def_light)
        end
        if self.flags[7] & 0x1 == 0x1 then
            stream:writeuint(self.reduce_def_light)
        end
        if self.flags[7] & 0x2 == 0x2 then
            stream:writeuint(self.reduce_def_light_low_limit)
        end
        if self.flags[7] & 0x4 == 0x4 then
            stream:writeuint(self.att_poison)
        end
        if self.flags[7] & 0x8 == 0x8 then
            stream:writeint(self.def_poison)
        end
        if self.flags[7] & 0x10 == 0x10 then
            stream:writeuint(self.reduce_def_poison)
        end
        if self.flags[7] & 0x20 == 0x20 then
            stream:writeuint(self.reduce_def_poison_low_limit)
        end
        if self.flags[7] & 0x40 == 0x40 then
            stream:writeuint(self.menpai)
        end
        if self.flags[7] & 0x80 == 0x80 then
            stream:writeint(self.guild_id)
        end
        if self.flags[13] & 0x10 == 0x10 then
            stream:writeint(self.confederate_id)
        end
        if self.flags[8] & 0x1 == 0x1 then
            stream:writeuint(self.unknow_57)
        end
        if self.flags[8] & 0x2 == 0x2 then
            stream:writeuint(self.unknow_58)
        end
        if self.flags[8] & 0x4 == 0x4 then
            stream:writeint(self.model_id)
        end
        if self.flags[8] & 0x8 == 0x8 then
            stream:writeint(self.ride_model)
        end
        if self.flags[8] & 0x10 == 0x10 then
            packet.PetGUID.bos(self.pet_guid, stream)
        end
        if self.flags[8] & 0x20 == 0x20 then
            packet.PetGUID.bos(self.soul_melting_pet_guid, stream)
        end
        if self.flags[8] & 0x40 == 0x40 then
            stream:writeuint(self.limit_move)
        end
        if self.flags[8] & 0x80 == 0x80 then
            stream:writeuint(self.unknow_66)
        end
        if self.flags[9] & 0x1 == 0x1 then
            stream:writeuint(self.unknow_67)
        end
        if self.flags[9] & 0x2 == 0x2 then stream:writeuint(self.vigor) end
        if self.flags[9] & 0x4 == 0x4 then
            stream:writeuint(self.vigor_max)
        end
        if self.flags[9] & 0x8 == 0x8 then stream:writeuint(self.stamina) end
        if self.flags[9] & 0x10 == 0x10 then
            stream:writeuint(self.stamina_max)
        end
        if self.flags[9] & 0x20 == 0x20 then
            stream:writeuint(self.gongli)
        end
        if self.flags[9] & 0x40 == 0x40 then
            stream:writeuint(self.nIbPower)		--unknow_73 神功值
        end
        if self.flags[9] & 0x80 == 0x80 then
          stream:writeuint(self.good_bad_value)
        end
        if self.flags[10] & 0x2 == 0x2 then
            stream:writeuint(self.unknow_76)
        end
        if self.flags[10] & 0x4 == 0x4 then
            stream:writeuint(self.is_fear)
        end
        if self.flags[10] & 0x8 == 0x8 then
            stream:writeuint(self.unknow_77)
        end
        if self.flags[10] & 0x10 == 0x10 then
            stream:writeuint(self.menpai_contribute_value)
        end
        if self.flags[10] & 0x20 == 0x20 then
            stream:write(self.guild_name, 0x18)
        end
        if self.flags[13] & 0x20 == 0x20 then
            for i = 1, 0x20 do stream:writeuchar(self.unknow_79[i] or 0) end
        end
        if self.flags[10] & 0x40 == 0x40 then
            stream:writeuint(self.unknow_81)
        end
        if self.flags[11] & 0x1 == 0x1 then
            stream:writeint(self.unknow_80)
        end
        if self.flags[10] & 0x80 == 0x80 then
          stream:writeshort(self.team_id)
        end
        if self.flags[11] & 0x2 == 0x2 then
          stream:writeuchar(self.pk_mode)
        end
        if self.flags[11] & 0x4 == 0x4 then
          stream:writeuint(self.pk_min_level)
        end
        if self.flags[11] & 0x8 == 0x8 then
          stream:writeuchar(self.pvp_rule)
        end
        if self.flags[11] & 0x10 == 0x10 then
          stream:writeshort(self.camp_id)
        end
        if self.flags[11] & 0x20 == 0x20 then
          stream:writeushort(self.reputation)
        end
        if self.flags[13] & 0x2 == 0x2 then
            stream:writeint(self.cur_attacker)
        end
        if self.flags[11] & 0x40 == 0x40 then
            table.sort(self.attackers, function(a1, a2)
                return a1.time > a2.time
            end)
            for i = 1, 30 do	--30x8
                local a = self.attackers[i] or {}
                stream:writeint(a.guid or define.INVAILD_ID)
                stream:writeuint(a.time or 0)
            end
        end
        if self.flags[11] & 0x80 == 0x80 then
            for i = 1, 0x28 do stream:writeuchar(self.unknow_90[i] or 0) end
        end
        if self.flags[12] & 0x1 == 0x1 then
            for i = 1, 0x28 do stream:writeuchar(self.unknow_91[i] or 0) end
        end
        if self.flags[12] & 0x2 == 0x2 then
            for i = 1, 0x28 do stream:writeuchar(self.unknow_92[i] or 0) end
        end
        if self.flags[12] & 0x4 == 0x4 then
            for i = 1, 6 do
                local d = self.pk_declaration_list[i] or {}
                stream:writeint(d.guid or define.INVAILD_ID)
                stream:writeuint(d.time or 0)
            end
        end
        if self.flags[12] & 0x8 == 0x8 then
            for i = 1, 0x100 do stream:writeuchar(self.unknow_94[i]) end
        end
        if self.flags[12] & 0x10 == 0x10 then
            stream:writeuint(self.yuanbao)
        end
        if self.flags[15] & 0x8 == 0x8 then
            stream:writeuint(self.zengdian)
        end
        if self.flags[12] & 0x20 == 0x20 then
            stream:writeuint(self.bind_yuanbao)
        end
        if self.flags[13] & 0x4 == 0x4 then
            stream:writeuint(self.unknow_98)
        end
        if self.flags[13] & 0x8 == 0x8 then
            stream:writeuint(self.unknow_99)
        end
        if self.flags[12] & 0x40 == 0x40 then
            stream:writeuint(self.unknow_100)
            stream:writeuint(self.unknow_101)
        end
        if self.flags[12] & 0x80 == 0x80 then
            for i = 1, 0x32 do stream:writeuchar(self.unknow_102[i]) end
        end
        if self.flags[13] & 0x1 == 0x1 then
            stream:writeint(self.change_pk_mode_delay)
        end
        if self.flags[13] & 0x40 == 0x40 then
            stream:writeuchar(self.pet_num_extra)
        end
        if self.flags[13] & 0x80 == 0x80 then
            stream:writeuint(self.unknow_105)
        end
        if self.flags[14] & 0x1 == 0x1 then
            stream:writeuint(self.unknow_106)
        end
        if self.flags[14] & 0x2 == 0x2 then
            stream:writeuint(self.unknow_107)
        end
        if self.flags[14] & 0x4 == 0x4 then
            stream:writeuint(self.jiaozi)
        end
        if self.flags[14] & 0x8 == 0x8 then
            stream:writeuint(self.unknow_109)
        end
        if self.flags[14] & 0x10 == 0x10 then
            stream:writeuint(math.floor(self.today_kill_monster_count))
        end
        if self.flags[14] & 0x20 == 0x20 then
            stream:writeuint(self.unknow_111)
        end
        if self.flags[14] & 0x40 == 0x40 then
            stream:writeuint(self.unknow_112)
        end
        if self.flags[14] & 0x80 == 0x80 then
            stream:writeuint(self.unknow_113)
        end
        if self.flags[15] & 0x1 == 0x1 then
            stream:writeuchar(self.wuhun_yy_flag)
        end
        if self.flags[15] & 0x2 == 0x2 then
            stream:writeushort(self.huanhun_qian_index)
        end
        if self.flags[15] & 0x4 == 0x4 then
            stream:writeushort(self.huanhun_kun_index)
        end
        if self.flags[15] & 0x10 == 0x10 then
            stream:writeuint(self.unknow_117)
        end
        if self.flags[15] & 0x20 == 0x20 then
            stream:writeuint(self.unknow_118)
        end
        if self.flags[15] & 0x40 == 0x40 then
            stream:writeshort(self.ride)
        end
        if self.flags[15] & 0x80 == 0x80 then
            stream:writeshort(self.exterior_face_style_index)
        end
        if self.flags[16] & 0x1 == 0x1 then
            stream:writeshort(self.exterior_hair_style_index)
        end
        if self.flags[16] & 0x2 == 0x2 then
            stream:writeshort(self.exterior_portrait_index)
        end
        if self.flags[16] & 0x4 == 0x4 then
            stream:writeshort(self.fashion_depot_index)
        end
        if self.flags[17] & 0x2 == 0x2 then
            stream:writeushort(self.unknow_125)
        end
        if self.flags[16] & 0x8 == 0x8 then
            stream:writeushort(self.exterior_pet_soul_id)
        end
        if self.flags[16] & 0x10 == 0x10 then
            stream:writeushort(self.unknow_127)
        end
        if self.flags[16] & 0x80 == 0x80 then
            stream:writeuint(self.datura_flower)
        end
        if self.flags[16] & 0x20 == 0x20 then
            stream:writeushort(self.exterior_weapon_visual_id)
        end
        if self.flags[16] & 0x40 == 0x40 then
          stream:writeuchar(self.exterior_weapon_selcet_level)
        end
        if self.flags[17] & 0x1 == 0x1 then
          stream:writeint(self.nLYDoTime)		--unknow_128	今日铸造次数
        end
        if self.flags[17] & 0x4 == 0x4 then
          stream:writeushort(self.unknow_129)	--空
        end
        if self.flags[17] & 0x8 == 0x8 then
          stream:writeuint(self.n69Kaji)		--69卡级
        end
		if self.flags[17] & 0x10 == 0x10 then
          stream:writeuint(self.n89Kaji)		--89卡级
        end
--        if self.flags[17] & 0x20 == 0x20 then	--废弃
--          stream:writeuint(self.unknow_131)
--        end
        if self.flags[17] & 0x40 == 0x40 then
          stream:writeuint(self.nYueKaExpRate)	--unknow_132	月卡经验补偿比例
        end
        if self.flags[17] & 0x80 == 0x80 then
          stream:writeuint(self.unknow_133)		
        end
        if self.flags[18] & 0x1 == 0x1 then
          stream:writeuint(self.nServerLevel)	--unknow_134	服务器角色等级
        end
--		if self.flags[18] & 0x2 == 0x2 then		--废弃
--          stream:writeuint(0)
--        end
        if self.flags[18] & 0x4 == 0x4 then		--盟会id
          stream:writeuint(self.menghui)
        end
        if self.flags[18] & 0x8 == 0x8 then
          stream:writeuint(self.today_huoyue)		--unknow_136	今日活跃
        end
        if self.flags[18] & 0x10 == 0x10 then
          stream:writeuint(self.unknow_137)
        end
		if self.flags[18] & 0x20 == 0x20 then
			stream:writeuint(self.unknow_137)
			stream:writeuint(self.unknow_137)
        end
		if self.flags[18] & 0x40 == 0x40 then
			stream:writeuchar(self.FeaturesNum)	--数据数量
			for i = 1,39 do
				if i > self.FeaturesNum then
					stream:writeint(0)
				else
					stream:writeint(self.FeaturesData[i])
				end
			end
        end
		if self.flags[18] & 0x80 == 0x80 then	--背饰数据
			stream:writeshort(self.exterior_back_id)
			stream:writeint(self.exterior_back_pos)
        end
		if self.flags[19] & 0x1 == 0x1 then		--头饰数据
			stream:writeshort(self.exterior_head_id)
			stream:writeint(self.exterior_head_pos)
        end
		if self.flags[19] & 0x2 == 0x2 then
			stream:writeuint(0)
        end
		if self.flags[19] & 0x4 == 0x4 then
			stream:writeuint(0)
        end
		if self.flags[19] & 0x8 == 0x8 then
			stream:writeuint(0)
        end
		if self.flags[19] & 0x10 == 0x10 then
			stream:writeuint(0)				--沙盒血量
        end
		if self.flags[19] & 0x20 == 0x20 then
			stream:writeuint(0)				--沙盒最大血量
        end
        return stream:get()
    end
}

packet.CGEnvRequest = {
    xy_id = packet.XYID_CG_ENV_REQUEST,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGEnvRequest})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end
}

packet.CGAskDetailAbilityInfo = {
    xy_id = packet.XYID_CG_ASK_DETAIL_ABILITY_INFO,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGAskDetailAbilityInfo})
        o:ctor()
        return o
    end,
    ctor = function(self) self.m_objID = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
    end
}

packet.CGWuhunWG = {
    xy_id = packet.XYID_CG_WUHUN_WG,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGWuhunWG})
        o:ctor()
        return o
    end,
    ctor = function(self)end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.type = stream:readuint()
        if self.type == 0 or self.type == 1 then
            self.targetId = stream:readint()
        elseif self.type == 2 then
            self.huanhun_id = stream:readshort()
            self.qiankun = stream:readint()
        elseif self.type == 3 then
            self.unknow_3 = stream:readshort()
        end
    end
}

packet.CGAskDetailSkillList = {
    xy_id = packet.XYID_CG_ASK_DETAIL_SKILL_LIST,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGAskDetailSkillList})
        o:ctor()
        return o
    end,
    ctor = function(self) self.m_objID = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
    end
}

packet.CGAutoCreateTeam = {
    xy_id = packet.XYID_CG_AUTO_CREATE_TEAM,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGAutoCreateTeam})
        o:ctor()
        return o
    end,
    ctor = function(self) self.unknow = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow = stream:readuint()
    end
}

packet.CGCityAskAttr = {
    xy_id = packet.XYID_CG_CITY_ASK_ATTR,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGCityAskAttr})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end
}

packet.CGCharAllTitles = {
    xy_id = packet.XYID_CG_CHAR_ALL_TITLES,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGCharAllTitles})
        o:ctor()
        return o
    end,
    ctor = function(self) self.m_objID = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
    end
}

packet.CGGuild = {
    xy_id = packet.XYID_CG_GUILD,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGGuild})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.packet_type = 0
        self.unknow_2 = 0
        self.unknow_3 = 0
    end,
    read_guild_ask_list = function(self, stream)
        self.unknow_1 = stream:readuchar()
        self.unknow_2 = stream:readushort()
    end,
    read_guild_ask_name_list = function(self, stream)
    end,
    read_guild_ask_create = function(self, stream)
        local guild_name_len = stream:readuchar()
        if guild_name_len > 0 and guild_name_len <= 0x18 then
            self.guild_name = stream:read(guild_name_len)
            self.guild_name = gbk.toutf8(self.guild_name)
        end
        local guild_desc_len = stream:readuchar()
        if guild_desc_len > 0 and guild_desc_len <= 0x18 then
            self.guild_desc = stream:read(guild_desc_len)
            self.guild_desc = gbk.toutf8(self.guild_desc)
        end
    end,
    read_guild_join = function(self, stream)
        self.guild_id = stream:readshort()
    end,
    read_guild_ask_info = function(self, stream)
        self.guild_id = stream:readshort()
        self.type = stream:readuchar()
        self.unknow_2 = stream:readuchar()
    end,
    read_guild_first_man = function(self, stream)
        self.guild_id = stream:readshort()
        self.unknow_1 = stream:readint()
        self.unknow_2 = stream:readuchar()
    end,
    read_guild_clear_join_info = function(self, stream)
        self.unknow_1 = stream:readuint()
    end,
    read_guild_adjust_auth = function(self, stream)
        self.m_GuildGUID = stream:readshort()
        self.m_CandidateGUID = stream:readint()
        self.m_NewAuthority = stream:readuchar()
    end,
    read_guild_recruit = function(self, stream)
        self.m_ProposerGUID = stream:readint()
    end,
    read_guild_expe = function(self, stream)
        self.m_GuildUserGUID = stream:readint()
    end,
    read_guild_withdraw = function(self, stream)
        self.m_MoneyAmount = stream:readint()
    end,
    read_guild_deposit = function(self, stream)
        self.m_MoneyAmount = stream:readint()
    end,
    read_guild_demise = function(self, stream)
    end,
    read_guild_leave = function(self, stream)
    end,
    read_guild_back_city = function(self, stream)
    end,
    read_guild_promote_chief = function(self, stream)
    end,
    read_guild_position_name_list = function(self, stream)
        local result = stream:readint()
        if result <= 0xA then
            self.unknow_1 = stream:read(result << 6)
        end
    end,
    read_guild_get_position_name = function(self, stream)
    end,
    read_guild_request_position_name = function(self, stream)
    end,
    read_guild_change_desc = function(self, stream)
        local len = stream:readuchar()
        if len > 0 and len <= 0x3C then
            self.guild_desc = stream:read(len)
            self.guild_desc = gbk.toutf8(self.guild_desc)
        end
    end,
    read_guild_com_miss_complete = function(self, stream)
    end,
    read_guild_modify_leave_word = function(self, stream)
        local len = stream:readuchar()
        if len > 0 and len <= 320 then
            self.guild_leave_word = stream:read(len)
            self.guild_leave_word = gbk.toutf8(self.guild_leave_word)
        end
    end,
    read_guild_appoint = function(self, stream)
        self.guild_id = stream:readshort()
        self.guid = stream:readint()
        self.new_position = stream:readchar()
    end,
    read_guild_demise = function(self, stream)
    end,
    read_guild_update_desc = function(self, stream)
        local len = stream:readuchar()
        if len > 0 and len <= 0x3C then
            self.new_desc = stream:read(len)
            self.new_desc = gbk.fromutf8(self.new_desc)
        end
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.packet_type = stream:readuchar()
        self.askid = stream:readuint()
        if self.packet_type == 3 then
            self:read_guild_ask_info(stream)
        elseif self.packet_type == 4 then
            self:read_guild_appoint(stream)
        elseif self.packet_type == 6 then
            self:read_guild_recruit(stream)
        elseif self.packet_type == 7 then
            self:read_guild_expe(stream)
        elseif self.packet_type == 12 then
            self:read_guild_demise(stream)
        elseif self.packet_type == 13 then
            self:read_guild_update_desc(stream)
        end
    end
}

packet.CGMACNotify = {
    xy_id = packet.XYID_CG_MAC_NOTIFY,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGMACNotify})
        o:ctor()
        return o
    end,
    ctor = function(self) self.mac = {} end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        for i = 1, 8 do self.mac[i] = stream:readuchar() end
    end
}

packet.CGMSShopBuyInfoReq = {
    xy_id = packet.XYID_CG_MS_SHOP_BUY_INFO_REQ,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGMSShopBuyInfoReq})
        o:ctor()
        return o
    end,
    ctor = function(self) self.mac = {} end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        for i = 1, 8 do self.mac[i] = stream:readuchar() end
    end
}

packet.CGMSShopBuyInfoReq = {
    xy_id = packet.XYID_CG_MS_SHOP_BUY_INFO_REQ,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGMSShopBuyInfoReq})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end
}

packet.CGAskDiGongShopInfo = {
    xy_id = packet.XYID_CG_ASk_DIGONG_SHOP_INFO,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGAskDiGongShopInfo})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end
}

packet.CGAskServerTime = {
    xy_id = packet.XYID_CG_ASK_SERVER_TIME,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGAskServerTime})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = 0
        self.unknow_2 = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readuint()
        self.unknow_2 = stream:readuint()
    end
}

packet.CGMinorPasswd = {
    xy_id = packet.XYID_CG_MINOR_PASSWD,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.CGMinorPasswd})
        o:ctor()
        return o
    end,
    ctor = function(self) self.flag = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.flag = stream:readuchar()
        local FLAG = define.MINORPASSWD_REQUEST_TYPE
        if self.flag == FLAG.MREQT_SETPASSWD or self.flag == FLAG.MREQT_UNLOCKPASSWD then
            local password_size = stream:readuchar()
            if password_size > 0 and password_size < 0x11 then
                self.password = stream:read(password_size)
            end
        elseif self.flag == FLAG.MREQT_MODIFYPASSWD then
            local old_password_size = stream:readuchar()
            if old_password_size > 0 and old_password_size < 0x11 then
                self.old_password = stream:read(old_password_size)
            end
            local new_password_size = stream:readuchar()
            if new_password_size > 0 and new_password_size < 0x11 then
                self.new_password = stream:read(new_password_size)
            end
        end
    end
}

packet.CGAskDetailEquipList = {
    xy_id = packet.XYID_CG_ASK_DETAIL_EQUIP_LIST,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGAskDetailEquipList})
        o:ctor()
        return o
    end,
    ctor = function(self) self.m_objID = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
    end
}

packet.CGAskMyBagSize = {
    xy_id = packet.XYID_CG_ASK_MY_BAG_SIZE,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGAskMyBagSize})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end
}

packet.CGAskMissionList = {
    xy_id = packet.XYID_CG_ASK_MISSION_LIST,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGAskMissionList})
        o:ctor()
        return o
    end,
    ctor = function(self) self.m_objID = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
    end
}

packet.CGAskSetting = {
    xy_id = packet.XYID_CG_ASK_SETTING,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGAskSetting})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end
}

packet.CGFriendGroupName = {
    xy_id = packet.XYID_CG_FRIEND_GROUP_NAME,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGFriendGroupName})
        o:ctor()
        return o
    end,
    ctor = function(self) self.unknow = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow = stream:readuint()
    end
}

packet.CGBankMoney = {
    xy_id = packet.XYID_CG_BANK_MONEY,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGBankMoney})
        o:ctor()
        return o
    end,
    ctor = function(self) self.unknow_1 = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.op = stream:readuchar()
        self.money = stream:readuint()
    end
}

packet.CGAskMail = {
    xy_id = packet.XYID_CG_ASK_MAIL,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGAskMail})
        o:ctor()
        return o
    end,
    ctor = function(self) self.m_askType = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_askType = stream:readuchar()
    end
}

packet.CGWAskAladdinToken = {
    xy_id = packet.XYID_CGW_ASK_ALADDIN_TOKEN,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGWAskAladdinToken})
        o:ctor()
        return o
    end,
    ctor = function(self) self.unknow_1 = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readuint()
    end
}

packet.CGStopPedding = {
    xy_id = packet.XYID_CG_STOP_PEDDING,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGStopPedding})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end
}

packet.CGLoginAcc = {
    xy_id = packet.XYID_CG_LOGIN_ACC,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGLoginAcc})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.size = 0
        self.data = ""
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.size = stream:readuchar()
        if self.size > 0x32 then self.size = 0x32 end
        self.data = stream:read(self.size)
    end
}

packet.CG_Unknow_0431 = {
    xy_id = packet.XYID_CG_UNKNOW_0431,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CG_Unknow_0431})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end
}

packet.GCCharImpactListUpdate = {
    xy_id = packet.XYID_GC_CHAR_IMPACT_LIST_UPDATE,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCCharImpactListUpdate})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_nOwnerID = 0
        self.unknow_1 = 0
        self.size = 0
        self.m_aImpact = {}
        self.unknow_2 = 0xffff
    end,
    bis = function(self, buffer)
        local stream    = bistream.new()
        stream:attach(buffer)
        self.m_nOwnerID = stream:readuint()
        self.unknow_1 = stream:readuint()
        self.size = stream:readushort()
        if self.size > 30 then
            self.size = 30
        end
        if self.size > 0 then
            for i = 1, self.size do
                local l = {}
                l.bufferid = stream:readushort()
                l.sender = stream:readuint()
                l.index = stream:readuint()
                table.insert(self.m_aImpact, l)
            end
        end
        self.unknow_2 = stream:readushort()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_nOwnerID)
        stream:writeuint(self.unknow_1)
        stream:writeushort(self.size)
        if self.size > 30 then
            self.size = 30
        end
        if self.size > 0 then
            for i = 1, self.size do
                self.m_aImpact[i] = self.m_aImpact[i]
                stream:writeshort(self.m_aImpact[i].buffer_id)
                stream:writeuint(self.m_aImpact[i].sender)
                stream:writeuint(self.m_aImpact[i].index)
            end
        end
        stream:writeushort(self.unknow_2)
        return stream:get()
    end
}

packet.GCWorldTime = {
    xy_id = packet.XYID_GC_WORLD_TIME,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCWorldTime})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow = 8
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_Time = stream:readuint()
        self.counter = stream:readuint()
        self.unknow = stream:readfloat()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_Time)
        stream:writeuint(self.counter)
        stream:writefloat(self.unknow)
        return stream:get()
    end
}

packet.GCRMBChatFaceInfo = {
    xy_id = packet.XYID_GC_RMB_CHAT_FACE_INFO,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCRMBChatFaceInfo})
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.id = stream:readuint()
        for i = 1, 4 do self.list[i] = stream:readuint() end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.id)
        for i = 1, 4 do
            self.dates[i] = self.dates[i] or 0
            stream:writeuint(self.dates[i])
        end
        return stream:get()
    end
}

packet.GCDoubleExpInfo = {
    xy_id = packet.XYID_GC_DOUBLE_EXP_INFO,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.GCDoubleExpInfo})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_3 = 0
    end,
    bis = function(self, buffer)
        local stream    = bistream.new()
        stream:attach(buffer)
        self.available_hour = stream:readuint()
        self.is_lock = stream:readuint()
        self.money_time = stream:readuint()
        self.total_time = stream:readuint()
        self.rtime = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.available_hour)
        stream:writeuint(self.is_lock)
        stream:writeuint(self.money_time)
        stream:writeuint(self.total_time)
        stream:writeuint(self.rtime)
        return stream:get()
    end
}

packet.GCJuqingPoint = {
    xy_id = packet.XYID_GC_JVQING_POINT,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCJuqingPoint})
        o:ctor()
        return o
    end,
    ctor = function(self) self.unknow_1 = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.unknow_1)
        return stream:get()
    end
}

packet.GCCooldownUpdate = {
    xy_id = packet.XYID_GC_COLL_DOWN_UPDATE,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCCooldownUpdate})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_uHighSection = 0
        self.m_uLowSection = 0

        self.m_nNumCooldown = 0
        self.m_aCooldowns = {}
    end,
    bis = function(self, buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_uHighSection)
        stream:writeuint(self.m_uLowSection)
        stream:writeushort(self.m_nNumCooldown)
        for i = 1, self.m_nNumCooldown do
            self.m_aCooldowns[i] = self.m_aCooldowns[i] or
                                       {
                    m_nID = 0,
                    m_nCooldown = 0,
                    m_nCooldownElapsed = 0
                }
            stream:writeint(self.m_aCooldowns[i].m_nID)
            self.m_aCooldowns[i].m_nCooldown = self.m_aCooldowns[i].m_nCooldown < 0 and 0 or self.m_aCooldowns[i].m_nCooldown
            stream:writeuint(self.m_aCooldowns[i].m_nCooldown)
            stream:writeuint(self.m_aCooldowns[i].m_nCooldownElapsed)
        end
        return stream:get()
    end
}

packet.GCDetailAbilityInfo = {
    xy_id = packet.XYID_GC_DETAIL_ABILITY_INFO,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCDetailAbilityInfo})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_uAbilityIDList = {}
        self.m_aAbility = {}
        self.m_aPrescr = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.m_wNumAbility = stream:readuchar()
        if self.m_wNumAbility > 0 and self.m_wNumAbility < 0x40 then
            for i = 1, self.m_wNumAbility do
                self.m_uAbilityIDList[i] = stream:readuchar()
            end
            for i = 1, self.m_wNumAbility do
                local ability = {}
                ability.m_Level = stream:readuint()
                ability.m_Exp = stream:readuint()
                table.insert(self.m_aAbility, ability)
            end
        end
        for i = 1, 0x100 do self.m_aPrescr[i] = stream:readuchar() end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        stream:writeuchar(self.m_wNumAbility)
        if self.m_wNumAbility > 0 and self.m_wNumAbility < 0x40 then
            for i = 1, self.m_wNumAbility do
                stream:writeuchar(self.m_uAbilityIDList[i])
            end
            for i = 1, self.m_wNumAbility do
                self.m_aAbility[i] = self.m_aAbility[i] or
                                         {m_Level = 0, m_Exp = 0}
                stream:writeuint(self.m_aAbility[i].m_Level)
                stream:writeuint(self.m_aAbility[i].m_Exp)
            end
        end
        for i = 1, 0x100 do stream:writeuchar(self.m_aPrescr[i]) end
        return stream:get()
    end
}

packet.GCDetailXinFaList = {
    xy_id = packet.XYID_GC_DETAIL_XINFA_LIST,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCDetailXinFaList})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_objID = 0
        self.m_wNumXinFa = 0
        self.m_aXinFa = {}
        self.unknow = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.m_wNumXinFa = stream:readushort()
        if self.m_wNumXinFa > 0 and self.m_wNumXinFa < 0x10 then
            for i = 1, self.m_wNumXinFa do
                local xinfa = {}
                xinfa.m_nXinFaID = stream:readuint()
                xinfa.m_nXinFaLevel = stream:readuint()
                table.insert(self.m_aXinFa, xinfa)
            end
        end
        self.unknow = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        stream:writeushort(self.m_wNumXinFa)
        if self.m_wNumXinFa > 0 and self.m_wNumXinFa < 0x10 then
            for i = 1, self.m_wNumXinFa do
                self.m_aXinFa[i] = self.m_aXinFa[i] or
                                         {m_nXinFaID = 0, m_nXinFaLevel = 0}
                stream:writeuint(self.m_aXinFa[i].m_nXinFaID)
                stream:writeuint(self.m_aXinFa[i].m_nXinFaLevel)
            end
        end
        stream:writeuint(self.unknow)
        return stream:get()
    end
}

packet.GCDetailXiulianList = {
    xy_id = packet.XYID_GC_DETAIL_XIULIAN_LIST,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCDetailXiulianList})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.xiulian = {}
        self.unknow_2 = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        for i = 1, 11 do self.xiulian[i] = stream:readuint() end
        self.unknow_2 = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        for i = 1, 11 do
            local xiulian = self.xiulian[i]
            stream:writeushort(xiulian.level)
        end
        for i = 1, 11 do
            local xiulian = self.xiulian[i]
            stream:writeushort(xiulian.upper_limit)
        end
        stream:writeuint(self.unknow_2)
        return stream:get()
    end
}

packet.GCSectDetail = {
    xy_id = packet.XYID_GC_SEC_DETAIL,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCSectDetail})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.list = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readint()
        self.understand_point = stream:readint()
        self.talent_type = stream:readint()
        self.unknow_4 = stream:readint()
        for i = 1, 15 do
            local l = {}
            l.id = stream:readshort()
            l.level = stream:readuchar()
            table.insert(self.list, l)
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.talent_type)
        stream:writeuint(self.understand_point)
        stream:writeuint(self.show_type)
        stream:writeuint(self.unknow_4 or 0)
        for i = 1, 15 do
            local talent_study = self.list[i]
            stream:writeshort(talent_study.id)
            stream:writeuchar(talent_study.level)
        end
        return stream:get()
    end
}

packet.GCWuhunWG = {
    xy_id = packet.XYID_GC_WUHUN_WG,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCWuhunWG})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unlockd = {}
    end,
    bis = function(self, buffer)
        local stream    = bistream.new()
        stream:attach(buffer)
        self.type = stream:readuint()
        if self.type == 0 or self.type == 1 then
            self.wg = stream:readint()
        else
            self.huanhun_id = stream:readshort()
        end
        self.huanhun_unlock_count= stream:readuint()
        for i = 1, self.huanhun_unlock_count do
            local huanhun = {}
            huanhun.id = stream:readushort()
            huanhun.level = stream:readushort()
            huanhun.grade = stream:readushort()
            huanhun.today_count = stream:readushort()
            table.insert(self.unlockd, huanhun)
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.type)
        if self.type == 0 or self.type == 1 then
            stream:writeint(self.wg)
        else
            stream:writeshort(self.huanhun_id)
        end
        stream:writeuint(self.huanhun_unlock_count)
        for i = 1, self.huanhun_unlock_count do
            local huanhun = self.unlockd[i]
            stream:writeushort(huanhun.id)
            stream:writeushort(huanhun.level)
            stream:writeushort(huanhun.grade)
            stream:writeushort(huanhun.today_count)
            -- table.insert(self.unlockd, huanhun)
        end
        return stream:get()
    end
}

packet.GCDetailSkillList = {
    xy_id = packet.XYID_GC_DETAIL_SKILL_LIST,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCDetailSkillList})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_objID = 0
        self.m_wNumSkill = 0
        self.m_aSkill = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.m_wNumSkill = stream:readushort()
        if self.m_wNumSkill > 0 and self.m_wNumSkill < 0x80 then
            for i = 1, self.m_wNumSkill do
                self.m_aSkill[i] = stream:readuint()
            end
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        stream:writeushort(self.m_wNumSkill)
        if self.m_wNumSkill > 0 and self.m_wNumSkill < 0x80 then
            for i = 1, self.m_wNumSkill do
                self.m_aSkill[i] = self.m_aSkill[i] or 0
                stream:writeuint(self.m_aSkill[i])
            end
        end
        return stream:get()
    end
}

packet.GCCharAllTitles = {
    xy_id = packet.XYID_GC_CHAR_ALL_TITLES,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCCharAllTitles})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_objID = 0
        self.m_nTitleId = 0
        self.m_nTitleStr = 0
        self.m_TitleIdList = {}
        self.m_TitleStrList = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.m_nTitleId = stream:readuchar()
        self.m_nTitleStr = stream:readuchar()
        if self.m_nTitleId > 0x86 then self.m_nTitleId = 0x86 end
        if self.m_nTitleStr > 0x10 then self.m_nTitleStr = 0x10 end
        if self.m_nTitleId > 0 then
            for i = 1, self.m_nTitleId do
                local l = {}
                l.unknow_1 = stream:readuint()
                l.unknow_2 = stream:readuint()
                l.unknow_3 = stream:readuint()
                table.insert(self.m_TitleIdList, l)
            end
        end
        if self.m_nTitleStr > 0 then
            for i = 1, self.m_nTitleStr do
                local l = {}
                l.unknow_1 = stream:readuint()
                l.size = stream:readuchar()
                l.unknow_2 = stream:readuint()
                l.unknow_3 = stream:readuint()
                if l.size < 0x22 then
                    l.unknow_4 = stream:read(l.size)
                end
                table.insert(self.m_TitleStrList, l)
            end
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        stream:writeuchar(self.m_nTitleId)
        stream:writeuchar(self.m_nTitleStr)
        if self.m_nTitleId > 0x86 then self.m_nTitleId = 0x86 end
        if self.m_nTitleStr > 0x10 then self.m_nTitleStr = 0x10 end
        if self.m_nTitleId > 0 then
            for i = 1, self.m_nTitleId do
                local title = self.m_TitleIdList[i] 
                stream:writeuint(0)
                stream:writeuint(title.id)
                stream:writeuint(title.remain_time or 0)
            end
        end
        if self.m_nTitleStr > 0 then
            for i = 1, self.m_nTitleStr do
                local title = self.m_TitleStrList[i]
                stream:writeuint(title.id)
                title.str = gbk.fromutf8(title.str)
                local len = string.len(title.str)
                stream:writeuchar(len)
                stream:writeuint(0)
                stream:writeuint(0)
                if len < 0x22 then
                    stream:write(title.str, len)
                end
            end
        end
        return stream:get()
    end
}

packet.GCMSShopBuyInfo = {
    xy_id = packet.XYID_GC_MS_SHOP_BUY_INFO,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCMSShopBuyInfo})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.size = 0
        self.unknow_1 = {}
        self.unknow_2 = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.size = stream:readuint()
        if self.size > 0 then
            for i = 1, self.size do
                self.unknow_1[i] = stream:readuint()
            end
            for i = 1, self.size do
                self.unknow_2[i] = stream:readuint()
            end
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.size)
        if self.size > 0 then
            for i = 1, self.size do
                stream:writeuint(self.unknow_1[i] or 0)
            end
            for i = 1, self.size do
                stream:writeuint(self.unknow_2[i] or 0)
            end
        end
        return stream:get()
    end
}

packet.GCDiGongShopInfo = {
    xy_id = packet.XYID_GC_DIGONG_SHOP_INFO,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCDiGongShopInfo})
        o:ctor()
        return o
    end,
    ctor = function(self) self.unknow = "" end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow = stream:read(0x80)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:write(self.unknow, 0x80)
        return stream:get()
    end
}

packet.GCExteriorInfo = {
    xy_id = packet.XYID_GC_EXTERIOR_INFO,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCExteriorInfo})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    read_extrior_list = function(self, stream)
        self.extrior_count = stream:readuint()
        if self.extrior_list > 0 then
            self.rider_list = {}
            for i = 1, self.extrior_count do
                self.extrior_list[i] = {}
                self.extrior_list[i].id = stream:readushort()
                self.extrior_list[i].remindtime = stream:readint()
                self.extrior_list[i].unknow_3 = stream:readuchar()
            end
        end
    end,
    read_sub_2 = function(self, stream)
        self.sub_2_unknow_1 = stream:readushort()
        self.sub_2_unknow_2 = stream:readushort()
        self.sub_2_unknow_3 = stream:readushort()
        self.sub_2_unknow_4 = stream:readushort()
        self.sub_2_unknow_5 = stream:readushort()
        self.sub_2_unknow_6 = stream:readuint()
        self.sub_2_unknow_7 = stream:readushort()
        self.extrior_weapon_visual_id = stream:readushort()
        self.extrior_weapon_visual_level = stream:readushort()
		self.extrior_soul_ranse = stream:readushort()
		self.exterior_back_id = stream:readushort()
		self.exterior_head_id = stream:readushort()
		self.exterior_back_pos = stream:readushort()
		self.exterior_head_pos = stream:readushort()
    end,
    read_weapon_visual = function(self, stream)
        local visual = {}
        visual.id = stream:readushort()
        visual.term = stream:readint()
        visual.unknow_1 = stream:readchar()
        visual.level = stream:readuchar()
        table.insert(self.weapon_visuals, visual)
    end,
    write_extrior_list = function(self, stream)
        stream:writeuint(self.extrior_count or 0)
        if self.extrior_count > 0 then
            for i = 1, self.extrior_count do
                stream:writeushort(self.extrior_list[i].id)
                stream:writeint(self.extrior_list[i].remindtime)
                stream:writeuchar(self.extrior_list[i].unknow_3)
            end
        end
    end,
    write_sub_2 = function(self, stream)
        stream:writeshort(self.sub_2_unknow_1 or -1)
        stream:writeshort(self.sub_2_unknow_2 or -1)
        stream:writeshort(self.sub_2_unknow_3 or -1)
        stream:writeshort(self.sub_2_unknow_4 or -1)
        stream:writeshort(self.sub_2_unknow_5 or -1)
        stream:writeint(self.sub_2_unknow_6 or -1)
        stream:writeshort(self.sub_2_unknow_7 or -1)
        stream:writeshort(self.extrior_weapon_visual_id)
        stream:writeshort(self.extrior_weapon_visual_level)
		--2 默认-1 兽魂染色数据 如果数据是131，则外观id是13 1为颜色
		stream:writeshort(self.extrior_soul_ranse or -1)
		--当前背饰
		stream:writeshort(self.exterior_back_id)
		--当前头饰
		stream:writeshort(self.exterior_head_id)
		--当前背饰位置
		stream:writeint(self.exterior_back_pos)	--CurOrnamentsBackPos
		--当前头饰位置
		stream:writeint(self.exterior_head_pos)	--CurOrnamentsHeadPos
    end,
    write_weapon_visual = function(self, stream, visual)
        stream:writeushort(visual.id)
        stream:writeint(visual.term)
        stream:writeuchar(0)
        stream:writeuchar(visual.level)
    end,
    bis = function(self, buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.type)
        stream:writeuint(self.unknow_2)
        if self.type == 0 then
            for i = 1, 5 do
                stream:writeuint(self.list_1[i].size)
                if self.list_1[i].size > 0 then
                    for j = 1, self.list_1[i].size do
                        stream:writeushort(self.list_1[i].list[j].unknow_1)
                        stream:writeint(self.list_1[i].list[j].unknow_2)
                        stream:writeuchar(self.list_1[i].list[j].unknow_3)
                    end
                end
            end
            stream:writeuint(self.exterior_hair_color_index)
            for i = 1, 20 do
                local hair_color = self.hair_colors[i]
                stream:writeint(hair_color.value)
                stream:writeuchar(0)
            end
            stream:writeuint(self.weapon_visual_count)
            if self.weapon_visual_count > 0 then
                for i = 1, self.weapon_visual_count do
                    local visual = self.weapon_visuals[i]
                    self:write_weapon_visual(stream, visual)
                end
            end
        end
        if self.type == 1 then
            self:write_extrior_list(stream)
        elseif self.type == 2 then
            self:write_extrior_list(stream)
        elseif self.type == 3 then
            self:write_extrior_list(stream)
        elseif self.type == 4 then
            self:write_extrior_list(stream)
        elseif self.type == 7 then
            self:write_extrior_list(stream)
        end
        if self.type ~= 5 then
            if self.type == 6 then
                self:write_sub_2(stream)
            elseif self.type == 8 then
                stream:writeuint(self.weapon_visual_count)
                if self.weapon_visual_count > 0 then
                    for i = 1, self.weapon_visual_count do
                        local visual = self.weapon_visuals[i]
                        self:write_weapon_visual(stream, visual)
                    end
                end
            end
        else
            stream:writeuint(self.exterior_hair_color_index)
            for i = 1, 20 do
                local hair_color = self.hair_colors[i]
                stream:writeint(hair_color.value)
                stream:writeuchar(0)
            end
        end
        return stream:get()
    end
}

packet.GCAskFashionDepotData = {
    xy_id = packet.XYID_GC_ASK_FASHION_DEPOT_DATA,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCAskFashionDepotData})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = 0
        self.unknow_2 = 0
        self.size = 0
        self.unknow_3 = 0
        self.list = {}
    end,
    bis = function(self, buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.unknow_1)
        stream:writeuint(self.unknow_2)
        stream:writeuint(self.size)
        self.size = self.size > 100 and 100 or self.size
        if self.size > 0 then
            for i = 1, self.size do
                local fashion = self.list[i]
                stream:writeint(fashion.item_index or define.INVAILD_ID)
                stream:writeuchar(fashion.quality)
                stream:writeushort(fashion.visual)
                for j = 1, 4 do
                    stream:writeuchar(0)
                end
                stream:writeuchar(fashion.slot_count or 0)
                local gems = fashion.list_2 or {}
                for j = 1, 3 do
                    stream:writeint(gems[j] or 0)
                end
                stream:writeuchar(0)
            end
        end
        stream:writeuchar(0)
        return stream:get()
    end
}

packet.GCAskServerTime = {
    xy_id = packet.XYID_GC_ASK_SERVER_TIME,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCAskServerTime})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.year = 0 -- 0x7e6
        self.month = 0 -- 0x7
        self.day = 0 -- 0x1c
        self.hour = 0 -- 0xf
        self.min = 0 -- 0x31
        self.sec = 0 -- 0x2b
        self.secneid = 0 -- 0x2
        self.servertime = 0 -- 0x630b1e17  1661672983 2022-08-28 15:49:43
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.year = stream:readushort()
        self.month = stream:readuchar()
        self.day = stream:readuchar()

        self.hour = stream:readuchar()
        self.min  = stream:readuchar()
        self.sec = stream:readuchar()
        self.secneid = stream:readuint()
        self.servertime = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeushort(self.year)
        stream:writeuchar(self.month)
        stream:writeuchar(self.day)
        stream:writeuchar(self.hour)
        stream:writeuchar(self.min )
        stream:writeuchar(self.sec)
        stream:writeuint(self.secneid)
        stream:writeuint(self.servertime)
        return stream:get()
    end
}

packet.GCMinorPasswd = {
    xy_id = packet.XYID_GC_MINOR_PASSWD,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCMinorPasswd})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_ReturnSetup = {}
        self.m_ReturnDeleteTime = {}
    end,
    bis = function(self, buffer)
        local stream    = bistream.new()
        stream:attach(buffer)
        self.m_Type = stream:readuchar()
        if self.m_Type == 0x1 or self.m_Type == 0xE then
            self.m_ReturnSetup.m_uFlag = stream:readuchar()
        elseif self.m_Type == 0x2 then
            self.m_ReturnDeleteTime.m_uTime = stream:readuint()
        end
        if self.m_Type == 1 or self.m_Type == 0xE then
            self.unknow = stream:readuchar()
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.m_Type)
        if self.m_Type == 0x1 or self.m_Type == 0xE then
            stream:writeuchar(self.m_ReturnSetup.m_uFlag)
        elseif self.m_Type == 0x2 then
            stream:writeuint(self.m_ReturnSetup.m_uTime)
        end
        if self.m_Type == 1 or self.m_Type == 0xE then
            stream:writeuchar(self.unknow or 0)
        end
        return stream:get()
    end
}

--[[
packet.GUID = {
    xy_id = packet.INVAILD_XYID,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GUID})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.world = 0
        self.series = 0
        self.server = 0
    end,
    set = function(t)
        self.world = t.world
        self.series = t.series
        self.server = t.server
    end,
    bis = function(self, stream)
        self.world = stream:readushort()
        self.series = stream:readuint()
        self.server = stream:readushort()
    end,
    bos = function(self, stream)
        stream:writeushort(self.world)
        stream:writeuint(self.series)
        stream:writeushort(self.server)
    end
}]]

packet.ItemGUID = {
    xy_id = packet.INVAILD_XYID,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.ItemGUID})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.world = 0
        self.server = 0
        self.mask = 0
        self.series = 0
    end,
    set = function(t)
        self.world = t.world
        self.server = t.server
        self.mask = t.mask
        self.series = t.series
    end,
    bis = function(self, stream)
        self.world = stream:readuchar()
        self.server = stream:readuchar()
        self.mask = stream:readushort()
        self.series = stream:readuint()
    end,
    bos = function(self, stream)
        stream:writeuchar(self.world)
        stream:writeuchar(self.server)
        stream:writeushort(self.mask)
        stream:writeuint(self.series)
    end
}

packet.PetGUID = {
    xy_id = packet.INVAILD_XYID,
    new = function()
        local o = {}
        setmetatable(o, {
            __index = packet.PetGUID
        })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_uHighSection = 0
        self.m_uLowSection = 0
    end,
    bis = function(self, stream)
        self.m_uHighSection = stream:readuint()
        self.m_uLowSection = stream:readuint()
    end,
    bos = function(self, stream)
        stream:writeuint(self.m_uHighSection)
        stream:writeuint(self.m_uLowSection)
    end
}

packet.PlayerShopGUID = {
    xy_id = packet.INVAILD_XYID,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.PlayerShopGUID})
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, stream)
        self.world = stream:readushort()
        self.server = stream:readuint()
        self.scene = stream:readuint()
        self.pollpos = stream:readushort()
    end,
    bos = function(self, stream)
        stream:writeushort(self.world)
        stream:writeuint(self.server)
        stream:writeuint(self.scene)
        stream:writeushort(self.pollpos)
    end
}

packet.ItemInfo = {
    xy_id = packet.INVAILD_XYID,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.ItemInfo})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    GetSerialType = function(self)
        return math.floor((self.item_index % 100000) / 1000)
    end,
    GetSerialClass = function(self)
        return math.floor(self.item_index / 10000000)
    end,
    GetSerialQual = function(self)
        return math.floor((self.item_index % 10000000) / 100000)
    end,
    GetSerialIndex = function(self) return self.item_index % 1000 end,
    bis = function(self, stream)
        self.guid = packet.ItemGUID.new()
        self.guid:bis(stream)
        self.item_index = stream:readint()
        self.rule = stream:readuchar()
        self.status = stream:readuchar()
        self.unknow_4 = {}
        for i = 1, 0xc do self.unknow_4[i] = stream:readuchar() end
        local flag = math.floor(self.item_index / 10000000)
        if flag == 1 then
            self.max_dur = stream:readuchar()
            self.slot_count = stream:readuchar()
            self.unknow_7 = stream:readuchar()
            self.dur = stream:readuchar()
            self.unknow_9 = stream:readushort()
            self.attr_count = stream:readuchar()
            if self.attr_count > 0 and self.attr_count <= 0x10 then
                self.attr_values = {}
                for i = 1, self.attr_count do
                    self.attr_values[i] = stream:readushort()
                end
            end
            self.gem_count = stream:readuchar()
            self.list_2 = {}
            for i = 1, 4 do self.list_2[i] = stream:readint() end
            self.enhancement_level = stream:readuchar()
            self.unknow_12 = stream:readuchar()
            self.unknow_13 = stream:readushort()
            self.qualifications = {}
            for i = 1, 6 do self.qualifications[i] = stream:readuchar() end
            self.quality = stream:readuchar()
            self.visual = stream:readshort()
            self.attr_type = stream:readulong()
            self.equip_type = stream:readuchar() --1
            stream:readuchar()
			
            self.reshuffle_count = stream:readuhcar()
            self.dw_advance_level = stream:readuhcar()
            self.dw_rankexp = stream:readshort()
            self.dw_featuresid = stream:readuhcar()
        elseif flag == 2 then
            self.unknow_19 = {}
            for i = 1, 0x20 do self.unknow_19[i] = stream:readuchar() end
        elseif flag == 3 then
            self.unknow_20 = {}
            for i = 1, 0x20 do self.unknow_20[i] = stream:readuchar() end
        elseif flag == 4 then
            self.unknow_21 = {}
            for i = 1, 0x20 do self.unknow_21[i] = stream:readuchar() end
        elseif flag == 5 then
            self.unknow_22 = {}
            for i = 1, 0x38 do self.unknow_22[i] = stream:readuchar() end
        elseif flag == 6 then
            self.unknow_23 = {}
            for i = 1, 0x14 do self.unknow_23[i] = stream:readuchar() end
        elseif flag == 7 then
            self.max_dur = stream:readuchar()
            self.attr_count = stream:readuchar()
            self.unknow_24 = stream:readuchar()
            self.dur = stream:readuchar()
            self.unknow_25 = stream:readuchar()
            self.unknow_26 = stream:readushort()
            for i = 1, 6 do self.qualifications[i] = stream:readuchar() end
            self.quality = stream:readuchar()
            self.unknow_28 = stream:readuchar()
            self.unknow_29 = {}
            for i = 1, 0x10 do self.unknow_29[i] = stream:readuchar() end
            self.attr_type = stream:readulong()
            self.unknow_30 = stream:readuchar()
            self.attr_values = {}
            if self.attr_count > 0x10 then self.attr_count = 0x10 end
            for i = 1, self.attr_count do
                self.attr_values[i] = stream:readushort()
            end
        end
        if flag == 1 then
            if self.equip_type == 1 then --暗器
                self.aq_xiulian = stream:readuchar()
                self.aq_exp = stream:readuint()
                self.aq_skill = {}
                for i = 1, 3 do
                    self.aq_skill[i] = stream:readushort()
                end
                self.aq_attr = {}
                for i = 1, 5 do
                    self.aq_attr[i] = stream:readushort()
                end
                self.aq_xidian = stream:readushort()
                self.aq_grow_rate = stream:readushort()
            elseif self.equip_type == 2 then --武魂
                self.unknow_35 = stream:readuint()
                self.wh_life = stream:readushort()
                self.wh_skill = {}
                for i = 1, 3 do
                    self.wh_skill[i] = stream:readushort()
                end
                self.wh_ex_attr = {}
                for i = 1, 10 do
                    self.wh_ex_attr[i] = stream:readuchar()
                end
                self.unknow_39 = stream:readuchar()
                self.wh_level = stream:readuchar()
                self.wh_hecheng_level = stream:readuchar()
                self.wh_ex_attr_number = stream:readuchar()
                self.wh_grow_rate = stream:readushort()
            elseif self.equip_type == 4 then
                self.fwq_star = stream:readuchar()
                self.fwq_zhuqing = stream:readuchar()
                self.fwq_attrs = {}
                self.fwq_list_2 = {}
                for i = 1, 6 do
                    self.fwq_list_1[i] = stream:readchar()
                end
                for i = 1, 3 do
                    self.fwq_list_2[i] = stream:readuchar()
                end
                self.fwq_skill_list_1 = {}
                for i = 1, 2 do
                    self.fwq_skill_list_1[i] = stream:readushort()
                end
                self.fwq_skill_list_2 = {}
                for i = 1, 3 do
                    self.fwq_skill_list_2[i] = stream:readushort()
                end
            end
        end
        if flag ~= 7 or self.pet_equip_type ~= 1 then
            if flag ~= 1 or self.equip_type ~= 3 then
                if self.status & 0x10 == 0x10 then
                    self.creator = stream:read(0x20)
                end
            else
                self.ling_yu_attrs = {}
                self.ling_yu_attr_vales = {}
                self.ling_yu_attrs_enhancement_level = {}
                self.lingyu_enhancement_levels_new = {}
                for i = 1, 3 do
                    self.ling_yu_attrs[i] = stream:readchar()
                    self.ling_yu_attr_vales[i] = stream:readint()
                    self.ling_yu_attrs_enhancement_level[i] = stream:readushort()
                    self.lingyu_enhancement_levels_new[i] = stream:readushort()
                end
            end
        else
            self.unknow_49 = stream:readushort()
            self.unknow_50 = stream:readushort()
            self.unknow_51 = stream:readuchar()
            self.unknow_52 = stream:readushort()
            self.unknow_53 = stream:readushort()
            self.pet_soul_attr = {}
            for i = 1, 6 do
                self.pet_soul_attr[i].type = stream:readuchar()
                self.pet_soul_attr[i].value = stream:readuint()
            end
        end
        self.unknow_44 = stream:readuint()
        self.unknow_45 = stream:readushort()
    end,
    bos = function(self, stream)
        packet.ItemGUID.bos(self.guid, stream)
        stream:writeint(self.item_index)
        stream:writeuchar(self.rule)
        stream:writeuchar(self.status)
        for i = 1, 0xc do stream:writeuchar(self.unknow_4[i]) end
        local flag = math.floor(self.item_index / 10000000)
        if flag == 1 then
            stream:writeuchar(self.max_dur)
            stream:writeuchar(self.slot_count)
            stream:writeuchar(self.unknow_7)
            stream:writeuchar(self.dur)
            stream:writeushort(self.unknow_9)
            stream:writeuchar(self.attr_count)
            if self.attr_count > 0 and self.attr_count <= 0x10 then
                for i = 1, self.attr_count do
                    stream:writeushort(self.attr_values[i])
                end
            end
            stream:writeuchar(self.gem_count)
            for i = 1, 4 do stream:writeint(self.list_2[i] or 0) end
            stream:writeuchar(self.enhancement_level)
            stream:writeuchar(self.diaowen_id // 8)
            stream:writeshort(self.diaowen_material_count * 8 + self.diaowen_id % 8)
            for i = 1, 6 do stream:writeuchar(self.qualifications[i]) end
            stream:writeuchar(self.quality)
			-- if not self.visual then
				-- local skynet = require "skynet"
				-- skynet.logi("self.equip_type = ",self.equip_type,"self.item_index = ",self.item_index)
			-- end
            stream:writeshort(self.visual or 0)
            stream:writeulong(self.attr_type)
            stream:writeuchar(self.equip_type)
            stream:writeuchar(0) --GF不用的作废数据
            stream:writeuchar(self.reshuffle_count or 0) --手工属性重洗次数
			--unkown 应该是雕纹精绘数据
			stream:writeuchar(self.dw_advance_level or 0) --雕文进阶等级	min=0
            stream:writeshort(self.dw_rankexp or 0) --RankExp 升级所需点数
			stream:writeuchar(self.dw_featuresid or 0) --FeaturesID 纹刻效果ID 无=0
        elseif flag == 2 then
            for i = 1, 0x20 do stream:writeuchar(self.unknow_19[i]) end
        elseif flag == 3 then
            for i = 1, 0x20 do stream:writeuchar(self.unknow_20[i]) end
        elseif flag == 4 then
            for i = 1, 0x20 do stream:writeuchar(self.unknow_21[i]) end
        elseif flag == 5 then
            for i = 1, 0x38 do stream:writeuchar(self.unknow_22[i]) end
        elseif flag == 6 then
            for i = 1, 0x14 do stream:writeuchar(self.unknow_23[i]) end
        elseif flag == 7 then
            stream:writechar(self.max_dur)
            stream:writeuchar(self.attr_count)
            stream:writeuchar(self.unknow_24)
            stream:writechar(self.dur)
            stream:writeuchar(self.unknow_25)
            stream:writeushort(self.unknow_26)
            for i = 1, 6 do stream:writeuchar(self.qualifications[i]) end
            stream:writeuchar(self.quality)
            stream:writeuchar(self.unknow_28)
            for i = 1, 0x10 do stream:writeuchar(self.unknow_29[i]) end
            stream:writeulong(self.attr_type)
            stream:writeuchar(self.pet_equip_type)
            if self.attr_count > 0x10 then self.attr_count = 0x10 end
            for i = 1, self.attr_count do
                stream:writeushort(self.attr_values[i])
            end
        end
        if flag == 1 then
            if self.equip_type == 1 then
                stream:writeuchar(self.aq_xiulian)
                stream:writeuint(self.aq_exp)
                for i = 1, 3 do
                    stream:writeushort(self.aq_skill[i])
                end
                for i = 1, 5 do
                    stream:writeushort(self.aq_attr[i])
                end
                stream:writeushort(self.aq_xidian)
                stream:writeushort(self.aq_grow_rate)
            elseif self.equip_type == 2 then
                stream:writeuint(self.wh_exp)
                stream:writeushort(self.wh_life)
                for i = 1, 3 do
                    stream:writeshort(self.wh_skill[i])
                end
                for i = 1, 10 do
                    stream:writeuchar(self.wh_ex_attr[i] or 0)
                end
                stream:writeuchar(self.unknow_39 or 0)
                stream:writeuchar(self.wh_level)
                stream:writeuchar(self.wh_hecheng_level)
                stream:writeuchar(self.wh_ex_attr_number)
                stream:writeushort(self.wh_grow_rate)
            elseif self.equip_type == 4 then
                stream:writeuchar(self.fwq_star)
                stream:writeuchar(self.fwq_zhuqing)
                for i = 1, 6 do
                    stream:writechar(self.fwq_attrs[i])
                end
                for i = 1, 3 do
                    stream:writechar(self.fwq_list_2[i] or 0)
                end
                for i = 1, 2 do
                    stream:writeushort(self.fwq_skill_list_1[i])
                end
                for i = 1, 3 do
                    stream:writeushort(self.fwq_skill_list_2[i])
                end
            end
        end
        if flag ~= 7 or self.pet_equip_type ~= 1 then
            if flag ~= 1 or self.equip_type ~= 3 then
                if self.status & 0x10 == 0x10 then
                    assert(self.creator, self.item_index)
                    stream:write(gbk.fromutf8(self.creator), 0x20)
                end
            else
                self.ling_yu_attrs_enhancement_level = self.ling_yu_attrs_enhancement_level or {}
                for i = 1, 3 do
                    stream:writechar(self.ling_yu_attrs[i])
                    stream:writeint(self.ling_yu_attr_values[i])
                    stream:writeshort(self.ling_yu_attrs_enhancement_level[i] or 0)
                    if self.lingyu_enhancement_levels_new and self.lingyu_enhancement_levels_new[i] then
                        stream:writeshort(self.lingyu_enhancement_levels_new[i])
                    else
                        stream:writeshort(0)
                    end
                end
            end
        else
            stream:writeushort(self.level)
            stream:writeushort(self.unknow_50 or 2)
            stream:writeuchar(self.pet_soul_level)
            stream:writeushort(self.pet_soul_exp)
            stream:writeushort(self.unknow_53 or 5)
            for i = 1, 6 do
                stream:writechar(self.pet_soul_attr[i].type)
                stream:writeuint(self.pet_soul_attr[i].value)
            end
        end
        stream:writeuint(self.unknow_44)
        stream:writeushort(self.unknow_45)
    end
}

packet.EquipStream = {
    xy_id = packet.INVAILD_XYID,
    new = function()
        local o = {}
        setmetatable(o, {
            __index = packet.EquipStream
        })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bos = function(self, stream)
        stream:write(self, string.len(self))
    end
}

packet.GCStallPetView_t = {
    xy_id = packet.INVAILD_XYID,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCStallPetView_t})
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.flag)
        stream:writeuchar(0xff)
        stream:writeushort(0xffff)
        stream:writeuint(self.price)
        stream:writeuint(self.serial)
        return stream:get()
    end
}

packet.GCExchangePetView_t = {
    xy_id = packet.INVAILD_XYID,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCExchangePetView_t})
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.flag)
        return stream:get()
    end
}


packet.EquipInfo = {
    xy_id = packet.INVAILD_XYID,
    new = function()
        local o = {}
        setmetatable(o, {
            __index = packet.EquipInfo
        })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.pet_equip_unknow_4 = {}
        self.pet_equip_unknow_5 = {}
        self.pet_equip_unknow_6 = {}
        self.pet_soul_attr = {}
        self.attr_type = 0
        self.attr_values = {}
    end,
    bis = function(self, stream)
    end,
    bos = function(self, stream)
	    --188
        packet.ItemGUID.bos(self.guid, stream)--8
        stream:writeint(self.item_index)--4
        stream:writeuchar(self.rule)--1
        stream:writeuchar(self.status)--1

        stream:writeushort(self.unknow_1 or 0)
        stream:writeuchar(self.level or 0)
        stream:writeuchar(self.unknow_2 or 0)
        stream:writeushort(self.pet_equip_unknow_8 or 0)
        stream:writeushort(self.pet_equip_unknow_3 or 0)
        stream:writeushort(self.pet_soul_exp or 0)
        stream:writeuchar(self.pet_soul_level or 0)

        self.pet_equip_unknow_4 = self.pet_equip_unknow_4 or {}
        for i = 1, 3 do
            stream:writeuchar(self.pet_equip_unknow_4[i] or 0)
        end

        self.pet_soul_attr = self.pet_soul_attr or {}
        self.pet_soul_attr[1] = self.pet_soul_attr[1] or {}
        stream:writeint(self.pet_soul_attr[1].type or 0)
        stream:writeuint(self.pet_soul_attr[1].value or 0)
        self.pet_soul_attr[2] = self.pet_soul_attr[2] or {}
        stream:writeint(self.pet_soul_attr[2].type or 0)
        stream:writeuint(self.pet_soul_attr[2].value or 0)
        self.pet_soul_attr[3] = self.pet_soul_attr[3] or {}
        stream:writeint(self.pet_soul_attr[3].type or 0)
        stream:writeuint(self.pet_soul_attr[3].value or 0)
        self.pet_soul_attr[4] = self.pet_soul_attr[4] or {}
        stream:writeint(self.pet_soul_attr[4].type or 0)
        stream:writeuint(self.pet_soul_attr[4].value or 0)
        self.pet_soul_attr[5] = self.pet_soul_attr[5] or {}
        stream:writeint(self.pet_soul_attr[5].type or 0)
        stream:writeuint(self.pet_soul_attr[5].value or 0)
        self.pet_soul_attr[6] = self.pet_soul_attr[6] or {}
        stream:writeint(self.pet_soul_attr[6].type or 0)
        stream:writeuint(self.pet_soul_attr[6].value or 0)

        self.pet_equip_unknow_5 = self.pet_equip_unknow_5 or {}
        for i = 1, 13 do
            stream:writeuchar(self.pet_equip_unknow_5[i] or 0)
        end
        stream:writeuchar(self.attr_count or 0)
        self.pet_equip_unknow_9 = self.pet_equip_unknow_9 or {}
        for i = 1, 12 do
            stream:writeuchar(self.pet_equip_unknow_9[i] or 0)
        end
        stream:writeuchar(self.quality or 0)
        self.pet_equip_unknow_10 = self.pet_equip_unknow_10 or {}
        for i = 1, 21 do
            stream:writeuchar(self.pet_equip_unknow_10[i] or 0)
        end
        stream:writeulong(self.attr_type or 0)
        stream:writeushort(self.unknow_7 or 0)
        self.attr_values = self.attr_values or {}
        for i = 1, 16 do
            stream:writeushort(self.attr_values[i] or 0)
        end

        self.pet_equip_unknow_6 = self.pet_equip_unknow_6 or {}
        for i = 1, 22 do
            stream:writeuchar(self.pet_equip_unknow_6[i] or 0)
        end
		--unkown 应该是雕纹精绘数据
		--stream:writeuchar(0)
		--stream:writeshort(0)
		--stream:writeuchar(0)
		-- stream:writeuchar(self.dw_advance_level or 0) --雕文进阶等级	min=0
		-- stream:writeshort(self.dw_rankexp or 0) --RankExp 升级所需点数
		-- stream:writeuchar(self.dw_featuresid or 0) --FeaturesID 纹刻效果ID 无=0
    end
}

packet.TeamMemberInfo = {
    xy_id = packet.INVAILD_XYID,
    new = function()
        local o = {}
        setmetatable(o, {
            __index = packet.TeamMemberInfo
        })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = 0
        self.unknow_2 = 259
        self.unknow_3 = 0
        self.unknow_4 = 8
    end,
    bis = function(self, stream)
    end,
    bos = function(self, stream)
        stream:writeuint(self.model)
        stream:writeuint(self.menpai)
        stream:writeuint(self.level)
        -- stream:writeuint(0)
        -- stream:writeuint(259)
        -- stream:writeuint(self.hair_color or 0)
        -- stream:writeint(self.fashion[define.WG_KEY_C])
        -- stream:writeuint(8)
        stream:writeuint(self.unknow_1 or 0)
        stream:writeuint(self.unknow_2 or 259)
        stream:writeuint(self.unknow_3 or 0)
        stream:writeint(0)
        stream:writeuint(self.unknow_4 or 8)
		--20250317 fix
		stream:writeint(-1)
		stream:writeint(-1)
		stream:writeint(-1)
    end
}
packet.GCDetailEquipList = {
    xy_id = packet.XYID_GC_DETAIL_EQUIP_LIST,
    ASK_EQUIP_MODE = {ASK_EQUIP_ALL = 0, ASK_EQUIP_SET = 1},
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCDetailEquipList})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_objID = 0
        self.m_mode = 0
        self.m_wPartFlags = {}
        self.itemList = {}
        self.unknow = 0
    end,
    bis = function(self, buffer)
	
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.m_mode = stream:readuint()
        for i = 1, 0xc do
            self.m_wPartFlags[i] = stream:readuchar()
        end
        for i = 0, 83 do
            local index = math.floor(i / 8) + 1
            local shift = i % 8
            if (self.m_wPartFlags[index] or 0) & (1 << shift) == (1 << shift) then
                local item = packet.ItemInfo.new()
                item:bis(stream)
                table.insert(self.itemList, item)
            end
        end
        self.unknow = stream:readuint()
	
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        stream:writeuint(self.m_mode)
        self.m_wPartFlags = {}
        for i = 0, 83 do
            local index = math.floor(i / 8) + 1
            local shift = i % 8
            local item = self.itemList[i]
            if item then
                self.m_wPartFlags[index] = (self.m_wPartFlags[index] or 0) | 1 << shift
            end
        end
        for i = 1, 0xc do
            stream:writeuchar(self.m_wPartFlags[i] or 0)
        end
        for i = 0, 83 do
            local item = self.itemList[i]
            if item then
                packet.ItemInfo.bos(item, stream)
            end
        end
        stream:writeuint(self.unknow)
        return stream:get()
    end
}

packet.GCBagSizeChange = {
    xy_id = packet.XYID_GC_BAG_SIZE_CHANGE,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCBagSizeChange})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.prop_size = 0
        self.material_size = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.prop_size = stream:readuchar()
        self.material_size = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.prop_size)
        stream:writeuchar(self.material_size)
        return stream:get()
    end
}

packet.GCMyBagList = {
    xy_id = packet.XYID_GC_MY_BAG_LIST,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCMyBagList})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_Mode = 0
        self.m_AskCount = 0
        self.list = {}
    end,
    bis = function(self, buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_Mode)
        stream:writeuchar(self.m_AskCount)
        if self.m_AskCount > 0xF0 then self.m_AskCount = 0xF0 end
        for i = 1, self.m_AskCount do
            local item = self.list[i]
            stream:writeuchar(item.index)
            for j = 1, 0x3 do stream:writeuchar(item.unknow[j]) end
            packet.ItemGUID.bos(item.guid, stream)
            stream:writeuint(item.item_index)
            stream:writeuchar(item.count)
            for j = 1, 0x3 do stream:writeuchar(item.unknow_1[j]) end
        end
        return stream:get()
    end
}

packet.GCMissionList = {
    xy_id = packet.XYID_GC_MISSION_LIST,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCMissionList})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_objID = 0
        self.m_uMissionListFlags = 0
        self.char_missions = {}
    end,
    bis = function(self, buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        stream:writeuint(self.m_uMissionListFlags)
        stream:writeuchar(#self.char_missions)
        for i = 1, 20 do
            local own = self.char_missions[i] or { index = -1, id = -1, yFlag = 0, params = { 0, 0, 0, 0, 0, 0, 0, 0}}
            stream:writeint(own.id)
            stream:writeint(own.index or define.INVAILD_ID)
            stream:writeuchar(own.yFlag)
            for i = 1, 8 do
                stream:writeint(own.params[i])
            end
        end
        stream:writeshort(0)
        stream:writechar(0)
        for i = 1, 128 do
            local value = self.mission_have_done_flags[i]
            stream:writeuint(value)
        end
        for i = 1, 200 do
            stream:writeuint(self.mission_datas[i] or 0)
        end
        return stream:get()
    end
}

packet.GCGroupingNameRet = {
    xy_id = packet.XYID_GC_GROUPING_NAME_RET,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCGroupingNameRet})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.list = {}
        self.unknow = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        for i = 1, 4 do
            local l = {}
            l.size = stream:readuint()
            if l.size > 0 and l.size <= 20 then
                l.data = stream:read(l.size)
            end
            table.insert(self.list, l)
        end
        self.unknow = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        for i = 1, 4 do
            self.list[i] = {size = 0, unknow_2 = ""}
            stream:writeuint(self.list[i].size)
            if self.list[i].size > 0 and self.list[i].size <= 20 then
                stream:write(self.list[i].data, self.list[i].size)
            end
        end
        stream:writeuint(self.unknow)
        return stream:get()
    end
}

packet.GCBankMoney = {
    xy_id = packet.XYID_GC_BANK_MONEY,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCBankMoney})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_4 = 0
        self.unknow_5 = ""
        self.list = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.op = stream:readuchar()
        self.bank_save_money = stream:readuint()
        self.result = stream:readuchar()
        self.unknow_size = stream:readuint()
        if self.size > 0 and self.size < 0x13 then
            for i = 1, self.size do
                local l = {}
                l.unknow_1 = stream:readuint()
                table.insert(self.list, l)
            end
            for i = 1, self.size do
                self.list[i].unknow_2 = stream:readuint()
            end
        end
        self.unknow_4 = stream:readuint()
        if self.unknow_4 < 0x3FF then
            self.unknow_5 = stream:read(self.unknow_4)
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.op)
        stream:writeuint(self.bank_save_money)
        stream:writeuchar(self.result)
        local size = #self.list
        stream:writeuint(size)
        if size > 0 and size < 0x13 then
            for i = 1, size do
                self.list[i] = self.list[i] or {unknow_1 = 0, unknow_2 = 0}
                stream:writeuint(self.list[i].unknow_1)
            end
            for i = 1, size do
                stream:writeuint(self.list[i].unknow_2)
            end
        end
        stream:writeuint(self.unknow_4)
        if self.unknow_4 < 0x3FF then
            stream:write(self.unknow_5, self.unknow_4)
        end
        return stream:get()
    end
}

packet.GCOpenWorldReference = {
    xy_id = packet.XYID_GC_OPEN_WORLD_REFERENCE,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCOpenWorldReference})
        o:ctor()
        return o
    end,
    ctor = function(self) self.unknow = "" end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow = stream:read(0x20)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:write(self.unknow, 0x20)
        return stream:get()
    end
}

packet.GCRetGSChitChatInfo = {
    xy_id = packet.XYID_GC_RET_GS_CHIT_CGAT_INFO,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCRetGSChitChatInfo})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = 0
        self.unknow_2 = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readuchar()
        self.unknow_2 = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.unknow_1)
        stream:writeuchar(self.unknow_2)
        return stream:get()
    end
}

packet.GCStopPedding = {
    xy_id = packet.XYID_GC_STOP_PEDDING,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCStopPedding})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        return stream:get()
    end
}

packet.GCLevelUpLock = {
    xy_id = packet.XYID_GC_LEVEL_UP_LOCK,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCLevelUpLock})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = 0
        self.unknow_2 = 0
        self.unknow_3 = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readuint()
        self.unknow_2 = stream:readuint()
        self.unknow_3 = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.unknow_1)
        stream:writeuint(self.unknow_2)
        stream:writeuint(self.unknow_3)
        return stream:get()
    end
}

packet.GCMissionModify = {
    xy_id = packet.XYID_GC_MISSION_MODIFY,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCMissionModify})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_nFlag = 0
        self.m_aMissionData = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_nFlag = stream:readuchar()
        if self.m_nFlag == 1 then
            self.mission_id = stream:readushort()
            self.script_id = stream:readuint()
        else
            self.m_aMissionData = {}
            self.m_aMissionData.mission_id = stream:readint()
            self.m_aMissionData.mission_index = stream:readint()
            self.m_aMissionData.m_yFlags = stream:readuchar()
            self.m_aMissionData.params = {}
            for i = 1, 8 do
                self.m_aMissionData.params[i] = stream:readint()
            end
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.m_nFlag)
        if self.m_nFlag == 1 then
            stream:writeushort(self.mission_id)
            stream:writeuint(self.mission_index)
        else
            stream:writeint(self.m_aMissionData.id)
            stream:writeint(self.m_aMissionData.index)
            stream:writechar(self.m_aMissionData.yFlag)
            for i = 1, 8 do
                stream:writeint(self.m_aMissionData.params[i])
            end
        end
        return stream:get()
    end
}

packet.GCVirtualNPCInfo = {
    xy_id = packet.XYID_GC_VIRTUAL_NPC_INFO,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCVirtualNPCInfo})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_nFlag = 0
        self.unknow_1 = 0
        self.unknow_2 = 0
        self.unknow_3 = 0
        self.unknow_4 = 0
        self.unknow_5 = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_nFlag = stream:readuchar()
        if self.m_nFlag == 1 then
            self.unknow_1 = stream:readuchar()
            self.unknow_2 = stream:readushort()
            self.unknow_3 = stream:readuint()
            self.unknow_4 = stream:readuint()
        else
            for i = 1, 0x10 do self.unknow_5[i] = stream:readuchar() end
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.m_nFlag)
        if self.m_nFlag == 1 then
            stream:writeuchar(self.unknow_1)
            stream:writeushort(self.unknow_2)
            stream:writeuint(self.unknow_3)
            stream:writeuint(self.unknow_4)
        else
            for i = 1, 0x10 do stream:writeuchar(self.unknow_5[i]) end
        end
        return stream:get()
    end
}

--[[
    00 00 00 00 00 00 00 00
    00 00 00 00
    00 00 00 00 00 00 00 00 00 00 00
    00 31 0f
]]
packet.GCDetailAttrib_Pet = {
    xy_id = packet.XYID_GC_DETAIL_ATTRIB_PET,
    TYPE = {
		TYPE_NORMAL = 0, 
		TYPE_EXCHANGE = 1,
		TYPE_STALL = 2,
		TYPE_PLAYERSHOP = 3,
		TYPE_CONTEX_MENU_OTHER_PET = 4,
    },
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.GCDetailAttrib_Pet})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_Flags = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
        self.skills = { activate = {}, positive = {}}
        self.equip_list = {}
    end,
    set_extra_data = function(self, data)
        self.extra_data = data
    end,
    set_guid = function(self, guid)
        self.guid = packet.PetGUID.new()
        self.guid.m_uHighSection = guid.m_uHighSection
        self.guid.m_uLowSection = guid.m_uLowSection
    end,
    set_obj_id = function(self, obj_id)
        if obj_id then
            self.m_objID = obj_id
            self.m_Flags[1] = self.m_Flags[1] | 0x1
        end
    end,
    set_unknow_2 = function(self, unknow_2)
        self.unknow_2 = unknow_2
        self.m_Flags[3] = self.m_Flags[3] | 0x40
    end,
    set_gengu = function(self, gengu)
        self.gengu = gengu
        self.m_Flags[5] = self.m_Flags[5] | 0x80
    end,
    set_unknow_5 = function(self, unknow_5)
        self.unknow_5 = unknow_5
        self.m_Flags[6] = self.m_Flags[6] | 0x2
    end,
    set_titles = function(self, titles)
        self.titles = titles
        self.m_Flags[8] = self.m_Flags[8] | 0x2
    end,
    set_current_title = function(self, current_title)
        self.current_title = current_title
        assert(current_title ~= 0)
        self.m_Flags[8] = self.m_Flags[8] | 0x4
    end,
    set_unknow_10 = function(self, unknow_10)
        self.unknow_10 = unknow_10
        self.m_Flags[8] = self.m_Flags[8] | 0x8
    end,
    set_unknow_11 = function(self, unknow_11)
        self.unknow_11 = unknow_11
    end,
    set_unknow_6 = function(self, unknow_6)
        self.unknow_6 = unknow_6
    end,
    set_unknow_7 = function(self, unknow_7)
        self.unknow_7 = unknow_7
    end,
    set_unknow_13 = function(self, unknow_13)
        self.unknow_13 = unknow_13
        self.m_Flags[10] = self.m_Flags[10] | 0x80
    end,
    set_data_id = function(self, data_id)
        self.data_index = data_id
        self.m_Flags[1] = self.m_Flags[1] | 0x2
    end,
    set_name = function(self, name)
        self.name = gbk.fromutf8(name)
        self.name_size = string.len(self.name)
        self.m_Flags[1] = self.m_Flags[1] | 0x4
    end,
    set_ai_type = function(self, ai_type)
        self.ai_type = ai_type
        self.m_Flags[1] = self.m_Flags[1] | 0x8
    end,
    set_spouse_guid = function(self, guid)
        self.spouse_GUID = packet.PetGUID.new()
        self.spouse_GUID.m_uHighSection = guid.m_uHighSection
        self.spouse_GUID.m_uLowSection = guid.m_uLowSection
        self.m_Flags[1] = self.m_Flags[1] | 0x10
    end,
    set_level = function(self, level)
        self.level = level
        self.m_Flags[1] = self.m_Flags[1] | 0x20
    end,
    set_exp = function(self, exp)
        self.exp = exp
        self.m_Flags[1] = self.m_Flags[1] | 0x80
    end,
    set_hp = function(self, hp)
        self.hp = hp
        self.m_Flags[2] = self.m_Flags[2] | 0x1
    end,
    set_hp_max = function(self, hp_max)
        self.hp_max = hp_max
        self.m_Flags[2] = self.m_Flags[2] | 0x2
    end,
    set_life_span = function(self, life_span)
        self.life_span = life_span
        self.m_Flags[2] = self.m_Flags[2] | 0x4
    end,
    set_lingxing = function(self, lingxing)
        self.lingxing = lingxing
        self.m_Flags[2] = self.m_Flags[2] | 0x8
    end,
    set_unknow_1 = function(self, unknow_1)
        self.unknow_1 = unknow_1
        self.m_Flags[1] = self.m_Flags[1] | 0x40
    end,
    set_happiness = function(self, happiness)
        self.happiness = happiness
        self.m_Flags[2] = self.m_Flags[2] | 0x10
    end,
    set_attrib_att_physics = function(self, attrib_att_physics)
        self.attrib_att_physics = attrib_att_physics
        self.m_Flags[2] = self.m_Flags[2] | 0x20
    end,
    set_attrib_att_magic = function(self, attrib_att_magic)
        self.attrib_att_magic = attrib_att_magic
        self.m_Flags[2] = self.m_Flags[2] | 0x40
    end,
    set_attrib_def_physics = function(self, attrib_def_physics)
        self.attrib_def_physics = attrib_def_physics
        self.m_Flags[2] = self.m_Flags[2] | 0x80
    end,
    set_attrib_def_magic = function(self, attrib_def_magic)
        self.attrib_def_magic = attrib_def_magic
        self.m_Flags[3] = self.m_Flags[3] | 0x1
    end,
    set_attrib_hit = function(self, attrib_hit)
        self.attrib_hit = attrib_hit
        self.m_Flags[3] = self.m_Flags[3] | 0x2
    end,
    set_attrib_miss = function(self, attrib_miss)
        self.attrib_miss = attrib_miss
        self.m_Flags[3] = self.m_Flags[3] | 0x4
    end,
    set_mind_attack = function(self, mind_attack)
        self.mind_attack = mind_attack
        self.m_Flags[3] = self.m_Flags[3] | 0x8
    end,
    set_mind_defend = function(self, mind_defend)
        self.mind_defend = mind_defend
        self.m_Flags[3] = self.m_Flags[3] | 0x10
    end,
    set_attack_type = function(self, attack_type)
        self.attack_type = attack_type
        self.m_Flags[3] = self.m_Flags[3] | 0x20
    end,
    set_main_perception = function(self, main_perception)
        self.main_perception = main_perception
        self.m_Flags[10] = self.m_Flags[10] | 0x40
    end,
    set_str_perception = function(self, str_perception)
        self.str_perception = str_perception
        self.m_Flags[4] = self.m_Flags[4] | 0x1
    end,
    set_con_perception = function(self, con_perception)
        self.con_perception = con_perception
        self.m_Flags[4] = self.m_Flags[4] | 0x2
    end,
    set_dex_perception = function(self, dex_perception)
        self.dex_perception = dex_perception
        self.m_Flags[4] = self.m_Flags[4] | 0x4
    end,
    set_spr_perception = function(self, spr_perception)
        self.spr_perception = spr_perception
        self.m_Flags[4] = self.m_Flags[4] | 0x8
    end,
    set_int_perception = function(self, int_perception)
        self.int_perception = int_perception
        self.m_Flags[4] = self.m_Flags[4] | 0x10
    end,
    set_soul_add_str_perception = function(self, soul_add_str_perception)
        self.soul_add_str_perception = soul_add_str_perception
        self.m_Flags[4] = self.m_Flags[4] | 0x20
    end,
    set_soul_add_con_perception = function(self, soul_add_con_perception)
        self.soul_add_con_perception = soul_add_con_perception
        self.m_Flags[4] = self.m_Flags[4] | 0x40
    end,
    set_soul_add_dex_perception = function(self, soul_add_dex_perception)
        self.soul_add_dex_perception = soul_add_dex_perception
        self.m_Flags[4] = self.m_Flags[4] | 0x80
    end,
    set_soul_add_spr_perception = function(self, soul_add_spr_perception)
        self.soul_add_spr_perception = soul_add_spr_perception
        self.m_Flags[5] = self.m_Flags[5] | 0x1
    end,
    set_soul_add_int_perception = function(self, soul_add_int_perception)
        self.soul_add_int_perception = soul_add_int_perception
        self.m_Flags[5] = self.m_Flags[5] | 0x2
    end,
    set_str = function(self, str)
        self.str = str
        self.m_Flags[5] = self.m_Flags[5] | 0x4
    end,
    set_con = function(self, con)
        self.con = con
        self.m_Flags[5] = self.m_Flags[5] | 0x8
    end,
    set_dex = function(self, dex)
        self.dex = dex
        self.m_Flags[5] = self.m_Flags[5] | 0x10
    end,
    set_spr = function(self, spr)
        self.spr = spr
        self.m_Flags[5] = self.m_Flags[5] | 0x20
    end,
    set_int= function(self, int)
        self.int = int
        self.m_Flags[5] = self.m_Flags[5] | 0x40
    end,
    set_point_remain = function(self, point_remain)
        self.point_remain = point_remain
        self.m_Flags[6] = self.m_Flags[6] | 0x1
    end,
    set_activate_skill_1 = function(self, skill)
        skill = skill or define.INVAILD_ID
        self.skills.activate[1] = { id = skill, level = 0}
        self.m_Flags[6] = self.m_Flags[6] | 0x4
    end,
    set_activate_skill_2 = function(self, skill)
        skill = skill or define.INVAILD_ID
        self.skills.activate[2] = { id = skill, level = 0}
        self.m_Flags[6] = self.m_Flags[6] | 0x8
    end,
    set_positive_skill_1 = function(self, skill)
        skill = skill or define.INVAILD_ID
        self.skills.positive[1] = { id = skill, level = 0}
        self.m_Flags[6] = self.m_Flags[6] | 0x10
    end,
    set_positive_skill_2 = function(self, skill)
        skill = skill or define.INVAILD_ID
        self.skills.positive[2] = { id = skill, level = 0}
        self.m_Flags[6] = self.m_Flags[6] | 0x20
    end,
    set_positive_skill_3 = function(self, skill)
        skill = skill or define.INVAILD_ID
        self.skills.positive[3] = { id = skill, level = 0}
        self.m_Flags[6] = self.m_Flags[6] | 0x40
    end,
    set_positive_skill_4 = function(self, skill)
        skill = skill or define.INVAILD_ID
        self.skills.positive[4] = { id = skill, level = 0}
        self.m_Flags[6] = self.m_Flags[6] | 0x80
    end,
    set_positive_skill_5 = function(self, skill)
        skill = skill or define.INVAILD_ID
        self.skills.positive[5] = { id = skill, level = 0}
        self.m_Flags[7] = self.m_Flags[7] | 0x1
    end,
    set_positive_skill_6 = function(self, skill)
        skill = skill or define.INVAILD_ID
        self.skills.positive[6] = { id = skill, level = 0}
        self.m_Flags[7] = self.m_Flags[7] | 0x2
    end,
    set_positive_skill_7 = function(self, skill)
        skill = skill or define.INVAILD_ID
        self.skills.positive[7] = { id = skill, level = 0}
        self.m_Flags[7] = self.m_Flags[7] | 0x4
    end,
    set_positive_skill_8 = function(self, skill)
        skill = skill or define.INVAILD_ID
        self.skills.positive[8] = { id = skill, level = 0}
        self.m_Flags[7] = self.m_Flags[7] | 0x8
    end,
    set_positive_skill_9 = function(self, skill)
        skill = skill or define.INVAILD_ID
        self.skills.positive[9] = { id = skill, level = 0}
        self.m_Flags[7] = self.m_Flags[7] | 0x10
    end,
    set_positive_skill_10 = function(self, skill)
        skill = skill or define.INVAILD_ID
        self.skills.positive[10] = { id = skill, level = 0}
        self.m_Flags[7] = self.m_Flags[7] | 0x20
    end,
    set_positive_skill_11 = function(self, skill)
        skill = skill or define.INVAILD_ID
        self.skills.positive[11] = { id = skill, level = 0}
        self.m_Flags[7] = self.m_Flags[7] | 0x40
    end,
    set_equip_1 = function(self, equip)
        if equip then
            self.equip_list[1] = equip
            self.m_Flags[8] = self.m_Flags[8] | 0x10
        end
    end,
    set_equip_2 = function(self, equip)
        if equip then
            self.equip_list[2] = equip
            self.m_Flags[8] = self.m_Flags[8] | 0x20
        end
    end,
    set_equip_3 = function(self, equip)
        if equip then
            self.equip_list[3] = equip
            self.m_Flags[8] = self.m_Flags[8] | 0x40
        end
    end,
    set_equip_4 = function(self, equip)
        if equip then
            self.equip_list[4] = equip
            self.m_Flags[8] = self.m_Flags[8] | 0x80
        end 
    end,
    set_equip_5 = function(self, equip)
        if equip then
            self.equip_list[5] = equip
            self.m_Flags[9] = self.m_Flags[8] | 0x1
        end
    end,
    set_equip_6 = function(self, equip)
        if equip then
            self.equip_list[6] = equip
            self.m_Flags[9] = self.m_Flags[9] | 0x2
        end
    end,
    set_wuxing = function(self, wuxing)
        self.wuxing = wuxing
        self.m_Flags[7] = self.m_Flags[7] | 0x80
    end,
    set_growth_rate = function(self, growth_rate)
        self.growth_rate = growth_rate
        self.m_Flags[8] = self.m_Flags[8] | 0x1
    end,
    set_att_cold = function(self, att_cold)
        self.att_cold = att_cold
        self.m_Flags[9] = self.m_Flags[9] | 0x4
    end,
    set_def_cold = function(self, def_cold)
        self.def_cold = def_cold
        self.m_Flags[9] = self.m_Flags[9] | 0x8
    end,
    set_reduce_def_cold = function(self, reduce_def_cold)
        self.reduce_def_cold = reduce_def_cold
        self.m_Flags[9] = self.m_Flags[9] | 0x10
    end,
    set_att_fire = function(self, att_fire)
        self.att_fire = att_fire
        self.m_Flags[9] = self.m_Flags[9] | 0x20
    end,
    set_def_fire = function(self, def_fire)
        self.def_fire = def_fire
        self.m_Flags[9] = self.m_Flags[9] | 0x40
    end,
    set_reduce_def_fire = function(self, reduce_def_fire)
        self.reduce_def_fire = reduce_def_fire
        self.m_Flags[9] = self.m_Flags[9] | 0x80
    end,
    set_att_light = function(self, att_light)
        self.att_light = att_light
        self.m_Flags[10] = self.m_Flags[10] | 0x1
    end,
    set_def_light = function(self, def_light)
        self.def_light = def_light
        self.m_Flags[10] = self.m_Flags[10] | 0x2
    end,
    set_reduce_def_light = function(self, reduce_def_light)
        self.reduce_def_light = reduce_def_light
        self.m_Flags[10] = self.m_Flags[10] | 0x4
    end,
    set_att_poison = function(self, att_poison)
        self.att_poison = att_poison
        self.m_Flags[10] = self.m_Flags[10] | 0x8
    end,
    set_def_poison = function(self, def_poison)
        self.def_poison = def_poison
        self.m_Flags[10] = self.m_Flags[10] | 0x10
    end,
    set_reduce_def_poison = function(self, reduce_def_poison)
        self.reduce_def_poison = reduce_def_poison
        self.m_Flags[10] = self.m_Flags[10] | 0x20
    end,
    set_used_procreate_count = function(self, used_procreate_count)
        self.used_procreate_count = used_procreate_count
        self.m_Flags[1] = self.m_Flags[1] | 0x40
    end,
    bis = function(self, buffer)
        local stream    = bistream.new()
        stream:attach(buffer)
        self.guid = packet.PetGUID.new()
        self.guid:bis(stream)
        self.m_nTradeIndex = stream:readuint()
        for i = 1, 0xB do
            self.m_Flags[i] = stream:readuchar()
        end
        if self.m_Flags[1] & 0x1 == 0x1 then
            self.m_objID = stream:readuint()
        end
        if self.m_Flags[1] & 0x2 == 0x2 then
            self.data_index = stream:readuint()
        end
        if self.m_Flags[1] & 0x4 == 0x4 then
            self.name_size = stream:readuchar()
            if self.name_size > 0 and self.name_size <= 0x1E then
                self.name = stream:read(self.name_size)
            end
        end
        if self.m_Flags[1] & 0x8 == 0x8 then
            self.ai_type = stream:readuint()
        end
        if self.m_Flags[1] & 0x10 == 0x10 then
            self.spouse_GUID = packet.PetGUID.new()
            self.spouse_GUID:bis(stream)
        end
        if self.m_Flags[1] & 0x20 == 0x20 then
            self.level = stream:readuint()
        end
        if self.m_Flags[1] & 0x40 == 0x40 then
            self.used_procreate_count = stream:readint()
        end
        if self.m_Flags[1] & 0x80 == 0x80 then
            self.exp = stream:readuint()
        end
        if self.m_Flags[2] & 0x1 == 0x1 then
            self.hp = stream:readuint()
        end
        if self.m_Flags[2] & 0x2 == 0x2 then
            self.hp_max = stream:readuint()
        end
        if self.m_Flags[2] & 0x4 == 0x4 then
            self.life_span = stream:readuint()
        end
        if self.m_Flags[2] & 0x8 == 0x8 then
            self.lingxing = stream:readuchar()
        end
        if self.m_Flags[2] & 0x10 == 0x10 then
            self.happiness = stream:readuchar()
        end
        if self.m_Flags[2] & 0x20 == 0x20 then
            self.attrib_att_physics = stream:readuint()
        end
        if self.m_Flags[2] & 0x40 == 0x40 then
            self.attrib_att_magic = stream:readuint()
        end
        if self.m_Flags[2] & 0x80 == 0x80 then
            self.attrib_def_physics = stream:readuint()
        end
        if self.m_Flags[3] & 0x1 == 0x1 then
            self.attrib_def_magic = stream:readuint()
        end
        if self.m_Flags[3] & 0x2 == 0x2 then
            self.attrib_hit = stream:readuint()
        end
        if self.m_Flags[3] & 0x4 == 0x4 then
            self.attrib_miss = stream:readuint()
        end
        if self.m_Flags[3] & 0x8 == 0x8 then
            self.mind_attack = stream:readuint()
        end
        if self.m_Flags[3] & 0x10 == 0x10 then
            self.mind_defend = stream:readuint()
        end
        if self.m_Flags[3] & 0x20 == 0x20 then
            self.attack_type = stream:readushort()
        end
        if self.m_Flags[3] & 0x40 == 0x40 then
            self.unknow_2 = stream:readint()
        end
        if self.m_Flags[3] & 0x80 == 0x80 then
            self.unknow_3 = stream:readuint()
        end
        if self.m_Flags[4] & 0x1 == 0x1 then
            self.str_perception = stream:readuint()
        end
        if self.m_Flags[4] & 0x2 == 0x2 then
            self.con_perception = stream:readuint()
        end
        if self.m_Flags[4] & 0x4 == 0x4 then
            self.dex_perception = stream:readuint()
        end
        if self.m_Flags[4] & 0x8 == 0x8 then
            self.spr_perception = stream:readuint()
        end
        if self.m_Flags[4] & 0x10 == 0x10 then
            self.int_perception = stream:readuint()
        end
        if self.m_Flags[4] & 0x20 == 0x20 then
            self.soul_add_str_perception = stream:readuint()
        end
        if self.m_Flags[4] & 0x40 == 0x40 then
            self.soul_add_con_perception = stream:readuint()
        end
        if self.m_Flags[4] & 0x80 == 0x80 then
            self.soul_add_dex_perception = stream:readuint()
        end
        if self.m_Flags[5] & 0x1 == 0x1 then
            self.soul_add_spr_perception = stream:readuint()
        end
        if self.m_Flags[5] & 0x2 == 0x2 then
            self.soul_add_int_perception = stream:readuint()
        end
        if self.m_Flags[5] & 0x4 == 0x4 then
            self.str = stream:readuint()
        end
        if self.m_Flags[5] & 0x8 == 0x8 then
            self.con = stream:readuint()
        end
        if self.m_Flags[5] & 0x10 == 0x10 then
            self.dex = stream:readuint()
        end
        if self.m_Flags[5] & 0x20 == 0x20 then
            self.spr = stream:readuint()
        end
        if self.m_Flags[5] & 0x40 == 0x40 then
            self.int = stream:readuint()
        end
        if self.m_Flags[5] & 0x80 == 0x80 then
            self.gengu = stream:readuint()
        end
        if self.m_Flags[6] & 0x1 == 0x1 then
            self.point_remain = stream:readuint()
        end
        if self.m_Flags[6] & 0x2 == 0x2 then
            self.unknow_5 = stream:readuchar()
        end
        if self.m_Flags[6] & 0x4 == 0x4 then
            local skill = {}
            skill.id = stream:readint()
            skill.level  = stream:readuchar()
            self.skills.activate[1] = skill
        end
        if self.m_Flags[6] & 0x8 == 0x8 then
            local skill = {}
            skill.id = stream:readint()
            skill.level  = stream:readuchar()
            self.skills.activate[2] = skill
        end
        if self.m_Flags[6] & 0x10 == 0x10 then
            local skill = {}
            skill.id = stream:readint()
            skill.level  = stream:readuchar()
            self.skills.positive[1] = skill
        end
        if self.m_Flags[6] & 0x20 == 0x20 then
            local skill = {}
            skill.id = stream:readint()
            skill.level  = stream:readuchar()
            self.skills.positive[2] = skill
        end
        if self.m_Flags[6] & 0x40 == 0x40 then
            local skill = {}
            skill.id = stream:readint()
            skill.level = stream:readuchar()
            self.skills.positive[3] = skill
        end
        if self.m_Flags[6] & 0x80 == 0x80 then
            local skill = {}
            skill.id = stream:readint()
            skill.level  = stream:readuchar()
            self.skills.positive[4] = skill
        end
        if self.m_Flags[7] & 0x1 == 0x1 then
            local skill = {}
            skill.id = stream:readint()
            skill.level  = stream:readuchar()
            self.skills.positive[5] = skill
        end
        if self.m_Flags[7] & 0x2 == 0x2 then
            local skill = {}
            skill.id = stream:readint()
            skill.level  = stream:readuchar()
            self.skills.positive[6] = skill
        end
        if self.m_Flags[7] & 0x4 == 0x4 then
            local skill = {}
            skill.id = stream:readint()
            skill.level  = stream:readuchar()
            self.skills.positive[7] = skill
        end
        if self.m_Flags[7] & 0x8 == 0x8 then
            local skill = {}
            skill.id = stream:readint()
            skill.level  = stream:readuchar()
            self.skills.positive[8] = skill
        end
        if self.m_Flags[7] & 0x10 == 0x10 then
            local skill = {}
            skill.id = stream:readint()
            skill.level  = stream:readuchar()
            self.skills.positive[9] = skill
        end
        if self.m_Flags[7] & 0x20 == 0x20 then
            local skill = {}
            skill.id = stream:readint()
            skill.level  = stream:readuchar()
            self.skills.positive[10] = skill
        end
        if self.m_Flags[7] & 0x40  == 0x40 then
            local skill = {}
            skill.id = stream:readint()
            skill.level  = stream:readuchar()
            self.skills.positive[11] = skill
        end
        if self.m_Flags[8] & 0x10 == 0x10 then
            self.equip_list[1] = packet.EquipInfo.new()
            self.equip_list[1]:bis(stream)
        end
        if self.m_Flags[8] & 0x20 == 0x20 then
            self.equip_list[2] = packet.EquipInfo.new()
            self.equip_list[2]:bis(stream)
        end
        if self.m_Flags[8] & 0x40 == 0x40 then
            self.equip_list[3] = packet.EquipInfo.new()
            self.equip_list[3]:bis(stream)
        end
        if self.m_Flags[8] & 0x80 == 0x80 then
            self.equip_list[4] = packet.EquipInfo.new()
            self.equip_list[4]:bis(stream)
        end
        if self.m_Flags[9] & 0x1 == 0x1 then
            self.equip_list[5] = packet.EquipInfo.new()
            self.equip_list[5]:bis(stream)
        end
        if self.m_Flags[9] & 0x2== 0x2 then
            self.equip_list[6] = packet.EquipInfo.new()
            self.equip_list[6]:bis(stream)
        end
        self.unknow_6 = stream:readuchar()
        if self.unknow_6 > 0 and self.unknow_6 <= 1024 then
            self.unknow_7 = {}
            for i = 1, self.unknow_6 do
                self.unknow_7[i] = stream:readuchar()
            end
        end
        if self.m_Flags[7] & 0x80 == 0x80 then
            self.wuxing = stream:readuint()
        end
        if self.m_Flags[8] & 0x1 == 0x1 then
            self.growth_rate = stream:readfloat()
        end
        if self.m_Flags[8] & 0x2 == 0x2 then
            self.titles = {} 
            for i = 1, 10 do
                self.titles[i] = stream:readint()
            end
        end
        if self.m_Flags[8] & 0x4 == 0x4 then
            self.current_title = stream:readint()
        end
        if self.m_Flags[8] & 0x8 == 0x8 then
            self.unknow_10 = stream:readuint()
        end
        self.unknow_11 = stream:readushort()
        if self.m_Flags[9] & 0x4 == 0x4 then
            self.att_cold = stream:readuint()
        end
        if self.m_Flags[9] & 0x8 == 0x8 then
            self.def_cold = stream:readuint()
        end
        if self.m_Flags[9] & 0x10 == 0x10 then
            self.reduce_def_cold = stream:readuint()
        end
        if self.m_Flags[9] & 0x20 == 0x20 then
            self.att_fire = stream:readuint()
        end
        if self.m_Flags[9] & 0x40 == 0x40 then
            self.def_fire = stream:readuint()
        end
        if self.m_Flags[9] & 0x80 == 0x80 then
            self.reduce_def_fire = stream:readuint()
        end
        if self.m_Flags[10] & 0x1 == 0x1 then
            self.att_light = stream:readuint()
        end
        if self.m_Flags[10] & 0x2 == 0x2 then
            self.def_light = stream:readuint()
        end
        if self.m_Flags[10] & 0x4 == 0x4 then
            self.reduce_def_light = stream:readuint()
        end
        if self.m_Flags[10] & 0x8 == 0x8 then
            self.att_poison = stream:readuint()
        end
        if self.m_Flags[10] & 0x10 == 0x10 then
            self.def_poison = stream:readuint()
        end
        if self.m_Flags[10] & 0x20 == 0x20 then
            self.reduce_def_poison = stream:readuint()
        end
        if self.m_Flags[10] & 0x40 == 0x40 then
            self.unknow_12 = stream:readuint()
        end
        if self.m_Flags[10] & 0x80 == 0x80 then
            self.unknow_13 = stream:readuchar()
        end
        if self.m_Flags[11] & 0x1 == 0x1 then
            self.unknow_14 = stream:readuint()
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        packet.PetGUID.bos(self.guid, stream)
        stream:writeuint(self.m_nTradeIndex)
        for i = 1, 0xB do
            stream:writeuchar(self.m_Flags[i])
        end
        if self.m_Flags[1] & 0x1 == 0x1 then
            stream:writeuint(self.m_objID)
        end
        if self.m_Flags[1] & 0x2 == 0x2 then
            stream:writeuint(self.data_index)
        end
        if self.m_Flags[1] & 0x4 == 0x4 then
            stream:writeuchar(self.name_size)
            if self.name_size <= 0x1E then
                stream:write(self.name, self.name_size)
            end
        end
        if self.m_Flags[1] & 0x8 == 0x8 then
            stream:writeuint(self.ai_type)
        end
        if self.m_Flags[1] & 0x10 == 0x10 then
            packet.PetGUID.bos(self.spouse_GUID, stream)
        end
        if self.m_Flags[1] & 0x20 == 0x20 then
            stream:writeuint(self.level)
        end
        if self.m_Flags[1] & 0x40 == 0x40 then
            stream:writeint(self.used_procreate_count)
        end
        if self.m_Flags[1] & 0x80 == 0x80 then
            stream:writeuint(self.exp)
        end
        if self.m_Flags[2] & 0x1 == 0x1 then
            stream:writeuint(self.hp)
        end
        if self.m_Flags[2] & 0x2 == 0x2 then
            stream:writeuint(self.hp_max)
        end
        if self.m_Flags[2] & 0x4 == 0x4 then
            stream:writeuint(self.life_span)
        end
        if self.m_Flags[2] & 0x8 == 0x8 then
            stream:writeuchar(self.lingxing)
        end
        if self.m_Flags[2] & 0x10 == 0x10 then
            stream:writeuchar(self.happiness)
        end
        if self.m_Flags[2] & 0x20 == 0x20 then
            stream:writeuint(self.attrib_att_physics)
        end
        if self.m_Flags[2] & 0x40 == 0x40 then
            stream:writeuint(self.attrib_att_magic)
        end
        if self.m_Flags[2] & 0x80 == 0x80 then
            stream:writeuint(self.attrib_def_physics)
        end
        if self.m_Flags[3] & 0x1 == 0x1 then
            stream:writeuint(self.attrib_def_magic)
        end
        if self.m_Flags[3] & 0x2 == 0x2 then
            stream:writeuint(self.attrib_hit)
        end
        if self.m_Flags[3] & 0x4 == 0x4 then
            stream:writeuint(self.attrib_miss)
        end
        if self.m_Flags[3] & 0x8 == 0x8 then
            stream:writeuint(self.mind_attack)
        end
        if self.m_Flags[3] & 0x10 == 0x10 then
            stream:writeuint(self.mind_defend)
        end
        if self.m_Flags[3] & 0x20 == 0x20 then
            stream:writeushort(self.attack_type)
        end
        if self.m_Flags[3] & 0x40 == 0x40 then
            stream:writeint(self.unknow_2)
        end
        if self.m_Flags[3] & 0x80 == 0x80 then
            stream:writeuint(self.unknow_3)
        end
        if self.m_Flags[4] & 0x1 == 0x1 then
            stream:writeuint(self.str_perception)
        end
        if self.m_Flags[4] & 0x2 == 0x2 then
            stream:writeuint(self.con_perception)
        end
        if self.m_Flags[4] & 0x4 == 0x4 then
            stream:writeuint(self.dex_perception)
        end
        if self.m_Flags[4] & 0x8 == 0x8 then
            stream:writeuint(self.spr_perception)
        end
        if self.m_Flags[4] & 0x10 == 0x10 then
            stream:writeuint(self.int_perception)
        end
        if self.m_Flags[4] & 0x20 == 0x20 then
            stream:writeuint(self.soul_add_str_perception)
        end
        if self.m_Flags[4] & 0x40 == 0x40 then
            stream:writeuint(self.soul_add_con_perception)
        end
        if self.m_Flags[4] & 0x80 == 0x80 then
            stream:writeuint(self.soul_add_dex_perception)
        end
        if self.m_Flags[5] & 0x1 == 0x1 then
            stream:writeuint(self.soul_add_spr_perception)
        end
        if self.m_Flags[5] & 0x2 == 0x2 then
            stream:writeuint(self.soul_add_int_perception)
        end
        if self.m_Flags[5] & 0x4 == 0x4 then
            stream:writeuint(self.str)
        end
        if self.m_Flags[5] & 0x8 == 0x8 then
            stream:writeuint(self.con)
        end
        if self.m_Flags[5] & 0x10 == 0x10 then
            stream:writeuint(self.dex)
        end
        if self.m_Flags[5] & 0x20 == 0x20 then
            stream:writeuint(self.spr)
        end
        if self.m_Flags[5] & 0x40 == 0x40 then
            stream:writeuint(self.int)
        end
        if self.m_Flags[5] & 0x80 == 0x80 then
            stream:writeuint(self.gengu)
        end
        if self.m_Flags[6] & 0x1 == 0x1 then
            stream:writeuint(self.point_remain)
        end
        if self.m_Flags[6] & 0x2 == 0x2 then
            stream:writeuchar(self.unknow_5)
        end
        if self.m_Flags[6] & 0x4 == 0x4 then
            local skill = self.skills.activate[1]
            stream:writeint(skill.id)
            stream:writeuchar(skill.level)
        end
        if self.m_Flags[6] & 0x8 == 0x8 then
            local skill = self.skills.activate[2]
            stream:writeint(skill.id)
            stream:writeuchar(skill.level)
        end
        if self.m_Flags[6] & 0x10 == 0x10 then
            local skill = self.skills.positive[1]
            stream:writeint(skill.id)
            stream:writeuchar(skill.level)
        end
        if self.m_Flags[6] & 0x20 == 0x20 then
            local skill = self.skills.positive[2]
            stream:writeint(skill.id)
            stream:writeuchar(skill.level)
        end
        if self.m_Flags[6] & 0x40 == 0x40 then
            local skill = self.skills.positive[3]
            stream:writeint(skill.id)
            stream:writeuchar(skill.level)
        end
        if self.m_Flags[6] & 0x80 == 0x80 then
            local skill = self.skills.positive[4]
            stream:writeint(skill.id)
            stream:writeuchar(skill.level)
        end
        if self.m_Flags[7] & 0x1 == 0x1 then
            local skill = self.skills.positive[5]
            stream:writeint(skill.id)
            stream:writeuchar(skill.level)
        end
        if self.m_Flags[7] & 0x2 == 0x2 then
            local skill = self.skills.positive[6]
            stream:writeint(skill.id)
            stream:writeuchar(skill.level)
        end
        if self.m_Flags[7] & 0x4 == 0x4 then
            local skill = self.skills.positive[7]
            stream:writeint(skill.id)
            stream:writeuchar(skill.level)
        end
        if self.m_Flags[7] & 0x8 == 0x8 then
            local skill = self.skills.positive[8]
            stream:writeint(skill.id)
            stream:writeuchar(skill.level)
        end
        if self.m_Flags[7] & 0x10 == 0x10 then
            local skill = self.skills.positive[9]
            stream:writeint(skill.id)
            stream:writeuchar(skill.level)
        end
        if self.m_Flags[7] & 0x20 == 0x20 then
            local skill = self.skills.positive[10]
            stream:writeint(skill.id)
            stream:writeuchar(skill.level)
        end
        if self.m_Flags[7] & 0x40  == 0x40 then
            local skill = self.skills.positive[11]
            stream:writeint(skill.id)
            stream:writeuchar(skill.level)
        end
        if self.m_Flags[8] & 0x10 == 0x10 then
            local equip = self.equip_list[1]
            packet.EquipInfo.bos(equip, stream)
        end
        if self.m_Flags[8] & 0x20 == 0x20 then
            local equip = self.equip_list[2]
            packet.EquipInfo.bos(equip, stream)
        end
        if self.m_Flags[8] & 0x40 == 0x40 then
            local equip = self.equip_list[3]
            packet.EquipInfo.bos(equip, stream)
        end
        if self.m_Flags[8] & 0x80 == 0x80 then
            local equip = self.equip_list[4]
            packet.EquipInfo.bos(equip, stream)
        end
        if self.m_Flags[9] & 0x1 == 0x1 then
            local equip = self.equip_list[5]
            packet.EquipInfo.bos(equip, stream)
        end
        if self.m_Flags[9] & 0x2 == 0x2 then
            local equip = self.equip_list[6]
            packet.EquipInfo.bos(equip, stream)
        end
        if self.extra_data then
            if self.extra_data.flag == self.TYPE.TYPE_STALL then
                local bin = packet.GCStallPetView_t.bos(self.extra_data, stream)
                local len = string.len(bin)
                stream:writeuchar(len)
                stream:write(bin, len)
            elseif self.extra_data.flag == self.TYPE.TYPE_EXCHANGE then
                local bin = packet.GCExchangePetView_t.bos(self.extra_data, stream)
                local len = string.len(bin)
                stream:writeuchar(len)
                stream:write(bin, len)
            end
        else
            self.unknow_6 = self.unknow_6 or 0
            stream:writeuchar(self.unknow_6)
            if self.unknow_6 > 0 and self.unknow_6 <= 1024 then
                for i = 1, self.unknow_6 do
                    stream:writeuchar(self.unknow_7[i])
                end
            end
        end
        if self.m_Flags[7] & 0x80 == 0x80 then
            stream:writeuint(self.wuxing)
        end
        if self.m_Flags[8] & 0x1 == 0x1 then
            stream:writefloat(self.growth_rate)
        end
        if self.m_Flags[8] & 0x2 == 0x2 then
            self.titles = self.titles or {}
            for i = 1, 10 do
                stream:writeint(self.titles[i] or define.INVAILD_ID)
            end
        end
        if self.m_Flags[8] & 0x4 == 0x4 then
            stream:writeint(self.current_title or define.INVAILD_ID)
        end
        if self.m_Flags[8] & 0x8 == 0x8 then
            stream:writeuint(self.unknow_10)
        end
        stream:writeushort(self.unknow_11)
        if self.m_Flags[9] & 0x4 == 0x4 then
            stream:writeuint(self.att_cold)
        end
        if self.m_Flags[9] & 0x8 == 0x8 then
            stream:writeuint(self.def_cold)
        end
        if self.m_Flags[9] & 0x10 == 0x10 then
            stream:writeuint(self.reduce_def_cold)
        end
        if self.m_Flags[9] & 0x20 == 0x20 then
            stream:writeuint(self.att_fire)
        end
        if self.m_Flags[9] & 0x40 == 0x40 then
            stream:writeuint(self.def_fire)
        end
        if self.m_Flags[9] & 0x80 == 0x80 then
            stream:writeuint(self.reduce_def_fire)
        end
        if self.m_Flags[10] & 0x1 == 0x1 then
            stream:writeuint(self.att_light)
        end
        if self.m_Flags[10] & 0x2 == 0x2 then
            stream:writeuint(self.def_light)
        end
        if self.m_Flags[10] & 0x4 == 0x4 then
            stream:writeuint(self.reduce_def_light)
        end
        if self.m_Flags[10] & 0x8 == 0x8 then
            stream:writeuint(self.att_poison)
        end
        if self.m_Flags[10] & 0x10 == 0x10 then
            stream:writeuint(self.def_poison)
        end
        if self.m_Flags[10] & 0x20 == 0x20 then
            stream:writeuint(self.reduce_def_poison)
        end
        if self.m_Flags[10] & 0x40 == 0x40 then
            stream:writeuint(self.main_perception)
        end
        if self.m_Flags[10] & 0x80 == 0x80 then
            stream:writeuchar(self.unknow_13)
        end
        if self.m_Flags[11] & 0x1 == 0x1 then
            stream:writeuint(self.unknow_14)
        end
        return stream:get()
    end
}

--[[
    b7 4e 00 00
    c3 ef e6 0e
    1a d4 17 43 54 de 16 43
    62 bb 18 40
    00 00 80 40
    07 08 00 00
    00 00 00 00
    90 01 00 00
    00
    01
    00 00 23 43 00 00 0b 43
]]
packet.GCNewPlayer_Move = {
    xy_id = packet.XYID_GC_NEW_PLAYER_MOVE,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCNewPlayer_Move})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_objID = 0
        self.m_posWorld = {x = 0.0, y = 0.0}
        self.dir = 0
        self.speed = 0
        self.m_wEquipVer = 0
        self.unknow_4 = 0
        self.unknow_6 = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID        = stream:readuint()
        self.guid           = stream:readuint()
        self.m_posWorld.x   = stream:readfloat()
        self.m_posWorld.y   = stream:readfloat()
        self.dir            = stream:readfloat()
        self.speed          = stream:readfloat()
        self.m_wEquipVer    = stream:readuint()
        self.unknow_4       = stream:readuint()
        self.handle         = stream:readuint()
        self.unknow_6       = stream:readuchar()
        self.posTargetSize  = stream:readuchar()
        if self.posTargetSize <= 0x10 then
            for i = 1, self.posTargetSize do
                local pos = {}
                pos.x = stream:readfloat()
                pos.y = stream:readfloat()
                table.insert(self.path, pos)
            end
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        stream:writeuint(self.guid)
        stream:writefloat(self.m_posWorld.x)
        stream:writefloat(self.m_posWorld.y)
        stream:writefloat(self.dir)
        stream:writefloat(self.speed)
        stream:writeuint(self.m_wEquipVer)
        stream:writeuint(self.unknow_4)
        stream:writeuint(self.handle)
        stream:writeuchar(self.unknow_6)
        stream:writeuchar(#self.path)
        for i = 1, #self.path do
            local pos = self.path[i]
            stream:writefloat(pos.x)
            stream:writefloat(pos.y)
        end
        return stream:get()
    end
}

packet.GCDelObject = {
    xy_id = packet.XYID_GC_DEL_OBJECT,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCDelObject})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_objID = 0
        self.m_idScene = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.m_idScene = stream:readushort()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        stream:writeushort(self.m_idScene)
        return stream:get()
    end
}

packet.CGAskDoubleExp = {
    xy_id = packet.XYID_CG_ASK_DOUBLE_EXP,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGAskDoubleExp})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        return stream:get()
    end
}

packet.CGAskJuqingPoint = {
    xy_id = packet.XYID_CG_ASK_JVQING_POINT,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGAskJuqingPoint})
        o:ctor()
        return o
    end,
    ctor = function(self) self.unknow = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.unknow)
        return stream:get()
    end
}

packet.CGAskDetailAttrib = {
    xy_id = packet.XYID_CG_ASK_DETAIL_ATTRIB,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGAskDetailAttrib})
        o:ctor()
        return o
    end,
    ctor = function(self) self.m_objID = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        return stream:get()
    end
}

packet.CGAskDetailXinFaList = {
    xy_id = packet.XYID_CG_ASK_DETAIL_XINFA_LIST,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGAskDetailXinFaList})
        o:ctor()
        return o
    end,
    ctor = function(self) self.m_objID = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        return stream:get()
    end
}

packet.CGAskTeamInfo = {
    xy_id = packet.XYID_CG_ASK_TEAM_INFO,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGAskTeamInfo})
        o:ctor()
        return o
    end,
    ctor = function(self) self.m_objID = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        return stream:get()
    end
}

packet.GCCheDiFuLuData = {
    xy_id = packet.XYID_GC_CHEDIFULU_DATA,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCCheDiFuLuData})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = 0
        self.size = 0
        self.list = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readuchar()
        self.size = stream:readuchar()
        if self.size > 0 then
            for i = 1, self.size do
                if i < 30 then
                    local l = {}
                    l.index = stream:readuint()
                    l.sceneid = stream:readuint()
                    l.x = stream:readuint()
                    l.y = stream:readuint()
                    table.insert(self.list, l)
                end
            end
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.unknow_1)
        stream:writeuchar(self.size)
        if self.size > 0 then
            for i = 1, self.size do
                local l = self.list[i] or
                              {
                        index = 0,
                        sceneid = 0,
                        x = 0,
                        y = 0
                    }
                stream:writeuint(l.index)
                stream:writeuint(l.sceneid)
                stream:writeuint(l.x)
                stream:writeuint(l.y)
            end
        end
        return stream:get()
    end
}

packet.CGMACNotify = {
    xy_id = packet.XYID_CG_MAC_NOTIFY,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGMACNotify})
        o:ctor()
        return o
    end,
    ctor = function(self) self.mac = {} end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        for i = 1, 8 do self.mac[i] = stream:readuchar() end
    end,
    bos = function(self)
        local stream = bostream.new()
        for i = 1, 8 do stream:writeuchar(self.mac[i] or 0) end
        return stream:get()
    end
}

packet.CGAskDiGongShopInfo = {
    xy_id = packet.XYID_CG_ASK_DIGONG_SHOP_INFO,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGAskDiGongShopInfo})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        return stream:get()
    end
}

packet.CGExteriorRequest = {
    xy_id = packet.XYID_CG_EXTERIOR_REQUEST,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGExteriorRequest})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.type = 0
        self.flag = 0
        self.size = 0
        self.list = {}
        self.unknow_2 = 0
        self.unknow_3 = 0
        self.unknow_4 = 0
        self.unknow_5 = 0

        self.unknow_6 = 0
        self.unknow_7 = 0

        self.unknow_8 = 0
        self.unknow_9 = 0
        self.unknow_10 = 0

        self.unknow_11 = 0
		
		self.OrnamentsBackExteriorId = 0
		self.OrnamentsHeadExteriorId = 0
		self.OrnamentsBackPos = 0
		self.OrnamentsHeadPos = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.type = stream:readuint()
        self.flag = stream:readuint()
        if self.type == 0 then
            self.unknow_11 = stream:readuchar()
        else
            if self.type == 7 then
                self.size = stream:readuint()
                if self.size > 0 then
                    self.list = {}
                    for i = 1, self.size do
                        local l = {}
                        l.unknow_1 = stream:readuint()
                        l.unknow_2 = stream:readushort()
                        l.unknow_3 = stream:readuint()
                        table.insert(self.list, l)
                    end
                end
                self.unknow_2 = stream:readuchar()
                self.unknow_3 = stream:readuint()	--m_WeaponChanged
                self.unknow_4 = stream:readushort()	--m_SaveWeaponId
                self.unknow_5 = stream:readuchar()	--m_SaveWeaponLv
				
				self.OrnamentsBackExteriorId = stream:readushort()
				self.OrnamentsHeadExteriorId = stream:readushort()
				self.OrnamentsBackPos = stream:readuint()
				self.OrnamentsHeadPos = stream:readuint()
            elseif self.type == 10 then
                self.unknow_6 = stream:readushort()
                self.unknow_7 = stream:readuchar()
            else
                self.unknow_8 = stream:readuint()
                self.unknow_9 = stream:readuint()
                self.unknow_10 = stream:readuint()
            end
        end
    end,
    bos = function(self)
    end
}

packet.CGAskFashionDepotData = {
    xy_id = packet.XYID_CG_ASK_FASHION_DEPOT_DATA,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGAskFashionDepotData})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = 0
        self.unknow_2 = 0
        self.unknow_3 = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readuchar()
        self.unknow_2 = stream:readuint()
        self.unknow_3 = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.unknow_1)
        stream:writeuint(self.unknow_2)
        stream:writeuint(self.unknow_3)
        return stream:get()
    end
}

packet.CGAskMyBagList = {
    xy_id = packet.XYID_CG_ASK_MY_BAG_LIST,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGAskMyBagList})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = 0
        self.size = 0
        self.list = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readuint()
        self.size = stream:readuchar()
        if self.size > 0xf0 then self.size = 0xf0 end
        for i = 1, self.size do self.list[i] = stream:readuchar() end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.unknow_1)
        stream:writeuchar(self.size)
        for i = 1, self.size do stream:writeuchar(self.list[i]) end
        return stream:get()
    end
}

packet.CGRelation = {
    xy_id = packet.XYID_CG_RELATION,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGRelation})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.type = 0
        self.request_relation_info = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.type = stream:readuchar()
        if self.type == 2 then
            self.request_relation_info.guid = stream:readint()
            local len = stream:readuchar()
            if len > 0 and len < 0x1E then
                self.request_relation_info.name = stream:read(len)
                self.request_relation_info.name = gbk.toutf8(self.request_relation_info.name)
            end
            self.request_relation_info.unknow_1 = stream:readshort()
        elseif self.type == 3 or self.type == 0xf then
                local len = stream:readuchar()
                if len > 0 and len < 0x1E then
                    self.request_relation_info.name = stream:read(len)
                    self.request_relation_info.name = gbk.toutf8(self.request_relation_info.name)
                end
                self.request_relation_info.unknow_1 = stream:readshort()
        elseif self.type == 4 or self.type == 6 or self.type == 0x18 then
            self.request_relation_info.guid = stream:readint()
            self.request_relation_info.unknow_2 = stream:readshort()
            local len = stream:readuchar()
            if len > 0 and len < 0x1E then
                self.request_relation_info.name = stream:read(len)
                self.request_relation_info.name = gbk.toutf8(self.request_relation_info.name)
            end
            self.request_relation_info.relation_type = stream:readchar()
            self.request_relation_info.group = stream:readchar()
        elseif self.type == 5 or self.type == 7 then
            self.request_relation_info.guid = stream:readint()
            self.request_relation_info.unknow_5 = stream:readshort()
            local len = stream:readuchar()
            if len > 0 and len < 0x1E then
                self.request_relation_info.name = stream:read(len)
            end
            self.request_relation_info.unknow_6 = stream:readchar()
        elseif self.type == 8 then
            self.request_relation_info.guid = stream:readint()
            self.request_relation_info.from = stream:readchar()
            self.request_relation_info.to = stream:readchar()
        elseif self.type == 9 or self.type == 0xA or self.type == 0x17 or self.type == 0x19 or self.type == 0x1A then
            self.request_relation_info.guid = stream:readint()
        elseif self.type == 0xd then
            local len = stream:readuchar()
            if len > 0 and len < 0x20 then
                self.request_relation_info.mood = stream:read(len)
                self.request_relation_info.mood = gbk.toutf8(self.request_relation_info.mood)
            end
        elseif self.type == 0x1d then
            local len = stream:readuchar()
            if len > 0 and len < 0x14 then
                self.request_relation_info.unknow_10 = stream:read(len)
            end
        elseif self.type == 0x1e then
            local len = stream:readuchar()
            if len > 0 and len < 0x1e then
                self.request_relation_info.unknow_11 = stream:read(len)
            end 
        end
    end
}

packet.GCRelation = {
    xy_id = packet.XYID_GC_RELATION,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCRelation})
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    read_relation_list = function(self, stream)
        self.relation_list = {}
        self.relation_list.s1 = stream:readuchar()
        self.relation_list.s2 = stream:readuchar()
        self.relation_list.s3 = stream:readuchar()
        self.relation_list.s4 = stream:readuchar()
        local mlen = stream:readuchar()
        if mlen > 0 and mlen < 0x20 then
            self.relation_list.mood = stream:read(mlen)
        end
        self.relation_list.unknow_1 = stream:readuchar()
        if self.relation_list.s1 <= 0x50 and self.relation_list.s2 <= 0xA and self.relation_list.s3 <= 0xA and self.relation_list.s4 <= 0xA then
            self.relation_list.l1 = {}
            for i = 1, self.relation_list.s1 do
                local r = {}
                r.guid = stream:readint()
                local nlen = stream:readuchar()
                if nlen > 0 and nlen < 0x1E then
                    r.name = stream:read(nlen)
                end
                mlen = stream:readuchar()
                if mlen > 0 and mlen < 0x1E then
                    r.mood = stream:read(mlen)
                end
                r.relation_type = stream:readuchar()
                r.group = stream:readuchar()
                r.friend_point = stream:readuint()
                r.unknow = stream:readuint()
                r.unknow_1 = stream:readuint()
                r.unknow_2 = stream:readuint()
                self.relation_list.l1[i] = r
            end
            self.relation_list.l2 = {}
            for i = 1, self.relation_list.s2 do
                local r = {}
                r.guid = stream:readint()
                local nlen = stream:readuchar()
                if nlen > 0 and nlen < 0x1E then
                    r.name = stream:read(nlen)
                end
                mlen = stream:readuchar()
                if mlen > 0 and mlen < 0x1E then
                    r.mood = stream:read(mlen)
                end
                r.unknow_1 = stream:readuint()
                self.relation_list.l2[i] = r
            end
            self.relation_list.l3 = {}
            for i = 1, self.relation_list.s3 do
                local r = {}
                r.guid = stream:readint()
                local nlen = stream:readuchar()
                if nlen > 0 and nlen < 0x1C then
                    r.name = stream:read(nlen)
                end
                mlen = stream:readuchar()
                if mlen > 0 and mlen < 0x1C then
                    r.mood = stream:read(mlen)
                end
                r.unknow_1 = stream:readuint()
                self.relation_list.l3[i] = r
            end
            self.relation_list.l4 = {}
            for i = 1, self.relation_list.s4 do
                local r = {}
                r.guid = stream:readint()
                local nlen = stream:readuchar()
                if nlen > 0 and nlen < 0x1E then
                    r.name = stream:read(nlen)
                end
                r.unknow_1 = stream:readint()
                r.unknow_2 = stream:readchar()
                self.relation_list.l3[i] = r
            end
        end
    end,
    read_relation_info = function(self, stream)
        self.relation_info = {}
        self.relation_info.relation_type = stream:readuchar()
        if self.relation_info.relation_type ~= 4 and self.relation_info.relation_type ~= 5 then
            self.relation_info.group = stream:readuchar()
            self.relation_info.friend_point = stream:readuint()
        end
        self.relation_info.relation = {}
        self.relation_info.relation.guid = stream:readint()
        local nlen = stream:readuchar()
        if nlen > 0 and nlen < 0x1E then
            self.relation_info.name = stream:read(nlen)
        end
        self.relation_info.level = stream:readuint()
        self.relation_info.menpai = stream:readuint()
        self.relation_info.portrait = stream:readuint()
        self.relation_info.guild = stream:readshort()
        local glen = stream:readuchar()
        if glen > 0 and glen < 0x18 then
            self.relation_info.guild_name = stream:read(glen)
        end
        self.relation_info.confederate = stream:readshort()
        local clen = stream:readuchar()
        if clen > 0 and clen < 0x20 then
            self.relation_info.confederate_name = stream:read(clen)
        end
        self.relation_info.online_flag = stream:readbool()
        if self.relation_info.online_flag then
            local mlen = stream:readuchar()
            if mlen > 0 and mlen < 0x20 then
                self.relation_info.mood = stream:read(mlen)
            end
            local tlen = stream:readuchar()
            if tlen > 0 and tlen < 0x22 then
                self.relation_info.title = stream:read(tlen)
            end
            self.relation_info.sceneid = stream:readushort()
            self.relation_info.team_size = stream:readuchar()
            self.relation_info.unknow_3 = stream:readint()
        end
    end,
    read_view_player = function(self, stream)
        self.view_player = {}
        self.view_player.guid = stream:readint()
        local nlen = stream:readuchar()
        if nlen > 0 and nlen < 0x1E then
            self.view_player.name = stream:read(nlen)
        end
    end,
    read_add_relation = function(self, stream)
        self.relation_info = {}
        self.relation_info.relation_type = stream:readuchar()
        self.relation_info.group = stream:readuchar()
        self.relation_info.guid = stream:readint()
        local nlen = stream:readuchar()
        if nlen > 0 and nlen < 0x1E then
            self.relation_info.name = stream:read(nlen)
        end
        self.relation_info.level = stream:readuint()
        self.relation_info.menpai = stream:readuint()
        self.relation_info.portrait = stream:readuint()
        self.relation_info.guild = stream:readshort()
        local glen = stream:readuchar()
        if glen > 0 and glen < 0x18 then
            self.relation_info.guild_name = stream:read(glen)
        end
        self.relation_info.unknow_1 = stream:readshort()
        local mlen = stream:readuchar()
        if mlen > 0 and mlen < 0x20 then
            self.relation_info.unknow_2 = stream:read(mlen)
        end
        self.relation_info.online_flag = stream:readuchar()
        if self.relation_info.online_flag then
            mlen = stream:readuchar()
            if mlen > 0 and mlen < 0x20 then
                self.relation_info.mood = stream:read(mlen)
            end
            local tlen = stream:readuchar()
            if tlen > 0 and tlen < 0x22 then
                self.relation_info.title = stream:read(tlen)
            end
            self.relation_info.sceneid = stream:readushort()
            self.relation_info.team_size = stream:readuchar()
            self.relation_info.unknow_2 = stream:readint()
        end
    end,
    read_relation_guid_uchar_uchar = function(self, stream)
        self.relation_guid_uchar_uchar = {}
        self.relation_guid_uchar_uchar.guid = stream:readint()
        self.relation_guid_uchar_uchar.relation_type = stream:readuchar()
        self.relation_guid_uchar_uchar.group = stream:readuchar()
    end,
    read_online_friends = function(self, stream)
        self.online_friends = {}
        self.online_friends.count = stream:readuchar()
        if self.online_friends.count > 0 and self.online_friends.count <= 0x50 then
            for i = 1, self.online_friends.count do
                local of = {}
                of.guid = stream:readint()
                local mlen = stream:readuchar()
                if mlen > 0 and mlen < 0x20 then
                    of.mood = stream:read(mlen)
                end
                of.unknow_1 = stream:readint()
                self.online_friends.list[i] = of
            end
        end
    end,
    read_relation_online = function(self, stream)
        self.relation_online = {}
        self.relation_online.guid = stream:readint()
        local nlen = stream:readuchar()
        if nlen > 0 and nlen < 0x1E then
            self.relation_online.name = bis:read(nlen)
            self.relation_online.name = gbk.toutf8(self.relation_online.name)
        end
        local mlen = stream:readuchar()
        if mlen > 0 and mlen < 0x20 then
            self.relation_online.mood = bis:read(nlen)
            self.relation_online.mood = gbk.toutf8(self.relation_online.mood)
        end
        self.unknow_1 = stream:readuint()
    end,
    read_relation_offline = function(self, stream)
        self.relation_offline = {}
        self.relation_offline.guid = stream:readint()
        local nlen = stream:readuchar()
        if nlen > 0 and nlen < 0x1E then
            self.relation_offline.name = stream:read(nlen)
        end
        local mlen = stream:readuchar()
        if mlen > 0 and mlen < 0x1E then
            self.relation_offline.mood = stream:read(mlen)
        end
        self.relation_offline.unknow_1 = stream:readint()
    end,
    write_relation_list = function(self, stream)
        stream:writeuchar(#self.relation_list.friends)
        stream:writeuchar(#self.relation_list.black)
        stream:writeuchar(#self.relation_list.enemies)
        stream:writeuchar(#self.relation_list.temp)
        self.relation_list.mood = gbk.fromutf8(self.relation_list.mood)
        local mlen = #self.relation_list.mood
        stream:writeuchar(mlen)
        if mlen > 0 and mlen < 0x1E then
            stream:write(self.relation_list.mood, mlen)
        end
        stream:writeuchar(self.relation_list.unknow_1 or 0)
        if #self.relation_list.friends <= 0x50 and #self.relation_list.black<= 0xA and #self.relation_list.enemies <= 0xA and #self.relation_list.temp <= 0xA then
            for i = 1, #self.relation_list.friends do
                local r = self.relation_list.friends[i]
                stream:writeint(r.guid)
                r.name = gbk.fromutf8(r.name)
                stream:writeuchar(#r.name)
                if #r.name > 0 and #r.name < 0x1C then
                    stream:write(r.name, #r.name)
                end
                r.mood = gbk.fromutf8(r.mood)
                stream:writeuchar(#r.mood)
                if #r.mood > 0 and #r.mood < 0x1C then
                    stream:write(r.mood, #r.mood)
                end
                stream:writeuchar(r.relation_type)
                stream:writeuchar(r.group)
                stream:writeuint(r.friend_point)
                stream:writeuint(r.unknow or 0)
                stream:writeuint(r.unknow_1 or 0)
                stream:writeuint(r.portrait or 0)
            end
            for i = 1, #self.relation_list.black do
                local r = self.relation_list.black[i]
                stream:writeint(r.guid)
                r.name = gbk.fromutf8(r.name)
                stream:writeuchar(#r.name)
                if #r.name > 0 and #r.name < 0x1C then
                    stream:write(r.name, #r.name)
                end
                r.mood = gbk.fromutf8(r.mood)
                stream:writeuchar(#r.mood)
                if #r.mood > 0 and #r.mood < 0x1C then
                    stream:write(r.mood, #r.mood)
                end
                stream:writeuint(r.unknow_1 or 0)
            end
            for i = 1, #self.relation_list.enemies do
                local r = self.relation_list.enemies[i]
                stream:writeint(r.guid)
                r.name = gbk.fromutf8(r.name)
                stream:writeuchar(#r.name)
                if #r.name > 0 and #r.name < 0x1C then
                    stream:write(r.name, #r.name)
                end
                r.mood = gbk.fromutf8(r.mood)
                stream:writeuchar(#r.mood)
                if #r.mood > 0 and #r.mood < 0x1C then
                    stream:write(r.mood, #r.mood)
                end
                stream:writeuint(r.unknow_1 or 0)
            end
            for i = 1, #self.relation_list.temp do
                local r = self.relation_list.temp[i]
                stream:writeint(r.guid)
                r.name = gbk.fromutf8(r.name)
                stream:writeuchar(#r.name)
                if #r.name > 0 and #r.name < 0x1E then
                    stream:write(r.name, #r.name)
                end
                stream:writeint(r.unknow_1 or 0)
                stream:writechar(r.unknow_2 or 0)
            end
        end
        for i = 1, 3 do
            stream:writeint(define.INVAILD_ID)
            stream:writeint(0)
        end
        stream:writeint(define.INVAILD_ID)
    end,
    write_relation_info = function(self, stream)
        stream:writeuchar(self.relation_info.relation_type)
        if self.relation_info.relation_type < 4 or self.relation_info.relation_type > 5 then
            stream:writeuchar(self.relation_info.group)
            stream:writeuint(self.relation_info.friend_point)
        end
        stream:writeint(self.relation_info.relation.guid)
        self.relation_info.relation.name = gbk.fromutf8(self.relation_info.relation.name)
        stream:writeuchar(#self.relation_info.relation.name)
        if #self.relation_info.relation.name > 0 and #self.relation_info.relation.name < 0x1E then
            stream:write(self.relation_info.relation.name, #self.relation_info.relation.name)
        end
        stream:writeuint(self.relation_info.relation.level)
        stream:writeuint(self.relation_info.relation.menpai)
        stream:writeuint(self.relation_info.relation.portrait)
        stream:writeshort(self.relation_info.relation.guild)
        self.relation_info.relation.guild_name = gbk.fromutf8(self.relation_info.relation.guild_name)
        stream:writeuchar(#self.relation_info.relation.guild_name)
        if #self.relation_info.relation.guild_name > 0 and #self.relation_info.relation.guild_name < 0x18 then
            stream:write(self.relation_info.relation.guild_name , #self.relation_info.relation.guild_name)
        end
        stream:writeshort(self.relation_info.relation.confederate)
        stream:writeuchar(#self.relation_info.relation.confederate_name)
        if #self.relation_info.relation.confederate_name > 0 and #self.relation_info.relation.confederate_name < 0x20 then
            stream:write(self.relation_info.relation.confederate_name, #self.relation_info.relation.confederate_name)
        end
        stream:writebool(self.relation_info.relation.online_flag)
        stream:writeuint(0)
        if self.relation_info.relation.online_flag then
            self.relation_info.relation.mood = gbk.fromutf8(self.relation_info.relation.mood)
            stream:writeuchar(#self.relation_info.relation.mood)
            if #self.relation_info.relation.mood > 0 and #self.relation_info.relation.mood< 0x20 then
                stream:write(self.relation_info.relation.mood, #self.relation_info.relation.mood)
            end
            stream:writeuchar(#self.relation_info.relation.title)
            if #self.relation_info.relation.title > 0 and #self.relation_info.relation.title < 0x22 then
                stream:write(self.relation_info.relation.title, #self.relation_info.relation.title)
            end
            stream:writeushort(self.relation_info.relation.sceneid )
            stream:writeuchar(self.relation_info.relation.team_size)
            stream:writeint(self.relation_info.relation.unknow_3 or 0)	--这里是角色的sex
			--fix 20250317
			stream:writeshort(-1)	--很有可能是目前所在场景的归属服务器ID，默认值为-1
        end
    end,
    write_view_player = function(self, stream)
        stream:writeint(self.view_player.guid)
        stream:writeuchar(#self.view_player.name)
        if #self.view_player.name > 0 and #self.view_player.name < 0x1E then
            stream:write(self.view_player.name, #self.view_player.name)
        end
    end,
    write_add_relation = function(self, stream)
        stream:writeuchar(self.relation_info.relation_type)
        stream:writeuchar(self.relation_info.group)
        stream:writeint(self.relation_info.guid)
        self.relation_info.name = gbk.fromutf8(self.relation_info.name)
        stream:writeuchar(#self.relation_info.name)
        if #self.relation_info.name > 0 and #self.relation_info.name < 0x1E then
            stream:write(self.relation_info.name, #self.relation_info.name)
        end
        stream:writeint(self.relation_info.level)
        stream:writeuint(self.relation_info.menpai)
        stream:writeuint(self.relation_info.portrait)
        stream:writeshort(self.relation_info.guild)
        self.relation_info.guild_name = gbk.fromutf8(self.relation_info.guild_name)
        stream:writeuchar(#self.relation_info.guild_name)
        if #self.relation_info.guild_name > 0 and #self.relation_info.guild_name < 0x18 then
            stream:write(self.relation_info.guild_name, #self.relation_info.guild_name)
        end
        stream:writeshort(self.relation_info.confederate)
        self.relation_info.confederate_name = gbk.fromutf8(self.relation_info.confederate_name)
        stream:writeuchar(#self.relation_info.confederate_name)
        if #self.relation_info.confederate_name > 0 and #self.relation_info.confederate_name < 0x20 then
            stream:write(self.relation_info.confederate_name, #self.relation_info.confederate_name)
        end
        stream:writebool(self.relation_info.online_flag)
        stream:writeuint(0)
        if self.relation_info.online_flag then
            self.relation_info.mood = gbk.fromutf8(self.relation_info.mood)
            stream:writeuchar(#self.relation_info.mood)
            if #self.relation_info.mood > 0 and #self.relation_info.mood < 0x20 then
                stream:write(self.relation_info.mood, #self.relation_info.mood)
            end
            self.relation_info.title = gbk.fromutf8(self.relation_info.title)
            stream:writeuchar(#self.relation_info.title)
            if #self.relation_info.title > 0 and #self.relation_info.title < 0x22 then
                stream:write(self.relation_info.title, #self.relation_info.title)
            end
            stream:writeushort(self.relation_info.sceneid)
            stream:writeuchar(self.relation_info.team_size)
            stream:writeint(self.relation_info.unknow_3 or 0)	--这里是角色的sex
			--fix 20250317
			stream:writeshort(-1)	--很有可能是目前所在场景的归属服务器ID，默认值为-1
        end
    end,
    write_relation_guid_uchar_uchar = function(self, stream)
        stream:writeint(self.relation_guid_uchar_uchar.guid)
        stream:writeuchar(self.relation_guid_uchar_uchar.relation_type)
        stream:writeuchar(self.relation_guid_uchar_uchar.group)
    end,
    write_online_friends = function(self, stream)
        stream:writeuchar(self.online_friends.count)
        if self.online_friends.count > 0 and self.online_friends.count <= 0x50 then
            for i = 1, self.online_friends.count do
                local of = self.online_friends.list[i]
                stream:writeint(of.guid)
                of.mood = gbk.fromutf8(of.mood)
                stream:writeuchar(#of.mood)
                if #of.mood > 0 and #of.mood < 0x20 then
                    stream:write(of.mood, #of.mood)
                end
                stream:writeint(of.unknow_1 or 0)
            end
        end
    end,
    write_relation_online = function(self, stream)
        stream:writeint(self.relation_online.guid)
        self.relation_online.name = gbk.fromutf8(self.relation_online.name)
        stream:writeuchar(#self.relation_online.name)
        if #self.relation_online.name > 0 and #self.relation_online.name < 0x1E then
            stream:write(self.relation_online.name, #self.relation_online.name)
        end
        self.relation_online.mood = gbk.fromutf8(self.relation_online.mood)
        stream:writeuchar(#self.relation_online.mood)
        if #self.relation_online.mood > 0 and #self.relation_online.mood < 0x20 then
            stream:write(self.relation_online.mood, #self.relation_online.mood)
        end
        stream:writeuint(self.unknow_1 or 1)
    end,
    write_relation_offline = function(self, stream)
        stream:writeint(self.relation_offline.guid )
        self.relation_offline.name = gbk.fromutf8(self.relation_offline.name)
        stream:writeuchar(#self.relation_offline.name)
        if #self.relation_offline.name > 0 and #self.relation_offline.name < 0x1E then
            stream:write(self.relation_offline.name, #self.relation_offline.name)
        end
        local mlen = stream:readuchar()
        if mlen > 0 and mlen < 0x1E then
            self.relation_offline.mood = stream:read(mlen)
        end
        self.relation_offline.unknow_1 = stream:readint()
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.type = stream:readuchar()
        if self.type == 1 then
            self:read_relation_list(stream)
        elseif self.type == 2 then
            self:read_relation_info(stream)
        elseif self.type == 3 then
            self:read_view_player(stream)
        elseif self.type == 5 or self.type == 6 or self.type == 7 or self.type == 8 or self.type == 0x13 or self.type == 0x15 then
            self:read_add_relation(stream)
        elseif self.type == 9 then
            self:read_relation_guid_uchar_uchar(self, stream)
        elseif self.type == 0xA or self.type == 0xB or self.type == 0xF or self.type == 0x14 or self.type == 0x17 then
            self.del_relation = {}
            self.del_relation.guid = stream:readint()
        elseif self.type == 0xC or self.type == 0x12 then
            self.notify_friend = {}
            self.notify_friend.guid = stream:readint()
            local nlen = stream:readuchar()
            if nlen > 0 and nlen < 0x1E then
                self.notify_friend.name = stream:read(nlen)
            end
        elseif self.type == 0xD then
            self:read_online_friends(stream)
        elseif self.type == 0xE then
            self:read_relation_online(stream)
        elseif self.type == 0x11 then
            local mlen = stream:readuchar()
            if mlen > 0 and mlen < 0x1E then
                self.new_mood = {}
                self.new_mood.mood = stream:read(mlen)
            end
        elseif self.type == 0x12 then
            local nlen = stream:readuchar()
            self.notify_add_temp_friend = {}
            if nlen > 0 and nlen < 0x1E then
                self.notify_add_temp_friend.name = stream:read(nlen)
            end
            self.notify_add_temp_friend.unknow_1 = stream:readshort()
        elseif self.type == 0x16 or self.type == 0x18 then
            self.err_already_in_black = {}
            self.err_already_in_black.guid = stream:readint()
            local nlen = stream:readuchar()
            if nlen > 0 and nlen < 0x1E then
                self.err_already_in_black.name = stream:read(nlen)
            end
            self.err_already_in_black.unknow_1 = stream:readint()
            self.err_already_in_black.unknow_2 = stream:readuchar()
        elseif self.type == 0x34 then
            self.unknow = {}
            self.unknow.guid = stream:readint()
            local nlen = stream:readuchar()
            if nlen > 0 and nlen < 0x1E then
                self.unknow.name = stream:read(nlen)
            end
        elseif self.type == 0x1A then
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.type)
        if self.type == 1 then
            self:write_relation_list(stream)
        elseif self.type == 2 then
            self:write_relation_info(stream)
        elseif self.type == 3 then
            self:write_view_player(stream)
        elseif self.type == 5 or self.type == 6 or self.type == 7 or self.type == 8 or self.type == 0x13 or self.type == 0x15 then
            self:write_add_relation(stream)
        elseif self.type == 9 then
            self:write_relation_guid_uchar_uchar(stream)
        elseif self.type == 0xA or self.type == 0xB or self.type == 0xF or self.type == 0x14 or self.type == 0x17 then
            stream:writeint(self.del_relation.guid)
        elseif self.type == 0xC or self.type == 0x12 then
            stream:writeint(self.notify_friend.guid)
            stream:writeuchar(#self.notify_friend.name)
            if #self.notify_friend.name > 0 and #self.notify_friend.name < 0x1E then
                stream:write(self.notify_friend.name, #self.notify_friend.name)
            end
        elseif self.type == 0xD then
            self:write_online_friends(stream)
        elseif self.type == 0xE then
            self:write_relation_online(stream)
        elseif self.type == 0x10 then
            self.new_mood.mood = gbk.fromutf8(self.new_mood.mood)
            stream:writeuchar(#self.new_mood.mood)
            if #self.new_mood.mood > 0 and #self.new_mood.mood < 0x1E then
                stream:write(self.new_mood.mood, #self.new_mood.mood)
            end
        elseif self.type == 0x11 then
            stream:writeuchar(#self.notify_add_temp_friend.name)
            if #self.notify_add_temp_friend.name > 0 and #self.notify_add_temp_friend.name < 0x1E then
                stream:write(self.notify_add_temp_friend.name, #self.notify_add_temp_friend.name)
            end
            stream:writeshort(self.notify_add_temp_friend.unknow_1 or 0)
        elseif self.type == 0x16 or self.type == 0x18 then
            stream:writeint(self.err_already_in_black.guid)
            stream:writeuchar(#self.err_already_in_black.name)
            if #self.err_already_in_black.name > 0 and #self.err_already_in_black.name < 0x1E then
                stream:write(self.err_already_in_black.name, #self.err_already_in_black.name)
            end
            stream:writeint(self.err_already_in_black.unknow_1)
            stream:writeuchar(self.err_already_in_black.unknow_2)
        elseif self.type == 0x34 then
            stream:writeint(self.unknow.guid)
            stream:writeuchar(#self.unknow.name)
            if #self.unknow.name > 0 and #self.unknow.name < 0x1E then
                stream:write(self.unknow.name, #self.unknow.name)
            end
        end
        return stream:get()
    end
}

packet.CGAskGSChitChatInfo = {
    xy_id = packet.XYID_CG_ASK_GS_CHIT_CHAT_INFO,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGAskGSChitChatInfo})
        o:ctor()
        return o
    end,
    ctor = function(self) self.unknow_1 = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.unknow_1)
        return stream:get()
    end
}



packet.GCCharEquipment = {
    xy_id = packet.XYID_CG_CHAR_EQUIPMENT,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCCharEquipment})
        o:ctor()
        return o
    end,
    set_weapon = function(self,m_WeaponID,WeaponGemID,Weapon_visual)
		self.m_WeaponID = m_WeaponID
		self.WeaponGemID = WeaponGemID
		self.Weapon_visual = Weapon_visual
		self.flag = self.flag | 0x1
    end,
    set_cap = function(self,m_CapID,CapGemID,Cap_visual)
		self.m_CapID = m_CapID
		self.CapGemID = CapGemID
		self.Cap_visual = Cap_visual
		self.flag = self.flag | 0x2
    end,
    set_armour = function(self,m_ArmourID,ArmourGemID,Armour_visual)
		self.m_ArmourID = m_ArmourID
		self.ArmourGemID = ArmourGemID
		self.Armour_visual = Armour_visual
		self.flag = self.flag | 0x4
	end,
    set_cuff = function(self,m_CuffID,CuffGemID,Cuff_visual)
		self.m_CuffID = m_CuffID
		self.CuffGemID = CuffGemID
		self.Cuff_visual = Cuff_visual
		self.flag = self.flag | 0x8
    end,
    set_unknow_6 = function(self,item_index,gemid,visual)
		self.unknow_6_a = item_index
		self.unknow_6_b = gemid
		self.unknow_6_c = visual
		self.flag = self.flag | 0x10
    end,
    set_fasion = function(self,fashion_item_id,fashion_unknow_2,fashion_unknow_3,fashion_unknow_4,visual)
		self.fashion_item_id = fashion_item_id
		self.fashion_unknow_2 = fashion_unknow_2
		self.fashion_unknow_3 = fashion_unknow_3
		self.fashion_unknow_4 = fashion_unknow_4
		self.visual = visual
		self.flag = self.flag | 0x10000
    end,
    set_wuhun = function(self,wuhun_item_id,wuhun_visual)
		self.wuhun_item_id = wuhun_item_id
		self.wuhun_visual = wuhun_visual
		self.flag = self.flag | 0x40000
    end,
    ctor = function(self)
        self.unknow_1 = 0
        self.flag = 0
    end,
    bis = function(self, buffer)
        -- local stream = bistream.new()
        -- stream:attach(buffer)
        -- self.m_objID = stream:readuint()
        -- self.unknow_1 = stream:readuint()
        -- self.flag = stream:readuint()

        -- if self.flag & 0x1 == 0x1 then
            -- self.m_WeaponID = stream:readuint()
            -- self.WeaponGemID = stream:readint()
            -- self.Weapon_visual = stream:readushort()
        -- end

        -- if self.flag & 0x2 == 0x2 then
            -- self.m_CapID = stream:readuint()
            -- self.CapGemID = stream:readint()
            -- self.Cap_visual = stream:readushort()
        -- end

        -- if self.flag & 0x4 == 0x4 then
            -- self.m_ArmourID = stream:readuint()
            -- self.ArmourGemID = stream:readint()
            -- self.Armour_visual = stream:readushort()
        -- end

        -- if self.flag & 0x8 == 0x8 then
            -- self.m_CuffID = stream:readuint()
            -- self.CuffGemID = stream:readint()
            -- self.Cuff_visual = stream:readushort()
        -- end

        -- if self.flag & 0x10 == 0x10 then
            -- self.unknow_6_a = stream:readuint()
            -- self.unknow_6_b = stream:readint()
            -- self.unknow_6_c = stream:readushort()
        -- end

        -- if self.flag & 0x10000 == 0x10000 then
            -- self.fashion_item_id = stream:readint()
            -- self.visual          = stream:readshort()
            -- self.fashion_unknow_2 = stream:readint()
            -- self.fashion_unknow_3 = stream:readint()
            -- self.fashion_unknow_4 = stream:readint()
        -- end

        -- if self.flag & 0x40000 == 0x40000 then
            -- self.wuhun_item_id = stream:readint()
            -- self.wuhun_visual = stream:readshort()
        -- end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        stream:writeuint(self.unknow_1)
        stream:writeuint(self.flag)

        if self.flag & 0x1 == 0x1 then
            stream:writeint(self.m_WeaponID)
            stream:writeint(self.WeaponGemID)
            stream:writeshort(self.Weapon_visual)
        end

        if self.flag & 0x2 == 0x2 then
			if not self.Cap_visual or self.Cap_visual < 0 then
				self.m_CapID = -1
				self.CapGemID = -1
				self.Cap_visual = 0
			end
            stream:writeint(self.m_CapID)
            stream:writeint(self.CapGemID)
            stream:writeshort(self.Cap_visual)
        end

        if self.flag & 0x4 == 0x4 then
			if not self.Armour_visual or self.Armour_visual < 0 then
				self.m_ArmourID = -1
				self.ArmourGemID = -1
				self.Armour_visual = 0
			end
            stream:writeint(self.m_ArmourID)
            stream:writeint(self.ArmourGemID)
            stream:writeshort(self.Armour_visual)
        end

        if self.flag & 0x8 == 0x8 then
			if not self.Cuff_visual or self.Cuff_visual < 0 then
				self.m_CuffID = -1
				self.CuffGemID = -1
				self.Cuff_visual = 0
			end
            stream:writeint(self.m_CuffID)
            stream:writeint(self.CuffGemID)
            stream:writeshort(self.Cuff_visual)
        end

        if self.flag & 0x10 == 0x10 then
			if not self.unknow_6_c or self.unknow_6_c < 0 then
				self.unknow_6_a = -1
				self.unknow_6_b = -1
				self.unknow_6_c = 0
			end
            stream:writeint(self.unknow_6_a)
            stream:writeint(self.unknow_6_b)
            stream:writeshort(self.unknow_6_c)
        end

        if self.flag & 0x10000 == 0x10000 then
			if not self.visual or self.visual < 0 then
				self.fashion_item_id = -1
				self.fashion_unknow_2 = -1
				self.fashion_unknow_3 = -1
				self.fashion_unknow_4 = -1
				self.visual = 0
			end
            stream:writeint(self.fashion_item_id)
            stream:writeshort(self.visual)
            stream:writeint(self.fashion_unknow_2)
            stream:writeint(self.fashion_unknow_3)
            stream:writeint(self.fashion_unknow_4)
        end

        if self.flag & 0x40000 == 0x40000 then
			if not self.wuhun_visual or self.wuhun_visual < 0 then
				self.wuhun_item_id = -1
				self.wuhun_visual = 0
			end
            stream:writeint(self.wuhun_item_id)
            stream:writeshort(self.wuhun_visual)
        end
        return stream:get()
    end
}




packet.unknow_440 = {
    xy_id = packet.XYID_UNKNOW_440,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.unknow_440})
        o:ctor()
        return o
    end,
    ctor = function(self) self.unknow_1 = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readushort()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeushort(self.unknow_1)
        return stream:get()
    end
}

packet.GCTeamList = {
    xy_id = packet.XYID_GC_TEAM_LIST,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.GCTeamList})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.type = 0
        self.exp_mode = 0
        self.member_size = 0
        self.member_list = {}
        self.uinfos = {}
    end,
    bis = function(self, buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.type)
        stream:writeushort(self.team_id)
        stream:writeuint(self.exp_mode)
        stream:writeuchar(self.member_size)
        stream:writeint(0)
        if self.member_size > 6 then
            self.member_size = 6
        end
        if self.member_size > 0 then
            for i = 1, self.member_size do
                self.member_list[i].name = gbk.fromutf8(self.member_list[i].name)
                self.member_list[i].name_size = string.len(self.member_list[i].name)
                stream:writeuint(self.member_list[i].guid)
                stream:writeushort(self.member_list[i].sceneid)
                stream:writeushort(self.member_list[i].client_res)
                stream:writeint(self.member_list[i].m_objID)
                stream:writeuchar(self.member_list[i].name_size)
                if self.member_list[i].name_size <= 0x1E then
                    stream:write(self.member_list[i].name, self.member_list[i].name_size)
                end
                stream:writeuint(self.member_list[i].portrait_id)
                stream:writeushort(self.member_list[i].model)
                stream:writeuint(self.member_list[i].level)
                stream:writeuchar(self.member_list[i].menpai)
                stream:writeshort(self.member_list[i].unknow_9 or define.INVAILD_ID)
            end
            for i = 1, self.member_size do
                local uinfo = self.uinfos[i]
                stream:writeuint(i)
                stream:writeuint(uinfo.menpai)
                stream:writeuint(uinfo.level)
                stream:writeuint(uinfo.is_offline or 0)
                stream:writeuint(uinfo.unknow_4 or 259)
                stream:writeint(uinfo.hair_color or 0)
                stream:writeint(uinfo.fashion[define.WG_KEY_C])
                stream:writeuint(uinfo.unknow_5 or 145)
				stream:writeuint(0)
				stream:writeuint(0)
				stream:writeuint(0)
            end
        end
        return stream:get()
    end
}

packet.WGCAladdinToken = {
    xy_id = packet.XYID_WGC_AlADDIN_TOKEN,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.WGCAladdinToken})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = 0
        self.unknow_2 = 0
        self.unknow_3 = ""
        self.unknow_4 = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readushort()
        self.unknow_2 = stream:readuint()
        self.unknow_3 = stream:read(0x10)
        self.unknow_4 = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeushort(self.unknow_1)
        stream:writeuint(self.unknow_2)
        stream:write(self.unknow_3, 0x10)
        stream:writeuint(self.unknow_4)
        return stream:get()
    end
}

packet.CGNetDelay = {
    xy_id = packet.XYID_CG_NET_DELAY,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGNetDelay})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = 0
        self.unknow_2 = 0
        self.unknow_3 = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readuint()
        self.unknow_2 = stream:readushort()
        self.unknow_3 = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.unknow_1)
        stream:writeushort(self.unknow_2)
        stream:writeuint(self.unknow_3)
        return stream:get()
    end
}

packet.GCRetNetDelay = {
    xy_id = packet.XYID_GC_RET_NET_DELAY,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCRetNetDelay})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        return stream:get()
    end
}

packet.CGCTUGabrielCmdRet = {
    xy_id = packet.XYID_GC_CTU_GABRIEL_CMD_RET,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGCTUGabrielCmdRet})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = 0
        self.len = 0
        self.data = ""
        self.unknow_2 = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readuint()
        self.len = stream:readushort()
        self.data = stream:read(self.len)
        self.unknow_2 = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.unknow_1)
        stream:writeushort(self.len)
        stream:write(self.data, self.len)
        stream:writeuint(self.unknow_2)
        return stream:get()
    end
}

packet.CGCharStopLogic = {
    xy_id = packet.XYID_GC_CHAR_STOP_LOGIC,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGCharStopLogic})
        o:ctor()
        return o
    end,
    ctor = function(self) self.m_objID = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        return stream:get()
    end
}

packet.CGModifySetting = {
    xy_id = packet.XYID_CG_MODIFY_SETTING,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGModifySetting})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.type = 0
        self.setting = {type = 0, data = 0}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.type = stream:readuchar()
        self.setting.type = stream:readuchar()
        self.setting.data = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.type)
        stream:writeuchar(self.setting.type)
        stream:writeuint(self.setting.data)
        return stream:get()
    end
}

packet.CGAskQuit = {
    xy_id = packet.XYID_CG_ASK_QUIT,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGAskQuit})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = 0
        self.unknow_2 = 0
        self.unknow_3 = 0
        self.unknow_4 = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readuint()
        self.unknow_2 = stream:readuchar()
        self.unknow_3 = stream:readuint()
        self.unknow_4 = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.unknow_1)
        stream:writeuchar(self.unknow_2)
        stream:writeuint(self.unknow_3)
        stream:writeuint(self.unknow_4)
        return stream:get()
    end
}

packet.GCNewPet_Move = {
    xy_id = packet.XYID_GC_NEW_PET_MOVE,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCNewPet_Move})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_objID = 0
        self.unknow_1 = 0
        self.worldpos = {x = 0, y = 0}
        self.unknow_2 = 0
        self.unknow_3 = 0
        self.unknow_4 = 0
        self.unknow_5 = 0

        self.unknow_6 = 0
        self.size = 0
        self.posList = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.unknow_1 = stream:readuint()
        self.worldpos.x = stream:readfloat()
        self.worldpos.y = stream:readfloat()
        self.unknow_2 = stream:readuint()
        self.unknow_3 = stream:readuint()
        self.unknow_4 = stream:readuint()
        self.unknow_5 = stream:readuint()

        self.unknow_6 = stream:readuchar()
        self.size = stream:readuchar()
        if self.size > 0 and self.size < 0x10 then
            for i = 1, self.size do
                local pos = {x = 0, y = 0}
                pos.x = stream:readfloat()
                pos.y = stream:readfloat()
                table.insert(self.posList, pos)
            end
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        stream:writeuint(self.unknow_1)
        stream:writefloat(self.worldpos.x)
        stream:writefloat(self.worldpos.y)
        stream:writeuint(self.unknow_2)
        stream:writeuint(self.unknow_3)
        stream:writeuint(self.unknow_4)
        stream:writeuint(self.unknow_5)
        stream:writeuchar(self.unknow_6)
        stream:writeuchar(self.size)
        if self.size > 0 and self.size < 0x10 then
            for i = 1, self.size do
                local pos = self.posList[i] or {x = 0, y = 0}
                stream:writefloat(pos.x)
                stream:writefloat(pos.y)
            end
        end

        return stream:get()
    end
}

packet.GCRetAskQuit = {
    xy_id = packet.XYID_GC_RET_ASK_QUIT,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCRetAskQuit})
        o:ctor()
        return o
    end,
    ctor = function(self) self.flag = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.flag = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.flag)
        return stream:get()
    end
}

packet.CGHeartBeat = {
    xy_id = packet.XYID_CG_HEART_BEAT,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGHeartBeat})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        return stream:get()
    end
}

packet.GCDetailImpactListUpdate = {
    xy_id = packet.XYID_GC_DETAIL_IMPACT_LIST_UPDATE,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.GCDetailImpactListUpdate})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.list = {}
        self.unknow_2 = -1
    end,
    bis = function(self, buffer)
        local stream    = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.size = stream:readushort()
        if self.size > 30 then
            self.size = 30
        end
        for i = 1, self.size do
            local impact = {}
            impact.sender = stream:readint()
            impact.buffer_id = stream:readint()
            impact.skill_id = stream:readint()
            impact.sn = stream:readint()
            impact.continuance = stream:readint()
            self.list[i] = impact
        end
        self.unknow_2 = stream:readshort()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        stream:writeushort(self.size)
        if self.size > 30 then
            self.size = 30
        end
        for i = 1, self.size do
            local impact = self.list[i]
            stream:writeint(impact.sender)
            stream:writeint(impact.buffer_id)
            stream:writeint(impact.skill_id)
            stream:writeint(impact.sn)
            stream:writeint(impact.continuance)
        end
        stream:writeshort(self.unknow_2)
        return stream:get()
    end
}

packet.GCUnknow_1093 = {
    xy_id = packet.XYID_GC_UNKNOW_1093,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCUnknow_1093})
        o:ctor()
        return o
    end,
    ctor = function(self) self.unknow = 0 end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.unknow)
        return stream:get()
    end
}

packet.GCNewPet = {
    xy_id = packet.XYID_GC_NEW_PET,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.GCNewPet})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = -1
        self.unknow_2 = 0
        self.unknow_4 = 0
    end,
    bis = function(self, buffer)
        local stream  = bistream.new()
        stream:attach(buffer)
        self.m_objID    = stream:readuint()
        self.unknow_1   = stream:readint()
        self.world_pos        = {}
        self.world_pos.x      = stream:readfloat()
        self.world_pos.y      = stream:readfloat()
        self.unknow_2   = stream:readuint()
        self.speed   = stream:readfloat()
        self.unknow_4   = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        stream:writeint(self.unknow_1)
        stream:writefloat(self.world_pos.x)
        stream:writefloat(self.world_pos.y)
        stream:writeuint(self.unknow_2)
        stream:writefloat(self.speed)
        stream:writeuint(self.unknow_4)
        return stream:get()
    end
}

packet.GCShowMonsterTaps = {
    xy_id = packet.XYID_GC_SHOW_MONSTER_TAPS,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCShowMonsterTaps})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.taps = {}    
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        local size = stream:readuchar()
        self.taps = {}
        for i = 1, size do
            local tap = {}
            tap.pos = {}
            tap.pos.x = stream:readfloat()
            tap.pos.y = stream:readfloat()
            tap.id = stream:readuint()
            self.taps[i] = tap
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(#self.taps)
        for i = 1, #self.taps do
            local tap = self.taps[i]
            stream:writefloat(tap.pos.x)
            stream:writefloat(tap.pos.y)
            stream:writeuint(tap.id)
        end
        stream:writeuchar(1)
        return stream:get()
    end
}

packet.CGPackage_SwapItem = {
    xy_id = packet.XYID_CG_PACKAGE_SWAP_ITEM,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGPackage_SwapItem})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.index_from = stream:readuchar()
        self.index_to = stream:readuchar()
        self.count = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.index_from)
        stream:writeuchar(self.index_to)
        stream:writeuchar(self.count)
        return stream:get()
    end
}

packet.GCPackage_SwapItem = {
    xy_id = packet.XYID_GC_PACKAGE_SWAP_ITEM,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCPackage_SwapItem})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.result = stream:readuchar()
        self.index_from = stream:readuchar()
        self.index_to = stream:readuchar()
        self.count = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.result)
        stream:writeuchar(self.index_from)
        stream:writeuchar(self.index_to)
        stream:writeuchar(self.count)
        return stream:get()
    end
}

packet.CGAskItemInfo = {
    xy_id = packet.XYID_CG_ASK_ITEM_INFO,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGAskItemInfo})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.bagIndex = stream:readushort()
        self.askid = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeushort(self.bagIndex)
        stream:writeuint(self.askid)
        return stream:get()
    end
}

packet.GCItemInfo = {
    xy_id = packet.XYID_GC_ITEM_INFO,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCItemInfo})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = 0
        self.bag_type = 0
        self.askid = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.bagIndex = stream:readushort()
        self.unknow_1 = stream:readint()
        self.item = packet.ItemInfo.new()
        self.item:bis(stream)
        self.askid = stream:readuint()
        self.bag_type = stream:readint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeshort(self.bagIndex)
        stream:writeint(self.unknow_1)
        packet.ItemInfo.bos(self.item, stream)
        stream:writeuint(self.askid)
        stream:writeint(self.bag_type)
        return stream:get()
    end
}

packet.CGUseEquip = {
    xy_id = packet.XYID_CG_USE_EQUIP,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGUseEquip})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.bagIndex = stream:readuchar()
        self.equipPoint = stream:readuchar()
        self.type = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.bagIndex)
        stream:writeuchar(self.equipPoint)
        stream:writeuchar(self.type)
        return stream:get()
    end
}

packet.GCUseEquipResult = {
    xy_id = packet.XYID_GC_USE_EQUIP_RESULT,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCUseEquipResult})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.result = stream:readuchar()
        self.equipPoint = stream:readuchar()
        self.bagIndex = stream:readuchar()
        self.equip_guid = packet.ItemGUID.new()
        self.equip_guid:bis(stream)
        self.item_guid = packet.ItemGUID.new()
        self.item_guid:bis(stream)
        self.equipTableIndex = stream:readint()
        self.item_index = stream:readint()
        self.unknow = stream:readushort()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.result)
        stream:writeuchar(self.equipPoint)
        stream:writeuchar(self.bagIndex)

        packet.ItemGUID.bos(self.equip_guid, stream)
        packet.ItemGUID.bos(self.item_guid, stream)

        stream:writeint(self.equipTableIndex)
        stream:writeint(self.item_index)

        stream:writeushort(self.unknow)
        return stream:get()
    end
}

packet.CGUnEquip = {
    xy_id = packet.XYID_CG_UN_EQUIP,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGUnEquip})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.equipPoint = stream:readuchar()
        self.unknow_2 = stream:readuchar()
        self.unknow_3 = stream:readuchar()
        self.unknow_4 = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.equipPoint)
        stream:writeuchar(self.unknow_2)
        stream:writeuchar(self.unknow_3)
        stream:writeuchar(self.unknow_4)
        return stream:get()
    end
}

packet.GCUnEquipResult = {
    xy_id = packet.XYID_GC_UN_EQUIP_RESULT,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCUnEquipResult})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.equipPoint = stream:readuchar()
        self.bagIndex = stream:readuchar()
        self.item_index = stream:readuint()
        self.item_guid = packet.ItemGUID.new()
        self.item_guid:bis(stream)
        self.result = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.equipPoint)
        stream:writeuchar(self.bagIndex or 255)
        stream:writeint(self.item_index)
        packet.ItemGUID.bos(self.item_guid, stream)
        stream:writeuchar(self.result)
        return stream:get()
    end
}

packet.CGPackUpPacket = {
    xy_id = packet.XYID_CG_PACKUP_PACKET,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGPackUpPacket})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.unknow)
        return stream:get()
    end
}

packet.GCPackUpPacket = {
    xy_id = packet.XYID_GC_PACKUP_PACKET,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCPackUpPacket})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.unknow)
        return stream:get()
    end
}

packet.CGUseItem = {
    xy_id = packet.XYID_CG_USE_ITEM,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGUseItem})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.bagIndex = stream:readuchar()
        self.item_index = stream:readuint()
        self.pet_guid = packet.ItemGUID.new()
        self.pet_guid:bis(stream)
        self.target_obj_id = stream:readint()
        self.target_pos = {}
        self.target_pos.x = stream:readfloat()
        self.target_pos.y = stream:readfloat()
        self.target_dir = stream:readfloat()
        self.pet_guid = packet.PetGUID.new()
        self.pet_guid:bis(stream)
        self.target_bag_index = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.unknow)
        return stream:get()
    end
}

packet.GCUseItemResult = {
    xy_id = packet.XYID_GC_USE_ITEM_RESULT,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCUseItemResult})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.result = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.result)
        return stream:get()
    end
}

packet.GCScriptCommand = {
    xy_id = packet.XYID_GC_SCRIPT_COMMAND,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCScriptCommand})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_nCmdID = stream:readuint()
        if self.m_nCmdID == 0 or self.m_nCmdID == 2 then
            self.target_id = stream:readuint()
            self.size = stream:readuchar()
            if self.size > 0 and self.size <= 0x10 then
                self.event = {}
                local i = 1
                while true do
                    self.event[i] = {}
                    self.event[i].flag = stream:readint()
                    if self.event[i].flag == 0 or self.event[i].flag == 2 then
                        local len = stream:readushort()
                        if len > 0 and len < 256 then
                            self.event[i].str = stream:read(len)
                        end
                    end
                    if self.event[i].flag == 1 then
                        self.event[i].unknow_4 = stream:readuint()
                        self.event[i].index = stream:readuint()
                        self.event[i].type = stream:readuint()
                        self.event[i].m_objID = stream:readuint()
                        local len = stream:readushort()
                        if len > 0 and len < 256 then
                            self.event[i].str = stream:read(len)
                        end
                    end
                    i = i + 1
                    if i > self.size then
                        return
                    end
                end
            end
        elseif self.m_nCmdID == 1 then
            self.m_idNPC = stream:readuint()
            self.unknow = stream:readint()
            self.ScriptID_t = stream:readuint()
            self.m_idMission = stream:readuint()
            self.m_yTextCount = stream:readuchar()
            if self.m_yTextCount > 0 and self.m_yTextCount < 8 then
                self.event = {}
                for i = 1, self.m_yTextCount do
                    self.event[i] = {}
                    local len = stream:readushort()
                    self.event[i].str = stream:read(len)
                end
            end
            self.m_yBonusCount = stream:readuchar()
            if self.m_yBonusCount > 0 and self.m_yBonusCount < 0x10 then
                self.m_aBonus = {}
                for i = 1, self.m_yBonusCount do
                    self.m_aBonus[i] = {}
                    self.m_aBonus[i].type = stream:readuint()
                    if self.m_aBonus[i].type == 0 or self.m_aBonus[i].type == 1 then
                        self.m_aBonus[i].item_index = stream:readuint()
                    elseif self.m_aBonus[i].type == 2 or self.m_aBonus[i].type == 4 then
                        self.m_aBonus[i].count = stream:readuchar()
                        self.m_aBonus[i].item_index = stream:readuint()
                    end
                end
            end
        elseif self.m_nCmdID == 3 then
            self.m_idNPC = stream:readuint()
            self.unknow = stream:readint()
            self.ScriptID_t = stream:readuint()
            self.m_idMission = stream:readuint()
            self.done = stream:readuint()
            self.m_yTextCount = stream:readuchar()
            if self.m_yTextCount > 0 and self.m_yTextCount < 8 then
                self.event = {}
                for i = 1, self.m_yTextCount do
                    self.event[i] = {}
                    local len = stream:readushort()
                    self.event[i].str = stream:read(len)
                end
            end
            self.m_yDemandCount = stream:readuchar()
            if self.m_yDemandCount > 0 and self.m_yDemandCount < 0x8 then
                self.m_aDemandItem = {}
                for i = 1, self.m_yDemandCount do
                    self.m_aDemandItem[i] = {}
                    self.m_aDemandItem[i].count = stream:readuchar()
                    self.m_aDemandItem[i].itemid = stream:readint()
                end
            end
        elseif self.m_nCmdID == 4 then
            self.target_id = stream:readint()
            self.unknow_4_2 = stream:readint()
            self.script_id = stream:readint()
            self.m_idMission = stream:readint()
            self.size = stream:readchar()
            self.event = {}
            for i = 1, self.size do
                self.event[i] = {}
                self.event[i].len = stream:readshort()
                if self.event[i].len > 0 and self.event[i].len < 256 then
                    self.event[i].str = stream:read(self.event[i].len)
                end
            end
            self.item_count = stream:readchar()
            if self.item_count > 0 and self.item_count <= 8 then
                self.items = {}
                for i = 1, self.item_count do
                    self.items[i] = {}
                    self.items[i].flag = stream:readint()
                    if self.items[i].flag == 2 or self.items[i].flag == 4 then
                        self.items[i].count = stream:readuchar()
                    end
                    self.items[i].item_index = stream:readint()
                end
            end
        elseif self.m_nCmdID == 5 then
            self.event = {}
            self.event.len = stream:readushort()
            if self.event.len <= 0 or self.event.len >= 256 then
                self.event.len = 0
                self.event.str = ""
            else
                self.event.str = stream:read(self.event.len)
            end
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_nCmdID)
        if self.m_nCmdID == 0 or self.m_nCmdID == 2 then
            stream:writeint(self.target_id)
            stream:writeuchar(self.size)
            if self.size > 0 and self.size <= 0x10 then
                local i = 1
                while true do
                    stream:writeint(self.event[i].flag)
                    if self.event[i].flag == 0 or self.event[i].flag == 2 then
                        local len = string.len(self.event[i].str)
                        stream:writeushort(len)
                        if len > 0 and len < 256 then
                            stream:write(self.event[i].str, len)
                        end
                    end
                    if self.event[i].flag == 1 then
						-- local skynet = require "skynet"
                        -- skynet.logi("self.event[i] =", table.tostr(self.event[i]))
                        stream:writeint(self.event[i].index)
                        stream:writeint(self.event[i].type)
                        stream:writeint(self.event[i].script_id)
                        stream:writeint(self.event[i].split)
                        local len = string.len(self.event[i].str)
                        stream:writeushort(len)
                        if len > 0 and len < 256 then
                            stream:write(self.event[i].str, len)
                        end
                    end
                    i = i + 1
                    if i > self.size then
                        return stream:get()
                    end
                end
            end
        elseif self.m_nCmdID == 1 then
            stream:writeuint(self.target_id)
            stream:writeint(-1)
            stream:writeint(self.m_objID)
            stream:writeint(self.m_idMission)
            stream:writeuchar(self.size)
            if self.size > 0 and self.size < 8 then
                for i = 1, self.size do
                    local len = string.len(self.event[i].str)
                    stream:writeushort(len)
                    stream:write(self.event[i].str, len)
                end
            end
            stream:writeuchar(self.m_yBonusCount)
            if self.m_yBonusCount > 0 and self.m_yBonusCount < 0x10 then
                for i = 1, self.m_yBonusCount do
                    stream:writeint(self.m_aBonus[i].type)
                    if self.m_aBonus[i].type == 0 or self.m_aBonus[i].type == 1 then
                        stream:writeuint(self.m_aBonus[i].item_index)
                    elseif self.m_aBonus[i].type == 2 or self.m_aBonus[i].type == 4 then
                        stream:writeuchar(self.m_aBonus[i].count)
                        stream:writeuint(self.m_aBonus[i].item_index)
                    end
                end
            end
        elseif self.m_nCmdID == 3 then
            stream:writeuint(self.target_id)
            stream:writeint(-1)
            stream:writeuint(self.m_objID)
            stream:writeuint(self.m_idMission)
            stream:writeuint(self.done)
            stream:writeuchar(self.size)
            if self.size > 0 and self.size <= 8 then
                for i = 1, self.size do
                    local len = string.len(self.event[i].str)
                    stream:writeushort(len)
                    if len > 0 and len < 256 then
                        stream:write(self.event[i].str, len)
                    end
                end
            end
            stream:writeuchar(self.m_yDemandCount)
            if self.m_yDemandCount > 0 and self.m_yDemandCount <= 0x8 then
                for i = 1, self.m_yDemandCount do
                    stream:writeuchar(self.m_aDemandItem[i].count)
                    stream:writeint(self.m_aDemandItem[i].itemid)
                end
            end
        elseif self.m_nCmdID == 4 then
            stream:writeint(self.target_id)
            stream:writeint(-1)
            stream:writeint(self.m_objID)
            stream:writeint(self.m_idMission)
            stream:writechar(self.size)
            for i = 1, self.size do
                local len = string.len(self.event[i].str)
                stream:writeushort(len)
                if self.event[i].len > 0 and self.event[i].len < 256 then
                    stream:write(self.event[i].str, len)
                end
            end
            stream:writechar(self.item_count)
            if self.item_count > 0 and self.item_count <= 8 then
                for i = 1, self.item_count do
                    stream:writeint(self.items[i].flag)
                    if self.items[i].flag == 2 or self.items[i].flag == 4 then
                        stream:writeuchar(self.items[i].count)
                    end
                    stream:writeint(self.items[i].item_index)
                end
            end
        elseif self.m_nCmdID == 5 then
            self.event.len = (self.event.len >= 256 or self.event.len < 0) and 0 or self.event.len
            stream:writeushort(self.event.len)
            stream:write(self.event.str, self.event.len)
        end
        return stream:get()
    end
}

packet.CGShowFashionDepotData = {
    xy_id = packet.XYID_CG_SHOW_FASHION_DEPOT_DATA,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGShowFashionDepotData})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.unknow)
        return stream:get()
    end
}

--[[
packet.GCShowFashionDepotData = {
    xy_id = packet.XYID_GC_SHOW_FASHION_DEPOT_DATA,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCShowFashionDepotData})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.unknow)
        return stream:get()
    end
}]]

packet.CGEventRequest = {
    xy_id = packet.XYID_CG_EVENT_REQUEST,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGEventRequest})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readint()
        self.index = stream:readint()
        self.arg = stream:readint()
        self.unknow = stream:readuint()
    end
}

packet.GCNotifyChangeScene = {
    xy_id = packet.XYID_GC_NOTIFY_CHANGE_SCENE,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCNotifyChangeScene})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_5 = {
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0
        }
        self.unknow_6 = {
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 128, 63, 0, 0, 0, 0, 0, 0, 0, 0
        }
        self.unknow_3 = 9
        self.client_res = 0
        self.world_pos = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.scene_from = stream:readushort()
        self.scene_to = stream:readushort()
        self.world_pos = {}
        self.world_pos.x = stream:readfloat()
        self.world_pos.y = stream:readfloat()
        self.unknow_3 = stream:readuchar()
        self.client_res = stream:readushort()
        self.unknow_5 = {}
        for i = 1, 0x1A do self.unknow_5[i] = stream:readuchar() end
        self.unknow_6 = {}
        for i = 1, 0x18 do self.unknow_6[i] = stream:readuchar() end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeushort(self.scene_from)
        stream:writeushort(self.scene_to)
        stream:writefloat(self.world_pos.x)
        stream:writefloat(self.world_pos.y)
        stream:writeuchar(self.unknow_3)
        stream:writeushort(self.client_res)
        for i = 1, 0x1A do stream:writeuchar(self.unknow_5[i]) end
        for i = 1, 0x18 do stream:writeuchar(self.unknow_6[i]) end
        return stream:get()
    end
}

packet.CGAskChangeScene = {
    xy_id = packet.XYID_CG_ASK_CHANGE_SCENE,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGAskChangeScene})
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.scene_from = stream:readushort()
        self.scene_to = stream:readushort()
        self.unknow_1 = stream:readuint()
        self.unknow_2 = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()

        return stream:get()
    end
}

packet.GCRetChangeScene = {
    xy_id = packet.XYID_GC_RET_CHANGE_SCENE,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCRetChangeScene})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.key = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.result = stream:readuchar()
        if self.result == 1 then
            self.ip = stream:read(0x18)
            self.port = stream:readushort()
        end
        self.key = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.result )
        if self.result == 1 then
            stream:write(self.ip, 0x18)
            stream:writeushort(self.port)
        end
        stream:writeuint(self.key)
        return stream:get()
    end
}

packet.GCCharSkill_Gather = {
    xy_id = packet.XYID_GC_CHAR_SKILL_GATHER,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCCharSkill_Gather})
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.logic_count = stream:readuint()
        self.skill_id = stream:readuint()
        self.world_pos = {}
        self.world_pos.x = stream:readfloat()
        self.world_pos.y = stream:readfloat()
        self.target_id = stream:readint()
        self.target_pos = {}
        self.target_pos.x = stream:readfloat()
        self.target_pos.y = stream:readfloat()
        self.dir = stream:readfloat()
        self.total_time = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        stream:writeuint(self.logic_count)
        stream:writeuint(self.skill_id)
        stream:writefloat(self.world_pos.x)
        stream:writefloat(self.world_pos.y)
        stream:writeint(self.target_id)
        stream:writefloat(self.target_pos.x)
        stream:writefloat(self.target_pos.y)
        stream:writefloat(self.dir)
        stream:writeuint(self.total_time)
        return stream:get()
    end
}

packet.GCCharSkill_Send = {
    xy_id = packet.XYID_GC_CHAR_SKILL_SEND,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCCharSkill_Send})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = 1
        self.unknow_2 = 0
    end,
    bis = function(self, buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        stream:writeuint(self.logic_count)
        stream:writeuint(self.skill_id)
        stream:writeint(self.target_id)
        stream:writefloat(self.target_pos.x)
        stream:writefloat(self.target_pos.y)
        stream:writeuchar(self.unknow_1)
        stream:writeuchar(self.unknow_2)
        return stream:get()
    end
}

packet.GCCharBuff = {
    xy_id = packet.XYID_GC_CHAR_BUFF,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCCharBuff})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_6 = 0
        self.unknow_2 = -1
    end,
    bis = function(self, buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.reciver)
        local flag = self.sn + 2
        stream:writeint(flag)
        stream:writeshort(self.buffer_id)
        stream:writeuint(self.enable)
        stream:writeint(self.sender)
        stream:writeint(self.unknow_2)
        stream:writeuint(self.sn)
        if self.enable ~= 0 then
            stream:writeint(self.logic_count)
        end
        if self.buffer_id == 4740 then
            stream:writeushort(self.unknow_6)
        end
        return stream:get()
    end
}

packet.GCDetailBuff = {
    xy_id = packet.XYID_GC_CHAR_DETAIL_BUFF,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCDetailBuff})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_7 = -1
    end,
    bis = function(self, buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.sn)
        stream:writeuint(self.enable)
        if self.enable ~= 0 then
            stream:writeint(self.sender)
            stream:writeint(self.reciver)
            stream:writeshort(self.buffer_id)
            stream:writeint(self.skill_id)
            stream:writeint(self.logic_count)
            stream:writeint(self.continuance)
        end
        stream:writeshort(self.unknow_7)
        return stream:get()
    end
}

packet.GCTargetListAndHitFlags = {
    xy_id = packet.XYID_GC_TARGET_LIST_AND_HIT_FLAGS,
    enum_type = {
        UNIT_USE_SKILL = 0,
        SPECIAL_OBJ_ACTIVATE = 1,
    },
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCTargetListAndHitFlags})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1  = 1
    end,
    bis = function(self, buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.data_type)
        stream:writeuint(self.m_objID)
        stream:writeuint(self.logic_count)
        stream:writeuint(self.skill_or_special_obj_id)
        stream:writefloat(self.target_pos.x)
        stream:writefloat(self.target_pos.y)
        stream:writeuchar(self.unknow_1)
        self.size = self.size > 0x40 and 0x40 or self.size
        stream:writeuchar(self.size)
        for i = 1, self.size do
            stream:writeuint(self.target_list[i])
        end
		--某种子弹效果 可能是恶人谷用
		stream:writeshort(self.shenme or 0)
        return stream:get()
    end
}

packet.GCCharMoveResult = {
    xy_id = packet.XYID_GC_CHAR_MOVE_RESULT,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCCharMoveResult})
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.result = stream:readint()
        self.handle = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        stream:writeint(self.result)
        stream:writeuint(self.handle)
        return stream:get()
    end
}

packet.GCRetSetting = {
    xy_id = packet.XYID_GC_RET_SETTING,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCRetSetting})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.setting = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        for i = 1, 0x61 do
            local setting = {}
            setting.type = stream:readuchar()
            setting.data = stream:readuint()
            self.setting[i] = setting
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        for i = 1, 0x61 do
            local setting = self.setting[i] or { type = 0, data = 0}
            stream:writeuchar(setting.type)
            if setting.data == -1 then
                setting.data = define.UINT_MAX
            end
            stream:writeuint(setting.data)
        end
        return stream:get()
    end
}

packet.GCDetailHealsAndDamages = {
    xy_id = packet.XYID_GC_DETAIL_HEALS_AND_DAMAGES,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCDetailHealsAndDamages})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.dirty_flags = 0
    end,
    bis = function(self, buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.dirty_flags)
        stream:writeuint(self.reciver)
        stream:writeint(self.sender)
        stream:writeuint(self.logic_count)
        if self.dirty_flags & 1 == 1 then
            stream:writeint(self.hp_modification)
        end
        if self.dirty_flags & 2 == 2 then
            stream:writeint(self.mp_modification)
        end
        if self.dirty_flags & 4 == 4 then
            stream:writeint(self.rage_modification)
        end
        if self.dirty_flags & 8 == 8 then
            stream:writeint(self.strike_point_modification)
        end
        stream:writeuchar(self.is_critical_hit)
        return stream:get()
    end
}

packet.GCCharDirectImpact = {
    xy_id = packet.XYID_GC_CHAR_DIRECT_IMPACT,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCCharDirectImpact})
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.reciver = stream:readuint()
        self.sender = stream:readuint()
        self.logic_count = stream:readuint()
        self.impact_id = stream:readushort()
        self.skill_id = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.reciver)
        stream:writeuint(self.sender)
        stream:writeuint(self.logic_count)
        stream:writeushort(self.impact_id)
        stream:writeuint(self.skill_id)
        return stream:get()
    end
}

packet.GCCharDirectImpact = {
    xy_id = packet.XYID_GC_CHAR_DIRECT_IMPACT,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCCharDirectImpact})
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.reciver = stream:readuint()
        self.sender = stream:readuint()
        self.logic_count = stream:readuint()
        self.impact_id = stream:readushort()
        self.skill_id = stream:readint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.reciver)
        stream:writeint(self.sender)
        stream:writeint(self.logic_count)
        stream:writeushort(self.impact_id)
        stream:writeint(self.skill_id)
        return stream:get()
    end
}

packet.GCCharSkill_Missed = {
    xy_id = packet.XYID_GC_CHAR_SKILL_MISSED,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCCharSkill_Missed})
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.reciver = stream:readuint()
        self.sender = stream:readuint()
        self.skill_id = stream:readuint()
        self.flag = stream:readuchar()
        self.sender_logic_count = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.reciver)
        stream:writeint(self.sender)
        stream:writeint(self.skill_id)
        stream:writechar(self.flag)
        stream:writeuint(self.sender_logic_count or 0)

        return stream:get()
    end
}

packet.GCNewItemBox = {
    xy_id = packet.XYID_GC_NEW_ITEM_BOX,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.GCNewItemBox})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_7 = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.owner_guid = stream:readuint()
        self.monster_id = stream:readuint()
        self.world_pos = {}
        self.world_pos.x = stream:readfloat()
        self.world_pos.y = stream:readfloat()
        self.item_box_type = stream:readint()
        self.unknow_7 = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        stream:writeint(self.owner_guid)
        stream:writeint(self.monster_id)
        stream:writefloat(self.world_pos.x)
        stream:writefloat(self.world_pos.y)
        stream:writeint(self.item_box_type)
        stream:writeuint(self.unknow_7)

        return stream:get()
    end
}

packet.GCFashionDepotOperation = {
    xy_id = packet.XYID_GC_FASHION_DEPOT_OPERATION,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.GCFashionDepotOperation})
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.flag = stream:readuchar()
        self.unknow_2 = stream:readuint()
        self.unknow_3 = stream:readuchar()
        if self.flag == 5 then
            self.unknow_3 = stream:readuint()
        else
            self.fashion = {}
            self.fashion.item_index = stream:readuint()
            self.fashion.quality = stream:readuchar()
            self.fashion.visual = stream:readushort()
            self.fashion.unknow_4 = {}
            for j = 1, 0xc do
                self.fashion.unknow_4[j] = stream:readuchar()
            end
            for j = 1, 5 do
                stream:readuchar()
            end
        end
        if self.flag == 3 or self.flag == 5 then
            self.unknow_4 = stream:readuint()
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.flag)
        stream:writeuint(self.unknow_2)
        stream:writeuchar(self.unknow_3 or 0)
        if self.flag == 5 then
            stream:writeuint(self.unknow_3)
        else
            stream:writeint(self.fashion.item_index)
            stream:writeuchar(self.fashion.quality)
            stream:writeushort(self.fashion.visual)
            for j = 1, 0xc do
                stream:writeuchar(self.fashion.unknow_4[j])
            end
            for j = 1, 5 do
                stream:writeuchar(0)
            end
        end
        if self.flag == 3 or self.flag == 5 then
            stream:writeuint(self.unknow_4)
        end
        return stream:get()
    end
}

packet.GCDetailExp = {
    xy_id = packet.XYID_GC_DETAIL_EXP,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCDetailExp})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = 0
        self.exp = 0
        self.award_exp = 0
        self.bb_exp = 0
        self.bb_award_exp = 0
        self.anqi_exp = 0
        self.anqi_award_exp = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readuint()
        self.exp = stream:readuint()
        self.award_exp = stream:readuint()
        self.bb_exp = stream:readuint()
        self.bb_award_exp = stream:readuint()
        self.anqi_exp = stream:readuint()
        self.anqi_award_exp = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.unknow_1)
        stream:writeuint(self.exp)
        stream:writeuint(self.award_exp)
        stream:writeuint(self.bb_exp)
        stream:writeuint(self.bb_award_exp)
        stream:writeuint(self.anqi_exp)
        stream:writeuint(self.anqi_award_exp)

        return stream:get()
    end
}

packet.GCCharStopAction = {
    xy_id = packet.XYID_GC_CHAR_STOP_ACTION,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCCharStopAction})
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.logic_count = stream:readuint()
        self.stop_time = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        stream:writeuint(self.logic_count)
        stream:writeuint(self.stop_time)
        return stream:get()
    end
}

packet.CGOpenItemBox = {
    xy_id = packet.XYID_CG_OPEN_ITEM_BOX,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGOpenItemBox})
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        return stream:get()
    end
}

packet.GCBoxItemList = {
    xy_id = packet.XYID_GC_ITEM_BOX_LIST,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.GCBoxItemList})
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.size = stream:readuchar()
        self.size = self.size > 10 and 10 or self.size
        self.item_box_type = stream:readshort()
        self.item_list = {}
        for i = 1, self.size do
            local item = packet.ItemInfo.new()
            item:bis(stream)
            self.item_list[i] = item
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        stream:writeuchar(self.size)
        self.size = self.size > 10 and 10 or self.size
        stream:writeshort(self.item_box_type)
        for i = 1, self.size do
            local item = self.item_list[i]
            packet.ItemInfo.bos(item, stream)
        end
        return stream:get()
    end
}

packet.GCPickResult = {
    xy_id = packet.XYID_GC_PICK_RESULT,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCPickResult})
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.item_box_guid = packet.ItemGUID.new()
        self.item_box_guid:bis(stream)
        self.result = stream:readuchar()
        self.bag_index = stream:readchar()
        self.item_box_type = stream:readshort()
        self.item_guid = packet.ItemGUID.new()
        self.item_guid:bis(stream)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        packet.ItemGUID.bos(self.item_box_guid, stream)
        stream:writeuchar(self.result)
        stream:writeuchar(self.bag_index)
        stream:writeshort(self.item_box_type)
        packet.ItemGUID.bos(self.item_guid, stream)
        return stream:get()
    end
}

packet.CGPickBoxItem = {
    xy_id = packet.XYID_CG_PICK_BOX_ITEM,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.CGPickBoxItem})
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.item_guid = packet.ItemGUID.new()
        self.item_guid:bis(stream)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        packet.ItemGUID.bos(self.item_guid, stream)
        return stream:get()
    end
}

packet.GCNewMonster_Move = {
    xy_id = packet.XYID_GC_NEW_MONSTER_MOVE,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.GCNewMonster_Move})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_3 = 0
        self.unknow_5 = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.guid = stream:readint()
        self.world_pos = {}
        self.world_pos.x = stream:readfloat()
        self.world_pos.y = stream:readfloat()
        self.dir = stream:readfloat()
        self.speed = stream:readfloat()
        self.unknow_3 = stream:readuint()
        self.handle = stream:readuint()
        self.unknow_5 = stream:readuchar()
        self.size = stream:readuchar()
        self.path = {}
        if self.size > 0 and self.size <= 0x10 then
            for i = 1, self.size do
                local pos = {}
                pos.x = stream:readfloat()
                pos.y = stream:readfloat()
                table.insert(self.path, pos)
            end
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        stream:writeint(self.guid)
        stream:writefloat(self.world_pos.x)
        stream:writefloat(self.world_pos.y)
        stream:writefloat(self.dir)
        stream:writefloat(self.speed)
        stream:writeuint(self.unknow_3)
        stream:writeuint(self.handle)
        stream:writeuchar(self.unknow_5)
        stream:writeuchar(#self.path)
        for i = 1, #self.path do
            local pos = self.path[i]
            stream:writefloat(pos.x)
            stream:writefloat(pos.y)
        end
        return stream:get()
    end
}

packet.GCCharMove = {
    xy_id = packet.XYID_GC_CHAR_MOVE,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.GCCharMove})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.flag = 0
        self.unknow_3 = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.start_time = stream:readuint()
        self.handleID = stream:readint()
        self.flag = stream:readuchar()
        self.size = stream:readuchar()
        self.path = {}
        if self.size > 0 and self.size <= 0x10 then
            for i = 1, self.size do
                local pos = {}
                pos.x = stream:readfloat()
                pos.y = stream:readfloat()
                table.insert(self.path, pos)
            end
        end
        if self.flag & 0x4 == 0x4 then
            self.stop_pos = {}
            self.stop_pos.x = stream:readfloat()
            self.stop_pos.y = stream:readfloat()
            self.stop_logic_count = stream:readuint()
            self.unknow_3 = stream:readuchar()
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        stream:writeuint(self.start_time)
        stream:writeint(self.handleID)
        stream:writeuchar(self.flag)
        stream:writeuchar(self.size)
        if self.size > 0 and self.size <= 0x10 then
            for i = 1, self.size do
                local pos = self.path[i]
                stream:writefloat(pos.x)
                stream:writefloat(pos.y)
            end
        end
        if self.flag & 0x4 == 0x4 then
            stream:writefloat(self.stop_pos.x)
            stream:writefloat(self.stop_pos.y)
            stream:writeuint(self.stop_logic_count)
            stream:writeuchar(self.unknow_3)
        end
        return stream:get()
    end
}

packet.GCObjTeleport = {
    xy_id = packet.XYID_GC_OBJECT_TELEPORT,
    new = function(o)
        o = o or {}
        setmetatable(o, { __index = packet.GCObjTeleport })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.world_pos = {}
        self.world_pos.x = stream:readfloat()
        self.world_pos.y = stream:readfloat()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        stream:writefloat(self.world_pos.x)
        stream:writefloat(self.world_pos.y)
        return stream:get()
    end
}

packet.CGDispelBuffReq = {
    xy_id = packet.XYID_CG_DISPEL_BUFF_REQ,
    new = function(o)
        o = o or {}
        setmetatable(o, { __index = packet.CGDispelBuffReq })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.skill_id = stream:readuint()
        self.buffer_id = stream:readushort()
        self.sn = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        return stream:get()
    end
}

packet.GCLevelUpResult = {
    xy_id = packet.XYID_GC_LEVEL_UP_RESULT,
    new = function(o)
        o = o or {}
        setmetatable(o, { __index = packet.GCLevelUpResult })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.remind_exp = stream:readuint()
        self.result = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.remind_exp)
        stream:writeuint(self.result)
        return stream:get()
    end
}

packet.GCLevelUp = {
    xy_id = packet.XYID_GC_LEVEL_UP,
    new = function(o)
        o = o or {}
        setmetatable(o, { __index = packet.GCLevelUp })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.level = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        stream:writeuint(self.level)
        return stream:get()
    end
}

packet.GCArrive = {
    xy_id = packet.XYID_GC_ARRIVE,
    new = function(o)
        o = o or {}
        setmetatable(o, { __index = packet.GCArrive })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.handleid = stream:readuint()
        self.unknow = stream:readchar()
        self.world_pos = {}
        self.world_pos.x = stream:readfloat()
        self.world_pos.y = stream:readlfoat()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        stream:writeuint(self.handleid)
        stream:writechar(self.unknow)
        stream:writefloat(self.world_pos.x)
        stream:writefloat(self.world_pos.y)
        return stream:get()
    end
}

packet.GCOperateResult = {
    xy_id = packet.XYID_GC_OPERATE_RESULT,
    new = function(o)
        o = o or {}
        setmetatable(o, { __index = packet.GCOperateResult })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.result = stream:readint()
    end,
    bos = function(self)
        local stream = bostream.new()
		-- local skynet = require "skynet"
		-- skynet.logi("self.result = ",self.result)
        stream:writeint(self.result or 0)
        return stream:get()
    end
}

packet.GCXinfaStudyInfo = {
    xy_id = packet.XYID_GC_XINFA_STUDY_INFO,
    new = function(o)
        o = o or {}
        setmetatable(o, { __index = packet.GCXinfaStudyInfo })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.menpai = self:readushort()
        self.teacher = self:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeushort(self.menpai)
        stream:writeuint(self.teacher)
        return stream:get()
    end
}

packet.GCStudyXinfa = {
    xy_id = packet.XYID_GC_STUDY_XINFA,
    new = function(o)
        o = o or {}
        setmetatable(o, { __index = packet.GCStudyXinfa })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.spare_money = stream:readuint()
        self.spare_exp = stream:readuint()
        self.xinfa = stream:readushort()
        self.now_level = stream:readushort()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.spare_money)
        stream:writeuint(self.spare_exp)
        stream:writeushort(self.xinfa)
        stream:writeushort(self.now_level)
        return stream:get()
    end
}

packet.CGAskStudyXinfa = {
    xy_id = packet.XYID_CG_ASK_STUDY_XINFA,
    new = function(o)
        o = o or {}
        setmetatable(o, { __index = packet.CGAskStudyXinfa })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.menpai = stream:readushort()
        self.xinfa = stream:readushort()
        self.now_level = stream:readushort()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeushort(self.menpai)
        stream:writeushort(self.xinfa)
        stream:writeushort(self.now_level)
        return stream:get()
    end
}

packet.GCAddSkill = {
    xy_id = packet.XYID_GC_ADD_SKILL,
    new = function(o)
        o = o or {}
        setmetatable(o, { __index = packet.GCAddSkill })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.skill = stream:readuint()
        self.unknow = stream:readushort()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.skill)
        stream:writeushort(self.unknow)
        return stream:get()
    end
}

packet.CGReqLevelUp = {
    xy_id = packet.XYID_CG_REQ_LEVEL_UP,
    new = function(o)
        o = o or {}
        setmetatable(o, { __index = packet.CGReqLevelUp })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        return stream:get()
    end
}

packet.GCCharSkill_Lead = {
    xy_id = packet.XYID_GC_CHAR_SKILL_LEAD,
    new = function(o)
        o = o or {}
        setmetatable(o, { __index = packet.GCCharSkill_Lead })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.logic_count = stream:readuint()
        self.skill_id = stream:readuint()
        self.world_pos = {}
        self.world_pos.x = stream:readfloat()
        self.world_pos.y = stream:readfloat()
        self.target_id = stream:readuint()
        self.tar_pos = {}
        self.tar_pos.x = stream:readfloat()
        self.tar_pos.y = stream:readfloat()
        self.dir = stream:readlfoat()
        self.total_time = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        stream:writeuint(self.logic_count)
        stream:writeuint(self.skill_id)
        stream:writefloat(self.world_pos.x)
        stream:writefloat(self.world_pos.y)
        stream:writeuint(self.target_id)
        stream:writefloat(self.tar_pos.x)
        stream:writefloat(self.tar_pos.y)
        stream:writefloat(self.dir)
        stream:writeuint(self.total_time)
        return stream:get()
    end
}

packet.GCShopMerchandiseList = {
    xy_id = packet.XYID_GC_SHOP_MERCHANDISE_LIST,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCShopMerchandiseList })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.sold_type = 1
        self.unknow_10 = 1065353216
        self.unknow_11 = 1065353216
        self.unknow_13 = 0
        self.can_multiple_buy = 1
        self.unknow_15 = 0
        self.unknow_18 = 0
        self.unknow_2 = 1
        self.unknow_3 = 40
        self.unknow_4 = 120
        self.unknow_5 = 1065353216
        self.unknow_6 = 1065353216
        self.unknow_8 = 1
        self.unknow_9 = 1065353216
        self.merchadise_list = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readint()
        self.merchandise_num = stream:readuchar()
        self.sold_type = stream:readint()
        self.unknow_2 = stream:readint()
        self.unknow_3 = stream:readuint()
        self.unknow_4 = stream:readuint()
        self.unknow_5 = stream:readuint()
        self.unknow_6 = stream:readuint()
        self.unique_id = stream:readuint()
        self.unknow_8 = stream:readuchar()
        self.unknow_9 = stream:readuint()
        self.unknow_10 = stream:readuint()
        self.unknow_11 = stream:readuint()
        self.shop_type = stream:readuchar()
        self.unknow_13 = stream:readuchar()
        self.can_multiple_buy = stream:readuchar()
        self.unknow_15 = stream:readuchar()
        self.shop_id = stream:readuint()
        self.is_yuanbao_shop = stream:readuchar()
        self.unknow_18 = stream:readuchar()
        self.merchadise_list = {}
        for i = 1, self.merchandise_num do
            local merchandise = {}
            merchandise.id = stream:readuint()
            merchandise.pnum = stream:readuint()
            merchandise.yuanbao_price = stream:readuint()
            merchandise.c_pmax = stream:readint()
            merchandise.pmax = stream:readint()
            merchandise.discount = stream:readuint()
            merchandise.price = stream:readuint()
            self.merchadise_list[i] = merchandise
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.m_objID)
        stream:writeuchar(self.merchandise_num)
        stream:writeint(self.sold_type)
        stream:writeint(self.unknow_2)
        stream:writeint(self.unknow_3)
        stream:writeint(self.unknow_4)
        stream:writeint(self.unknow_5)
        stream:writeint(self.unknow_6)
        stream:writeint(self.unique_id)
        stream:writeuchar(self.unknow_8)
        stream:writeint(self.unknow_9)
        stream:writeint(self.unknow_10)
        stream:writeint(self.unknow_11)
        stream:writeuchar(self.shop_type)
        stream:writeuchar(self.unknow_13)
        stream:writeuchar(self.can_multiple_buy)
        stream:writeuchar(self.unknow_15)
        stream:writeint(self.shop_id)
        stream:writeuchar(self.is_yuanbao_shop)
        stream:writeuchar(self.unknow_18)
        for i = 1, self.merchandise_num do
            local merchandise = self.merchadise_list[i]
            stream:writeuint(merchandise.id)
            stream:writeint(merchandise.pnum)
            stream:writeint(merchandise.yuanbao_price or 0)
            stream:writeint(merchandise.c_pmax)
            stream:writeint(merchandise.pmax)
            stream:writeint(merchandise.discount)
            stream:writeuint(merchandise.price)            
            self.merchadise_list[i] = merchandise
        end
        return stream:get()
    end
}

packet.GCShopSoldList = {
    xy_id = packet.XYID_GC_SHOP_SOLD_LIST,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCShopSoldList })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.merchandise_num)
        print("self.merchandise_num =", self.merchandise_num)
        for i = 1, self.merchandise_num do
            local ei = self.item_list[i]
            print("#ei.item", #ei.item)
            packet.EquipStream.bos(ei.item, stream)
            stream:writeuint(ei.price)
        end
        return stream:get()
    end
}

packet.CGShopBuy = {
    xy_id = packet.XYID_CG_SHOP_BUY,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGShopBuy })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.index = stream:readuchar()
        self.series_num = stream:readuchar()
        self.unique_id = stream:readuint()
        self.item_guid = packet.ItemGUID.new()
        self.item_guid:bis(stream)
        self.buy_num = stream:readuint()
        self.unknow_1 = stream:readuint()
        self.unknow_2 = stream:readuint()
        self.unknow_3 = stream:readuint()
        self.unknow_4 = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.merchandise_num)
        for i = 1, self.merchandise_num do
            local item = self.item_list[i]
            packet.ItemInfo.bos(item, stream)
        end
        return stream:get()
    end
}

packet.GCShopBuy = {
    xy_id = packet.XYID_GC_SHOP_BUY,
    BUY_RESULT = {
        BUY_OK          = 0,-- 购买成功
        BUY_BACK_OK     = 1,-- 回购成功
        BUY_RMB_FAIL    = 2,-- 没钱了
        BUY_BAG_FULL    = 4,-- 放不下了
    },
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCShopBuy })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_2 = 0
        self.unknow_11 = 0
        self.item_index = -1
        self.count = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.result = stream:readuchar()
        self.item_index = stream:readint()
        self.count = stream:readint()
        self.flag = stream:readuchar()
        if self.flag == 1 then
            self.shop_id = stream:readuint()
            self.index = stream:readuint()
            self.count = stream:readuchar()
            self.price = stream:readuint()
            self.unknow_8 = stream:readint()
            self.unknow_9 = stream:readuint()
            self.price = stream:readuint()
        end
        self.unknow_11 = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.result)
        stream:writeint(self.item_index)
        stream:writeint(self.count)
        stream:writeuchar(self.unknow_2)
        if self.unknow_2 == 1 then
            stream:writeuint(self.shop_id)
            stream:writeuint(self.index)
            stream:writeuchar(self.count)
            stream:writeuint(self.price)
            stream:writeint(self.unknow_8)
            stream:writeuint(self.unknow_9)
            stream:writeuint(self.price)
        end
        stream:writeuint(self.unknow_11)
        return stream:get()
    end
}

packet.GCNotifyEquip = {
    xy_id = packet.XYID_GC_NOTIFY_EQUIP,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCNotifyEquip })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeushort(self.bag_index)
        packet.EquipInfo.bos(self.item, stream)
        return stream:get()
    end
}

packet.CGUseGem = {
    xy_id = packet.XYID_CG_USE_GEM,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGUseGem })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.gem_index = stream:readuchar()
        self.equip_index = stream:readuchar()
        self.unknow_3 = stream:readuchar()
        self.unknow_4 = stream:readuchar()
        self.unknow_5 = stream:readuint()
        self.unknow_6 = stream:readuchar()
    end,
}

packet.CGRemoveGem = {
    xy_id = packet.XYID_CG_REMOVE_GEM,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGRemoveGem })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.gem_index = stream:readuchar()
        self.equip_index = stream:readuchar()
        self.mat_index = stream:readuchar()
    end,
}

packet.CGGemCompound = {
    xy_id = packet.XYID_CG_GEM_COMPOUND,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGGemCompound })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.gem_id = stream:readuint()
        self.mat_index = stream:readuint()
        self.method = stream:readuint()
    end
}

packet.CGDisplaceGem = {
    xy_id = packet.XYID_CG_DISPLACE_GEM,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGDisplaceGem })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.from_bag_index = stream:readuchar()
        self.to_bag_index = stream:readuchar()
    end
}

packet.GCAbilityLevel = {
    xy_id = packet.XYID_GC_ABILITY_LEVEL,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCAbilityLevel })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.id = stream:readushort()
        self.level = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeushort(self.id)
        stream:writeuint(self.level)
        return stream:get()
    end
}

packet.GCPrescription = {
    xy_id = packet.XYID_GC_PRESCRIPTION,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPrescription })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.id = stream:readuint()
        self.learn_or_abandon = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.id)
        stream:writeuint(self.learn_or_abandon)
        return stream:get()
    end
}

packet.GCAbilityResult = {
    xy_id = packet.XYID_GC_ABILITY_RESULT,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCAbilityResult })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.ability = stream:readushort()
        self.prescription = stream:readuint()
        self.result = stream:readint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeushort(self.ability)
        stream:writeint(self.prescription)
        stream:writeint(self.result)
        return stream:get()
    end
}

packet.GCAbilityAction = {
    xy_id = packet.XYID_GC_ABILITY_ACTION,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCAbilityAction })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.logic_count = stream:readuint()
        self.ability = stream:readushort()
        self.prescription = stream:readuint()
        self.target_obj_id = stream:readint()
        self.begin_or_end = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.m_objID)
        stream:writeuint(self.logic_count)
        stream:writeushort(self.ability)
        stream:writeint(self.prescription)
        stream:writeuint(self.target_obj_id)
        stream:writeuchar(self.begin_or_end)
        return stream:get()
    end
}

packet.GCAbilitySucc = {
    xy_id = packet.XYID_GC_ABILITY_SUCC,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCAbilitySucc })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.ability = stream:readushort()
        self.prescription = stream:readuint()
        self.item_index = stream:readuint()
        self.num = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeushort(self.ability)
        stream:writeint(self.prescription)
        stream:writeint(self.item_index)
        stream:writeuchar(self.num)
        stream:writeuchar(0)
        return stream:get()
    end
}

packet.CGSplitItem = {
    xy_id = packet.XYID_CG_SPLIT_ITEM,
    Container = {
        BANK_CON = 0,
        BAG_CON  = 1,
    },
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGSplitItem })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.container = stream:readuint()
        self.position = stream:readuint()
        self.num = stream:readuint()
    end
}

packet.GCSplitItemResult = {
    xy_id = packet.XYID_GC_SPLIT_ITEM_RESULT,
    RESULT = {
        RESULT_FALSE = 0,
        RESULT_FALSE_NOGRID = 1,
        RESULT_SUCCEED = 2,
    },
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCSplitItemResult })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.con_index = -1
        self.is_null = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.con_index = stream:readshort()
        self.is_null = stream:readuint()
        self.container = stream:readuint()
        self.result = stream:readuchar()
        self.item = packet.ItemInfo.new()
        self.item:bis(stream)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeshort(self.con_index)
        stream:writeuint(self.is_null)
        stream:writeuint(self.container)
        stream:writeuchar(self.result)
        packet.ItemInfo.bos(self.item, stream)
        return stream:get()
    end
}

packet.CGTeamInvite = {
    xy_id = packet.XYID_CG_TEAM_INVITE,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGTeamInvite })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readint()
        self.unknow = stream:readint()
        self.dest_name_size = stream:readuchar()
        if self.dest_name_size > 0 and self.dest_name_size < 0x1E then
            self.dest_name = gbk.toutf8(stream:read(self.dest_name_size))
        end
        self.unknow_1 = stream:readushort()
    end
}

packet.CGDiscardItem = {
    xy_id = packet.XYID_CG_DISCARD_ITEM,
    OPT = {
        FromBag  = 0,
        FromBank = 1,
    },
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGDiscardItem })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.bag_index = stream:readuchar()
        self.opt = stream:readuchar()
    end 
}

packet.GCDiscardItemResult = {
    xy_id = packet.XYID_CG_DISCARD_ITEM_RESULT,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCDiscardItemResult })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.result = stream:readuchar()
        self.bag_index = stream:readuchar()
        self.opt = stream:readuchar()
        self.item_index = stream:readint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.result)
        stream:writeuchar(self.bag_index)
        stream:writeuchar(self.opt)
        stream:writeint(self.item_index)
        return stream:get()
    end
}

packet.CGTeamDismiss = {
    xy_id = packet.XYID_CG_TEAM_DISMISS,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGTeamDismiss })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.guid = stream:readint()
    end
}

packet.GCTeamResult = {
    xy_id = packet.XYID_GC_TEAM_RESULT,
    new = function()
        local o = o or {}
        setmetatable(o, { __index = packet.GCTeamResult })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_7 = define.INVAILD_ID
    end,
    bis = function(self, buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        self.name = gbk.fromutf8(self.name)
        self.name_size = string.len(self.name)
        stream:writeuchar(self.return_type)
        stream:writeint(self.guid)
        stream:writeushort(self.team_id)
        stream:writeint(self.guid_ex)
        stream:writeshort(self.sceneid)
        stream:writeshort(self.client_res)
        stream:writeuchar(self.name_size)
        if self.name_size > 0 and self.name_size <= 0x1E then
            stream:write(self.name, self.name_size)
        end
        stream:writeuint(self.portrait_id)
        stream:writeushort(self.sex)
        stream:writeshort(self.unknow_7)
        if self.return_type == 8 or self.return_type == 0 then
            packet.TeamMemberInfo.bos(self.uinfo, stream)
        end
        return stream:get()
    end
}

packet.GCTeamAskInvite = {
    xy_id = packet.XYID_GC_TEAM_ASK_INVITE,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCTeamAskInvite })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = -1
        self.member_list = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.guid = stream:readint()
        self.nickname = stream:read(0x1E)
        self.unknow_1 = stream:readshort()
        self.member_size = stream:readuchar()
        if self.member_size > 6 then
            self.member_size = 6
        end
        if self.member_size > 0 then
            for i = 1, self.member_size do
                local uinfo = {}
                uinfo.detail_flag = stream:readuchar()
                local nickname_size = stream:readuchar()
                if nickname_size > 0 and nickname_size < 0x1E then
                    uinfo.nickname = stream:read(nickname_size)
                end
                uinfo.menpai = stream:readint()
                uinfo.sceneid = stream:readshort()
                uinfo.level = stream:readuint()
                uinfo.model = stream:readshort() --0
                uinfo.unknow_6 = stream:readint()   --0
                uinfo.unknow_7 = stream:readshort() --3
                -- if uinfo.detail_flag ~= 0 then
                    -- uinfo.weapon[define.WG_KEY_A] = stream:readint()
                    -- uinfo.weapon[define.WG_KEY_B] = stream:readint()
                    -- uinfo.weapon[define.WG_KEY_C] = stream:readushort()

                    -- uinfo.cap[define.WG_KEY_A] = stream:readint()
                    -- uinfo.cap[define.WG_KEY_B] = stream:readint()
                    -- uinfo.cap[define.WG_KEY_C] = stream:readushort()

                    -- uinfo.armour[define.WG_KEY_A] = stream:readint()
                    -- uinfo.armour[define.WG_KEY_B] = stream:readint()
                    -- uinfo.armour[define.WG_KEY_C] = stream:readushort()

                    -- uinfo.cuff[define.WG_KEY_A] = stream:readint()
                    -- uinfo.cuff[define.WG_KEY_B] = stream:readint()
                    -- uinfo.cuff[define.WG_KEY_C] = stream:readushort()

                    -- uinfo.foot[define.WG_KEY_A] = stream:readint()
                    -- uinfo.foot[define.WG_KEY_B] = stream:readint()
                    -- uinfo.foot[define.WG_KEY_C] = stream:readushort()

                    -- uinfo.unknow_7 = stream:readint()   -- 100
                    -- uinfo.fasion_visual = stream:readint()
                    -- uinfo.unknow_9 = stream:readint()   -- 0
                    -- uinfo.fashion[define.WG_KEY_A] = stream:readint()
                    -- uinfo.fashion[define.WG_KEY_D] = stream:readint()  -- -1
                    -- uinfo.fashion[define.WG_KEY_E] = stream:readint()  -- -1
                    -- uinfo.fashion[define.WG_KEY_F] = stream:readint()  -- -1
                    -- uinfo.unknow_14 = stream:readuint() -- 3394306053
                    -- uinfo.fashion[define.WG_KEY_C] = stream:readushort() -- 1744
					
                    -- uinfo.unknow_7 = stream:readint()   -- 100
                    -- uinfo.fasion_visual = stream:readint()
                    -- uinfo.unknow_9 = stream:readint()   -- 0
                    -- uinfo.fashion = stream:readint()
                    -- uinfo.unknow_11 = stream:readint()  -- -1
                    -- uinfo.unknow_12 = stream:readint()  -- -1
                    -- uinfo.unknow_13 = stream:readint()  -- -1
                    -- uinfo.unknow_14 = stream:readuint() -- 3394306053
                    -- uinfo.unknow_15 = stream:readushort() -- 1744
                -- end
                table.insert(self.member_list, uinfo)
            end
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.guid)
        self.nickname = gbk.fromutf8(self.nickname)
        stream:write(self.nickname, 0x1E)
        stream:writeshort(self.unknow_1)
        stream:writeuchar(self.member_size)
        if self.member_size > 6 then
            self.member_size = 6 
        end
        if self.member_size > 0 then
            for i = 1, self.member_size do
                local uinfo = self.member_list[i]
                stream:writeuchar(uinfo.detail_flag or 0)
                uinfo.nickname = gbk.fromutf8(uinfo.nickname)
                local nickname_size = string.len(uinfo.nickname)
                stream:writeuchar(nickname_size)
                if nickname_size > 0 and nickname_size <= 0x1E then
                    stream:write(uinfo.nickname, nickname_size)
                end
                stream:writeint(uinfo.menpai)
                stream:writeshort(uinfo.sceneid)
                stream:writeint(uinfo.level)
                stream:writeshort(uinfo.model)
                stream:writeint(uinfo.unknow_6 or 0)
                stream:writeshort(uinfo.unknow_7 or 3)
                -- if uinfo.detail_flag ~= 0 then
                    -- stream:writeint(uinfo.weapon[define.WG_KEY_A])
                    -- stream:writeint(uinfo.weapon[define.WG_KEY_B])
                    -- stream:writeushort(uinfo.weapon[define.WG_KEY_C])

                    -- stream:writeint(uinfo.cap[define.WG_KEY_A])
                    -- stream:writeint(uinfo.cap[define.WG_KEY_B])
                    -- stream:writeushort(uinfo.cap[define.WG_KEY_C])

                    -- stream:writeint(uinfo.armour[define.WG_KEY_A])
                    -- stream:writeint(uinfo.armour[define.WG_KEY_B])
                    -- stream:writeushort(uinfo.armour[define.WG_KEY_C])

                    -- stream:writeint(uinfo.cuff[define.WG_KEY_A])
                    -- stream:writeint(uinfo.cuff[define.WG_KEY_B])
                    -- stream:writeushort(uinfo.cuff[define.WG_KEY_C])

                    -- stream:writeint(uinfo.foot[define.WG_KEY_A])
                    -- stream:writeint(uinfo.foot[define.WG_KEY_B])
                    -- stream:writeushort(uinfo.foot[define.WG_KEY_C])

                    -- stream:writeint(uinfo.unknow_7 or 100)
                    -- stream:writeint(uinfo.fasion_visual or 0)
                    -- stream:writeint(uinfo.unknow_9 or 0)
                    -- stream:writeint(uinfo.fashion[define.WG_KEY_A])
                    -- stream:writeint(uinfo.fashion[define.WG_KEY_D])
                    -- stream:writeint(uinfo.fashion[define.WG_KEY_E])
                    -- stream:writeint(uinfo.fashion[define.WG_KEY_F])
                    -- stream:writeushort(uinfo.fashion[define.WG_KEY_C])
					
                    -- stream:writeint(uinfo.unknow_7 or 100)
                    -- stream:writeint(uinfo.fasion_visual)
                    -- stream:writeint(uinfo.unknow_9 or 0)
                    -- stream:writeint(uinfo.fashion)
                    -- stream:writeint(uinfo.unknow_11 or -1)
                    -- stream:writeint(uinfo.unknow_12 or -1)
                    -- stream:writeint(uinfo.unknow_13 or -1)
                    -- stream:writeushort(uinfo.unknow_15 or 1744)
                -- end
            end
        end
        stream:writeuint(71147369)
        return stream:get()
    end 
}

packet.CGTeamRetInvite = {
    xy_id = packet.XYID_CG_TEAM_RET_INVITE,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGTeamRetInvite })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.list = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.return_type = stream:readuchar()
        self.guid = stream:readuint()
        self.unknow_3 = stream:readuint()
        for i = 1, 8 do
            self.list[i] = stream:readuint()
        end
    end
}

packet.CGAskTeamMemberInfo = {
    xy_id = packet.XYID_CG_ASK_TEAM_MEMBER_INFO,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGAskTeamMemberInfo })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readint()
        self.guid = stream:readint()
        self.sceneid = stream:readshort()
    end
}

packet.GCTeamMemberInfo = {
    xy_id = packet.XYID_GC_TEAM_MEMBER_INFO,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCTeamMemberInfo })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_19 = 0
        self.flag = 0
        self.data_index = 0
    end,
    set_menpai = function(self, menpai)
        self.menpai = menpai
        self.flag = menpai and self.flag | 0x1 or self.flag & ~0x1
    end,
    set_level = function(self, level)
        self.level = level
        self.flag = level and self.flag | 0x2 or self.flag & ~0x2
    end,
    set_world_pos = function(self, world_pos)
        self.world_pos = world_pos
        self.flag = world_pos and self.flag | 0x4 or self.flag & ~0x4
    end,
    set_hp = function(self, hp)
        self.hp = hp
        self.flag = hp and self.flag | 0x8 or self.flag & ~0x8
    end,
    set_hp_max = function(self, hp_max)
        self.hp_max = hp_max
        self.flag = hp_max and self.flag | 0x10 or self.flag & ~0x10
    end,
    set_mp = function(self, mp)
        self.mp = mp
        self.flag = mp and self.flag | 0x20 or self.flag & ~0x20
    end,
    set_mp_max = function(self, mp_max)
        self.mp_max = mp_max
        self.flag = mp_max and self.flag | 0x40 or self.flag & ~0x40
    end,
    set_rage = function(self, rage)
        self.rage = rage
        self.flag = rage and self.flag | 0x80 or self.flag & ~0x80
    end,
    set_weapon = function(self, weapon)
		if weapon then
			self.weapon = weapon
			self.flag = self.flag | 0x100
		else
			self.flag = self.flag & ~0x100
		end
    end,
    set_cap = function(self, cap)
		if cap then
			self.cap = cap
			self.flag = self.flag | 0x200
		else
			self.flag = self.flag & ~0x200
		end
    end,
    set_armour = function(self, armour)
		if armour then
			self.armour = armour
			self.flag = self.flag | 0x400
		else
			self.flag = self.flag & ~0x400
		end
    end,
    set_cuff = function(self, cuff)
		if cuff then
			self.cuff = cuff
			self.flag = self.flag | 0x800
		else
			self.flag = self.flag & ~0x800
		end
    end,
    set_foot = function(self, foot)
		if foot then
			self.foot = foot
			self.flag = self.flag | 0x1000
		else
			self.flag = self.flag & ~0x1000
		end
    end,
    set_fashion = function(self, fashion)
		if fashion then
			self.fashion = fashion
			self.flag = self.flag | 0x80000
		else
			self.flag = self.flag & ~0x80000
		end
    end,
    bis = function(self, buffer)
        -- local stream = bistream.new()
        -- stream:attach(buffer)
        -- self.guid = stream:readint()
        -- self.data_index = stream:readint()
        -- self.flag = stream:readuint()
        -- if self.flag & 0x1 == 0x1 then
            -- self.menpai = stream:readuint()
        -- end
        -- if self.flag & 0x2 == 0x2 then
            -- self.level = stream:readuint()
        -- end
        -- if self.flag & 0x4 == 0x4 then
            -- self.world_pos = {}
            -- self.world_pos.x = stream:readfloat()
            -- self.world_pos.y = stream:readfloat()
        -- end
        -- if self.flag & 0x8 == 0x8 then
            -- self.hp = stream:readuint()
        -- end
        -- if self.flag & 0x10 == 0x10 then
            -- self.hp_max = stream:readuint()
        -- end
        -- if self.flag & 0x20 == 0x20 then
            -- self.mp = stream:readuint()
        -- end
        -- if self.flag & 0x40 == 0x40 then
            -- self.mp_max = stream:readuint()
        -- end
        -- if self.flag & 0x80 == 0x80 then
            -- self.rage = stream:readuint()
        -- end
        -- if self.flag & 0x100 == 0x100 then
			-- self.weapon = {}
            -- self.weapon[define.WG_KEY_A] = stream:readint()
            -- self.weapon[define.WG_KEY_B] = stream:readint()
            -- self.weapon[define.WG_KEY_C] = stream:readushort()
        -- end
        -- if self.flag & 0x200 == 0x200 then
			-- self.cap = {}
            -- self.cap[define.WG_KEY_A] = stream:readint()
            -- self.cap[define.WG_KEY_B] = stream:readint()
            -- self.cap[define.WG_KEY_C] = stream:readushort()
        -- end
        -- if self.flag & 0x400 == 0x400 then
			-- self.armour = {}
            -- self.armour[define.WG_KEY_A] = stream:readint()
            -- self.armour[define.WG_KEY_B] = stream:readint()
            -- self.armour[define.WG_KEY_C] = stream:readushort()
        -- end
        -- if self.flag & 0x800 == 0x800 then
			-- self.cuff = {}
            -- self.cuff[define.WG_KEY_A] = stream:readint()
            -- self.cuff[define.WG_KEY_B] = stream:readint()
            -- self.cuff[define.WG_KEY_C] = stream:readushort()
        -- end
        -- if self.flag & 0x1000 == 0x1000 then
			-- self.foot = {}
            -- self.foot[define.WG_KEY_A] = stream:readint()
            -- self.foot[define.WG_KEY_B] = stream:readint()
            -- self.foot[define.WG_KEY_C] = stream:readushort()
        -- end
        -- if self.flag & 0x4000 == 0x4000 then
            -- self.strike_point = stream:readuchar()
        -- end
        -- if self.flag & 0x8000 == 0x8000 then
            -- self.unknow_10 = stream:readuchar()
        -- end
        -- if self.flag & 0x10000 == 0x10000 then
            -- self.unknow_11 = stream:readuint()
        -- end
        -- if self.flag & 0x20000 == 0x20000 then
            -- self.unknow_12 = stream:readuint()
        -- end
        -- if self.flag & 0x40000 == 0x40000 then
            -- self.unknow_13 = stream:readuint()
        -- end
        -- if self.flag & 0x80000 == 0x80000 then
			-- self.fashion = {}
            -- self.fashion[define.WG_KEY_A] = stream:readint()
            -- self.fashion[define.WG_KEY_D] = stream:readint()
            -- self.fashion[define.WG_KEY_E] = stream:readint()
            -- -- self.fashion[define.WG_KEY_F] = stream:readint()
            -- self.fashion[define.WG_KEY_C] = stream:readshort()
        -- end
        -- if self.flag & 0x100000 == 0x100000 then
            -- self.unknow_18 = stream:readuint()
        -- end
        -- self.unknow_19 = stream:readchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.guid)
        stream:writeuint(self.data_index)
        stream:writeint(self.flag)
        if self.flag & 0x1 == 0x1 then
            stream:writeint(self.menpai)
        end
        if self.flag & 0x2 == 0x2 then
            stream:writeint(self.level)
        end
        if self.flag & 0x4 == 0x4 then
            stream:writefloat(self.world_pos.x)
            stream:writefloat(self.world_pos.y)
        end
        if self.flag & 0x8 == 0x8 then
            stream:writeuint(self.hp)
        end
        if self.flag & 0x10 == 0x10 then
            stream:writeuint(self.hp_max)
        end
        if self.flag & 0x20 == 0x20 then
            stream:writeuint(self.mp)
        end
        if self.flag & 0x40 == 0x40 then
            stream:writeuint(self.mp_max)
        end
        if self.flag & 0x80 == 0x80 then
            stream:writeuint(self.rage)
        end
        if self.flag & 0x100 == 0x100 then
            stream:writeint(self.weapon[define.WG_KEY_A])
            stream:writeint(self.weapon[define.WG_KEY_B])
            stream:writeshort(self.weapon[define.WG_KEY_C])
        end
        if self.flag & 0x200 == 0x200 then
            stream:writeint(self.cap[define.WG_KEY_A])
            stream:writeint(self.cap[define.WG_KEY_B])
            stream:writeshort(self.cap[define.WG_KEY_C])
        end
        if self.flag & 0x400 == 0x400 then
            stream:writeint(self.armour[define.WG_KEY_A])
            stream:writeint(self.armour[define.WG_KEY_B])
            stream:writeshort(self.armour[define.WG_KEY_C])
        end
        if self.flag & 0x800 == 0x800 then
            stream:writeint(self.cuff[define.WG_KEY_A])
            stream:writeint(self.cuff[define.WG_KEY_B])
            stream:writeshort(self.cuff[define.WG_KEY_C])
        end
        if self.flag & 0x1000 == 0x1000 then
            stream:writeint(self.foot[define.WG_KEY_A])
            stream:writeint(self.foot[define.WG_KEY_B])
            stream:writeshort(self.foot[define.WG_KEY_C])
        end
        if self.flag & 0x4000 == 0x4000 then
            stream:writeuchar(self.strike_point)
        end
        if self.flag & 0x8000 == 0x8000 then
            stream:writeuchar(self.unknow_10)
        end
        if self.flag & 0x10000 == 0x10000 then
            stream:writeuint(self.unknow_11)
        end
        if self.flag & 0x20000 == 0x20000 then
            stream:writeuint(self.unknow_12)
        end
        if self.flag & 0x40000 == 0x40000 then
            stream:writeuint(self.unknow_13)
        end
        if self.flag & 0x80000 == 0x80000 then
            stream:writeint(self.fashion[define.WG_KEY_A])
            stream:writeint(self.fashion[define.WG_KEY_D])
            stream:writeint(self.fashion[define.WG_KEY_E])
            stream:writeint(self.fashion[define.WG_KEY_F])
            stream:writeshort(self.fashion[define.WG_KEY_C])
        end
        if self.flag & 0x100000 == 0x100000 then
            stream:writeuint(self.unknow_18)
        end
        stream:writeuchar(self.unknow_19)
        return stream:get()
    end
}

packet.CGTeamLeave = {
    xy_id = packet.XYID_CG_TEAM_LEAVE,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGTeamLeave })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.guid = stream:readint()
    end
}

packet.GCBankBegin = {
    xy_id = packet.XYID_GC_BANK_BEGIN,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCBankBegin })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.flag = 1
        self.unknow = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.flag = stream:readuchar()
        self.npc = stream:readint()
        self.unknow = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.flag)
        stream:writeint(self.npc)
        stream:writeuchar(self.unknow)
        return stream:get()
    end
}

packet.CGBankAcquireList = {
    xy_id = packet.XYID_CG_BANK_ACQUIRE_LIST,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGBankAcquireList })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.flag = stream:readuchar()
    end
}

packet.GCBankAcquireList = {
    xy_id = packet.XYID_GC_BANK_ACQUIRE_LIST,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCBankAcquireList })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.bank_items = {}
        self.unknow_4 = 1
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.used_space = stream:readchar()
        self.all_space = stream:readchar()
        self.save_money = stream:readuint()
        self.unknow_4 = stream:readchar()
        for i = 1, self.used_space do
            local bank_item = {}
            bank_item.bag_index = stream:readuchar()
            bank_item.unknow_2 = stream:readuchar() -- 1
            bank_item.count = stream:readuchar()
            if bank_item.unknow_2 ~= 0 then
                bank_item.item = packet.ItemInfo.new()
                bank_item.item:bis(stream)
            else
                bank_item.unknow_4 = stream:readint()
            end
            self.bank_items[i] = bank_item
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.used_space)
        stream:writeuchar(self.all_space)
        stream:writeint(self.save_money)
        stream:writechar(self.unknow_4)
        for i = 1, self.used_space do
            local bank_item = self.bank_items[i]
            if bank_item then
                stream:writeuchar(bank_item.bag_index)
                stream:writechar(bank_item.unknow_2)
                stream:writeuchar(bank_item.count)
                if bank_item.unknow_2 ~= 0 then
                    packet.ItemInfo.bos(bank_item.item, stream)
                else
                    stream:writeint(bank_item.unknow_4)
                end
            end
        end
        return stream:get()
    end
}

packet.GCBankItemInfo = {
    xy_id = packet.XYID_GC_BANK_INFO,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCBankItemInfo })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.bank_items = {}
        self.unknow_3 = 0
        self.unknow_4 = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readshort()
        self.unknow_2 = stream:readint()
        self.item = packet.ItemInfo.new()
        self.item:bis(stream)
    end,
}

packet.CGBankSwapItem = {
    xy_id = packet.XYID_CG_BANK_SWAP_ITEM,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGBankSwapItem })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.from_bag = stream:readuchar()
        self.to_bag = stream:readuchar()
        self.from_index = stream:readuchar()
        self.to_index = stream:readuchar()
    end
}

packet.GCBankSwapItem = {
    xy_id = packet.XYID_GC_BANK_SWAP_ITEM,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCBankSwapItem })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.from_bag = stream:readuchar()
        self.to_bag = stream:readuchar()
        self.from_index = stream:readuchar()
        self.to_index = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.from_bag)
        stream:writeuchar(self.to_bag)
        stream:writeuchar(self.from_index)
        stream:writeuchar(self.to_index)
        return stream:get()
    end
}

packet.CGBankAddItem = {
    xy_id = packet.XYID_CG_BANK_ADD_ITEM,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGBankAddItem })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.from_bag = stream:readuchar()
        self.from_index = stream:readuchar()
        self.to_index = stream:readuchar()
    end
}

packet.GCBankAddItem = {
    xy_id = packet.XYID_GC_BANK_ADD_ITEM,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCBankAddItem })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.from_bag = stream:readuchar()
        self.from_index = stream:readuchar()
        self.to_index = stream:readuchar()
        self.result = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.from_bag)
        stream:writeuchar(self.from_index)
        stream:writeuchar(self.to_index)
        stream:writeuchar(self.result)
        return stream:get()
    end
}

packet.CGBankRemoveItem = {
    xy_id = packet.XYID_CG_BANK_REMOVE_ITEM,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGBankRemoveItem })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.to_bag = stream:readuchar()
        self.from_index = stream:readuchar()
        self.to_index = stream:readuchar()
    end
}

packet.GCBankRemoveItem = {
    xy_id = packet.XYID_GC_BANK_REMOVE_ITEM,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCBankRemoveItem })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.to_bag = stream:readuchar()
        self.from_index = stream:readuchar()
        self.to_index = stream:readchar()
        self.result = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.to_bag)
        stream:writeuchar(self.from_index)
        stream:writeuchar(self.to_index)
        stream:writeuchar(self.result)
        return stream:get()
    end
}

packet.CGPackUpBank = {
    xy_id = packet.XYID_CG_PACK_UP_BANK,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGPackUpBank })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.froms = {}
        self.tos = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readushort()
        self.size = stream:readshort()
        for i = 1, self.size do
            self.froms[i] = stream:readushort()    
        end
        for i = 1, self.size do
            self.tos[i] = stream:readushort()    
        end
    end
}

packet.GCPackUpBank = {
    xy_id = packet.XYID_GC_PACK_UP_BANK,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPackUpBank })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.unknow_1)
        return stream:get()
    end
}

packet.GCPlayerDie = {
    xy_id = packet.XYID_GC_PlAYER_DIE,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPlayerDie })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.new_player = stream:readuint()
        self.can_relive = stream:readuint()
        self.utime = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.new_player)
        stream:writeuint(self.can_relive)
        stream:writeint(0)
        stream:writeuint(self.utime)
        return stream:get()
    end
}

packet.CGPlayerDieResult = {
    xy_id = packet.XYID_CG_PlAYER_DIE_RESULT,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGPlayerDieResult })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.code = stream:readuint()
    end
}

packet.GCPlayerRelive = {
    xy_id = packet.XYID_GC_PlAYER_RELIVE,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPlayerRelive })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        return stream:get()
    end
}

packet.CGPetBankAddPet = {
    xy_id = packet.XYID_CG_PET_BANK_ADD_PET,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGPetBankAddPet })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.type = stream:readuchar()
        self.pet_guid_from = packet.PetGUID.new()
        self.pet_guid_from:bis(stream)
        self.pet_guid_to = packet.PetGUID.new()
        self.pet_guid_to:bis(stream)
    end
}

packet.GCPetBankAddPet = {
    xy_id = packet.XYID_GC_PET_BANK_ADD_PET,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPetBankAddPet })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.pet_guid_from = packet.PetGUID.new()
        self.pet_guid_from:bis(stream)
        self.pet_guid_to = packet.PetGUID.new()
        self.pet_guid_to:bis(stream)
        self.type = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        packet.PetGUID.bos(self.pet_guid_from, stream)
        packet.PetGUID.bos(self.pet_guid_to, stream)
        stream:writeuchar(self.type)
        return stream:get()
    end
}

packet.GCPetBankListUPData = {
    xy_id = packet.XYID_GC_PET_BANK_LIST_UPDATA,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPetBankListUPData })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.pet_list = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.flag = stream:readushort()
        for i = 1, 10 do
            local bit = 0x1 << (i - 1)
            if (bit & self.flag) == bit then
                self.pet_list[i] = packet.GCDetailAttrib_Pet.new()
                self.pet_list[i]:bis(stream:get())
            end
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        local flag = 0
        for i = 1, 10 do
            if self.pet_list[i] then
                local bit = 0x1 << (i - 1)
                flag = flag + bit
            end
        end
        stream:writeushort(flag)
        for i = 1, 10 do
            local pet_data = self.pet_list[i]
            if pet_data then
                local len = string.len(pet_data)
                stream:write(pet_data, len)
            end
        end
        return stream:get()
    end
}

packet.CommisionShop = {
    xy_id = define.INVAILD_ID,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CommisionShop })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.merchadise_list = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        local size = stream:readuchar()
        self.grade = stream:readuchar()
        self.target_id = stream:readint()
        for i = 1, size do
            local merchadise = {}
            merchadise.serial = stream:readuint()
            merchadise.type = stream:readuchar()
            merchadise.name = stream:readuint()
            merchadise.price = stream:readuint()
            merchadise.unknow_2 = stream:readuint()
            table.insert(self.merchadise_list, merchadise)
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        local size = 0
        for i = 1, 20 do
            i = tostring(i)
            local merchadise = self.merchadise_list[i]
            if merchadise then
                size = size + 1
            end
        end
        stream:writeuchar(size)
        stream:writeuchar(self.grade)
        stream:writeint(self.target_id)
        for i = 1, 20 do
            i = tostring(i)
            local merchadise = self.merchadise_list[i]
            if merchadise then
                stream:writeuint(merchadise.serial)
                stream:writeuchar(0)
                stream:writeuint(merchadise.name)
                stream:writeuint(merchadise.price)
                stream:writeuint(merchadise.unknow_2 or 0)
            end
        end
        return stream:get()
    end
}

packet.GCPacketStream = {
    xy_id = packet.XYID_GC_PACKET_STREAM,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPacketStream })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.args = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.size = stream:readshort()
        self.id = stream:readshort()
        if self.size > 0 then
            for i = 1, self.size do
                self.args[i] = stream:readuchar()
            end
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        if type(self.args) == "table" then
            local size = #self.args
            stream:writeshort(size)
            stream:writeshort(self.id)
            if size > 0 then
                for i = 1, size do
                    stream:writeuchar(self.args[i])
                end
            end
        else
            local size = string.len(self.args)
            stream:writeshort(size)
            stream:writeshort(self.id)
            if size > 0 then
                stream:write(self.args, size)
            end
        end
        return stream:get()
    end
}

packet.CGShopSell = {
    xy_id = packet.XYID_CG_SHOP_SELL,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGShopSell })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.bag_index = stream:readuchar()
        self.unknow_2 = stream:readuint()
        self.unknow_3 = stream:readuchar()
    end
}

packet.GCShopSell = {
    xy_id = packet.XYID_GC_SHOP_SELL,
    SELL_RESULT = {
        SELL_OK = 0,
        SELL_FAIL = 1
    },
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCShopSell })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.result = stream:readchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writechar(self.result)
        return stream:get()
    end
}

packet.CGReqManualAttr = {
    xy_id = packet.XYID_CG_REQ_MANUAL_ATTR,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGReqManualAttr })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.str = stream:readint()
        self.spr = stream:readint()
        self.con = stream:readint()
        self.int = stream:readint()
        self.dex = stream:readint()
    end
}

packet.GCManualAttrResult = {
    xy_id = packet.XYID_GC_MANUAL_ATTR_RESULT,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCManualAttrResult })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.result = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.result)
        return stream:get()
    end
}

packet.GCCharFly = {
    xy_id = packet.XYID_GC_CHAR_FLY,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCCharFly })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.from = {}
        self.to = {}
        self.unknow_4 = 0
        self.unknow_5 = 4
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readint()
        self.logic_count = stream:readint()
        self.skill_id = stream:readint()
        self.from.x = stream:readfloat()
        self.from.y = stream:readfloat()
        self.to.x = stream:readfloat()
        self.to.y = stream:readfloat()
        self.to.x = stream:readfloat()
        self.to.y = stream:readfloat()
        self.unknow_4 = stream:readint()
        self.unknow_5 = stream:readfloat()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.m_objID)
        stream:writeint(self.logic_count)
        stream:writeint(self.skill_id)
        stream:writefloat(self.from.x)
        stream:writefloat(self.from.y)
        stream:writefloat(self.to.x)
        stream:writefloat(self.to.y)
        stream:writefloat(self.to.x)
        stream:writefloat(self.to.y)
        stream:writeint(self.unknow_4)
        stream:writefloat(self.unknow_5)
        return stream:get()
    end
}

packet.CGFashionDepotOperation = {
    xy_id = packet.XYID_CG_FASHION_DEPOT_OPERATION,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGFashionDepotOperation })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.dest_container = stream:readuchar()
        self.from_index = stream:readuint()
        self.dest_index = stream:readint()
    end,
}

packet.CGManipulatePet = {
    xy_id = packet.XYID_CG_MANIPULATE_PET,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGManipulatePet })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readuint()
        self.pet_guid = packet.PetGUID.new()
        self.pet_guid:bis(stream)
        self.type = stream:readint()
    end
}

packet.GCManipulatePetRet = {
    xy_id = packet.XYID_GC_MANIPULATE_PET_RET,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCManipulatePetRet })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.is_fighting = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.guid = packet.PetGUID.new()
        self.guid:bis(stream)
        self.is_fighting = stream:readuint()
        self.ret = stream:readint()
    end,
    bos = function(self)
        local stream = bostream.new()
        packet.PetGUID.bos(self.guid, stream)
        stream:writeuint(self.is_fighting)
        stream:writeint(self.ret)
        return stream:get()
    end
}

packet.CGSetPetAttrib = {
    xy_id = packet.XYID_CG_SET_PET_ATTRIB,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGSetPetAttrib })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_Flags = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.guid = packet.PetGUID.new()
        self.guid:bis(stream)
        for i = 1, 2 do
            self.m_Flags[i] = stream:readuchar()
        end
        if self.m_Flags[1] & 0x1 == 0x1 then
            local len = stream:readuchar()
            if len > 0x1E then
                len = 0x1E
            end
            self.name = gbk.toutf8(stream:read(len))
        end
        if self.m_Flags[1] & 0x2 == 0x2 then
            self.str_increment = stream:readuint()
        end
        if self.m_Flags[1] & 0x4 == 0x4 then
            self.con_increment = stream:readuint()
        end
        if self.m_Flags[1] & 0x8 == 0x8 then
            self.dex_increment = stream:readuint()
        end
        if self.m_Flags[1] & 0x10 == 0x10 then
            self.spr_increment = stream:readuint()
        end
        if self.m_Flags[1] & 0x20 == 0x20 then
            self.int_increment = stream:readuint()
        end
        if self.m_Flags[1] & 0x40 == 0x40 then
            self.current_title = stream:readint()
        end
    end
}

packet.GCRemovePet = {
    xy_id = packet.XYID_GC_REMOVE_PET,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCRemovePet })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.guid = packet.PetGUID.new()
        self.guid:bis(stream)
    end,
    bos = function(self)
        local stream = bostream.new()
        packet.PetGUID.bos(self.guid, stream)
        return stream:get()
    end 
}

packet.GCDarkResult = {
    xy_id = packet.XYID_GC_DARK_RESULT,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCDarkResult })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readuchar()
        self.unknow_2 = stream:readushort()
        if self.unknow_1 == 0 then
            self.unknow_3 = stream:readuchar()
        elseif self.unknow_1 == 3 then
            self.unknow_4 = stream:readuchar()
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writechar(self.unknow_1)
        stream:writeshort(self.unknow_2)
        if self.unknow_1 == 0 then
            stream:writechar(self.unknow_3)
        elseif self.unknow_1 == 3 then
            stream:writechar(self.unknow_4)
        end
        return stream:get()
    end
}

packet.GCRefreshDarkSkill = {
    xy_id = packet.XYID_GC_REFRESH_DARK_SKILL,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCRefreshDarkSkill })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.skills = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.bag_pos = stream:readuint()
        self.skills = {}
        for i = 1, 3 do
            self.skills[i] = stream:readushort()
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.bag_pos)
        for i = 1, 3 do
            stream:writeushort(self.skills[i])
        end
        return stream:get()
    end
}

packet.CGAskDarkAdjust = {
    xy_id = packet.XYID_CG_ASK_DARK_ADJUST,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGAskDarkAdjust })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.bag_index = stream:readuint()
        self.type = stream:readuint()
        if self.type == 0 then
            self.unknow_1 = stream:readuint()
        elseif self.type == 3 then
            self.unknow_2 = stream:readuint()
        end
        self.unknow_3 = stream:readuchar()
    end
}

packet.CGPetUseEquip = {
    xy_id = packet.XYID_CG_PET_USE_EQUIP,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGPetUseEquip })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.from = stream:readuchar()
        self.to = stream:readuchar()
        self.pet_guid = packet.PetGUID.new()
        self.pet_guid:bis(stream)
    end
}

packet.GCPetUseEquipResult = {
    xy_id = packet.XYID_GC_PET_USE_EQUIP_RESULT,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPetUseEquipResult })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.pet_guid = packet.PetGUID.new()
        self.pet_guid:bis(stream)
        self.result = stream:readuchar()
        self.equip_point = stream:readuchar()
        self.bag_index = stream:readuchar()
        self.equip_guid = packet.ItemGUID.new()
        self.equip_guid:bis(stream)
        self.item_guid = packet.ItemGUID.new()
        self.item_guid:bis(stream)
    end,
    bos = function(self)
        local stream = bostream.new()
        packet.PetGUID.bos(self.pet_guid, stream)
        stream:writeuchar(self.result)
        stream:writeuchar(self.equip_point)
        stream:writeuchar(self.bag_index)
        packet.ItemGUID.bos(self.equip_guid, stream)
        packet.ItemGUID.bos(self.item_guid, stream)
        return stream:get()
    end
}

packet.CGPetUnEquip = {
    xy_id = packet.XYID_CG_PET_UN_EQUIP,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGPetUnEquip })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.pet_guid = packet.PetGUID.new()
        self.pet_guid:bis(stream)
        self.from = stream:readchar()
        self.to = stream:readchar()
    end
}

packet.GCPetUnEquipResult = {
    xy_id = packet.XYID_GC_PET_UN_EQUIP_RESULT,
    new = function(o)
        o = o or {}
        setmetatable(o, {__index = packet.GCPetUnEquipResult})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.pet_guid = packet.PetGUID.new()
        self.pet_guid:bis(stream)
        self.equip_point = stream:readuchar()
        self.bag_index = stream:readuchar()
        self.item_index = stream:readuint()
        self.item_guid = packet.ItemGUID.new()
        self.item_guid:bis(stream)
        self.result = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        local stream = bostream.new()
        packet.PetGUID.bos(self.pet_guid, stream)
        stream:writeuchar(self.equip_point)
        stream:writeuchar(self.bag_index)
        stream:writeuint(self.item_index)
        packet.ItemGUID.bos(self.item_guid, stream)
        stream:writeuchar(self.result)
        return stream:get()
    end
}

packet.CGMissionSubmit = {
    xy_id = packet.XYID_CG_MISSION_SUBMIT,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGMissionSubmit })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.npc_id = stream:readint()
        self.script_id = stream:readint()
        self.select_radio_id = stream:readint()
        self.unknow_4 = stream:readint()
    end
}

packet.GCComboSkillOperation = {
    xy_id = packet.XYID_GC_COMB_SKILL_OPERATION,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCComboSkillOperation })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_3 = 0
        self.combo_list = { 0, 0, 0, 0, 0 }
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.cur_comb = stream:readint()
        self.skill_id = stream:readint()
        self.unknow_3 = stream:readint()
        self.tempnum = stream:readint()
        self.combo_list = {}
        for i = 1, 5 do
            self.combo_list[i] = stream:readuint()
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.cur_comb)
        stream:writeint(self.skill_id)
        stream:writeint(self.unknow_3)
        stream:writeint(self.tempnum)
        for i = 1, 5 do
            stream:writeuint(self.combo_list[i])
        end
        return stream:get()
    end
}

packet.GCSpecialObj_ActNow = {
    xy_id = packet.XYID_GC_SPECIAL_OBJ_ACT_NOW,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCSpecialObj_ActNow })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.obj_list = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readint()
        self.logic_count = stream:readint()
        self.obj_count = stream:readint()
        if self.obj_count > 512 then
            self.obj_count = 512
        end
        for i = 1, self.obj_count do
            self.obj_list[i] = stream:readint()
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.m_objID)
        stream:writeint(self.logic_count)
        stream:writeint(self.obj_count)
        for i = 1, self.obj_count do
            stream:writeint(self.obj_list[i])
        end
        return stream:get()
    end
}

packet.GCNewSpecial = {
    xy_id = packet.XYID_GC_NEW_SPECIAL,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCNewSpecial })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.world_pos = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readint()
        self.world_pos.x = stream:readfloat()
        self.world_pos.y = stream:readfloat()
        self.dir = stream:readfloat()
        self.data_id = stream:readint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.m_objID)
        stream:writefloat(self.world_pos.x)
        stream:writefloat(self.world_pos.y)
        stream:writefloat(self.dir)
        stream:writeint(self.data_id)
        return stream:get()
    end
}

packet.GCSpecialObj_FadeOut = {
    xy_id = packet.XYID_GC_SPECIAL_OBJ_FADE_OUT,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCSpecialObj_FadeOut })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.m_objID)
        return stream:get()
    end
}

packet.GCCharJump = {
    xy_id = packet.XYID_GC_CHAR_JUMP,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCCharJump })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.m_objID)
        return stream:get()
    end
}

packet.CGKfsOperate = {
    xy_id = packet.XYID_CG_KFS_OPERATE,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGKfsOperate })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.operate = stream:readint()
        self.arg_1 = stream:readuchar()
        self.arg_2 = stream:readuchar()
        self.arg_3 = stream:readchar()
    end 
}

packet.GCRefreshKFSSkill = {
    xy_id = packet.XYID_GC_REFRESH_KFS_SKILL,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCRefreshKFSSkill })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.skills = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.bag_index = stream:readuint()
        for i = 1, 3 do
            self.skills[i] = stream:readshort()
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.bag_index)
        for i = 1, 3 do
            stream:writeshort(self.skills[i])
        end
        return stream:get()
    end
}

packet.CGAskPrivateInfo = {
    xy_id = packet.XYID_CG_ASK_PRIVATE_INFO,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGAskPrivateInfo })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readint()
    end, 
}

packet.GCPrivateInfo = {
    xy_id = packet.XYID_GC_PRIVATE_INFO,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPrivateInfo })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = 0
        self.unknow_10 = 0
        self.unknow_11 = 0
        self.unknow_12 = 0
        self.unknow_13 = 0
        self.unknow_15 = 0
        self.unknow_2 = 0
        self.unknow_21 = 0
        self.unknow_22 = 0
        self.unknow_4 = 0
        self.unknow_5 = 0
        self.unknow_6 = 0
        self.unknow_7 = 0
        self.unknow_8 = 0
        self.unknow_9 = 0
        self.unkow_16 = ""
        self.unkow_17 = ""
        self.unkow_18 = ""
        self.unkow_19 = ""
        self.unkow_20 = gbk.fromutf8("这家伙很懒，什么都没写啊。")
        self.unknow_14 = string.len(self.unkow_20)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readchar()
        self.unknow_2 = stream:readchar()
        self.guid = stream:readint()
        self.unknow_4 = stream:readchar()
        self.unknow_5 = stream:readchar()
        self.unknow_6 = stream:readchar()
        self.unknow_7 = stream:readchar()
        self.unknow_8 = stream:readchar()
        self.unknow_9 = stream:readchar()
        self.unknow_10 = stream:readchar()
        self.unknow_11 = stream:readchar()
        self.unknow_12 = stream:readchar()
        self.unknow_13 = stream:readchar()
        self.unknow_14 = stream:readchar()
        self.unknow_15 = stream:readchar()
        if self.unknow_10 <= 0x32 then
            self.unkow_16 = stream:read(self.unknow_10)
        end
        if self.unknow_11 <= 0x32 then
            self.unkow_17 = stream:read(self.unknow_11)
        end
        if self.unknow_12 <= 0x10 then
            self.unkow_18 = stream:read(self.unknow_12)
        end
        if self.unknow_13 <= 0x32 then
            self.unkow_19 = stream:read(self.unknow_13)
        end
        if self.unknow_14 <= 0x22 then
            self.unkow_20 = stream:read(self.unknow_14)
        end
        self.unknow_21 = stream:readint()
        self.unknow_22 = stream:readint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writechar(self.unknow_1)
        stream:writechar(self.unknow_2)
        stream:writeint(self.guid)
        stream:writechar(self.unknow_4)
        stream:writechar(self.unknow_5)
        stream:writechar(self.unknow_6)
        stream:writechar(self.unknow_7)
        stream:writechar(self.unknow_8)
        stream:writechar(self.unknow_9)
        stream:writechar(self.unknow_10)
        stream:writechar(self.unknow_11)
        stream:writechar(self.unknow_12)
        stream:writechar(self.unknow_13)
        stream:writechar(self.unknow_14)
        stream:writechar(self.unknow_15)
        if self.unknow_10 <= 0x32 then
            stream:write(self.unkow_16, self.unknow_10)
        end
        if self.unknow_11 <= 0x32 then
            stream:write(self.unkow_17, self.unknow_11)
        end
        if self.unknow_12 <= 0x10 then
            stream:write(self.unkow_18, self.unknow_12)
        end
        if self.unknow_13 <= 0x32 then
            stream:write(self.unkow_19, self.unknow_13)
        end
        if self.unknow_14 <= 0x22 then
            stream:write(self.unkow_20, self.unknow_14)
        end
        stream:writeuint(self.unknow_21)
        stream:writeuint(self.unknow_22)

        return stream:get()
    end
}

packet.CGFinger = {
    xy_id = packet.XYID_CG_FINGER,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGFinger })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.type = stream:readuchar()
        if self.type == 1 then
            self.finger_by_guid = {}
            self.finger_by_guid.target_guid = stream:readuint()
            self.finger_by_guid.online_flag = stream:readchar()
        elseif self.type == 2 then
            self.finger_by_name = {}
            local len = stream:readchar()
            self.finger_by_name.name = gbk.toutf8(stream:read(len))
            self.finger_by_name.online_flag = stream:readchar()
            self.finger_by_name.precise_flag = stream:readchar()
            self.finger_by_name.position = stream:readuint()
        elseif self.type == 3 then
            self.advanced_finger = {}
            self.advanced_finger.flag = stream:readchar()
            self.advanced_finger.position = stream:readint()
            if self.advanced_finger.flag & 0x1 == 0x1 then
                self.advanced_finger.menpai = stream:readint()
            end
            if self.advanced_finger.flag & 0x2 == 0x2 then
                self.advanced_finger.guild = stream:readshort()
            end
            if self.advanced_finger.flag & 0x4 == 0x4 then
                self.advanced_finger.sex = stream:readchar()
            end
            if self.advanced_finger.flag & 0x8 == 0x8 then
                self.advanced_finger.bottom_level = stream:readushort()
                self.advanced_finger.top_level = stream:readushort()
            end
        else
            assert(false)
        end
    end, 
}

packet.GCFinger = {
    xy_id = packet.XYID_GC_FINGER,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCFinger })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.users = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.flag = stream:readuchar()
        if self.flag == 1 then
            self.size = stream:readuchar()
            if self.size <= 10 then
                for i = 1, self.size do
                    local user = {}
                    user.guid = stream:readuint()
                    local len = stream:readuchar()
                    user.name = stream:read(len)
                    user.online_flag = stream:readuchar()
                    user.level = stream:readuint()
                    user.sex = stream:readuchar()
                    user.menpai = stream:readuint()
                    user.guild = stream:readshort()
                    local guid_len = stream:readuchar()
                    user.confederate = stream:readshort()
                    local confederate_len = stream:readuchar()
                    if guid_len > 0 and guid_len < 0x18 then
                        user.guild_name = stream:read(guid_len)
                    end
                    if confederate_len > 0 and confederate_len < 0x20 then
                        user.confederate_name = stream:read(confederate_len)
                    end
                    user.portrait_id = stream:readuint()
                    table.insert(self.users, user)
                end
            end
            self.finger_flag = stream:readuchar()
            self.position = stream:readuint()
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.flag)
        if self.flag == 1 then
            stream:writeuchar(self.size)
            if self.size <= 10 then
                for i = 1, self.size do
                    local user = self.users[i]
                    stream:writeuint(user.guid)
                    user.name = gbk.fromutf8(user.name)
                    user.guid_name = gbk.fromutf8(user.guild_name)
                    user.confederate_name = gbk.fromutf8(user.confederate_name)
                    local len = string.len(user.name)
                    local guild_len = string.len(user.name)
                    local confederate_len = string.len(user.name)
                    stream:writeuchar(len)
                    stream:write(user.name, len)
                    stream:writeuchar(user.online_flag)
                    stream:writeuint(user.level)
                    stream:writeuchar(user.model)
                    stream:writeuint(user.menpai)
                    stream:writeshort(user.guild)
                    stream:writeuchar(guild_len)
                    stream:writeshort(user.confederate)
                    stream:writeuchar(confederate_len)
                    if guild_len > 0 and guild_len < 0x18 then
                        stream:write(user.guild_name, guild_len)
                    end
                    if confederate_len > 0 and confederate_len < 0x20 then
                        stream:write(user.confederate_name, confederate_len)
                    end
                    stream:writeuint(user.portrait_id)
                end
            end
            stream:writeuchar(self.finger_flag)
            stream:writeuint(self.position)
        end
        return stream:get()
    end
}

packet.GCPetSoulXiShuXing = {
    xy_id = packet.XYID_GC_PET_SOUL_XI_SHU_XING,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPetSoulXiShuXing })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.shuxings = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.result = stream:readuint()
        for i = 1, 6 do
            local shuxing = {}
            self.shuxings[i] = shuxing
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.result)
        for i = 1, 6 do
            local shuxing = self.shuxings[i]
            stream:writeint(shuxing.type)
            stream:writeint(shuxing.value)
        end
        return stream:get()
    end
}

packet.CGPetSoulXiShuXing = {
    xy_id = packet.XYID_CG_PET_SOUL_XI_SHU_XING,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGPetSoulXiShuXing })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.shuxings = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.type = stream:readuint()
        self.bag_index = stream:readuint()
        for i = 1, 6 do
            local shuxing = {}
            shuxing.type = stream:readuint()
            shuxing.value = stream:readuint()
            self.shuxings[i] = shuxing
        end
    end
}

packet.CGLookUpOther = {
    xy_id = packet.XYID_CG_LOOK_UP_OTHER,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGLookUpOther })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.name = stream:read(0x1E)
        self.name = gbk.toutf8(self.name)
        self.name = string.match(self.name, "([^\0]+)")
    end
}

packet.GCLookUpOther = {
    xy_id = packet.XYID_GC_LOOK_UP_OTHER,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCLookUpOther })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writechar(self.unknow_1 or 0)
        stream:writeint(self.guid)
        self.name = gbk.fromutf8(self.name)
        stream:writeuchar(#self.name)
        if #self.name > 0 and #self.name < 0x1E then
            stream:write(self.name, #self.name)
        end
        stream:writeuint(self.level)
        stream:writeuint(self.menpai)
        stream:writeuint(self.portrait)
        stream:writeshort(self.guild)
        self.guild_name = gbk.fromutf8(self.guild_name)
        self.confederate_name = gbk.fromutf8(self.confederate_name)
        stream:writeuchar(#self.guild_name)
        stream:writeshort(self.confederate)
        stream:writeuchar(#self.confederate_name)
        if #self.guild_name > 0 and #self.guild_name < 0x18 then
            stream:write(self.guild_name, #self.guild_name)
        end
        if #self.confederate_name > 0 and #self.confederate_name < 0x20 then
            stream:write(self.confederate_name, #self.confederate_name)
        end
        self.mood = gbk.fromutf8(self.mood)
        stream:writeuchar(#self.mood)
        if #self.mood > 0 and #self.mood < 0x20 then
            stream:write(self.mood, #self.mood)
        end
        self.title = gbk.fromutf8(self.title)
        stream:writeuchar(#self.title)
        if #self.title > 0 and #self.title < 0x20 then
            stream:write(self.title, #self.title)
        end
        stream:writeshort(self.sceneid)
        stream:writeuchar(self.team_size)
        stream:writefloat(self.world_pos.x)
        stream:writefloat(self.world_pos.y)
        stream:writechar(self.unknow_2 or 0)
		--250324调整
		stream:writeuint(0)
        return stream:get()
    end
}

packet.GCCharCharge = {
    xy_id = packet.XYID_GC_CHAR_CHARGE,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCCharCharge })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.m_objID)
        stream:writeint(self.logic_count)
        stream:writefloat(self.from.x)
        stream:writefloat(self.from.y)
        stream:writefloat(self.to.x)
        stream:writefloat(self.to.y)
        stream:writeint(self.unknow or 1)
        stream:writeint(self.nSkillId or 0)
        return stream:get()
    end
}

packet.CGChallenge = {
    xy_id = packet.XYID_CG_CHALLENGE,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGChallenge })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.type = stream:readuchar()
        self.m_objID = stream:readint()
    end,
}

packet.GCGameCommond = {
    xy_id = packet.XYID_GC_GAME_COMMOND,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCGameCommond })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.type = 4
        self.is_end = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.is_end = stream:readint()
        self.type = stream:readint()
        if self.type > 0 and self.type < 0x100 then
            self.effect = stream:readint()
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.is_end)
        stream:writeint(self.type)
        if self.type > 0 and self.type < 0x100 then
            stream:writeint(self.effect)
        end
        return stream:get()
    end
}

packet.CGStallApply = {
    xy_id = packet.XYID_CG_STALL_APPLY,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGStallApply })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end
}

packet.GCStallApply = {
    xy_id = packet.XYID_GC_STALL_APPLY,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCStallApply })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.is_yuanbao_stall = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.is_can_stall = stream:readchar()
        self.pos_tax = stream:readint()
        self.trade_tax = stream:readchar()
        self.is_yuanbao_stall = stream:readchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writechar(self.is_can_stall)
        stream:writeint(self.pos_tax)
        stream:writechar(self.trade_tax)
        stream:writechar(self.is_yuanbao_stall)
        return stream:get()
    end
}

packet.CGStallEstablish = {
    xy_id = packet.XYID_CG_STALL_ESTABLISH,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGStallEstablish })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end
}

packet.GCStallEstablish = {
    xy_id = packet.XYID_GC_STALL_ESTABLISH,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCStallEstablish })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        return stream:get()
    end
}

packet.CGStallOpen = {
    xy_id = packet.XYID_CG_STALL_OPEN,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGStallOpen })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readint()
    end
}

packet.CGStallAddItem = {
    xy_id = packet.XYID_CG_STALL_ADD_ITEM,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGStallAddItem })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.item_guid = packet.ItemGUID.new()
        self.item_guid:bis(stream)
        self.pet_guid = packet.PetGUID.new()
        self.pet_guid:bis(stream)
        self.price = stream:readuint()
        self.from_type = stream:readuchar()
    end
}

packet.GCStallAddItem = {
    xy_id = packet.XYID_GC_STALL_ADD_ITEM,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCStallAddItem })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.from_type = 0
        self.item_guid = packet.ItemGUID.new()
        self.pet_guid = packet.PetGUID.new()
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.item_guid = packet.ItemGUID.new()
        self.item_guid:bis(stream)
        self.pet_guid = packet.PetGUID.new()
        self.pet_guid:bis(stream)
        self.price = stream:readuint()
        self.serial = stream:readuint()
        self.to_index = stream:readuchar()
        self.from_type = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        packet.ItemGUID.bos(self.item_guid, stream)
        packet.PetGUID.bos(self.pet_guid, stream)
        stream:writeuint(self.price)
        stream:writeuint(self.serial)
        stream:writeuchar(self.to_index)
        stream:writeuchar(self.from_type)
        return stream:get()
    end
}

packet.GCStallOpen = {
    xy_id = packet.XYID_GC_STALL_OPEN,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCStallOpen })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.m_StallItemList = {}
        self.unknow = 0
    end,
    bis = function(self, buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
		stream:writeuchar(self.m_nFirstPage)
		stream:writeint(self.m_OwnerObjId)
		stream:writeint(self.m_OwnerGuid)
		stream:writeuchar(self.is_yuanbao_stall)
		stream:write(gbk.fromutf8(self.stall_name), 0x23)
		
        self.m_nStallItemNum = self.m_nStallItemNum > 0x29 and 0x29 or self.m_nStallItemNum
        stream:writeuchar(self.m_nStallItemNum)
        for i = 1, self.m_nStallItemNum do
            local stall_item = self.m_StallItemList[i]
            stream:writeuchar(stall_item.is_pet)
            stream:writeuchar(stall_item.index)
            stream:writeuint(stall_item.serial)
            stream:writeuint(stall_item.price)
            packet.EquipStream.bos(stall_item.item, stream)
            packet.PetGUID.bos(stall_item.pet_guid, stream)
        end
        
		local FinStream = bostream.new()
		FinStream:writeint(#stream:get())
		FinStream:write(stream:get(), #stream:get())
		
        return FinStream:get()
    end
}

packet.CGStallItemPrice = {
    xy_id = packet.XYID_CG_STALL_ITEM_PRICE,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGStallItemPrice })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.item_guid = packet.ItemGUID.new()
        self.item_guid:bis(stream)
        self.pet_guid = packet.PetGUID.new()
        self.pet_guid:bis(stream)
        self.price = stream:readuint()
        self.serial = stream:readuint()
    end
}

packet.GCStallItemPrice = {
    xy_id = packet.XYID_GC_STALL_ITEM_PRICE,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCStallItemPrice })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.item_guid = packet.ItemGUID.new()
        self.pet_guid = packet.PetGUID.new()
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.item_guid = packet.ItemGUID.new()
        self.item_guid:bis(stream)
        self.pet_guid = packet.PetGUID.new()
        self.pet_guid:bis(stream)
        self.price = stream:readuint()
        self.serial = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        packet.ItemGUID.bos(self.item_guid, stream)
        packet.PetGUID.bos(self.pet_guid, stream)
        stream:writeuint(self.price)
        stream:writeuint(self.serial)
        return stream:get()
    end
}

packet.CGStallRemoveItem = {
    xy_id = packet.XYID_CG_STALL_REMOVE_ITEM,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGStallRemoveItem })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.item_guid = packet.ItemGUID.new()
        self.item_guid:bis(stream)
        self.pet_guid = packet.PetGUID.new()
        self.pet_guid:bis(stream)
        self.serial = stream:readuint()
        self.to_type = stream:readuchar()
    end
}

packet.GCStallRemoveItem = {
    xy_id = packet.XYID_GC_STALL_REMOVE_ITEM,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCStallRemoveItem })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.item_guid = packet.ItemGUID.new()
        self.pet_guid = packet.PetGUID.new()
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.item_guid = packet.ItemGUID.new()
        self.item_guid:bis(stream)
        self.pet_guid = packet.PetGUID.new()
        self.pet_guid:bis(stream)
        self.serial = stream:readuint()
        self.to_type = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        packet.ItemGUID.bos(self.item_guid, stream)
        packet.PetGUID.bos(self.pet_guid, stream)
        stream:writeuint(self.serial)
        stream:writeuchar(self.to_type)
        return stream:get()
    end
}

packet.CGStallClose = {
    xy_id = packet.XYID_CG_STALL_CLOSE,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGStallClose })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end 
}

packet.GCStallClose = {
    xy_id = packet.XYID_GC_STALL_CLOSE,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCStallClose })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        return stream:get()
    end
}

packet.CGStallBuy = {
    xy_id = packet.XYID_CG_STALL_BUY,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGStallBuy })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readint()
        self.item_guid = packet.ItemGUID.new()
        self.item_guid:bis(stream)
        self.pet_guid = packet.PetGUID.new()
        self.pet_guid:bis(stream)
        self.serial = stream:readuint()
    end 
}

packet.GCStallBuy = {
    xy_id = packet.XYID_GC_STALL_BUY,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCStallBuy })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readint()
        self.item_guid = packet.ItemGUID.new()
        self.item_guid:bis(stream)
        self.pet_guid = packet.PetGUID.new()
        self.pet_guid:bis(stream)
        self.serial = stream:readuint()
        self.to_index = stream:readuchar()
        self.to_type = stream:readuchar()
        
        self.unknow_1 = stream:readuchar()
        self.cost = stream:readint()
        self.profit = stream:readint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.m_objID)
        packet.ItemGUID.bos(self.item_guid, stream)
        packet.PetGUID.bos(self.pet_guid, stream)
        stream:writeuint(self.serial)
        stream:writeuchar(self.to_index)
        stream:writeuchar(self.to_type)

        stream:writeuchar(0)
        stream:writeuint(self.cost)
        stream:writeuint(self.profit)
        return stream:get()
    end
}

packet.CGStallShopName = {
    xy_id = packet.XYID_CG_STALL_SHOP_NAME,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGStallShopName })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        local len = stream:readuchar()
        len = len > 34 and 34 or len
        self.stall_name = stream:read(len)
        self.stall_name = gbk.toutf8(self.stall_name)
    end 
}

packet.CGBBSApply = {
    xy_id = packet.XYID_CG_BBS_APPLY,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGBBSApply })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readint()
        self.serial = stream:readuint()
    end   
}

packet.GCBBSMessages = {
    xy_id = packet.XYID_GC_BBS_MESSSAGES,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCBBSMessages })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.messages = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readint()
        self.serial = stream:readuint()
        local len = stream:readuchar()
        self.title = stream:read(len)
        self.title = gbk.toutf8(self.title)
        local num = stream:readuchar()
        if num > 0 and num < 0x14 then
            for i = 1, num do
                local message = {}
                message.author = gbk.toutf8(stream:read(0x27))
                message.id = stream:readuint()
                message.hour = stream:readuchar()
                message.min = stream:readuchar()
                message.has_reply = stream:readuchar()
                if message.has_reply == 1 then
                    message.re_hour = stream:readuchar()
                    message.re_min = stream:readuchar()
                    local len = stream:readuchar()
                    message.message = stream:read(len)
                    len = stream:readuchar()
                    message.replymessage = stream:read(len)
                else
                    local len = stream:readuchar()
                    message.message = stream:read(len)
                end
                table.insert(self.messages, message)
            end
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.m_objID)
        stream:writeint(self.serial)
        self.title = gbk.fromutf8(self.title or "")
        local len = string.len(self.title)
        stream:writeuchar(len)
        stream:write(self.title, len)
        local num = #self.messages
        stream:writeuchar(num)
        if num > 0 and num <= 0x14 then
            for i = 1, num do
                local message = self.messages[i]
                message.author = gbk.fromutf8(message.author)
                stream:write(message.author, 0x27)
                stream:writeuint(message.id)
                stream:writeuchar(message.hour)
                stream:writeuchar(message.min)
                stream:writeuchar(message.has_reply and 1 or 0)
                if message.has_reply then
                    stream:writeuchar(message.re_hour)
                    stream:writeuchar(message.re_min)
                    message.message = gbk.fromutf8(message.message)
                    if message.item_transfer then
                        message.message = string.format(message.message, message.item_transfer)
                    end
                    local len = string.len(message.message)
                    stream:writeuchar(len)
                    stream:write(message.message, len)
                    message.replymessage = gbk.fromutf8(message.replymessage)
                    local len = string.len(message.replymessage)
                    stream:writeuchar(len)
                    stream:write(message.replymessage, len)
                else
                    message.message = gbk.fromutf8(message.message)
                    if message.item_transfer then
                        message.message = string.format(message.message, message.item_transfer)
                    end
                    local len = string.len(message.message)
                    stream:writeuchar(len)
                    stream:write(message.message, len)
                end
            end
        end
        return stream:get()
    end
}

packet.CGBBSSychMessages = {
    xy_id = packet.XYID_CG_BBS_SYCH_MESSAGE,
    OPTS = {
        OPT_NONE = 0,
        OPT_NEW_MESSAGE = 1,
        OPT_REPLY_MESSAGE = 2,
        OPT_DEL_MESSAGE = 3,
        OPT_SET_TITLE = 4,
    },
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGBBSSychMessages })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readint()
        self.opt = stream:readuchar()
        if self.opt == 1 or self.opt == 4 then
            local len = stream:readuchar()
            self.message_data = stream:read(len)
            self.message_data = gbk.toutf8(self.message_data)
        elseif self.opt == 2 then
            self.id = stream:readuint()
            local len = stream:readuchar()
            self.message_data = stream:read(len)
            self.message_data = gbk.toutf8(self.message_data)
        elseif self.opt == 3 then
            self.id = stream:readuint()
        end
    end   
}

packet.GCStallError = {
    xy_id = packet.XYID_GC_STALL_ERROR,
    STALL_MSG = {
        ERR_ERR         = 0,
		ERR_ILLEGAL     = 1,
		ERR_CLOSE       = 2,
		ERR_OWNER_INVALID = 3,
		ERR_NEED_NEW_COPY = 4,
		ERR_NOT_ENOUGH_ROOM = 5,
		ERR_NOT_ENOUGH_ROOM_IN_STALL = 6,
		ERR_NOT_ENOUGH_MONEY = 7,
		ERR_ALREADY_LOCK = 8,
		ERR_NOT_ENOUGH_MONEY_TO_OPEN = 9,
		ERR_PET_LEVEL_TOO_HIGH = 10,
    },
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCStallError })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.result)
        return stream:get()
    end
}

packet.CGMissionAbandon = {
    xy_id = packet.XYID_CG_MISSION_ABANDON,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGMissionAbandon })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.index = stream:readint()
    end   
}

packet.GCMissionRemove = {
    xy_id = packet.XYID_GC_MISSION_REMOVE,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCMissionRemove })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bos = function(self, buffer)
        local stream = bostream.new()
        stream:writeint(self.id)
        return stream:get()
    end
}

packet.CGMissionAccept = {
    xy_id = packet.XYID_CG_MISSION_ACCEPT,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGMissionAccept })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_idNPC = stream:readint()
        self.unknow = stream:readint()
        self.m_idScript = stream:readint()
    end   
}

packet.GCMissionAdd = {
    xy_id = packet.XYID_GC_MISSION_ADD,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCMissionAdd })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bos = function(self, buffer)
        local stream = bostream.new()
        stream:writeint(self.id)
        stream:writeint(self.index)
        stream:writechar(self.yFlag)
        for i = 1, 8 do
            stream:writeint(self.params[i])
        end
        return stream:get()
    end
}

packet.CGMissionContinue = {
    xy_id = packet.XYID_CG_MISSION_CONTINUE,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGMissionContinue })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_idNPC = stream:readint()
        self.unknow = stream:readint()
        self.m_idScript = stream:readint()
    end   
}

packet.CGMail = {
    xy_id = packet.XYID_CG_MAIL,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGMail })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.guid = stream:readint()
        local source_size = stream:readuchar()
        source_size = source_size >= 0x1E and 0x1E or source_size
        self.source = gbk.toutf8(stream:read(source_size))
        self.portrait_id = stream:readint()
        self.unknow_2 = stream:readint()
        local dest_size = stream:readuchar()
        dest_size = dest_size >= 0x1E and 0x1E or dest_size
        self.dest = gbk.toutf8(stream:read(dest_size))
        local content_size = stream:readushort()
        content_size = content_size >= 0x100 and 0x100 or content_size
        self.content = gbk.toutf8(stream:read(content_size))
        self.flag = stream:readuint()
        self.create_time = stream:readuint()
        if self.flag == 2 then
            self.param_1 = stream:readint()
            self.param_2 = stream:readint()
            self.param_3= stream:readint()
            self.param_4 = stream:readint()
            self.param_5 = stream:readint()
        end
        self.unknow_9 = stream:readuint()
    end   
}

packet.GCMail = {
    xy_id = packet.XYID_GC_MAIL,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCMail })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.count = 0
        self.mails = {}
    end,
    bos = function(self, buffer)
        local stream = bostream.new()
        stream:writeuchar(self.count )
        self.count = self.count > 0x14 and 0x14 or self.count
        for i = 1, self.count do
            local mail = self.mails[i]
            stream:writeint(mail.guid)
            mail.source = gbk.fromutf8(mail.source) 
            local source_size = string.len(mail.source)
            stream:writeuchar(source_size)
            stream:write(mail.source, source_size)
            stream:writeint(mail.portrait_id)
            stream:writeint(mail.guid)
            mail.dest = gbk.fromutf8(mail.dest) 
            local dest_size = string.len(mail.dest)
            stream:writeuchar(dest_size)
            stream:write(mail.dest, dest_size)
            mail.content = gbk.fromutf8(mail.content)
            local ctx_len = string.len(mail.content)
            stream:writeushort(ctx_len)
            stream:write(mail.content, ctx_len)
            stream:writeuint(mail.flag)
            stream:writeuint(mail.create_time)
            if mail.flag == 2 then
                stream:writeint(mail.param_1)
                stream:writeint(mail.param_2)
                stream:writeint(mail.param_3)
                stream:writeint(mail.param_4)
                stream:writeint(mail.param_5)
            end
        end
        self.leave_count = self.leave_count > define.UCHAR_MAX and define.UCHAR_MAX or self.leave_count
        stream:writeuchar(self.leave_count)
        return stream:get()
    end
}

packet.CGRemoveDressGem = {
    xy_id = packet.XYID_CG_REMOVE_DRESS_GEM,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGRemoveDressGem })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.gem_index = stream:readuchar()
        self.equip_index = stream:readuchar()
        self.mat_index = stream:readuchar()
    end   
}

packet.GCGuildApply = {
    xy_id = packet.XYID_GC_GUILD_APPLY,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCGuildApply })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bos = function(self, buffer)
        local stream = bostream.new()
        stream:writeuint(self.m_NpcId)
        return stream:get()
    end
}

packet.CGGuildApply = {
    xy_id = packet.XYID_CG_GUILD_APPLY,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGGuildApply })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        local nameSize = stream:readuchar()
        if nameSize > 0 and nameSize <= 0x18 then
            self.name = stream:read(nameSize)
            self.name = gbk.toutf8(self.name)
        end
        local descSize = stream:readuchar()
        if descSize > 0 and descSize <= 0x3C then
            self.desc = stream:read(descSize)
            self.desc = gbk.toutf8(self.desc)
        end
    end 
}

packet.GCGuildReturn = {
    xy_id = packet.XYID_GC_GUILD_RETURN,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCGuildReturn })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bos = function(self, buffer)
        local stream = bostream.new()
        local enum_return_type = define.GUILD_RETURN_TYPE
        stream:writeuchar(self.return_type)
        if self.return_type == enum_return_type.GUILD_RETURN_CREATE or self.return_type == enum_return_type.GUILD_RETURN_JOIN then
            stream:writeuint(self.id)
            stream:writeshort(self.confederate_id)
            self.name = gbk.fromutf8(self.name)
            local len = string.len(self.name)
            stream:writeuchar(len)
            if len > 0 and len <= 0x18 then
                stream:write(self.name, len)
            end
        elseif self.return_type == enum_return_type.GUILD_RETURN_LEAVE or self.return_type == enum_return_type.GUILD_RETURN_REJECT then
            stream:writeint(self.askid)
            stream:writeint(self.guid)
            self.guild_name = gbk.fromutf8(self.guild_name)
            self.name = gbk.fromutf8(self.name)
            local guild_name_len = string.len(self.guild_name)
            local name_len = string.len(self.name)
            stream:writeuchar(guild_name_len)
            stream:writeuchar(name_len)
            if guild_name_len <= 0x18 then
                stream:write(self.guild_name, guild_name_len)
            end
            if name_len<= 0x1E then
                stream:write(self.name, name_len)
            end
        elseif self.return_type == enum_return_type.GUILD_RETURN_RECRUIT then
            stream:writeint(self.askid)
            stream:writeshort(self.guild_id)
            stream:writeint(self.guid)
            stream:writeint(self.chief_guid)
            self.chief_name = gbk.fromutf8(self.chief_name)
            self.name = gbk.fromutf8(self.name)
            self.guild_name = gbk.fromutf8(self.guild_name)
            self.confederate_name = gbk.fromutf8(self.confederate_name)
            local cheif_name_len = string.len(self.chief_name)
            local name_len = string.len(self.name)
            local guild_name_len = string.len(self.guild_name)
            local confederate_name_len = string.len(self.confederate_name)
            stream:writeuchar(cheif_name_len)
            stream:writeuchar(name_len)
            stream:writeuchar(guild_name_len)
            stream:writeuchar(confederate_name_len)
            stream:writeuint(self.join_time)
            stream:writeuchar(self.is_online)
            if cheif_name_len <= 0x1E then
                stream:write(self.chief_name, cheif_name_len)
            end
            if name_len <= 0x1E then
                stream:write(self.name, name_len)
            end
            if guild_name_len <= 0x18 then
                stream:write(self.guild_name, guild_name_len)
            end
            if confederate_name_len <= 0x18 then
                stream:write(self.confederate_name, confederate_name_len)
            end
        elseif self.return_type == enum_return_type.GUILD_RETURN_EXPEL then
            stream:writeint(self.askid)
            stream:writeint(self.guid)
            self.guild_name = gbk.fromutf8(self.guild_name)
            self.chief_name = gbk.fromutf8(self.chief_name)
            self.name = gbk.fromutf8(self.name)
            local cheif_name_len = string.len(self.chief_name)
            local name_len = string.len(self.name)
            local guild_name_len = string.len(self.guild_name)
            stream:writeuchar(guild_name_len)
            stream:writeuchar(cheif_name_len)
            stream:writeuchar(name_len)
            if guild_name_len <= 0x18 then
                stream:write(self.guild_name, guild_name_len)
            end
            if cheif_name_len <= 0x1E then
                stream:write(self.chief_name, cheif_name_len)
            end
            if name_len <= 0x1E then
                stream:write(self.name, name_len)
            end
        elseif self.return_type == 3 then
            stream:writeint(self.askid)
            stream:writeint(self.dest_guid)
            stream:writeshort(self.guild_id)
            stream:writechar(self.position)
            self.source_name = gbk.fromutf8(self.source_name)
            local source_name_size = string.len(self.source_name)
            stream:writeuchar(source_name_size)

            self.dest_name = gbk.fromutf8(self.dest_name)
            local dest_name_size = string.len(self.dest_name)
            stream:writeuchar(dest_name_size)

            self.guild_name = gbk.fromutf8(self.guild_name)
            local guild_name_size = string.len(self.guild_name)
            stream:writeuchar(guild_name_size)

            self.position_name = gbk.fromutf8(self.position_name)
            local position_name_size = string.len(self.position_name)
            stream:writeuchar(position_name_size)

            if source_name_size <= 0x1E then
                stream:write(self.source_name, source_name_size)
            end
            if dest_name_size <= 0x1E then
                stream:write(self.dest_name, dest_name_size)
            end
            if guild_name_size <= 0x18 then
                stream:write(self.guild_name, guild_name_size)
            end
            if position_name_size <= 0x18 then
                stream:write(self.position_name, position_name_size)
            end
        elseif self.return_type == 9 then
            stream:writeint(self.askid)
            stream:writeint(self.source_guid)
            stream:writeint(self.dest_guid)
            stream:writeshort(self.guild_id)
            stream:writechar(self.source_position)
            stream:writechar(self.dest_position)
  
            self.source_name = gbk.fromutf8(self.source_name)
            local source_name_size = string.len(self.source_name)
            stream:writeuchar(source_name_size)

            self.dest_name = gbk.fromutf8(self.dest_name)
            local dest_name_size = string.len(self.dest_name)
            stream:writeuchar(dest_name_size)
        
            self.dest_name = gbk.fromutf8(self.dest_name)
            local dest_name_size = string.len(self.dest_name)
            stream:writeuchar(dest_name_size)

            self.guild_name = gbk.fromutf8(self.guild_name)
            local guild_name_size = string.len(self.guild_name)
            stream:writeuchar(guild_name_size)

            self.source_position_name = gbk.fromutf8(self.source_position_name)
            local source_position_name_size = string.len(self.source_position_name)
            stream:writeuchar(source_position_name_size)
    
            self.dest_position_name = gbk.fromutf8(self.dest_position_name)
            local dest_position_name_size = string.len(self.dest_position_name)
            stream:writeuchar(dest_position_name_size)

            if source_name_size <= 0x1E then
                stream:write(self.source_name, source_name_size)
            end

            if dest_name_size <= 0x1E then
                stream:write(self.dest_name, dest_name_size)
            end

            if guild_name_size <= 0x18 then
                stream:write(self.guild_name, guild_name_size)
            end
            
            if source_position_name_size <= 0x18 then
                stream:write(self.source_position_name, source_position_name_size)
            end

            if dest_position_name_size <= 0x18 then
                stream:write(self.dest_position_name, dest_position_name_size)
            end
        end
        return stream:get()
    end
}

packet.GCGuild = {
    xy_id = packet.XYID_GC_GUILD,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCGuild })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    read_guild_list = function(self, stream)
        self.m_uStartIndex = stream:readshort()
        self.m_uGuildCount = stream:readshort()
        self.m_camp = stream:readchar()
        self.guild_list = {}
        for i = 1, 1 do
            local guild = {}
            guild.id = stream:readshort()
            guild.chief_name = stream:read(0x1E)
            guild.name = stream:read(0x18)
            guild.desc = stream:read(0x3C)
            guild.city_name = stream:read(0x1A)
            guild.confederate_name = stream:read(0x20)
            guild.port_scene_id = stream:readint()
            guild.status = stream:readuchar()
            guild.user_count = stream:readint()
            guild.level = stream:readuchar()
            guild.founded_time = stream:readint()
            guild.prosperity = stream:readint()
            guild.unknow_5 = stream:readint()
            table.insert(self.guild_list, guild)
        end
    end,
    read_self_guild_info = function(self, stream)
        self.guild_id = stream:readshort()
        local guild_name_size = stream:readuchar()
        if guild_name_size > 0 and guild_name_size <= 0x18 then
            self.guild_name = stream:read(guild_name_size)
        end
        local guild_postion_size = stream:readuchar()
        if guild_postion_size > 0 and guild_postion_size <= 0x18 then
            self.guild_postion_name = stream:read(guild_postion_size)
        end
        local confederate_name_size = stream:readuchar()
        if confederate_name_size > 0 and confederate_name_size < 0x20 then
            self.confederate_name = stream:read(confederate_name_size)
        end
        self.m_bPosition = stream:readchar()
        self.unknow_9 = stream:readint()
        self.unknow_10 = stream:readint()
        self.unknow_11 = stream:readint()
        self.unknow_12 = stream:readshort()  
        self.message_len = stream:readint()  
        if self.message_len > 0 and self.message_len <= 0x240 then
            self.message = stream:read(self.message_len)
        end
        self.desc_len = stream:readuchar()
        if self.desc_len > 0 and self.desc_len <= 0x3E then
            self.desc = stream:read(self.desc_len)
        end
        self.unknow_17 = stream:readint()
        self.m_iJoinTime = stream:readuint()
        self.wild_war_guilds = {}
        for i = 1, 3 do
            local u = {}
            u.id = stream:readshort()
            u.unknow = stream:readuint()
            table.insert(self.wild_war_guilds, u)
        end
        self.unknow_20 = stream:readint()
        self.unknow_21 = stream:readint()
        self.m_iLogOutTime = stream:readuint()
        self.unknow_23 = stream:readint()
    end,
    read_guild_name_list = function(self, stream)
        self.name_list = stream:readuchar(0x7000)
    end,
    read_guild_member_list = function(self, stream)
        self.valid_member_count = stream:readshort()
        self.member_count = stream:readshort()
        self.member_max = stream:readshort()
        self.position = stream:readchar()
        self.access = stream:readuchar()
        self.desc = stream:read(0x3C)
        self.name = stream:read(0x18)
        self.confederate_name = stream:read(0x20)
        self.unknow_6 = stream:readint()
        self.unknow_7 = stream:readchar()
        self.unknow_8 = stream:readchar()
        if self.member_count > 0 and self.member_count <= 0x10E then
            self.guild_member_data = {}
            for i = 1, self.member_count do
                local m = {}
                m.name = stream:read(0x1E)
                m.guid = stream:readint()
                m.level = stream:readuchar()
                m.menpai = stream:readuchar()
                m.cur_contribute = stream:readint()
                m.max_contribute = stream:readint()
                m.week_contribute = stream:readuint()
                m.join_time = stream:readuint()
                m.logout_time = stream:readuint()
                m.is_online = stream:readuchar()
                m.position = stream:readuchar()
                m.unknow_1 = stream:readuchar()
                table.insert(self.guild_member_data, m)
            end
        end
    end,
    read_guild_appoint_info = function(self, stream)
        self.iPosNum = stream:readuint()
        self.unknow_1 = stream:readuchar()
        self.ais = {}
        for i = 1, 10 do
            local ai = {}
            ai.m_PosID = stream:readuchar()
            ai.m_PosName = stream:read(24)
            table.insert(self.ais, ai)
        end
    end,
    read_guild_first_man = function(self, stream)
        self.unknow_1 = stream:readuchar()
        self.unknow_2 = stream:read(0x1E)
    end,
    read_guild_info = function(self, stream)
        self.name = stream:read(0x18)
        self.creator = stream:read(0x1E)
        self.chief_name = stream:read(0x1E)
        self.city_name = stream:read(0x1A)
        self.confederate_name = stream:read(0x20)
        self.level = stream:readuchar()
        self.port_scene_id = stream:readint()
        self.mem_num = stream:readuint()
        self.longevity = stream:readuint()
        self.contribute = stream:readuint()
        self.honor = stream:readuint()
        self.founded_money = stream:readuint()

        self.ind_level = stream:readuint()
        self.agr_level = stream:readuint()
        self.com_level = stream:readuint()
        self.def_level = stream:readuint()
        self.tech_level = stream:readuint()
        self.ambi_level = stream:readuint()

        self.founded_time = stream:readuint()
        self.unknow_2 = stream:readint()
        self.unknow_3 = stream:readuint()
        self.unknow_4 = stream:readuint()
        self.unknow_5 = stream:readint()
        self.prosperity = stream:readuint()
        self.unknow_7 = stream:readuint()
        self.unknow_8 = stream:readuint()
        self.unknow_9 = stream:readuint()
        self.unknow_10 = stream:readuint()
        self.unknow_11 = stream:readuint()
    end,
    write_guild_list = function(self, stream)
        stream:writeshort(self.start_index)
        stream:writeshort(self.guild_count)
        stream:writeuchar(self.guild_count)
        for i = 1, self.guild_count do
            local guild = self.guild_list[i]
            stream:writeshort(guild.id)
            guild.chief_name = gbk.fromutf8(guild.chief_name)
            guild.name = gbk.fromutf8(guild.name)
            guild.desc = gbk.fromutf8(guild.desc)
            guild.city_name = gbk.fromutf8(guild.city_name)
            guild.confederate_name = gbk.fromutf8(guild.confederate_name)
            stream:write(guild.chief_name, 0x1E)
            stream:write(guild.name, 0x18)
            stream:write(guild.desc, 0x3C)
            stream:write(guild.city_name, 0x1A)
            stream:write(guild.confederate_name, 0x20)
            stream:writeint(guild.port_scene_id)
            stream:writeuchar(guild.status)
            stream:writeint(guild.user_count)
            stream:writeuchar(guild.level)
            stream:writeuint(guild.founded_time)
            stream:writeint(guild.prosperity)
            stream:writeint(guild.unknow_5)
            stream:writeint(guild.unknow_6)
        end
    end,
    write_self_guild_info = function(self, stream)
        stream:writeshort(self.guild_id)
        self.name = gbk.fromutf8(self.name)
        local guild_name_size = string.len(self.name)
        stream:writeuchar(guild_name_size)
        if guild_name_size > 0 and guild_name_size <= 0x18 then
            stream:write(self.name, guild_name_size)
        end
        self.position_name = gbk.fromutf8(self.position_name)
        local position_name_size = string.len(self.position_name)
        stream:writeuchar(position_name_size)
        if position_name_size > 0 and position_name_size <= 0x18 then
            stream:write(self.position_name, position_name_size)
        end
        self.confederate_name = gbk.fromutf8(self.confederate_name)
        local confederate_name_size = string.len(self.confederate_name)
        stream:writeuchar(confederate_name_size)
        if confederate_name_size < 0x20 then
            stream:write(self.confederate_name, confederate_name_size)
        end
        stream:writeuchar(self.position)
        stream:writeint(self.unknow_9)
        stream:writeint(self.unknow_10)
        stream:writeint(self.unknow_11)
        stream:writeshort(self.unknow_12)
        self.message = gbk.fromutf8(self.message)
        local message_len = string.len(self.message)
        stream:writeint(message_len)
        if message_len > 0 and message_len <= 0x240 then
            stream:write(self.message, message_len)
        end
        self.desc = gbk.fromutf8(self.desc)
        local desc_len = string.len(self.desc)
        stream:writeuchar(desc_len)
        if desc_len > 0 and desc_len <= 0x3E then
            stream:write(self.desc, desc_len)
        end
        stream:writeint(self.unknow_17)
        stream:writeuint(self.join_time)
        self.wild_war_guilds = self.wild_war_guilds or {}
        for i = 1, 3 do
            local u = self.wild_war_guilds[i] or { id = define.INVAILD_ID, unknow = 0}
            stream:writeshort(u.id)
            stream:writeuint(u.begin_date or 0)
        end
        stream:writeint(self.wild_war_flag)
        stream:writeint(self.unknow_21)
        stream:writeuint(self.logout_time)
        stream:writeint(self.unknow_23)
    end,
    write_guild_member_list = function(self, stream)
        stream:writeshort(self.valid_member_count)
        stream:writeshort(self.member_count)
        stream:writeshort(self.member_max)
        stream:writechar(self.position)
        stream:writeuchar(self.access)
        self.desc = gbk.fromutf8(self.desc)
        self.name = gbk.fromutf8(self.name)
        self.confederate_name = gbk.fromutf8(self.confederate_name)
        stream:write(self.desc, 0x3C)
        stream:write(self.name, 0x18)
        stream:write(self.confederate_name, 0x20)
        stream:writeint(self.unknow_6)
        stream:writechar(self.unknow_7)
        stream:writechar(self.unknow_8)
        if self.member_count > 0 and self.member_count <= 0x10E then
            for i = 1, self.member_count do
                local m = self.memberlist[i]
                m.name = gbk.fromutf8(m.name)
                stream:write(m.name, 0x1E)
                stream:writeint(m.guid)
                stream:writeuchar(m.level)
                stream:writeuchar(m.menpai)
                stream:writeint(m.cur_contribute)
                stream:writeint(m.max_contribute)
                stream:writeint(m.week_contribute)
                stream:writeuint(m.join_time)
                stream:writeuint(m.logout_time)
                stream:writeuchar(m.is_online)
                stream:writeuchar(m.position)
                stream:writeuchar(0)
            end
        end
    end,
    write_guild_info = function(self, stream)
        self.name = gbk.fromutf8(self.name)
        self.creator = gbk.fromutf8(self.creator)
        self.chief_name = gbk.fromutf8(self.chief_name)
        self.city_name = gbk.fromutf8(self.city_name)
        self.confederate_name = gbk.fromutf8(self.confederate_name)
        stream:write(self.name, 0x18)
        stream:write(self.creator, 0x1E)
        stream:write(self.chief_name, 0x1E)
        stream:write(self.city_name, 0x1A)
        stream:write(self.confederate_name, 0x20)
        stream:writeuchar(self.level)
        stream:writeint(self.port_scene_id)
        stream:writeuint(self.mem_num)
        
        stream:writeuint(self.longevity)
        stream:writeuint(self.contribute)
        stream:writeuint(self.honor)
        stream:writeuint(self.founded_money)

        stream:writeuint(self.ind_level)
        stream:writeuint(self.agr_level)
        stream:writeuint(self.com_level)
        stream:writeuint(self.def_level)
        stream:writeuint(self.tech_level)
        stream:writeuint(self.ambi_level)

        stream:writeuint(self.founded_time)
        stream:writeint(self.unknow_2)
        stream:writeuint(self.unknow_3)
        stream:writeint(self.unknow_4)
        stream:writeint(self.unknow_5)
        stream:writeuint(self.prosperity)
        stream:writeuint(self.unknow_7)
        stream:writeuint(self.unknow_8)
        stream:writeuint(self.unknow_9)
        stream:writeuint(self.unknow_10)
        stream:writeuint(self.unknow_11)
    end,
    read_appoint_info = function(self, stream)
        local size = stream:readuint()
        self.unknow_2 = stream:readuchar()
        self.appoint_infos = {}
        if size <= 10 then
            for i = 1, size do
                self.appoint_infos[i] = stream:read(25)
            end
        end
    end,
    write_appoin_info = function(self, stream)
        stream:writeuint(#self.appoint_infos)
        stream:writeuchar(0)
        if #self.appoint_infos <= 10 then
            for _, ai in ipairs(self.appoint_infos) do
                local name = gbk.fromutf8(ai.name)
                stream:write(name, 24)
                stream:writeuchar(ai.pos)
            end
        end
    end,
    write_name_list = function(self, stream)
        stream:write(self.name_list, 0x7000)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.packet_type = stream:readuchar()
        self.askid = stream:readuint()
        if self.packet_type == 48 or self.packet_type == 57 then
            self:read_guild_list(stream)
        elseif self.packet_type == 49 or self.packet_type == 58 then
            self:read_guild_member_list(stream)
        elseif self.packet_type == 50 or self.packet_type == 59 then
            self:read_guild_info(stream)
        elseif self.packet_type == 51 or self.packet_type == 60 then
            self:read_appoint_info(stream)
        elseif self.packet_type == 52 or self.packet_type == 61 then
            self:read_self_guild_info(stream)
        elseif self.packet_type == 53 or self.packet_type == 62 then
        elseif self.packet_type == 54 or self.packet_type == 63 then
        elseif self.packet_type == 55 or self.packet_type == 64 then
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.packet_type)
        stream:writeuint(self.askid)
        if self.packet_type == 48 or self.packet_type == 57 then
            self:write_guild_list(stream)
        elseif self.packet_type == 49 or self.packet_type == 58 then
            self:write_guild_member_list(stream)
        elseif self.packet_type == 50 or self.packet_type == 59 then
            self:write_guild_info(stream)
        elseif self.packet_type == 51 or self.packet_type == 60 then
            self:write_appoin_info(stream)
        elseif self.packet_type == 52 or self.packet_type == 61 then
            self:write_self_guild_info(stream)
        elseif self.packet_type == 53 or self.packet_type == 62 then
        elseif self.packet_type == 54 or self.packet_type == 63 then
            self:write_name_list(stream)
        elseif self.packet_type == 55 or self.packet_type == 64 then
        end
        return stream:get()
    end
}

packet.CGGuildJoin = {
    xy_id = packet.XYID_CG_GUILD_JOIN,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGGuildJoin })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.guild_id = stream:readshort()
    end 
}

packet.CGWPacket_CityApply = {
    xy_id = define.INVAILD_ID,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGWPacket_CityApply })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, stream)
        self.city_enter_group = stream:readuint()
        self.guid = stream:readint()
        self.unknow = stream:readint()
        self.name = stream:read(0x1A)
        self.name = gbk.toutf8(self.name)
        self.name = string.match(self.name, "([^%z]+)")
    end 
}

packet.CGWPacket_GuildWar = {
    xy_id = define.INVAILD_ID,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGWPacket_GuildWar })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, stream)
        self.initiate_or_accept = stream:readuint()
        self.my_guild_id = stream:readshort()
        self.tar_guild_id = stream:readshort()
    end 
}

packet.CGWPacket_GuildWildWar = {
    xy_id = define.INVAILD_ID,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGWPacket_GuildWildWar })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, stream)
        stream:read(0x20)
        self.tar_guild_id = stream:readshort()
    end 
}

packet.CGCGWPacket = {
    xy_id = packet.XYID_CG_CGW_PACKET,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGCGWPacket })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.type = stream:readuchar()
        local len = stream:readuint()
        if self.type == 1 then
            self.city_apply = packet.CGWPacket_CityApply.new()
            self.city_apply:bis(stream)
        elseif self.type == 3 then
            self.guild_wild_war = packet.CGWPacket_GuildWildWar.new()
            self.guild_wild_war:bis(stream)
        elseif self.type == 11 then
            self.guild_war = packet.CGWPacket_GuildWar.new()
            self.guild_war:bis(stream)
        else
            self.data = {}
            for i = 1, len do
                self.data[i] = stream:readuchar()
            end
        end
    end 
}

packet.GCRefreshSuperAttr = {
    xy_id = packet.XYID_GC_REFRESH_SUPER_ATTR,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCRefreshSuperAttr })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.bagIndex = stream:readuint()
        self.attr_count = stream:readuint()
        self.attr_type = stream:readulong()
        self.attr_values = {}
        for i = 1, 16 do
            self.attr_values[i] = stream:readushort()
        end
        self.item_index = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.bagIndex)
        stream:writeuint(self.attr_count)
        stream:writeulong(self.attr_type)
        for i = 1, 16 do
            stream:writeushort(self.attr_values[i] or 0)
        end
        stream:writeuint(self.item_index)
        return stream:get()
    end
}

packet.GCCharModifyAction = {
    xy_id = packet.XYID_GC_CHAR_MODIFY_ACTION,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCCharModifyAction })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.m_objID)
        stream:writeint(self.logic_count)
        stream:writeint(self.modify_time)
        return stream:get()
    end
}

packet.CGMissionCheck = {
    xy_id = packet.XYID_CG_MISSION_CHECK,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGMissionCheck })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_idNPC = stream:readint()
        self.unknow_2 = stream:readint()
        self.m_idScript = stream:readint()
        self.m_ItemIndexList = {}
        for i = 1, 3 do
            self.m_ItemIndexList[i] = stream:readchar()
        end
        self.pet_index = stream:readuchar()
        self.unknow_5 = stream:readint()
        self.unknow_6 = stream:readint()
    end 
}

packet.CGAskTeamFollow = {
    xy_id = packet.XYID_CG_ASK_TEAM_FOLLOW,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGAskTeamFollow })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end
}

packet.GCReturnTeamFollow = {
    xy_id = packet.XYID_GC_RETURN_TEAM_FOLLOW,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCReturnTeamFollow })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.return_type)
        stream:writeint(self.guid)
        return stream:get()
    end
}

packet.GCAskTeamFollow = {
    xy_id = packet.XYID_GC_ASK_TEAM_FOLLOW,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCAskTeamFollow })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bos = function(self)
        local stream = bostream.new()
        return stream:get()
    end
}

packet.CGStopTeamFollow = {
    xy_id = packet.XYID_CG_STOP_TEAM_FOLLOW,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGStopTeamFollow })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end
}

packet.GCTeamFollowList = {
    xy_id = packet.XYID_GC_TEAM_FOLLOW_LIST,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCTeamFollowList })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.guids = {}
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.m_objID)
        stream:writeuchar(#self.guids)
        if #self.guids <= 6 then
            for _, guid in ipairs(self.guids) do
                stream:writeint(guid)
            end
        end
        return stream:get()
    end
}

packet.CGReturnTeamFollow = {
    xy_id = packet.XYID_CG_RETURN_TEAM_FOLLOW,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGReturnTeamFollow })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.return_type = stream:readuchar()
    end
}

packet.GCTeamFollowErr = {
    xy_id = packet.XYID_GC_TEAM_FOLLOW_ERR,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCTeamFollowErr })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.error)
        return stream:get()
    end
}

packet.CGTeamKick = {
    xy_id = packet.XYID_CG_TEAM_KICK,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGTeamKick })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.source_guid = stream:readint()
        self.dest_guid = stream:readint()
    end
}

packet.CGTeamApply = {
    xy_id = packet.XYID_CG_TEAM_APPLY,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGTeamApply })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.source_guid = stream:readint()
        self.unknow_1= stream:readint()
        local len = stream:readuchar()
        if len > 0 and len < 0x1E then
            self.dest_name = stream:read(len)
            self.dest_name = gbk.toutf8(self.dest_name)
        end
        self.unknow_2 = stream:readushort()
    end
}

packet.CGTeamRetApply = {
    xy_id = packet.XYID_CG_TEAM_RET_APPLY,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGTeamRetApply })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.return_type = stream:readuchar()
        self.source_guid = stream:readint()
        self.team_guids = {}
        for i = 1, 8 do
            self.team_guids[i] = stream:readint()
        end
    end
}

packet.CGTeamLeaderRetInvite = {
    xy_id = packet.XYID_CG_TEAM_LEADER_RET_APPLY,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGTeamLeaderRetInvite })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.return_type = stream:readuchar()
        self.source_guid = stream:readint()
        self.dest_guid = stream:readint()
        self.guids = {}
        for i = 1, 8 do
            self.guids[i] = stream:readint()
        end
        self.team_guids = {}
        for i = 1, 8 do
            self.team_guids[i] = stream:readint()
        end
    end
}

packet.GCTeamAskApply = {
    xy_id = packet.XYID_GC_TEAM_ASK_APPLY,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCTeamAskApply })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.source_guid)
        stream:writeint(self.dest_guid)
        self.source_name = gbk.fromutf8(self.source_name)
        self.dest_name = gbk.fromutf8(self.dest_name)
        local source_len = string.len(self.source_name)
        local dest_len = string.len(self.dest_name)
        stream:writeuchar(source_len)
        stream:writeuchar(dest_len)
        if source_len < 0x1E then
            stream:write(self.source_name, source_len)
        end
        if dest_len < 0x1E then
            stream:write(self.dest_name, dest_len)
        end
        local uinfo = self.uinfo
        stream:writeuint(uinfo.menpai)
        stream:writeushort(uinfo.sceneid)
        stream:writeuint(uinfo.level)
        stream:writeuchar(uinfo.detail_flag or 0)
        stream:writeushort(uinfo.model)
        stream:writeint(uinfo.unknow_1 or 2)
        stream:writeshort(uinfo.unknow_2 or -1)
		
		-- stream:writeint(uinfo.weapon[define.WG_KEY_A])
		-- stream:writeint(uinfo.weapon[define.WG_KEY_B])
		-- stream:writeushort(uinfo.weapon[define.WG_KEY_C])
		
		-- stream:writeint(uinfo.cap[define.WG_KEY_A])
		-- stream:writeint(uinfo.cap[define.WG_KEY_B])
		-- stream:writeushort(uinfo.cap[define.WG_KEY_C])
			
		-- stream:writeint(uinfo.armour[define.WG_KEY_A])
		-- stream:writeint(uinfo.armour[define.WG_KEY_B])
		-- stream:writeushort(uinfo.armour[define.WG_KEY_C])
		
		-- stream:writeint(uinfo.cuff[define.WG_KEY_A])
		-- stream:writeint(uinfo.cuff[define.WG_KEY_B])
		-- stream:writeushort(uinfo.cuff[define.WG_KEY_C])
		
		-- stream:writeint(uinfo.foot[define.WG_KEY_A])
		-- stream:writeint(uinfo.foot[define.WG_KEY_B])
		-- stream:writeushort(uinfo.foot[define.WG_KEY_C])
		
		-- stream:writeint(100)
		-- stream:writeint(0)
		-- stream:writeint(0)
		
		-- -- stream:writeint(uinfo.unknow_7 or 100)
		-- -- stream:writeint(uinfo.equip.fasion_visual)
		-- -- stream:writeint(uinfo.unknow_9 or 0)
		
		-- stream:writeint(uinfo.fashion[define.WG_KEY_A])
		-- stream:writeint(uinfo.fashion[define.WG_KEY_D])
		-- stream:writeint(uinfo.fashion[define.WG_KEY_E])
		-- stream:writeint(uinfo.fashion[define.WG_KEY_F])
		-- stream:writeushort(uinfo.fashion[define.WG_KEY_C])
		
        -- if uinfo.detail_flag == 1 then
            -- stream:writeuint(uinfo.equip.weapon)
            -- stream:writeint(uinfo.equip.weapon_gem)
            -- stream:writeushort(uinfo.equip.weapon_visual)
            -- stream:writeuint(uinfo.equip.cap)

            -- stream:writeint(uinfo.equip.cap_gem)
            -- stream:writeushort(uinfo.equip.cap_visual)

            -- stream:writeuint(uinfo.equip.armour)
            -- stream:writeint(uinfo.equip.armour_gem)
            -- stream:writeushort(uinfo.equip.armour_visual)

            -- stream:writeuint(uinfo.equip.cuff)
            -- stream:writeint(uinfo.equip.cuff_gem)
            -- stream:writeushort(uinfo.equip.cuff_visual)

            -- stream:writeuint(uinfo.equip.foot)
            -- stream:writeint(uinfo.equip.foot_gem)
            -- stream:writeushort(uinfo.equip.foot_visual)

            -- stream:writeint(uinfo.unknow_7 or 100)
            -- stream:writeint(uinfo.equip.fasion_visual)
            -- stream:writeint(uinfo.unknow_9 or 0)
            -- stream:writeint(uinfo.equip.fashion)
            -- stream:writeint(uinfo.unknow_11 or -1)
            -- stream:writeint(uinfo.unknow_12 or -1)
            -- stream:writeint(uinfo.unknow_13 or -1)
            -- stream:writeushort(uinfo.unknow_14 or 0)
        -- end
        stream:writeuint(uinfo.unknow_15 or 39344113)
        return stream:get()
    end
}

packet.CGTeamAppoint = {
    xy_id = packet.XYID_CG_TEAM_APPOINT,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGTeamAppoint })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.source_guid = stream:readint()
        self.dest_guid = stream:readint()
    end
}

packet.CGExchangeApplyI = {
    xy_id = packet.XYID_CG_EXCHANGE_APPLY_I,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGExchangeApplyI })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readint()
        self.unknow = stream:readint()
    end
}

packet.GCExchangeError = {
    xy_id = packet.XYID_GC_EXCHANGE_ERROR,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCExchangeError })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.error_code)
        return stream:get()
    end
}

packet.GCExchangeApplyI = {
    xy_id = packet.XYID_GC_EXCHANGE_APPLY_I,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCExchangeApplyI })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.source_oid = stream:readint()
        self.source_guid = stream:readint()
        local len = stream:readuint()
        if len < 30 then
            self.source_name = stream:read(len)
        end
        self.source_name = gbk.toutf8(self.source_name)
        self.source_level = stream:readint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.source_oid)
        stream:writeint(self.source_guid)
        self.source_name = gbk.fromutf8(self.source_name)
        local len = string.len(self.source_name)
        stream:writeuint(len)
        if len < 30 then
            stream:write(self.source_name, len)
        end
        stream:writeint(self.source_level)
        return stream:get()
    end
}

packet.GCExchangeEstablishI = {
    xy_id = packet.XYID_GC_EXCHANGE_ESTABLISH_I,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCExchangeEstablishI })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.m_objID)
        return stream:get()
    end
}

packet.GCExchangeNotifySerial = {
    xy_id = packet.XYID_GC_EXCHANGE_NOTIFY_SERIAL,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCExchangeNotifySerial })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.serial = stream:readint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.serial)
        return stream:get()
    end
}

packet.CGExchangeReplyI = {
    xy_id = packet.XYID_GC_EXCHANGE_REPLY_I,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGExchangeReplyI })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.source_oid = stream:readint()
        self.soure_guid = stream:readint()
    end
}

packet.CGExchangeSynchItemII = {
    xy_id = packet.XYID_CG_EXCHANGE_SYNC_ITEM_II,
    OPT = {
		OPT_ERROR = 0,
		OPT_ADDITEM = 1,
		OPT_REMOVEITEM = 2,
		OPT_MONEY = 3,
		OPT_REMOVEMONEY = 4,
		OPT_ADDPET = 5,
		OPT_REMOVEPET = 6,
    },
    POS = 
	{
		POS_ERR	= 0,
		POS_BAG = 1,	--背包
		POS_EQUIP = 2,	--装备
		POS_PET = 3,    --宠物
	},
    ERR =
	{
		ERR_ERR = 0,
		ERR_SELF_IN_EXCHANGE = 1,
		ERR_TARGET_IN_EXCHANGE = 2,
		ERR_DROP = 3,
		ERR_ALREADY_LOCKED = 4,
		ERR_ILLEGAL = 5,
		ERR_NOT_ENOUGHT_ROOM_SELF = 6,
		ERR_NOT_ENOUGHT_ROOM_OTHER = 7,
		ERR_NOT_ENOUGHT_EXROOM = 8,
		ERR_NOT_ENOUGHT_MONEY_SELF = 9,
		ERR_NOT_ENOUGHT_MONEY_OTHER = 10,
		ERR_TOO_FAR = 11,
		ERR_REFUSE_TRADE = 12,
		ERR_PET_LEVEL_TOO_HIGH = 13,
	},
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGExchangeSynchItemII })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.opt = stream:readuchar()
        if self.opt == self.OPT.OPT_ADDITEM then
            self.from_type = stream:readuchar()
            self.from_index = stream:readuchar()
            self.series = stream:readint()
        elseif self.opt == self.OPT.OPT_ADDPET or self.opt == self.OPT.OPT_REMOVEPET then
            self.pet_guid = packet.PetGUID.new()
            self.pet_guid:bis(stream)
            self.series = stream:readint()
        elseif self.opt == self.OPT.OPT_REMOVEITEM then
            self.from_index = stream:readuchar()
            self.to_type = stream:readuchar()
            self.to_index = stream:readuchar()
            self.series = stream:readint()
        end
    end
}

packet.CGExchangeCancel = {
    xy_id = packet.XYID_CG_EXCHANGE_CANCEL,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGExchangeCancel })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end
}

packet.CGExchangeSynchLock = {
    xy_id = packet.XYID_CG_EXCHANGE_SYNCH_LOCK,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGExchangeSynchLock })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.lock_my_self = stream:readuchar()
        self.serial =  stream:readint()
    end
}

packet.CGExchangeOkIII = {
    xy_id = packet.XYID_CG_EXCHANGE_OK_III,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGExchangeOkIII })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.series =  stream:readint()
    end
}

packet.CGExchangeSynchMoneyII = {
    xy_id = packet.XYID_CG_EXCHANGE_SYNC_MONEY_II,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGExchangeSynchMoneyII })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.money = stream:readuint()
        self.series =  stream:readint()
    end
}

packet.GCExchangeSynchLock = {
    xy_id = packet.XYID_GC_EXCHANGE_SYNCH_LOCK,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCExchangeSynchLock })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow = stream:readushort()
        self.is_both = stream:readuchar()
        self.is_my_self = stream:readuchar()
        self.is_lockd = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeushort(self.unknow or 0)
        stream:writeuchar(self.is_both)
        stream:writeuchar(self.is_my_self)
        stream:writeuchar(self.is_lockd)
        return stream:get()
    end
}

packet.GCExchangeSynchConfirmII = {
    xy_id = packet.XYID_GC_EXCHANGE_SYNCH_CONFIRM_II,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCExchangeSynchConfirmII })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.is_enable = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.is_enable)
        return stream:get()
    end
}

packet.GCExchangeSuccessIII = {
    xy_id = packet.XYID_GC_EXCHANGE_SUCCESS_III,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCExchangeSuccessIII })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.item_list = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.guid = stream:readint()
        self.item_num = stream:readuchar()
        if self.item_num < 0xA then
            self.item_list = {}
            for i = 1, 0xA do
                local item = {}
                item.from_type = stream:readuchar()
                item.from_index = stream:readuchar()
                item.to_type = stream:readuchar()
                item.to_index = stream:readuchar()
                self.item_list[i] = item
            end
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.guid)
        stream:writeuchar(#self.item_list)
        if #self.item_list < 0xA then
            for _, item in ipairs(self.item_list) do
                stream:writeuchar(item.from_type)
                stream:writeuchar(item.from_index)
                stream:writeuchar(item.to_type)
                stream:writeuchar(item.to_index)
            end
        end
        return stream:get()
    end
}

packet.GCExchangeCancel = {
    xy_id = packet.XYID_GC_EXCHANGE_CANCEL,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCExchangeCancel })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        return stream:get()
    end
}

packet.GCExchangeSynchII = {
    xy_id = packet.XYID_GC_EXCHANGE_SYNC_II,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCExchangeSynchII })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.is_my_self)
        stream:writeuchar(self.opt)
        stream:writeushort(self.unknow or 0)
        if self.is_my_self == 1 then
            if self.opt == 1 then
                stream:writeuchar(self.from_type)
                stream:writeuchar(self.from_index)
                stream:writeuchar(self.to_index)
            elseif self.opt == 2 then
                stream:writeuchar(self.to_type)
                stream:writeuchar(self.to_index)
                stream:writeuchar(self.from_index)
            elseif self.opt == 3 or self.opt == 4 then
                stream:writeuint(self.money)
            elseif self.opt == 5 then
                stream:writeuchar(self.to_index)
                packet.PetGUID.bos(self.pet_guid, stream)
            elseif self.opt == 6 then
                packet.PetGUID.bos(self.pet_guid, stream)
            end
        else
            if self.opt == 1  then
                stream:writeuchar(self.to_index)
                stream:writeuchar(self.is_blue_equip)
                stream:writeuchar(self.by_number)
                if self.is_blue_equip == 1 then
                    packet.EquipStream.bos(self.item_data, stream)
                else
                    stream:writeuint(self.item_guid)
                end
            elseif self.opt == 2 then
                stream:writeuchar(self.from_index)
            elseif self.opt == 3 or self.opt == 4 then
                stream:writeuint(self.money)
            elseif self.opt == 6 then
                packet.PetGUID.bos(self.pet_guid, stream)
            end
        end
        return stream:get()
    end
}

packet.GCPlayerShopAcquireShopList = {
    xy_id = packet.XYID_GC_PLAYER_SHOP_ACQUIRE_SHOP_LIST,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPlayerShopAcquireShopList })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.shop_infos = {}
    end,
    read_shop_info = function(self, stream)
        local si = {}
        si.name = stream:read(34)
        si.stall_open_num = stream:readuchar()
        si.stall_close_num = stream:readuchar()
        si.type = stream:readuint()
        si.guid = packet.PlayerShopGUID.new()
        si.guid:bis(stream)
        si.id = stream:readuint()
        si.owner_guid = stream:readint()
        si.owner_name = stream:read(0x1E)
        si.unknow_2 = stream:readuchar()
        si.unknow_3 = stream:readuchar()
        si.founded_day = stream:readuint()
        si.desc = stream:read(82)
        si.is_in_favor = stream:readuchar()
        si.unknow_4 = stream:read(77)
        return si
    end,
    write_shop_info = function(self, stream, si)
        si.name = si.name or ""
        si.name = gbk.fromutf8(si.name)
        si.owner_name = gbk.fromutf8(si.owner_name)
        si.desc = gbk.fromutf8(si.desc or "")
        stream:write(si.name, 34)
        stream:writeuchar(si.stall_open_num)
        stream:writeuchar(si.stall_close_num)
        stream:writeuint(si.type)
        packet.PlayerShopGUID.bos(si.guid, stream)
        stream:writeuint(si.id)
        stream:writeint(si.owner_guid)
        stream:write(si.owner_name, 0x1E)
        stream:writeuchar(si.unknow_2 or 0)
        stream:writeuchar(si.unknow_3 or 0)
        stream:writeuint(si.founded_day)
        stream:write(si.desc, 82)
        stream:writeuchar(si.is_in_favor)
        stream:write(si.unknow_4 or "", 77)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.npc_id = stream:readint()
        self.shop_num = stream:readuint()
        self.com_factor = stream:readfloat()
        if self.shop_num < 0x201 then
            for i = 1, self.shop_num do
                local shop = self:read_shop_info(stream)
                table.insert(self.shop_infos, shop)
            end
        end
        self.unknow = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.npc_id)
        stream:writeuint(#self.shop_infos)
        stream:writefloat(self.com_factor)
        if #self.shop_infos < 0x201 then
            for _, shop in ipairs(self.shop_infos) do
                self:write_shop_info(stream, shop)
            end
        end
        stream:writeuchar(0)
        return stream:get()
    end
}

packet.GCPlayerShopError = {
    xy_id = packet.XYID_GC_PLAYER_SHOP_ERROR,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPlayerShopError })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.error_code)
        return stream:get()
    end
}
packet.GCPlayerShopApply = {
    xy_id = packet.XYID_GC_PLAYER_SHOP_APPLY,
    TYPE = {
		TYPE_ERR = 0,
		TYPE_ITEM = 1,
		TYPE_PET = 2,
		TYPE_BOTH = 3,
    },
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPlayerShopApply })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.npc_id = stream:readint()
        self.com_factor = stream:readfloat()
        self.cost = stream:readuint()
        self.type = stream:readuchar()
        self.unknow = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.npc_id)
        stream:writefloat(self.com_factor)
        stream:writeint(self.cost)
        stream:writeuchar(self.type)
        stream:writeuchar(self.unknow)
        return stream:get()
    end
}

packet.CGPlayerShopEstablish = {
    xy_id = packet.XYID_CG_PLAYER_SHOP_ESTABLISH,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGPlayerShopEstablish })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.type = stream:readuchar()
        local shop_name_len = stream:readuchar()
        self.unknow = stream:readuchar()
        if shop_name_len <= 0xC then
            self.name = stream:read(shop_name_len)
            self.name = gbk.toutf8(self.name)
        end
    end
}

packet.CGPlayerShopOnSale = {
    xy_id = packet.XYID_CG_PLAYER_SHOP_ON_SALE,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGPlayerShopOnSale })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_id = packet.PlayerShopGUID.new()
        self.shop_id:bis(stream)
        self.stall_index = stream:readuchar()
        self.item_guid = packet.ItemGUID.new()
        self.item_guid:bis(stream)
        self.serial = stream:readuint()
        self.price = stream:readuint()
        self.is_on_sale = stream:readuchar()
        self.pet_guid = packet.PetGUID.new()
        self.pet_guid:bis(stream)
        self.shop_serial = stream:readuchar()
    end
}

packet.CGPlayerShopMoney = {
    xy_id = packet.XYID_CG_PLAYER_SHOP_MONEY,
    OPT = {
        OPT_SAVE_MONEY = 0,
        OPT_GET_MONEY = 1,
    },
    TYPE = {
        TYPE_BASE_MONEY = 0,
        TYPE_PROFIT_MONEY = 1,
    },
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGPlayerShopMoney })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_id = packet.PlayerShopGUID.new()
        self.shop_id:bis(stream)
        self.opt = stream:readuchar()
        self.type = stream:readuchar()
        self.amount = stream:readuint()
        self.serial = stream:readuchar()
    end
}

packet.CGPlayerShopBuyItem = {
    xy_id = packet.XYID_CG_PLAYER_SHOP_BUY_ITEM,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGPlayerShopBuyItem })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_id = packet.PlayerShopGUID.new()
        self.shop_id:bis(stream)
        self.stall_index = stream:readuchar()
        self.item_guid = packet.ItemGUID.new()
        self.item_guid:bis(stream)
        self.pet_guid = packet.PetGUID.new()
        self.pet_guid:bis(stream)
        self.serial = stream:readuint()
    end
}

packet.CGPlayerShopOpenStall = {
    xy_id = packet.XYID_CG_PLAYER_SHOP_OPEN_STALL,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGPlayerShopOpenStall })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_id = packet.PlayerShopGUID.new()
        self.shop_id:bis(stream)
        self.stall_index = stream:readuchar()
        self.open = stream:readuchar()
        self.serial = stream:readuchar()
    end
}

packet.CGPlayerShopDesc = {
    xy_id = packet.XYID_CG_PLAYER_SHOP_DESC,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGPlayerShopDesc })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_id = packet.PlayerShopGUID.new()
        self.shop_id:bis(stream)
        local desc_len = stream:readuchar()
        if desc_len <= 0x26 then
            self.desc = stream:read(desc_len)
            self.desc = gbk.toutf8(self.desc)
        end
    end
}

packet.CGPlayerShopName = {
    xy_id = packet.XYID_CG_PLAYER_SHOP_NAME,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGPlayerShopName })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_id = packet.PlayerShopGUID.new()
        self.shop_id:bis(stream)
        local desc_len = stream:readuchar()
        if desc_len <= 0xC then
            self.desc = stream:read(desc_len)
            self.desc = gbk.toutf8(self.desc)
        end
    end
}

packet.CGPlayerShopSaleOut = {
    xy_id = packet.XYID_CG_PLAYER_SHOP_SALE_SOUT,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGPlayerShopSaleOut })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_id = packet.PlayerShopGUID.new()
        self.shop_id:bis(stream)
        self.sale_out = stream:readuchar()
        self.unknow = stream:readuchar()
        self.price = stream:readuint()
        self.serial = stream:readuchar()
    end
}

packet.CGPlayerShopBuyShop = {
    xy_id = packet.XYID_CG_PLAYER_SHOP_BUY_SHOP,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGPlayerShopBuyShop })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_id = packet.PlayerShopGUID.new()
        self.shop_id:bis(stream)
        self.serial = stream:readuchar()
    end
}

packet.CGPlayerShopPartner = {
    xy_id = packet.XYID_CG_PLAYER_SHOP_PARTNER,
    OPT = {
        OPT_NONE = 0,
        OPT_ADD_PARTNER = 1,
        OPT_DEL_PARTNER = 2,
    },
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGPlayerShopPartner })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_id = packet.PlayerShopGUID.new()
        self.shop_id:bis(stream)
        self.opt = stream:readuchar()
        self.partner_guid = stream:readint()
    end
}

packet.CGPlayerShopAskForRecord = {
    xy_id = packet.XYID_CG_PLAYER_SHOP_ASK_FOR_RECORD,
    TYPE = {
        TYPE_EXCHANGE_RECORD = 0,
        TYPE_MANAGER_RECORD = 1,
    },
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGPlayerShopAskForRecord })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_id = packet.PlayerShopGUID.new()
        self.shop_id:bis(stream)
        self.type = stream:readuchar()
        self.page = stream:readuchar()
    end
}

packet.CGPlayerShopSize = {
    xy_id = packet.XYID_CG_PLAYER_SHOP_SHOP_SIZE,
    OPT = {
        TYPE_EXPAND = 0,
        TYPE_SHRINK = 1,
    },
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGPlayerShopSize })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_id = packet.PlayerShopGUID.new()
        self.shop_id:bis(stream)
        self.opt = stream:readuchar()
        self.unknow = stream:readuchar()
    end
}

packet.CGPlayerShopType = {
    xy_id = packet.XYID_CG_PLAYER_SHOP_TYPE,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGPlayerShopType })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_id = packet.PlayerShopGUID.new()
        self.shop_id:bis(stream)
        self.type = stream:readuchar()
    end
}

packet.CGPlayerShopFavorite = {
    xy_id = packet.XYID_CG_PLAYER_SHOP_FAVORITE,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGPlayerShopFavorite })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.opt = stream:readuchar()
        self.favorite_id = packet.PlayerShopGUID.new()
        self.favorite_id:bis(stream)
    end
}

packet.CGPlayerShopSaleShopOpt = {
    xy_id = packet.XYID_CG_PLAYER_SHOP_SALE_SHOP_OPT,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGPlayerShopSaleShopOpt })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_id = packet.PlayerShopGUID.new()
        self.shop_id:bis(stream)
        self.unknow_1 = stream:readuchar()
        self.unknow_2 = stream:readint()
        self.unknow_3 = stream:readint()
        self.unknow_4 = stream:readint()
        self.unknow_5 = stream:readint()
        self.unknow_6 = stream:readulong()
        self.unknow_7 = stream:readint()
        local len = stream:readuint()
        if len < 72 then
            self.unknow_8 = stream:read(len)
            self.unknow_8 = gbk.toutf8(self.unknow_8)
        end
    end
}

packet.CGPlayerShopSaleShopAskInfo = {
    xy_id = packet.XYID_CG_PLAYER_SHOP_SALE_SHOP_ASK_INFO,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGPlayerShopSaleShopAskInfo })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_id = packet.PlayerShopGUID.new()
        self.shop_id:bis(stream)
        self.unknow = stream:readuchar()
    end
}

packet.CGPlayerShopApply = {
    xy_id = packet.XYID_CG_PLAYER_SHOP_APPLY,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGPlayerShopApply })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end
}

packet.CGPlayerShopAcquireShopList = {
    xy_id = packet.XYID_CG_PLAYER_SHOP_ACQUIRE_SHOP_LIST,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGPlayerShopAcquireShopList })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end
}

packet.GCPlayerShopEstablish = {
    xy_id = packet.XYID_GC_PLAYER_SHOP_ESTABLISH,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPlayerShopEstablish })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_id = packet.PlayerShopGUID.new()
        self.shop_id:bis(stream)
    end,
    bos = function(self)
        local stream = bostream.new()
        packet.PlayerShopGUID.bos(self.shop_id, stream)
        return stream:get()
    end
}

packet.GCPlayerShopMoney = {
    xy_id = packet.XYID_GC_PLAYER_SHOP_MONEY,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPlayerShopMoney })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_id = packet.PlayerShopGUID.new()
        self.shop_id:bis(stream)
        self.type = stream:readuchar()
        self.amount = stream:readuint()
        self.serial = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        packet.PlayerShopGUID.bos(self.shop_id, stream)
        stream:writeuchar(self.type)
        stream:writeuint(self.amount)
        stream:writeuchar(self.serial)
        return stream:get()
    end
}

packet.GCPlayerShopOpenStall = {
    xy_id = packet.XYID_GC_PLAYER_SHOP_OPEN_STALL,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPlayerShopOpenStall })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_id = packet.PlayerShopGUID.new()
        self.shop_id:bis(stream)
        self.stall_index = stream:readuchar()
        self.open = stream:readuchar()
        self.serial = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        packet.PlayerShopGUID.bos(self.shop_id, stream)
        stream:writeuchar(self.stall_index)
        stream:writeuchar(self.open)
        stream:writeuchar(self.serial)
        return stream:get()
    end
}

packet.GCPlayerShopSaleOut = {
    xy_id = packet.XYID_GC_PLAYER_SHOP_SALE_OUT,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPlayerShopSaleOut })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.sale_out = stream:readuchar()
        self.serial = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.sale_out)
        stream:writeuchar(self.serial)
        return stream:get()
    end
}

packet.GCPlayerShopBuyShop = {
    xy_id = packet.XYID_GC_PLAYER_SHOP_BUY_SHOP,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPlayerShopBuyShop })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_id = packet.PlayerShopGUID.new()
        self.shop_id:bis(stream)
    end,
    bos = function(self)
        local stream = bostream.new()
        packet.PlayerShopGUID.bos(self.shop_id, stream)
        return stream:get()
    end
}

packet.GCPlayerShopRecordList = {
    xy_id = packet.XYID_GC_PLAYER_SHOP_RECORD_LIST,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPlayerShopRecordList })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.entrys = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_id = packet.PlayerShopGUID.new()
        self.shop_id:bis(stream)
        self.unknow = stream:readuchar()
        self.num = stream:readuchar()
        for i = 1, self.num do
            self.entrys[i] = stream:read(128)
        end
        self.page = stream:readint()
    end,
    bos = function(self)
        local stream = bostream.new()
        packet.PlayerShopGUID.bos(self.shop_id, stream)
        stream:writeuchar(self.unknow or 0)
        local num = #self.entrys
        num = num > 0xA and 0xA or num
        stream:writeuchar(num)
        local start = #self.entrys - num + 1
        for i = start, #self.entrys do
            local e = self.entrys[i]
            e = gbk.fromutf8(e)
            stream:write(e, 128)
        end
        stream:writeint(self.page)
        return stream:get()
    end
}

packet.GCPlayerShopUpdatePartners = {
    xy_id = packet.XYID_GC_PLAYER_SHOP_UPDATE_PARTNERS,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPlayerShopUpdatePartners })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.partner_list = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_id = packet.PlayerShopGUID.new()
        self.shop_id:bis(stream)
        self.num = stream:readuchar()
        for i = 1, self.num do
            local partner = {}
            partner.guid = stream:readint()
            partner.name = stream:read(32)
            table.insert(self.partner_list, partner)
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        packet.PlayerShopGUID.bos(self.shop_id, stream)
        stream:writeuchar(#self.partner_list)
        for i = 1, #self.partner_list do
            local partner = self.partner_list[i] or { guid = define.INVAILD_ID, name = ""}
            stream:writeint(partner.guid)
            local name = gbk.fromutf8(partner.name)
            stream:write(name, 32)
        end
        return stream:get()
    end
}

packet.GCPlayerShopUpdateFavorite = {
    xy_id = packet.XYID_GC_PLAYER_SHOP_UPDATE_FAVORITE,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPlayerShopUpdateFavorite })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.partner_list = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_id = packet.PlayerShopGUID.new()
        self.shop_id:bis(stream)
        self.is_in_favorite = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        packet.PlayerShopGUID.bos(self.shop_id, stream)
        stream:writeuchar(self.is_in_favorite)
        return stream:get()
    end
}

packet.GCPlayerShopType = {
    xy_id = packet.XYID_GC_PLAYER_SHOP_TYPE,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPlayerShopType })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_id = packet.PlayerShopGUID.new()
        self.shop_id:bis(stream)
        self.type = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        packet.PlayerShopGUID.bos(self.shop_id, stream)
        stream:writeuchar(self.type)
        return stream:get()
    end
}

packet.GCPlayerShopStallStatus = {
    xy_id = packet.XYID_GC_PLAYER_SHOP_STALL_STATUS,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPlayerShopStallStatus })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_id = packet.PlayerShopGUID.new()
        self.shop_id:bis(stream)
        self.stall_index = stream:readuchar()
        self.status = stream:readuchar()
        self.final_stall_num = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        packet.PlayerShopGUID.bos(self.shop_id, stream)
        stream:writeuchar(self.stall_index)
        stream:writeuchar(self.status)
        stream:writeuchar(self.final_stall_num)
        return stream:get()
    end
}

packet.GCOpenPlayerShop = {
    xy_id = packet.XYID_GC_OPEN_PLAYER_SHOP,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCOpenPlayerShop })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow = stream:readint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.unknow)
        return stream:get()
    end
}

packet.GCPlayerShopSaleShopInfo = {
    xy_id = packet.XYID_GC_PLAYER_SHOP_SALE_SHOP_INFO,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPlayerShopSaleShopInfo })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_7 = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_id = packet.PlayerShopGUID.new()
        self.shop_id:bis(stream)
        self.unknow_1 = stream:readint()
        self.unknow_2 = stream:readuchar()
        self.unknow_3 = stream:readint()
        self.unknow_4 = stream:readint()
        self.unknow_5 = stream:read(0xC)
        self.name = stream:read(0x1E)
        self.unknow_6 = stream:readint()
        local size = stream:readuint()
        for i = 1, size do
            local s = stream:read(20)
            self.unknow_7[i] = s
        end
        self.unknow_8 = stream:readuint()
        for i = 1, 72 do
            self.unknow_9 = stream:read(self.unknow_8)
        end
        self.unknow_10 = stream:readint()
    end,
    bos = function(self)
        local stream = bostream.new()
        packet.PlayerShopGUID.bos(self.shop_id, stream)
        return stream:get()
    end
}

packet.GCPlayerShopSaleShopOptResult = {
    xy_id = packet.XYID_GC_PLAYER_SHOP_OPT_RESULT,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPlayerShopSaleShopOptResult })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_id = packet.PlayerShopGUID.new()
        self.shop_id:bis(stream)
        self.unknow_1 = stream:readuchar()
        self.unknow_2 = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        packet.PlayerShopGUID.bos(self.shop_id, stream)
        stream:writeuchar(self.unknow_1)
        stream:writeuchar(self.unknow_2)
        return stream:get()
    end
}

packet.CGPlayerShopAcquireItemList = {
    xy_id = packet.XYID_CG_PLAYER_SHOP_ACQUIRE_ITEM_LIST,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGPlayerShopAcquireItemList })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_id = packet.PlayerShopGUID.new()
        self.shop_id:bis(stream)
        self.stall_index = stream:readuchar()
        self.sign = stream:readuchar()
        self.is_manager = stream:readuchar()
    end,
}

packet.GCPlayerShopItemListForSelf_t ={
    xy_id = define.INVAILD_ID,
    FLAG = {
        FOR_BUYER = 1,
        FOR_MANAGER = 2,
    },
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPlayerShopItemListForSelf_t })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = 0
        self.unknow_2 = 0
        self.unknow_3 = 0
        self.unknow_5 = 0
        self.unknow_6 = 0
        self.unknow_7 = 0
        self.unknow_8 = 0
        self.unknow_9 = 0
        self.unknow_10 = 0
        self.unknow_15 = 191
        self.unknow_16 = 170
        self.unknow_11 = 1
        self.unknow_12 = 1
        self.unknow_13 = 0
    end,
    bis = function(self, stream)
        self.flag = stream:readuchar()
        self.unknow_1 = stream:readuchar()
        self.unknow_2 = stream:readuchar()
        self.unknow_3 = stream:readuchar()
        self.shop_guid = packet.PlayerShopGUID.new()
        self.shop_guid:bis(stream)
        self.shop_id = stream:readuchar()
        self.unknow_5 = stream:readuchar()
        self.unknow_6 = stream:readuchar()
        self.unknow_7 = stream:readuchar()
        self.shop_name = stream:read(0xc)
        self.desc = stream:read(0x26)
        self.unknow_15 = stream:readuchar()
        self.unknow_16 = stream:readuchar()
        self.owner_guid = stream:readint()
        self.owner_name = stream:read(32)
        self.base_money = stream:readuint()
        self.profit_money = stream:readuint()
        self.stall_is_open = {}
        for i = 1, 10 do
            table.insert(self.stall_is_open, stream:readuchar())
        end
        self.is_item_list = stream:readuchar()
        self.ui_flag = stream:readuchar()
        self.is_sale_out = stream:readuchar()
        self.sale_out_price = stream:readuint()
        self.unknow_10 = stream:readuchar()
        self.unknow_8 = stream:readuchar()
        self.unknow_9 = stream:readuchar()
        self.serial = stream:readuchar()
        self.ex_rec_list_num = stream:readuchar()
        self.ma_rec_list_num = stream:readuchar()
        self.stall_num = stream:readuchar()
        self.unknow_11 = stream:readuchar()
        self.unknow_12 = stream:readuchar()
        self.unknow_13 = stream:readuchar()
        self.type = stream:readuchar()
        self.com_factor = stream:readfloat()
        self.unknow_146 = stream:read(8)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.flag)
        stream:writeuchar(self.unknow_1)
        stream:writeuchar(self.unknow_2)
        stream:writeuchar(self.unknow_3)
        packet.PlayerShopGUID.bos(self.shop_guid, stream)
        stream:writeuchar(self.shop_id)
        stream:writeuchar(self.unknow_5)
        stream:writeuchar(self.unknow_6)
        stream:writeuchar(self.unknow_7)
        self.shop_name = gbk.fromutf8(self.shop_name or "")
        stream:write(self.shop_name, 0xc)
        self.desc = gbk.fromutf8(self.desc or "")
        stream:write(self.desc, 0x52)
        stream:writeuchar(self.unknow_15)
        stream:writeuchar(self.unknow_16)
        stream:writeint(self.owner_guid)
        self.owner_name = gbk.fromutf8(self.owner_name)
        stream:write(self.owner_name, 32)
        stream:writeuint(self.base_money)
        stream:writeuint(self.profit_money)
        for _, s in ipairs(self.stall_is_open) do
            stream:writeuchar(s)
        end
        stream:writeuchar(self.is_item_list)
        stream:writeuchar(self.ui_flag)
        stream:writeuchar(self.is_sale_out)
        stream:writeuint(self.sale_out_price)
        stream:writeuchar(self.unknow_10)
        stream:writeuchar(self.unknow_8)
        stream:writeuchar(self.unknow_9)
        stream:writeuchar(self.serial)
        stream:writeuchar(self.ex_rec_list_num)
        stream:writeuchar(self.ma_rec_list_num)
        stream:writeuchar(self.stall_num)
        stream:writeuchar(self.unknow_11)
        stream:writeuchar(self.unknow_12)
        stream:writeuchar(self.unknow_13)
        stream:writeuchar(self.type)
        stream:writefloat(self.com_factor)
        stream:write("", 8)
        return stream:get()
    end
}

packet.GCPlayerShopItemListEachSerialForSelf_t = {
    xy_id = define.INVAILD_ID,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPlayerShopItemListEachSerialForSelf_t })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, stream)
        self.stall_index = stream:readuchar()
        self.item_serial = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.stall_index)
        stream:writeuchar(self.item_serial)
        return stream:get()
    end
}

packet.GCPlayerShopItemListEachItemForSelf_t = {
    xy_id = define.INVAILD_ID,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPlayerShopItemListEachItemForSelf_t })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = define.INVAILD
        self.unknow_2 = define.INVAILD
        self.unknow_3 = define.INVAILD
    end,
    bis = function(self, stream)
        self.stall_index = stream:readchar()
        self.unknow_1 = stream:readshort()
        self.unknow_2 = stream:readchar()
        self.item_price = stream:readuint()
        self.item_serial = stream:readuchar()
        self.is_mine = stream:readchar()
        self.is_on_sale = stream:readchar()
        self.unknow_3 = stream:readchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writechar(self.stall_index)
        stream:writeshort(self.unknow_1)
        stream:writechar(self.unknow_2)
        stream:writeuint(self.item_price)
        stream:writeuchar(self.item_serial)
        stream:writechar(self.is_mine)
        stream:writechar(self.is_on_sale)
        stream:writechar(self.unknow_3)
        return stream:get()
    end
}

packet.GCPlayerShopItemListEachItemForSelf_t = {
    xy_id = define.INVAILD_ID,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPlayerShopItemListEachItemForSelf_t })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = define.INVAILD_ID
        self.unknow_2 = define.INVAILD_ID
        self.unknow_3 = define.INVAILD_ID
    end,
    bis = function(self, stream)
        self.stall_index = stream:readchar()
        self.unknow_1 = stream:readshort()
        self.unknow_2 = stream:readchar()
        self.item_price = stream:readuint()
        self.item_serial = stream:readuchar()
        self.is_mine = stream:readchar()
        self.is_on_sale = stream:readchar()
        self.unknow_3 = stream:readchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writechar(self.stall_index)
        stream:writeshort(self.unknow_1)
        stream:writechar(self.unknow_2)
        stream:writeuint(self.item_price)
        stream:writeuchar(self.item_serial)
        stream:writechar(self.is_mine)
        stream:writechar(self.is_on_sale)
        stream:writechar(self.unknow_3)
        return stream:get()
    end
}

packet.GCPlayerShopItemListForOther_t = {
    xy_id = define.INVAILD_ID,
    FLAG = {
        FOR_BUYER = 1,
        FOR_MANAGER = 2,
    },
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPlayerShopItemListForOther_t })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_00 = 1
        self.unknow_01 = 0
        self.unknow_02 = 0
        self.unknow_11 = 0
        self.unknow_12 = 0
        self.unknow_13 = 0
        self.unknow_21 = 80
        self.unknow_22 = -116
        self.unknow_41 = -1
        self.unknow_54 = 0
        self.unknow_71 = 0
        self.unknow_72 = 0
        self.unknow_81 = -1
        self.unknow_82 = 2
        self.sale_out_price = 2147811328
    end,
    bis = function(self, stream)
        self.flag = stream:readuchar()
        self.unknow_00 = stream:readuchar()
        self.unknow_01 = stream:readuchar()
        self.unknow_02 = stream:readuchar()
        self.shop_guid = packet.PlayerShopGUID.new()
        self.shop_guid:bis(stream)
        self.shop_id = stream:readuchar()
        self.unknow_11 = stream:readuchar()
        self.unknow_12 = stream:readuchar()
        self.unknow_13 = stream:readuchar()
        self.shop_name = stream:read(0xc)
        self.desc = stream:read(0x52)
        self.unknow_21 = stream:readchar()
        self.unknow_22 = stream:readchar()
        self.owner_guid = stream:readint()
        self.owner_name = stream:read(30)
        self.stall_is_open = {}
        for i = 1, 10 do
            table.insert(self.stall_is_open, stream:readuchar())
        end
        self.is_item_list = stream:readuchar()
        self.ui_flag = stream:readuchar()
        self.is_sale_out = stream:readuchar()
        self.unknow_41 = stream:readchar()
        self.base_money = stream:readuint()
        self.profit_money = stream:readuint()
        self.sale_out_price = stream:readuint()
        self.unknow_54 = stream:readuchar()
        self.type = stream:readuchar()
        self.unknow_71 = stream:readuchar()
        self.unknow_72 = stream:readuchar()
        self.serial = stream:readuchar()
        self.stall_num = stream:readuchar()
        self.unknow_81 = stream:readchar()
        self.unknow_82 = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.flag)
        stream:writeuchar(self.unknow_00)
        stream:writeuchar(self.unknow_01)
        stream:writeuchar(self.unknow_02)
        packet.PlayerShopGUID.bos(self.shop_guid, stream)
        stream:writeuchar(self.shop_id)
        stream:writeuchar(self.unknow_11)
        stream:writeuchar(self.unknow_12)
        stream:writeuchar(self.unknow_13)
        self.shop_name = gbk.fromutf8(self.shop_name or "")
        stream:write(self.shop_name, 0xc)
        self.desc = gbk.fromutf8(self.desc or "")
        stream:write(self.desc, 0x52)
        stream:writechar(self.unknow_21)
        stream:writechar(self.unknow_22)
        stream:writeint(self.owner_guid)
        self.owner_name = gbk.fromutf8(self.owner_name)
        stream:write(self.owner_name, 30)
        for _, s in ipairs(self.stall_is_open) do
            stream:writeuchar(s)
        end
        stream:writeuchar(self.is_item_list)
        stream:writeuchar(self.ui_flag)
        stream:writeuchar(self.is_sale_out)
        stream:writechar(self.unknow_41)
        stream:writeuint(math.floor(self.base_money))
        stream:writeuint(math.floor(self.profit_money))
        stream:writeuint(self.sale_out_price)
        stream:writeuchar(self.unknow_54)
        stream:writeuchar(self.type)
        stream:writeuchar(self.unknow_71)
        stream:writeuchar(self.unknow_72)
        stream:writeuchar(self.serial)
        stream:writeuchar(self.stall_num)
        stream:writechar(self.unknow_81)
        stream:writeuchar(self.unknow_82)
        return stream:get()
    end
}

packet.GCPlayerShopItemListEachItemForOther_t = {
    xy_id = define.INVAILD_ID,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPlayerShopItemListEachItemForOther_t })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = define.INVAILD_ID
        self.unknow_2 = 0
        self.unknow_3 = 0
        self.unknow_4 = 185
    end,
    bis = function(self, stream)
        self.stall_index = stream:readchar()
        self.unknow_1 = stream:readchar()
        self.unknow_2 = stream:readchar()
        self.unknow_3 = stream:readchar()
        self.item_price = stream:readuint()
        self.item_serial = stream:readuchar()
        self.is_mine = stream:readchar()
        self.unknow_4 = stream:readshort()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writechar(self.stall_index)
        stream:writechar(self.unknow_1)
        stream:writechar(self.unknow_2)
        stream:writechar(self.unknow_3)
        stream:writeuint(self.item_price)
        stream:writeuchar(self.item_serial)
        stream:writechar(self.is_mine)
        stream:writeshort(self.unknow_4)
        return stream:get()
    end    
}

packet.GCItemList = {
    xy_id = packet.XYID_GC_ITEM_LIST,
    OPT = 
    {
        OPT_NONE = 0,
        OPT_ADD_ONE_ITEM = 1,
        OPT_ADD_ITEM_LIST = 2,
    },
    TYPE =
    {
        TYPE_ITEM = 0,
        TYPE_PET = 1,
        TYPE_SERIALS = 2,
    },
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCItemList })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.item_list = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.opt = stream:readuchar()
        if self.opt == self.OPT.OPT_ADD_ONE_ITEM then
            self.type = stream:readuchar()
            if self.type == self.TYPE.TYPE_ITEM then
                local item = {}
                item.index = stream:readuchar()
                item.data = stream:read(0xBC)
                local len = stream:readuchar()
                if len <= 0xc8 then
                    item.extra_info = stream:read(len)
                end
                table.insert(self.item_list, item)
            elseif self.type == self.TYPE.TYPE_PET then
                local item = {}
                item.index = stream:readuchar()
                local len = stream:readuchar()
                if len <= 0xc8 then
                    item.extra_info = stream:read(len)
                end
            elseif self.type == self.TYPE.TYPE_SERIALS then
                local item = {}
                item.index = stream:readuchar()
                local len = stream:readuchar()
                if len <= 0xc8 then
                    item.extra_info = stream:read(len)
                end
            end
        elseif self.opt == self.OPT.OPT_ADD_ITEM_LIST then
            self.item_num = stream:readuchar()
            for i = 1, self.item_num do 
                local item = {}
                item.type = stream:readuchar()
                if item.type == self.TYPE.TYPE_ITEM then
                    item.index = stream:readuchar()
                    item.data = stream:read(0xBC)
                    item.len = stream:readuchar()
                    if item.len <= 0xc8 then
                        item.extra_info = packet.GCPlayerShopItemListEachItemForSelf_t.new()
                        item.extra_info:bis(stream)
                    end
                elseif item.type == self.TYPE.TYPE_PET then
                    local item = {}
                    item.index = stream:readuchar()
                    local len = stream:readuchar()
                    if len <= 0xc8 then
                        item.extra_info = stream:read(len)
                    end
                elseif item.type == self.TYPE.TYPE_SERIALS then
                    item.index = stream:readuchar()
                    local len = stream:readuchar()
                    if len <= 0xc8 then
                        item.extra_info = packet.GCPlayerShopItemListEachSerialForSelf_t.new()
                        item.extra_info:bis(stream)
                    end
                end
                table.insert(self.item_list, item)
            end
        end
        local len = stream:readuchar()
        if len > 0 then
            self.extra_data = packet.GCPlayerShopItemListForSelf_t.new()
            self.extra_data:bis(stream)
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.opt)
        if self.opt == self.OPT.OPT_ADD_ONE_ITEM then
            local item = self.item_list[1]
            stream:writeuchar(item.type)
            if item.type == self.TYPE.TYPE_ITEM then
                stream:writeuchar(item.index)
                stream:write(item.data)
                local len = string.len(item.extra_info)
                stream:writeuchar(len)
                if len <= 0xc8 then
                    stream:write(item.extra_info, len)
                end
            elseif item.type == self.TYPE.TYPE_PET then
                stream:writeuchar(item.index)
                local len = string.len(item.extra_info)
                stream:writeuchar(len)
                if len <= 0xc8 then
                    stream:write(item.extra_info, len)
                end
            elseif self.type == self.TYPE.TYPE_SERIALS then
                stream:writeuchar(item.index)
                local len = string.len(item.extra_info)
                stream:writeuchar(len)
                if len <= 0xc8 then
                    stream:write(item.extra_info, len)
                end
            end
        elseif self.opt == self.OPT.OPT_ADD_ITEM_LIST then
            stream:writeuchar(#self.item_list)
            for i = 1, #self.item_list do
                local item = self.item_list[i]
                stream:writeuchar(item.type)
                if item.type == self.TYPE.TYPE_ITEM then
                    stream:writeuchar(item.index)
                    stream:write(item.data, 0xBC)
                    local len = string.len(item.extra_info)
                    stream:writeuchar(len)
                    if len <= 0xc8 then
                        stream:write(item.extra_info, len)
                    end
                elseif item.type == self.TYPE.TYPE_PET then
                    stream:writeuchar(item.index)
                    local len = string.len(item.extra_info)
                    stream:writeuchar(len)
                    if len <= 0xc8 then
                        stream:write(item.extra_info, len)
                    end
                elseif item.type == self.TYPE.TYPE_SERIALS then
                    stream:writeuchar(item.index)
                    local len = string.len(item.extra_info)
                    stream:writeuchar(len)
                    if len <= 0xc8 then
                        stream:write(item.extra_info, len)
                    end
                end
            end
        end
        self.extra_data = self.extra_data or ""
        local len = string.len(self.extra_data)
        print("len =", len)
        stream:writeuchar(len)
        if len <= 0xc8 then
            stream:write(self.extra_data, len)
        end
        return stream:get()
    end
}

packet.CGAutoMoveItemFromBagToPlayerShop_t = {
    xy_id = define.INVAILD_ID,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGAutoMoveItemFromBagToPlayerShop_t })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_guid = packet.PlayerShopGUID.new()
        self.shop_guid:bis(stream)
        self.stall_index = stream:readuchar()
        self.shop_serial = stream:readuchar()
    end
}

packet.CGAutoMoveItemFromPlayerShopToBag_t = {
    xy_id = define.INVAILD_ID,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGAutoMoveItemFromPlayerShopToBag_t })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_guid = packet.PlayerShopGUID.new()
        self.shop_guid:bis(stream)
        self.stall_index = stream:readuchar()
        self.unknow_1 = stream:readuchar()
        self.unknow_2 = stream:readuchar()
        self.unknow_3 = stream:readuchar()
        self.unknow_4 = stream:readuchar()
        self.unknow_5 = stream:readuchar()
        self.unknow_6 = stream:readuchar()
        self.unknow_7 = stream:readuchar()
        self.shop_serial = stream:readuchar()
        self.unknow_9 = stream:readuchar()
        self.serial = stream:readuchar()
        self.unknow_8 = stream:readuchar()
    end
}

packet.CGManuMoveItemFromBagToPlayerShop_t = {
    xy_id = define.INVAILD_ID,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGManuMoveItemFromBagToPlayerShop_t })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_guid = packet.PlayerShopGUID.new()
        self.shop_guid:bis(stream)
        self.stall_index = stream:readuchar()
        self.serial = stream:readuchar()
    end
}

packet.CGManuMoveItemFromPlayerShopToBag_t = {
    xy_id = define.INVAILD_ID,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGManuMoveItemFromPlayerShopToBag_t })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_guid = packet.PlayerShopGUID.new()
        self.shop_guid:bis(stream)
        self.stall_index = stream:readuchar()
        self.serial = stream:readuchar()
    end
}

packet.CGManuMoveItemFromPlayerShopToPlayerShop_t = {
    xy_id = define.INVAILD_ID,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGManuMoveItemFromPlayerShopToPlayerShop_t })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_guid = packet.PlayerShopGUID.new()
        self.shop_guid:bis(stream)
        self.stall_index = stream:readuint()
        self.serial_source = stream:readuint()
        self.serial_dest = stream:readuint()
        self.shop_serial = stream:readuchar()
        self.unknow_6 = stream:readuchar()
        self.unknow_7 = stream:readuchar()
        self.unknow_8 = stream:readuchar()
    end
}

packet.CGAutoMovePetFromPlayerShopToBag_t = {
    xy_id = define.INVAILD_ID,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGAutoMovePetFromPlayerShopToBag_t })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_guid = packet.PlayerShopGUID.new()
        self.shop_guid:bis(stream)
        self.stall_index = stream:readuchar()
        self.serial = stream:readuchar()
        self.shop_serial = stream:readuchar()
    end
}

packet.CGItemSynch = {
    xy_id = packet.XYID_CG_ITEM_SYNCH,
    OPT =
    {
        OPT_MOVE_ITEM_AUTO = 0,
        OPT_MOVE_ITEM_MANU = 1,
    },
    POS =
    {
        POS_BAG = 0,
        POS_EQUIP = 1,
        POS_PET = 2,
        POS_BANK = 3,
        POS_PLAYERSHOP = 4,
        POS_PLAYERSHOPPET = 5,
    },
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGItemSynch })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.opt = stream:readuchar()
        if self.opt == self.OPT.OPT_MOVE_ITEM_MANU then
            self.from_type = stream:readuchar()
            if self.from_type == self.POS.POS_BAG or
                self.from_type == self.POS.POS_EQUIP or
                self.from_type == self.POS.POS_BANK or
                self.from_type == self.POS.POS_PLAYERSHOP then
                    self.to_type = stream:readuchar()
                    self.to_index = stream:readuchar()
                    self.item_guid = packet.ItemGUID.new()
                    self.item_guid:bis(stream)
            elseif self.from_type == self.POS.POS_PET then
                self.to_type = stream:readuchar()
                self.to_index = stream:readuchar()
                self.pet_guid = packet.PetGUID.new()
                self.pet_guid:bis(stream)
            elseif self.from_type == self.POS.POS_PLAYERSHOPPET then
                self.to_type = stream:readuchar()
                self.to_index = stream:readuchar()
                self.pet_guid = packet.PetGUID.new()
                self.pet_guid:bis(stream)
            end
        else
            self.from_type = stream:readuchar()
            if self.from_type == self.POS.POS_BAG or
                self.from_type == self.POS.POS_EQUIP or
                self.from_type == self.POS.POS_BANK or
                self.from_type == self.POS.POS_PLAYERSHOP then
                    self.to_type = stream:readuchar()
                    self.item_guid = packet.ItemGUID.new()
                    self.item_guid:bis(stream)
            elseif self.from_type == self.POS.POS_PET then
                self.to_type = stream:readuchar()
                self.pet_guid = packet.PetGUID.new()
                self.pet_guid:bis(stream)
            elseif self.from_type == self.POS.POS_PLAYERSHOPPET then
                self.to_type = stream:readuchar()
                self.pet_guid = packet.PetGUID.new()
                self.pet_guid:bis(stream)
            end
        end
        local len = stream:readuchar()
        if len then
            self.extra_data = stream:read(len)
        end
    end
}

packet.GCMoveItemFromBagToPlayerShop_t = {
    xy_id = define.INVAILD_ID,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCMoveItemFromBagToPlayerShop_t })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_guid = packet.PlayerShopGUID.new()
        self.shop_guid:bis(stream)
        self.stall_index = stream:readuint()
        self.serial = stream:readuint()
        self.shop_serial = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        packet.PlayerShopGUID.bos(self.shop_guid, stream)
        stream:writeuint(self.stall_index)
        stream:writeuint(self.serial)
        stream:writeuint(self.shop_serial)
        return stream:get()
    end
}

packet.GCMoveItemFromPlayerShopToBag_t = {
    xy_id = define.INVAILD_ID,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCMoveItemFromPlayerShopToBag_t })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = 0
        self.unknow_2 = 0
        self.unknow_3 = 0
        self.unknow_4 = 0
        self.unknow_5 = 0
        self.unknow_7 = 0
        self.unknow_8 = 0
        self.unknow_9 = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_guid = packet.PlayerShopGUID.new()
        self.shop_guid:bis(stream)
        self.stall_index = stream:readuchar()
        self.flag = stream:readuchar()
        self.unknow_1 = stream:readuchar()
        self.unknow_2 = stream:readuchar()
        self.serial = stream:readuint()
        self.shop_serial = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        packet.PlayerShopGUID.bos(self.shop_guid, stream)
        stream:writeuchar(self.stall_index)
        stream:writeuchar(self.flag)
        stream:writeuchar(self.unknow_1)
        stream:writeuchar(self.unknow_2)
        stream:writeuint(self.serial)
        stream:writeuint(self.shop_serial)
        return stream:get()
    end
}

packet.GCExchangeItemFromPlayerShopToBag_t = {
    xy_id = define.INVAILD_ID,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCExchangeItemFromPlayerShopToBag_t })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_guid = packet.PlayerShopGUID.new()
        self.shop_guid:bis(stream)
        self.stall_index = stream:readuchar()
        self.serial = stream:readuchar()
        self.shop_serial = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        packet.PlayerShopGUID.bos(self.shop_guid, stream)
        stream:writeuchar(self.stall_index)
        stream:writeuchar(self.serial)
        stream:writeuchar(self.shop_serial)
        return stream:get()
    end
}

packet.GCExchangeItemFromPlayerShopToPlayerShop_t = {
    xy_id = define.INVAILD_ID,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCExchangeItemFromPlayerShopToPlayerShop_t })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = 0
        self.unknow_2 = 0
        self.unknow_3 = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_guid = packet.PlayerShopGUID.new()
        self.shop_guid:bis(stream)
        self.stall_index = stream:readuint()
        self.source_serial = stream:readuint()
        self.dest_serial = stream:readuint()
        self.shop_serial = stream:readuchar()
        self.unknow_1 = stream:readuchar()
        self.unknow_2 = stream:readuchar()
        self.unknow_3 = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        packet.PlayerShopGUID.bos(self.shop_guid, stream)
        stream:writeuint(self.stall_index)
        stream:writeuint(self.source_serial)
        stream:writeuint(self.dest_serial)
        stream:writeuchar(self.shop_serial)
        stream:writeuchar(self.unknow_1)
        stream:writeuchar(self.unknow_2)
        stream:writeuchar(self.unknow_3)
        return stream:get()
    end
}

packet.GCMovePetFromBagToPlayerShop_t = {
    xy_id = define.INVAILD_ID,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCMovePetFromBagToPlayerShop_t })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_guid = packet.PlayerShopGUID.new()
        self.shop_guid:bis(stream)
        self.stall_index = stream:readuchar()
        self.serial = stream:readuchar()
        self.shop_serial = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        packet.PlayerShopGUID.bos(self.shop_guid, stream)
        stream:writeuchar(self.stall_index)
        stream:writeuchar(self.serial)
        stream:writeuchar(self.shop_serial)
        return stream:get()
    end
}

packet.GCMovePetFromPlayerShopToBag_t = {
    xy_id = define.INVAILD_ID,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCMovePetFromPlayerShopToBag_t })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_guid = packet.PlayerShopGUID.new()
        self.shop_guid:bis(stream)
        self.stall_index = stream:readuchar()
        self.flag = stream:readuchar()
        self.serial = stream:readuchar()
        self.shop_serial = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        packet.PlayerShopGUID.bos(self.shop_guid, stream)
        stream:writeuchar(self.stall_index)
        stream:writeuchar(self.flag)
        stream:writeuchar(self.serial)
        stream:writeuchar(self.shop_serial)
        return stream:get()
    end
}

packet.GCItemSynch = {
    xy_id = packet.XYID_GC_ITEM_SYNCH,
    OPT =
    {
        OPT_MOVE_ITEM = 0,
        OPT_REMOVE_ITEM = 1,
        OPT_EXCHANGE_ITEM = 2,
    },
    POS =
    {
        POS_BAG = 0,
        POS_EQUIP = 1,
        POS_PET = 2,
        POS_BANK = 3,
        POS_PLAYERSHOP = 4,
        POS_PLAYERSHOPPET = 5,
    },
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCItemSynch })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.opt = stream:readuchar()
        if self.opt == self.OPT.OPT_MOVE_ITEM then
            self.from_type = stream:readuchar()
            if self.from_type == self.POS.POS_BAG or
                self.from_type == self.POS.POS_EQUIP or
                self.from_type == self.POS.POS_BANK or
                self.from_type == self.POS.POS_PLAYERSHOP then
                    self.to_type = stream:readuchar()
                    self.to_index = stream:readuchar()
                    self.item_guid = packet.ItemGUID.new()
                    self.item_guid:bis(stream)
            elseif self.from_type == self.POS.POS_PET then
                self.to_type = stream:readuchar()
                self.to_index = stream:readuchar()
                self.pet_guid = packet.PetGUID.new()
                self.pet_guid:bis(stream)
            elseif self.from_type == self.POS.POS_PLAYERSHOPPET then
                self.to_type = stream:readuchar()
                self.to_index = stream:readuchar()
                self.pet_guid = packet.PetGUID.new()
                self.pet_guid:bis(stream)
            end
        else
            self.from_type = stream:readuchar()
            if self.from_type == self.POS.POS_BAG or
                self.from_type == self.POS.POS_EQUIP or
                self.from_type == self.POS.POS_BANK or
                self.from_type == self.POS.POS_PLAYERSHOP then
                    self.to_type = stream:readuchar()
                    self.item_guid = packet.ItemGUID.new()
                    self.item_guid:bis(stream)
            elseif self.from_type == self.POS.POS_PET then
                self.to_type = stream:readuchar()
                self.pet_guid = packet.PetGUID.new()
                self.pet_guid:bis(stream)
            elseif self.from_type == self.POS.POS_PLAYERSHOPPET then
                self.to_type = stream:readuchar()
                self.pet_guid = packet.PetGUID.new()
                self.pet_guid:bis(stream)
            end
        end
        local len = stream:readuchar()
        if len then
            self.extra_data = stream:read(len)
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.opt)
        if self.opt == self.OPT.OPT_MOVE_ITEM then
            stream:writeuchar(self.from_type)
            if self.from_type == self.POS.POS_BAG or self.from_type == self.POS.POS_EQUIP or
                self.from_type == self.POS.POS_BANK or self.from_type == self.POS.POS_PLAYERSHOP then
                    stream:writeuchar(self.to_type)
                    stream:writeuchar(self.to_index)
                    packet.ItemGUID.bos(self.item_guid, stream)
            elseif self.from_type == self.POS.POS_PET or self.from_type == self.POS.POS_PLAYERSHOPPET then
                stream:writeuchar(self.to_type)
                stream:writeuchar(self.to_index)
                packet.PetGUID.bos(self.pet_guid, stream)
            end
        elseif self.opt == self.OPT.OPT_REMOVE_ITEM then
            stream:writeuchar(self.to_type)
            packet.ItemGUID.bos(self.item_guid, stream)
        elseif self.opt == self.OPT.OPT_EXCHANGE_ITEM then
            stream:writeuchar(self.from_type)
            stream:writeuchar(self.to_type)
            stream:writeuchar(self.to_index)
            packet.ItemGUID.bos(self.item_guid, stream)
        end
        local len = string.len(self.extra_data)
        stream:writeuchar(len)
        if len then
            stream:write(self.extra_data, len)
        end
        return stream:get()
    end
}

packet.GCPlayerShopOnSale = {
    xy_id = packet.XYID_GC_PLAYER_SHOP_ON_SALE,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPlayerShopOnSale })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.shop_guid = packet.PlayerShopGUID.new()
        self.shop_guid:bis(stream)
        self.stall_index = stream:readuchar()
        self.item_guid = packet.ItemGUID.new()
        self.item_guid:bis(stream)
        self.serial = stream:readuint()
        self.is_on_sale = stream:readuchar()
        self.price = stream:readuint()
        self.pet_guid = packet.PetGUID.new()
        self.pet_guid:bis(stream)
        self.shop_serial = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        packet.PlayerShopGUID.bos(self.shop_guid, stream)
        stream:writeuchar(self.stall_index)
        packet.ItemGUID.bos(self.item_guid, stream)
        stream:writeuint(self.serial, stream)
        stream:writeuchar(self.is_on_sale)
        stream:writeuint(self.price)
        packet.PetGUID.bos(self.pet_guid, stream)
        stream:writeuchar(self.shop_serial)
        return stream:get()
    end
}

packet.CGCreateGuildLeague = {
    xy_id = packet.XYID_CG_CREATE_GUILD_LEAGUE,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGCreateGuildLeague })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.name = stream:read(0x20)
        self.name = gbk.toutf8(self.name)
        self.desc = stream:read(0x40)
        self.desc = gbk.toutf8(self.desc)
    end
}

packet.GCChallengeListInfo = {
    xy_id = packet.XYID_GC_CHALLENGE_LIST_INFO,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCChallengeListInfo })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.list = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        local count = stream:readuint()
        if count < 128 then
            for i = 1, count do
                local info = {}
                info.unknow_1 = stream:readshort()
                info.name = stream:read(0x1E)
                info.unknow_2 = stream:readchar()
                info.unknow_3 = stream:readchar()
                info.unknow_4 = stream:readchar()
                info.unknow_9 = stream:readshort()
                info.unknow_5 = stream:read(0x1E)
                info.unknow_6 = stream:readchar()
                info.unknow_7 = stream:readchar()
                info.unknow_8 = stream:readchar()
                info.unknow_10 = stream:readshort()
                self.list[i] = info
            end
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        return stream:get()
    end
}

packet.GCChallenge = {
    xy_id = packet.XYID_GC_CHALLENGE,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCChallenge })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.member_list = {}
    end,
    bis = function(self, buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.type)
        if self.type == 1 or self.type == 0x12 then
            stream:writeint(self.m_objID)
            local count = #self.member_list
            stream:writeuchar(count)
            if count <= 6 then
                for i = 1, count do
                    local member = self.member_list[i]
                    local name = gbk.fromutf8(member.name)
                    local len = string.len(name)
                    stream:writeuchar(len)
                    if len < 0x1E then
                        stream:write(name, len)
                    end
                    stream:writeshort(member.menpai)
                    stream:writeshort(member.unknow_1 or 0)
                    stream:writeint(member.level)
                    stream:writeshort(member.model)
                    stream:writeint(member.unknow_2 or 0)
                    stream:writeint(member.weapon)
                    stream:writeint(member.weapon_gem)
                    stream:writeshort(member.weapon_visual)
                    stream:writeint(member.cap)
                    stream:writeint(member.cap_gem)
                    stream:writeshort(member.cap_visual)
                    stream:writeint(member.armor)
                    stream:writeint(member.armor_gem)
                    stream:writeshort(member.armor_visual)
                    stream:writeint(member.glove)
                    stream:writeint(member.glove_gem)
                    stream:writeshort(member.glove_visual)
                    stream:writeint(member.shoe)
                    stream:writeint(member.shoe_gem)
                    stream:writeshort(member.shoe_visual)
                    stream:writeint(member.face_style)
                    stream:writeint(member.hair_style)
                    stream:writeint(member.hair_color)
                    stream:writeint(member.fashion)
                    stream:writeint(member.fashion_gem_1 or define.INVAILD_ID)
                    stream:writeint(member.fashion_gem_2 or define.INVAILD_ID)
                    stream:writeint(member.fashion_gem_3 or define.INVAILD_ID)
                    stream:writeshort(member.fashion_visual)
                    stream:writeint(member.server_id)
					--fix 20250317
					--当前背饰
					stream:writeshort(member.backid)
					--当前头饰
					stream:writeshort(member.headid)
					--当前背饰位置
					stream:writeint(member.backpos)
					--当前头饰位置
					stream:writeint(member.headpos)
                    -- self.member_list[i] = member
                end
            end
        elseif self.type == 2 or self.type == 3 or self.type == 4 or self.type == 0xB or self.type == 0x10 then 
            local name = gbk.fromutf8(self.name)
            local len = string.len(name)
            stream:writeuchar(len)
            if len < 0x1E then
                stream:write(name, len)
            end
        end
        return stream:get()
    end
}

packet.CGSectOper = {
    xy_id = packet.XYID_CG_SECT_OPER,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGSectOper })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.op = stream:readuint()
        self.val = stream:readuint()
    end
}

packet.CGAskCampaignCount = {
    xy_id = packet.XYID_CG_ASK_CAMPAIGN_COUNT,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGAskCampaignCount })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.type = stream:readuint()
    end
}

packet.CGAskSecKillNum = {
    xy_id = packet.XYID_CG_ASK_SEC_KILL_NUM,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGAskSecKillNum })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end
}

packet.CGAskSecKillData = {
    xy_id = packet.XYID_CG_ASK_SEC_KILL_DATA,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGAskSecKillData })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end
}

packet.GCRetSecKillData = {
    xy_id = packet.XYID_GC_RET_SEC_KILL_DATA,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCRetSecKillData })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.item_list = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readuchar()
        self.unknow_2 = stream:readuchar()
        self.fuben_index = stream:readuchar()
        self.boss_id = stream:readuchar()

        self.item_count = stream:readuchar()
        self.unknow_6 = stream:readuchar()
        self.unknow_7 = stream:readuchar()
        self.unknow_8 = stream:readuchar()
        self.unknow_9 = stream:readuint()
        self.unknow_10 = stream:readint()
        if self.item_count > 0 then
            for i = 1, self.item_count do
                local l = {}
                l.unknow_1 = stream:readuchar()
                l.unknow_2 = stream:readuchar()
                l.count = stream:readuchar()
                l.item_index = stream:readint()
                self.item_list[i] = l
            end
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        self.unknow_1 = self.unknow_1 or 0
        stream:writeuchar(self.unknow_1)
        if self.unknow_1 == 0 then
            stream:writeuchar(self.have_next or 0)
            stream:writeuchar(self.fuben_index or 0)
            stream:writeuchar(self.boss_id or 0)
            self.item_list = self.item_list or {}
            stream:writeuchar(#self.item_list)
            stream:writeuchar(self.unknow_6 or 0)
            stream:writeuchar(self.have_next or 0)
            stream:writeuchar(self.unknow_8 or 0)
            stream:writeuint(self.unknow_9 or 0)
            stream:writeuint(self.unknow_10 or 0)
            stream:writeuchar(self.unknow_13 or 0)
            stream:writeuint(self.unknow_14 or 0)
            if #self.item_list > 0 then
                for i, l in ipairs(self.item_list) do
                    stream:writeuchar(l.index or (i - 1))
                    stream:writeuchar(l.unknow_2 or 0)
                    stream:writeuchar(l.count)
                    stream:writeint(l.id)
                end
            end
        else
            if self.unknow_1 == 1 then
                stream:writeint(self.unknow_11 or 0)
            elseif self.unknow_1 == 2 then
                stream:writeint(self.unknow_12 or 0)
            end
        end
        return stream:get()
    end
}

packet.GCRetCampaignCount = {
    xy_id = packet.XYID_GC_RET_CAMPAIGN_COUNT,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCRetCampaignCount })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.list_1 = {}
        self.list_2 = {}
        self.list_3 = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readuint()
        if self.unknow_1 == 1 or self.unknow_1 == 3 then
            for i = 1, 38 do
                self.list_1[i] = stream:readuint()
            end
        end
        if self.unknow_1 == 2 then
            for i = 1, 50 do
                self.list_2[i] = stream:readuint()
            end
            for i = 1, 38 do
                self.list_3[i] = stream:readuint()
            end
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.unknow_1)
        if self.unknow_1 == 1 or self.unknow_1 == 3 then
            for i = 1, 38 do
                stream:writeuint(self.list_1[tostring(i)] or 0)
            end
        end
        if self.unknow_1 == 2 then
            for i = 1, 50 do
                stream:writeuint(self.list_2[i])
            end
            for i = 1, 38 do
                stream:writeuint(self.list_3[i])
            end
        end
        return stream:get()
    end
}

packet.GCRetSecKillNum = {
    xy_id = packet.XYID_GC_RET_SEC_KILL_NUM,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCRetSecKillNum })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.list = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        for i = 1, 32 do
            self.list[tostring(i)] = stream:readuchar()
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        for i = 1, 32 do
            local v = self.list[tostring(i)] or 0
            stream:writeuchar(v)
        end
        stream:writeint(0)
        return stream:get()
    end
}

packet.CGExteriorCoupleFashion = {
    xy_id = packet.XYID_CG_EXTERIOR_COUPLE_FASHION,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGExteriorCoupleFashion })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readuchar()
        self.unknow_2 = stream:readshort()
    end,
}

packet.GCExteriorCoupleFashion = {
    xy_id = packet.XYID_GC_EXTERIOR_COUPLE_FASHION,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCExteriorCoupleFashion })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.list_1 = {}
        self.list_2 = {}
        self.list_3 = {}
        self.list_4 = {}
        self.list_5 = {}
        self.list_6 = {}
        self.list_7 = {}
        self.list_8 = {}

        self.list_9 = {}
        self.list_10 = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readchar()
        self.unknow_2 = stream:readshort()
        self.unknow_3 = stream:readchar()
        if self.unknow_1 == 1 then
            for i = 1, 100 do
                self.list_1[i] = stream:readchar()
            end
        end
        if self.unknow_1 == 3 or self.unknow_1 == 5 or self.unknow_1 == 21 then
            self.unknow_4 = stream:readushort()
            self.unknow_4 = self.unknow_4 > 20 and 20 or self.unknow_4
            for i = 1, self.unknow_4 do
                self.list_2[i] = stream:read(0x1D)
            end
            self.unknow_5 = stream:readushort()
            self.unknow_5 = self.unknow_5 > 20 and 20 or self.unknow_5
            for i = 1, self.unknow_5 do
                self.list_3[i] = stream:read(0x1D)
            end
            for i = 1, 100 do
                self.list_4[i] = stream:readuchar()
            end
        end
        if self.unknow_1 == 10 then
            self.unknow_6 = stream:readushort()
            self.unknow_6 = self.unknow_6 > 20 and 20 or self.unknow_6
            for i = 1, self.unknow_6 do
                self.list_7[i] = stream:read(0x1D)
            end
            for i = 1, 100 do
                self.list_8[i] = stream:readuchar()
            end
        end
        if self.unknow_1 == 11 then
            self.unknow_9 = stream:readushort()
            self.unknow_9 = self.unknow_9 > 20 and 20 or self.unknow_9
            for i = 1, self.unknow_9 do
                self.list_10[i] = stream:read(0x1D)
            end
        end
        if self.unknow_1 == 17 then
            self.list_11 = stream:read(0x14)
            self.list_12 = stream:read(0x14)
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.unknow_1)
        stream:writeshort(self.unknow_2)
        stream:writeuchar(self.unknow_3)
        if self.unknow_1 == 1 then
            for i = 1, 100 do
                stream:writechar(self.list_1[i] or 0)
            end
        end
        if self.unknow_1 == 3 or self.unknow_1 == 5 or self.unknow_1 == 21 then
            self.unknow_4 = self.unknow_4 > 20 and 20 or self.unknow_4
            stream:writeushort(self.unknow_4)
            for i = 1, self.unknow_4 do
                stream:write(self.list_2[i], 0x1D)
            end
            self.unknow_5 = self.unknow_5 > 20 and 20 or self.unknow_5
            stream:writeushort(self.unknow_5)
            for i = 1, self.unknow_5 do
                stream:write(self.list_3[i], 0x1D)
            end
            for i = 1, 100 do
                stream:writechar(self.list_4[i] or 0)
            end
        end
        if self.unknow_1 == 10 then
            self.unknow_6 = self.unknow_6 > 20 and 20 or self.unknow_6
            stream:writeushort(self.unknow_6)
            for i = 1, self.unknow_6 do
                stream:write(self.list_7[i], 0x1D)
            end
            for i = 1, 100 do
                stream:writechar(self.list_8[i] or 0)
            end
        end
        if self.unknow_1 == 11 then
            self.unknow_9 = self.unknow_9 > 20 and 20 or self.unknow_9
            stream:writeushort(self.unknow_9)
            for i = 1, self.unknow_9 do
                stream:write(self.list_10[i], 0x1D)
            end
        end
        if self.unknow_1 == 17 then
            stream:write(self.list_11, 0x14)
            stream:write(self.list_12, 0x14)
        end
        return stream:get()
    end
}

packet.GCSetDynamicRegion = {
    xy_id = packet.XYID_GC_SET_DYNAMIC_REGION,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCSetDynamicRegion })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.world_pos = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.id = stream:readshort()
        self.data_index = stream:readint()
        self.world_pos = {}
        self.world_pos.x = stream:readfloat()
        self.world_pos.y = stream:readfloat()
        self.dir = stream:readfloat()
        self.enable = stream:readint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeshort(self.id)
        stream:writeint(self.data_index)
        stream:writefloat(self.world_pos.x)
        stream:writefloat(self.world_pos.y)
        stream:writefloat(self.dir)
        stream:writeint(self.enable)
        return stream:get()
    end
}

packet.GCNpcTalk = {
    xy_id = packet.XYID_GC_NPC_TALK,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCNpcTalk })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.id = stream:readint()
        local len = stream:readushort()
        if len < 256 then
            self.content = stream:read(len)
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.id)
        self.content = gbk.fromutf8(self.content or "")
        local len = string.len(self.content)
        stream:writeushort(len)
        if len < 256 then
            stream:write(self.content, len)
        end
        return stream:get()
    end
}

packet.CGZdZdRequest = {
    xy_id = packet.XYID_CG_ZDZD_REQUEST,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGZdZdRequest })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.type = stream:readuint()
        if self.type == 1 then
            self.args = {}
            for i = 1, 7 do
                table.insert(self.args, stream:readuint())
            end
        elseif self.type == 4 then
            self.unknow_7 = stream:readuint()
        end
    end
}

packet.GCZhouHuoYueInfo = {
    xy_id = packet.XYID_GC_ZHOU_HUOYUE_INFO,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.GCZhouHuoYueInfo})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.can_get = {}
        self.getd = {}
    end,
    bis = function(self, buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        for i = 1, 0x2A do
            local can_get = self.can_get[i] or 0
            can_get = can_get > define.UINT32_MAX and define.UINT32_MAX or can_get
            stream:writeuint(can_get or 0)
        end
        for i = 1, 0x2A do
            local getd = self.getd[i] or 0
            getd = getd > define.UINT32_MAX and define.UINT32_MAX or getd
            stream:writeuint(getd or 0)
        end
        stream:writeuint(self.week_get)
        stream:writeuint(self.unknow_4)
        stream:writeuint(self.get_award_index)
        stream:writeuint(self.level)
        stream:writeuint(self.day_get)
        return stream:get()
    end
}

packet.GCShengWangInfo = {
    xy_id = packet.XYID_GC_SHENG_WANG_INFO,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.GCShengWangInfo})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.list_1 = {}
        self.list_2 = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readint()
        self.camp = stream:readint()
        self.unknow_3 = stream:readint()
        self.player_camp = stream:readint()
        self.show_wanshige = stream:readint()
        self.unknow_6 = stream:readint()
        self.unknow_7 = stream:readint()
        for i = 1, 3 do
            self.list_1[i] = stream:readint()
        end
        for i = 1, 3 do
            self.list_2[i] = stream:readint()
        end
        self.unknow_10 = stream:readint()
        self.unknow_11 = stream:read(0x190)
        self.unknow_12 = stream:read(0x190)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.unknow_1)
        stream:writeint(self.camp)
        stream:writeint(self.unknow_3)
        stream:writeint(self.player_camp)
        stream:writeint(self.show_wanshige)
        stream:writeint(self.unknow_6)
        stream:writeint(self.unknow_7)
        for i = 1, 6 do
            stream:writeint(self.list_1[i] or 0)
        end
        for i = 1, 6 do
            stream:writeint(self.list_2[i] or 0)
        end
        stream:writeint(self.unknow_10)
        stream:write(self.unknow_11 or "", 0x190)
        for i = 1, 50 do
            local item = self.item_list[i] or { id = 0, count = 0}
            stream:writeint(item.id)
            stream:writeint(item.count)
        end
        stream:writeint(0)
        return stream:get()
    end
}

packet.CGCharUpdateCurTitle = {
    xy_id = packet.XYID_CG_CHAR_UPDATE_CUR_TITLE,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGCharUpdateCurTitle })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.id = stream:readuint()
        self.id_title_id = stream:readushort()
    end
}

packet.CGWGuildLeagueList = {
    xy_id = packet.XYID_CGW_GUILD_LEAGUE_LIST,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGWGuildLeagueList })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readint()
    end
}

packet.WGCGuildLeagueList = {
    xy_id = packet.XYID_WGC_GUILD_LEAGUE_LIST,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.WGCGuildLeagueList })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = 6924
        self.leagues = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readshort()
        self.size = stream:readuint()
        if self.size <= 512 then
            for i = 1, self.size do
                local league = {}
                league.id = stream:readshort()
                league.creator_guid = stream:readint()
                league.name = stream:read(0x20)
                league.desc = stream:read(0x40)
                league.founded_time = stream:readuint()
                league.creator = stream:read(0x1E)
                league.guild_count = stream:readint()
                table.insert(self.leagues, league)
            end
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeshort(self.unknow_1)
        stream:writeuint(#self.leagues)
        if #self.leagues <= 512 then
            for i = 1, #self.leagues do
                local league = self.leagues[i]
                stream:writeshort(league.id)
                stream:writeint(league.chief_guid)
                league.name = gbk.fromutf8(league.name)
                league.desc = gbk.fromutf8(league.desc)
                league.chief_name = gbk.fromutf8(league.chief_name)
                stream:write(league.name, 0x20)
                stream:write(league.desc, 0x40)
                stream:writeuint(league.founded_time)
                stream:write(league.chief_name, 0x1E)
                stream:writeint(league.guild_count)
            end
        end
        return stream:get()
    end
}

packet.CGWGuildLeagueInfo = {
    xy_id = packet.XYID_CGW_GUILD_LEAGUE_INFO,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGWGuildLeagueInfo })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.league_id = stream:readint()
    end
}

packet.WGCGuildLeagueInfo = {
    xy_id = packet.XYID_WGC_GUILD_LEAGUE_INFO,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.WGCGuildLeagueInfo })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.guilds = {}
        self.unknow = 7497
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow = stream:readshort()
        self.league_id = stream:readshort()
        self.chief_guid = stream:readint()
        self.name = stream:read(0x20)
        self.desc = stream:read(0x40)
        self.create_date = stream:readuint()
        self.chief_name = stream:read(0x1E)
        self.creator = stream:read(0x1E)
        self.member_count = stream:readuint()
        local count = stream:readuint()
        for i = 1, count do
            local guild = {}
            guild.guild_id = stream:readshort()
            guild.chief_guid = stream:readint()
            guild.name = stream:read(0x20)
            guild.join_date = stream:readuint()
            guild.chief_name = stream:read(0x1E)
            guild.member_count = stream:readuint()
            table.insert(self.guilds, guild)
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeshort(self.unknow)
        stream:writeshort(self.league_id)
        stream:writeint(self.chief_guid)
        self.name = gbk.fromutf8(self.name)
        self.desc = gbk.fromutf8(self.desc)
        self.creator = gbk.fromutf8(self.creator)
        self.chief_name = gbk.fromutf8(self.chief_name)
        stream:write(self.name, 0x20)
        stream:write(self.desc, 0x40)
        stream:writeuint(self.founded_time)
        stream:write(self.creator, 0x1E)
        stream:write(self.chief_name, 0x1E)
        stream:writeuint(self.member_count)
        stream:writeuint(#self.guilds)
        for i = 1, #self.guilds do
            local guild = self.guilds[i]
            stream:writeshort(guild.id)
            stream:writeint(guild.chief_guid)
            guild.name = gbk.fromutf8(guild.name)
            guild.chief_name = gbk.fromutf8(guild.chief_name)
            stream:write(guild.name, 0x20)
            stream:writeuint(guild.join_date)
            stream:write(guild.chief_name, 0x1E)
            stream:writeuint(guild.member_count)
        end
        return stream:get()
    end
}

packet.CGWGuildLeagueAskEnter = {
    xy_id = packet.XYID_CGW_GUILD_LEAGUE_ASK_ENTER,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGWGuildLeagueAskEnter })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readint()
        self.league_id = stream:readshort()
    end
}

packet.CGWGuildLeagueQuit = {
    xy_id = packet.XYID_CGW_GUILD_LEAGUE_QUIT,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGWGuildLeagueQuit })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readint()
    end
}

packet.CGWGuildLeagueMemberApplyList = {
    xy_id = packet.XYID_CGW_GUILD_LEAGUE_MEMBER_APPLY_LIST,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGWGuildLeagueMemberApplyList })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readint()
    end
}

packet.WGCGuildLeagueMemberApplyList = {
    xy_id = packet.XYID_WGC_GUILD_LEAGUE_MEMBER_APPLY_LIST,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.WGCGuildLeagueMemberApplyList })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeshort(self.league_id)
        local size = #self.guilds
        size = size > 10 and 10 or size
        stream:writeuint(size)
        for i = 1, size do
            local guild = self.guilds[i]
            guild.name = gbk.fromutf8(guild.name)
            guild.desc = gbk.fromutf8(guild.desc)
            guild.chief_name = gbk.fromutf8(guild.chief_name)
            guild.city_name = gbk.fromutf8(guild.city_name)
            stream:writeshort(guild.id)
            stream:write(guild.name, 0x20)
            stream:write(guild.desc, 0x3E)
            stream:write(guild.chief_name, 0x1E)
            stream:write(guild.city_name, 0x1A)
            stream:writeuint(guild.founded_time)
            stream:writeuchar(guild.level)
            stream:writeuint(guild.member_count)
        end
        return stream:get()
    end
}

packet.CGWGuildLeagueAnswerEnter = {
    xy_id = packet.XYID_CGW_GUILD_LEAGUE_ANSWER_ENTER,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGWGuildLeagueAnswerEnter })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readint()
        self.guild_id = stream:readshort()
        self.answer = stream:readint()
    end
}

packet.WGCRetQueryXBWRankCharts = {
    xy_id = packet.XYID_WGC_RET_QUERY_XBW_RANK_CHARTS,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.WGCRetQueryXBWRankCharts })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.top_list = {}
        self.unknow_4 = -1
        self.unknow_7 = 1
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.status = stream:readuint()
        self.guid = stream:readuint()
        self.type = stream:readuchar()
        self.unknow_4 = stream:readint()
        if self.status == 2 then
            self.rank_count = stream:readuchar()
            for i = 1, 200 do
                local rank = {}
                rank.name = stream:read(0x20)
                rank.rank_value_1 = stream:readuint()
                rank.rank_value_2 = stream:readuint()
                rank.rank_value_3 = stream:readuint()
                rank.level = stream:readushort()
                rank.menpai = stream:readushort()
                rank.win = stream:readuint()
                rank.total = stream:readuint()
                rank.server_id = stream:readuint()
                self.top_list[i] = rank
            end
            self.unknow_7 = stream:readuchar()
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.status)
        stream:writeint(self.guid)
        stream:writeuchar(self.type)
        stream:writeint(self.unknow_4)
        if self.status == 2 then
            stream:writeuchar(self.rank_count)
            for i = 1, 200 do
                local rank = self.top_list[i]
                rank.name = gbk.fromutf8(rank.name)
                stream:write(rank.name, 0x20)
                stream:writeuint(rank.rank_value_1)
                stream:writeuint(rank.rank_value_2)
                stream:writeuint(rank.rank_value_3)
                stream:writeushort(rank.level)
                stream:writeushort(rank.menpai)
                stream:writeuint(rank.win)
                stream:writeuint(rank.total)
                stream:writeuint(rank.server_id)
            end
            stream:writeuchar(self.unknow_7)
        end
        return stream:get()
    end
}

packet.GCMonsterSpeak = 
{
    xy_id = packet.XYID_GC_MONSTER_SPEAK,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCMonsterSpeak })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.m_objID)
        self.speek_content = gbk.fromutf8(self.speek_content)
        local len = string.len(self.speek_content)
        len = len >= 0x40 and 63 or len
        stream:writeuchar(len)
        stream:write(self.speek_content, len)
        return stream:get()
    end
}

packet.GCAuctionSearch = {
    xy_id = packet.XYID_GC_AUCTION_SEARCH,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCAuctionSearch })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.merchandise_list = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.type = stream:readchar()
        self.sub_type = stream:readuchar()
        self.order = stream:readchar() --1从低到高，2从高到低
        self.cur_page_num_1 = stream:readushort()
        self.cur_page_num_2 = stream:readushort()
        self.page_total = stream:readushort()
        local count = stream:readuchar()
        for i = 1, count do
            local merchandise = {}
            merchandise.id = stream:readint()
            merchandise.unknow_1 = stream:readchar()
            merchandise.unknow_2 = stream:readchar()
            merchandise.on_sale_date = stream:readuint()
            merchandise.total_price = stream:readint()
            merchandise.seller_name = stream:read(0x1E)
            merchandise.seller_guid = stream:readint()
            if self.type == 1 then
                --todo GCDetailAttrib_Pet
            else
                merchandise.item = packet.ItemInfo.new()
                merchandise.item:bis(stream)
            end
            table.insert(self.merchandise_list, merchandise)
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.type)
        stream:writeuchar(self.sub_type)
        stream:writeuchar(self.order)
        stream:writeushort(self.cur_page_num)
        stream:writeushort(self.cur_page_num)
        stream:writeushort(self.page_total)
        stream:writeuchar(#self.merchandise_list)
        for _, merchadise in ipairs(self.merchandise_list) do
            stream:writeuint(merchadise.id or 0)
            stream:writeuchar(merchadise.unknow_1 or 0)
            stream:writeuchar(merchadise.unknow_2 or 0)
            stream:writeuint(merchadise.on_sale_date)
            stream:writeuint(merchadise.price)
            merchadise.seller_name = gbk.fromutf8(merchadise.seller_name)
            stream:write(merchadise.seller_name, 0x1E)
            stream:writeint(merchadise.seller_guid)
            if self.type == 1 then
                local pet_detail = require "pet_detail"
                local detail = pet_detail.new()
                detail:init_from_data(merchadise.item)
                local detail_attrib_pet = packet.GCDetailAttrib_Pet.new()
                detail:calculate_pet_detail_attrib(detail_attrib_pet)
                local buffer = detail_attrib_pet:bos()
                stream:write(buffer, string.len(buffer))
            else
                packet.ItemInfo.bos(merchadise.item, stream)
            end
        end
        return stream:get()
    end
}

packet.CGAuctionSearch = {
    xy_id = packet.XYID_CG_AUCTION_SEARCH,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGAuctionSearch })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.type = stream:readchar()
        self.sub_type = stream:readuint()
        self.order = stream:readuchar()
        local len = stream:readuint()
        self.name = stream:read(len)
        self.name = gbk.toutf8(self.name)
        self.page = stream:readshort()
    end
}

packet.CGAuctionSell = {
    xy_id = packet.XYID_CG_AUCTION_SELL,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGAuctionSell })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.type = stream:readuchar()
        if self.type == 1 then
            self.pet_guid = packet.PetGUID.new()
            self.pet_guid:bis(stream)
        elseif self.type == 2 then
            self.item_guid = packet.ItemGUID.new()
            self.item_guid:bis(stream)
        end
        self.pos = stream:readuchar()
        self.unknow_2 = stream:readchar()
        self.price = stream:readuint()
    end
}

packet.CGAuctionBoxList = {
    xy_id = packet.XYID_CG_AUCTION_BOX_LIST,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGAuctionBoxList })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end
}

packet.CGAuctionTakeBack = {
    xy_id = packet.XYID_CG_AUCTION_TAKE_BACK,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGAuctionTakeBack })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.type = stream:readuchar()
        self.index = stream:readuchar()
    end
}

packet.GCAuctionChangeStatus = {
    xy_id = packet.XYID_GC_AUCTION_CHANGE_STATUS,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCAuctionChangeStatus })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.prices = {}
        self.unknow_1 = 1
        self.unknow_2 = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readuchar()
        self.type = stream:readuchar()
        self.unknow_2 = stream:readchar()
        self.bag_index = stream:readuchar()
        self.serial = stream:readuchar()
        local count = stream:readuchar()
        for i = 1, count do
            local price = stream:readuint()
            table.insert(self.prices, price)
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.unknow_1)
        stream:writeuchar(self.type)
        stream:writechar(self.unknow_2)
        stream:writeuchar(self.bag_index)
        stream:writeuchar(self.serial)
        stream:writeuchar(#self.prices)
        for _, price in ipairs(self.prices) do
            stream:writeuint(price)
        end
        return stream:get()
    end
}

packet.GCAuctionBoxList = {
    xy_id = packet.XYID_GC_AUCTION_BOX_LIST,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCAuctionBoxList })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.merchandise_list = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.flag = stream:readushort()
        for i = 1, 10 do
            local bit = (0x1 << (i - 1))
            if (bit & self.flag) == bit then
                local merchandise = {}
                merchandise.id = stream:readint()
                merchandise.unknow_1 = stream:readchar()
                merchandise.unknow_2 = stream:readchar()
                merchandise.on_sale_date = stream:readuint()
                merchandise.total_price = stream:readint()
                merchandise.seller_name = stream:read(0x1E)
                merchandise.seller_guid = stream:readint()
                merchandise.item = packet.ItemInfo.new()
                merchandise.item:bis(stream)
                self.merchandise_list[i] = merchandise
            end
        end
        for i = 11, 15 do
            local bit = (0x1 << (i - 1))
            if (bit & self.flag) == bit then
                local merchandise = {}
                merchandise.id = stream:readint()
                merchandise.unknow_1 = stream:readchar()
                merchandise.unknow_2 = stream:readchar()
                merchandise.on_sale_date = stream:readuint()
                merchandise.total_price = stream:readint()
                merchandise.seller_name = stream:read(0x1E)
                merchandise.seller_guid = stream:readint()
                merchandise.pet = packet.GCDetailAttrib_Pet.new()
                merchandise.pet:bis(stream)
                self.merchandise_list[i] = merchandise
            end
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        self.flag = 0
        for i = 1, 10 do
            local merchadise = self.merchadise_list.items[i]
            if merchadise then
                self.flag = self.flag | (1 << (i - 1))
            end
        end
        for i = 11, 15 do
            local merchadise = self.merchadise_list.pets[i - 10]
            if merchadise then
                self.flag = self.flag | (1 << (i - 1))
            end
        end
        stream:writeshort(self.flag)
        for i = 1, 10 do
            local bit = (0x1 << (i - 1))
            if (bit & self.flag) == bit then
                local merchadise = self.merchadise_list.items[i]
                stream:writeint(merchadise.id or 0)
                if merchadise.status == "on_sale" then
                    stream:writechar(merchadise.unknow_1 or 1)
                elseif merchadise.status == "off" then
                    stream:writechar(merchadise.unknow_1 or 2)
                elseif merchadise.status == "buyed" then
                    stream:writechar(merchadise.unknow_1 or 3)
                else
                    stream:writechar(merchadise.unknow_1 or 0)
                end
                stream:writechar(i)
                stream:writeuint(merchadise.on_sale_date)
                stream:writeuint(merchadise.price)
                merchadise.seller_name = gbk.fromutf8(merchadise.seller_name)
                stream:write(merchadise.seller_name, 0x1E)
                stream:writeint(merchadise.seller_guid)
                packet.ItemInfo.bos(merchadise.item, stream)
            end
        end
        for i = 11, 15 do
            local bit = (0x1 << (i - 1))
            if (bit & self.flag) == bit then
                local merchadise = self.merchadise_list.pets[i - 10]
                stream:writeint(merchadise.id or 0)
                if merchadise.status == "on_sale" then
                    stream:writechar(merchadise.unknow_1 or 1)
                elseif merchadise.status == "off" then
                    stream:writechar(merchadise.unknow_1 or 2)
                elseif merchadise.status == "buyed" then
                    stream:writechar(merchadise.unknow_1 or 3)
                else
                    stream:writechar(merchadise.unknow_1 or 0)
                end
                stream:writechar(i)
                stream:writeuint(merchadise.on_sale_date)
                stream:writeuint(merchadise.price)
                merchadise.seller_name = gbk.fromutf8(merchadise.seller_name)
                stream:write(merchadise.seller_name, 0x1E)
                stream:writeint(merchadise.seller_guid)
                local pet_detail = require "pet_detail"
                local detail = pet_detail.new()
                detail:init_from_data(merchadise.item)
                local detail_attrib_pet = packet.GCDetailAttrib_Pet.new()
                detail:calculate_pet_detail_attrib(detail_attrib_pet)
                local buffer = detail_attrib_pet:bos()
                stream:write(buffer, string.len(buffer))
            end
        end
        return stream:get()
    end
}

packet.CGAuctionBuy = {
    xy_id = packet.XYID_CG_AUCTION_BUY,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGAuctionBuy })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.type = stream:readuchar()
        if self.type == 1 then
            self.pet_guid = packet.PetGUID.new()
            self.pet_guid:bis(stream)
        elseif self.type == 2 then
            self.item_guid = packet.ItemGUID.new()
            self.item_guid:bis(stream)
        end
        self.seller_guid = stream:readint()
        self.index = stream:readuchar()
        self.price = stream:readuint()
    end
}

packet.CGAuctionMultiBuyItem = {
    xy_id = packet.XYID_CG_AUCTION_MULTI_BUY_ITEM,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGAuctionMultiBuyItem })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.buy_items = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        local count = stream:readuchar()
        if count <= 0xA then
            for i = 1, count do
                local buy = {}
                buy.item_guid = packet.ItemInfo.new()
                buy.item_guid:bis(stream)
                buy.seller_guid = stream:readint()
                buy.index = stream:readuchar()
                buy.price = stream:readuint()
                table.insert(self.buy_items, buy)
            end
        end
    end
}

packet.CGAuctionGetYB = {
    xy_id = packet.XYID_CG_AUCTION_GET_YB,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGAuctionGetYB })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.type = stream:readuchar()
        self.index = stream:readuchar()
    end
}

packet.CGAuctionModify = {
    xy_id = packet.XYID_CG_AUCTION_MODIFY,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGAuctionModify })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.type = stream:readuchar()
        self.index = stream:readuchar()
        self.new_price = stream:readuint()
    end
}

packet.CGAuctionExpireBack = {
    xy_id = packet.XYID_CG_AUCTION_EXPIRE_BACK,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGAuctionExpireBack })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.type = stream:readuchar()
        self.index = stream:readuchar()
    end
}

packet.GCAuctionChangeMoney = {
    xy_id = packet.XYID_CG_AUCTION_CHANGE_MONEY,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCAuctionChangeMoney })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.type = stream:readuchar()
        self.index = stream:readuchar()
        self.new_price = stream:readuint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.type)
        stream:writeuchar(self.index)
        stream:writeuint(self.new_price)
        return stream:get()
    end
}

packet.GCAuctionError = {
    ERR_CODE = {
        SELL_LIST_FULL = 8,
    },
    xy_id = packet.XYID_CG_AUCTION_ERROR,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCAuctionError })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.result = stream:readuchar()
        local len = stream:readushort()
        self.msg = stream:read(len)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.result)
        self.msg = gbk.fromutf8(self.msg)
        local len = string.len(self.msg)
        stream:writeushort(len)
        stream:write(self.msg, len)
        return stream:get()
    end
}

packet.GCByname = {
    xy_id = packet.XYID_GC_BY_NAME,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCByname })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.type)
        if self.type == 0x11 then
            stream:writeuchar(self.num)
        elseif self.type == 0x12 or self.type == 0x13 or self.type == 0x21 or self.type == 0x22 then
            self.data = gbk.fromutf8(self.data)
            local len = string.len(self.data)
            stream:writeuchar(len)
            stream:write(self.data, len)
        end
        return stream:get()
    end 
}

packet.CGByname = {
    xy_id = packet.XYID_CG_BY_NAME,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGByname })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.type = stream:readuchar()
        local len = stream:readuchar()
        if self.type == 0x11 or self.type == 0x12 
            or self.type == 0x13 or self.type == 0x14
            or self.type == 0x15 or self.type == 0x1B
            or self.type == 0x1C or self.type == 0x1F
            or self.type == 0x20 or self.type == 0x21
            or self.type == 0x22 then
                self.str = stream:read(len)
                self.str = gbk.toutf8(self.str)
            end
    end
}

packet.GCNewBus = {
    xy_id = packet.XYID_GC_NEW_BUS,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.GCNewBus})
        o:ctor()
        return o
    end, 
    ctor = function(self)
        self.path = {}
    end,
    bis = function(self, buffer)
    end,
    bos = function(self, buffer)
        local stream = bostream.new()
        stream:writeint(self.m_objID)
        stream:writeint(self.data_id)
        stream:writefloat(self.world_pos.x)
        stream:writefloat(self.world_pos.y)
        stream:writeint(0)
        stream:writeuint(#self.path)
        if #self.path <= 8 then
            for _, pos in ipairs(self.path) do
                stream:writefloat(pos.x)
                stream:writefloat(pos.y)
            end
        end
        return stream:get()
    end
}

packet.GCNewBus_Move = {
    xy_id = packet.XYID_GC_NEW_BUS_MOVE,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.GCNewBus_Move})
        o:ctor()
        return o
    end, 
    ctor = function(self)
        self.path = {}
    end,
    bis = function(self, buffer)
    end,
    bos = function(self, buffer)
        local stream = bostream.new()
        stream:writeint(self.m_objID)
        stream:writeint(self.data_id)
        stream:writefloat(self.world_pos.x)
        stream:writefloat(self.world_pos.y)
        stream:writefloat(self.world_pos.z)
        stream:writefloat(self.next_pos.x)
        stream:writefloat(self.next_pos.y)
        stream:writefloat(self.next_pos.z)
		stream:writeint(-1)
        stream:writeuint(#self.path)
        if #self.path <= 8 then
            for _, pos in ipairs(self.path) do
                stream:writefloat(pos.x)
                stream:writefloat(pos.y)
            end
        end
        return stream:get()
    end
}

packet.GCBusMove = {
    xy_id = packet.XYID_GC_BUS_MOVE,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.GCBusMove})
        o:ctor()
        return o
    end, 
    ctor = function(self)
    end,
    bis = function(self, buffer)
    end,
    bos = function(self, buffer)
        local stream = bostream.new()
        stream:writeint(self.m_objID)
        stream:writefloat(self.world_pos.x)
        stream:writefloat(self.world_pos.y)
        stream:writefloat(self.next_pos.x)
        stream:writefloat(self.next_pos.y)
        stream:writefloat(self.next_pos.z)
		stream:writeint(-1)
        return stream:get()
    end
}

packet.GCBusAddPassenger = {
    xy_id = packet.XYID_GC_BUS_ADD_PASSENGER,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCBusAddPassenger })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.bus_id = stream:readint()
        self.before_num = stream:readint()
        self.m_objID = stream:readint()
    end,
    bos = function(self, buffer)
        local stream = bostream.new()
        stream:writeint(self.bus_id)
        stream:writeint(self.before_num)
        stream:writeint(self.m_objID)
        return stream:get()
    end
}

packet.GCBusRemoveAllPassenger = {
    xy_id = packet.XYID_GC_BUS_REMOVE_ALL_PASSENGER,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCBusRemoveAllPassenger })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.bus_id = stream:readint()
    end,
    bos = function(self, buffer)
        local stream = bostream.new()
        stream:writeint(self.bus_id)
        return stream:get()
    end
}

packet.GCCityList = {
    xy_id = packet.XYID_GC_CITY_LIST,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCCityList })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.city_list = {}
        for i = 1, 0x36 do
            self.city_list[i] = stream:readuchar()
        end
    end,
    bos = function(self, buffer)
        local stream = bostream.new()
        for i = 1, 0x36 do
            stream:writeuchar(self.city_list[i] or 2)
        end
        return stream:get()
    end
}

packet.GCPhoenixPlainWarScore = {
    xy_id = packet.XYID_GC_PHOENIX_PLAIN_WAR_SCORE,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPhoenixPlainWarScore })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.score_list = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readuint()
        for i = 1, 10 do
            local score = {}
            score.league_id = stream:readshort()
            score.league_name = stream:read(0x20)
            score.guild_id_1 = stream:readshort()
            score.guild_id_2 = stream:readshort()
            score.guild_id_3 = stream:readshort()
            score.guild_name_1 = stream:read(0x20)
            score.guild_name_2 = stream:read(0x20)
            score.guild_name_3 = stream:read(0x20)
            score.crystal_hold_score = stream:readuint()
            score.flag_capture_score = stream:readuint()
            self.score_list[i] = score
        end
    end,
    bos = function(self, buffer)
        local stream = bostream.new()
        stream:writeuint(0)
        for i = 1, 10 do
            local score = self.score_list[i] or {}
            stream:writeshort(score.league_id or define.INVAILD_ID)
            score.league_name = gbk.fromutf8(score.league_name or "")
            score.guild_name_1 = gbk.fromutf8(score.guild_name_1 or "")
            score.guild_name_2 = gbk.fromutf8(score.guild_name_2 or "")
            score.guild_name_3 = gbk.fromutf8(score.guild_name_3 or "")
            stream:write(score.league_name, 0x20)
            stream:writeshort(score.guild_id_1 or define.INVAILD_ID)
            stream:writeshort(score.guild_id_2 or define.INVAILD_ID)
            stream:writeshort(score.guild_id_3 or define.INVAILD_ID)
            stream:write(score.guild_name_1 or "", 0x20)
            stream:write(score.guild_name_2 or "", 0x20)
            stream:write(score.guild_name_3 or "", 0x20)
			if not score.crystal_hold_score or score.crystal_hold_score < 0 then
				score.crystal_hold_score = 0
			elseif score.crystal_hold_score > 4294967295 then
				score.crystal_hold_score = 4294967295
			end
            stream:writeuint(score.crystal_hold_score)
			if not score.flag_capture_score or score.flag_capture_score < 0 then
				score.flag_capture_score = 0
			elseif score.flag_capture_score > 4294967295 then
				score.flag_capture_score = 4294967295
			end
            stream:writeuint(score.flag_capture_score)
        end
        return stream:get()
    end
}

packet.GCPhoenixPlainWarFlagPos = {
    xy_id = packet.XYID_GC_PHOENIX_PLAIN_WAR_FLAG_POS,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPhoenixPlainWarFlagPos })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.world_pos = {}
        self.world_pos.x = stream:readushort()
        self.world_pos.y = stream:readushort()
        self.hold_flag_name = stream:read(0x1E)
        self.hold_flag_guild_name = stream:read(0x20)
    end,
    bos = function(self, buffer)
        local stream = bostream.new()
        stream:writeushort(math.floor(self.world_pos.x))
        stream:writeushort(math.floor(self.world_pos.y))
        self.hold_flag_name = gbk.fromutf8(self.hold_flag_name)
        self.hold_flag_guild_name = gbk.fromutf8(self.hold_flag_guild_name)
        stream:write(self.hold_flag_name, 0x1E)
        stream:write(self.hold_flag_guild_name, 0x20)
        return stream:get()
    end
}

packet.GCPhoenixPlainWarCrystalPos = {
    xy_id = packet.XYID_GC_PHOENIX_PLAIN_WAR_CRYSTAL_POS,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPhoenixPlainWarCrystalPos })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.crystal_poss = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        for i = 1, 4 do
            local pos = {}
            pos.world_pos = {}
            pos.world_pos.x = stream:readushort()
            pos.world_pos.y = stream:readushort()
            pos.league_id = stream:readshort()
            pos.guild_id = stream:readshort()
            pos.league_name = stream:read(0x20)
            pos.hp = stream:readushort()
            self.crystal_poss[i] = pos
        end
    end,
    bos = function(self, buffer)
        local stream = bostream.new()
        for i = 1, 4 do
            local pos = self.crystal_poss[i] or { 
                world_pos = { x = define.INVAILD_ID, y = define.INVAILD_ID},
                league_id = define.INVAILD_ID, guild_id = define.INVAILD_ID,
                league_name = "", hp = 0
             }
            stream:writeshort(math.floor(pos.world_pos.x))
            stream:writeshort(math.floor(pos.world_pos.y))
            stream:writeshort(pos.league_id)
            stream:writeshort(pos.guild_id)
            pos.league_name = gbk.fromutf8(pos.league_name)
            stream:write(pos.league_name, 0x20)
            stream:writeushort(pos.hp)
        end
        return stream:get()
    end
}

packet.GCPhoenixPlainWarCampInfo = {
    xy_id = packet.XYID_GC_PHOENIX_PLAIN_WAR_CAMP_INFO,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPhoenixPlainWarCampInfo })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.camp_infos = { xs = {}, ys = {}, names = {}}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.count = stream:readuint()
        if self.count <= 400 then
            for i = 1, self.count do
                self.camp_infos.xs[i] = stream:readshort()
            end
            for i = 1, self.count do
                self.camp_infos.ys[i] = stream:readshort()
            end
            for i = 1, self.count do
                self.camp_infos.names[i] = stream:read(0x1E)
            end
        end
    end,
    bos = function(self, buffer)
        local stream = bostream.new()
        stream:writeuint(self.count)
        if self.count <= 400 then
            for i = 1, self.count do
                stream:writeushort(math.floor(self.camp_infos.xs[i]))
            end
            for i = 1, self.count do
                stream:writeushort(math.floor(self.camp_infos.ys[i]))
            end
            for i = 1, self.count do
                local name = self.camp_infos.names[i]
                name = gbk.fromutf8(name)
                stream:write(name, 0x1E)
            end
        end
        return stream:get()
    end
}

packet.WGCGuild = {
    xy_id = define.INVAILD_ID,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.WGCGuild })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeshort(self.id)
        stream:write(self.name, 0x1A)
        stream:writeint(self.unknow_1 or 0)
        stream:writeint(self.unknow_2 or 0)
        stream:writeint(self.unknow_3 or 0)
        stream:writeint(self.founded_money or 10000000)
        stream:writeint(self.unknow_4 or 53)
        stream:writeint(self.unknow_5 or 53)
        stream:write(self.unknow_6 or "", 20)
        stream:writeuint(self.kuozhang) 
        stream:writeint(self.unknow_7 or 10)
        stream:writeint(self.unknow_8 or 10)
        stream:writeint(self.unknow_9 or 10)
        stream:writeint(self.unknow_10 or 10)
        stream:writeint(self.unknow_11 or 10)
        stream:writeint(self.unknow_12 or 10)
        stream:writeint(self.unknow_13 or 10)
        return stream:get()
    end
}

packet.WGCZhengTao = {
    xy_id = define.INVAILD_ID,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.WGCZhengTao })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.sub_type)
        stream:writeuint(self.founded_money)
        stream:writeuint(self.kuozhang)
        self.list = self.list or {}
        for i = 1, 32 do
            local l = self.list[i] or { id = define.INVAILD_ID, remain_time = 0, name = ""}
            stream:writeshort(l.id)
            stream:writeshort(define.INVAILD_ID)
            stream:writeint(math.ceil(l.remain_time / 1000 / 60))
            l.name = gbk.fromutf8(l.name)
            stream:write(l.name, 0x20)
        end
        stream:writeint(self.unknow_3 or 0)
        return stream:get()
    end
}

packet.WGCNoitceBeWar = {
    xy_id = define.INVAILD_ID,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.WGCNoitceBeWar })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(0)
        stream:writeshort(self.tar_guild_id)
        stream:writeshort(self.my_guild_id)
        return stream:get()
    end
}

packet.WGCIntNums = {
    xy_id = define.INVAILD_ID,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.WGCIntNums })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeshort(define.INVAILD_ID)
        stream:writeuchar(31)
        stream:writeuchar(122)
        for i = 1, 21 do
            stream:writeuint(i)
        end
        return stream:get()
    end
}

packet.GCWGCPacket = {
    xy_id = packet.XYID_WGC_PACKET,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCWGCPacket })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.type = stream:readuchar()
        self.len = stream:readuint()
        if self.type == 4 then
            local zhengtao_1 = {}
            zhengtao_1.guild_id = stream:readshort()
            zhengtao_1.guild_name = stream:read(0x1A)
            zhengtao_1.unknow_1 = stream:readint()
            zhengtao_1.unknow_2 = stream:readint()
            zhengtao_1.unknow_3 = stream:readint()
            zhengtao_1.founded_money = stream:readint()
            zhengtao_1.unknow_4 = stream:readint()
            zhengtao_1.unknow_5 = stream:readint()
            zhengtao_1.unknow_6 = stream:read(20)
            zhengtao_1.kuozhang = stream:readuint()    
            zhengtao_1.unknow_7 = stream:readint()
            zhengtao_1.unknow_8 = stream:readint()
            zhengtao_1.unknow_9 = stream:readint()
            zhengtao_1.unknow_10 = stream:readint()
            zhengtao_1.unknow_11 = stream:readint()
            zhengtao_1.unknow_12 = stream:readint()
            zhengtao_1.unknow_13 = stream:readint()
            self.zhengtao_1 = zhengtao_1
        elseif self.type == 10 then
            local zhengtao_2 = {}
            zhengtao_2.sub_type = stream:readuint() -- 3
            zhengtao_2.founded_money = stream:readuint()
            zhengtao_2.kuozhang = stream:readuint()
            zhengtao_2.list = {}
            for i = 1, 32 do
                local l = {}
                l.unknow_1 = stream:readint()
                l.unknow_2 = stream:read(36)
                zhengtao_2.list[i] = l
            end
            zhengtao_2.unknow_3 = stream:readint()
            self.zhengtao_2 = zhengtao_2
        elseif self.type == 11 then
            local notice_be_war = {}
            notice_be_war.unknow = stream:readint()
            notice_be_war.my_guild_id = stream:readshort()
            notice_be_war.tar_guild_id = stream:readshort()
            self.notice_be_war = notice_be_war
        else
            self.data = {}
            for i = 1, self.len do
                self.data[i] = stream:readuchar()
            end
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.type)
        local buffer
        if self.type == 4 then
            buffer = packet.WGCGuild.bos(self.wgc_guild)
        elseif self.type == 10 then
            buffer = packet.WGCZhengTao.bos(self.wgc_zhengtao)
        elseif self.type == 11 then
            buffer = packet.WGCNoitceBeWar.bos(self.notice_be_war)
        elseif self.type == 12 then
            buffer = packet.WGCIntNums.bos(self.wgc_int_nums)
        end
        local len = string.len(buffer)
        stream:writeuint(len)
        stream:write(buffer, len)
        return stream:get()
    end
}

packet.GCCityAttr = {
    xy_id = packet.XYID_GC_CITY_ATTR,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCCityAttr })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.flag = stream:readuint()
        if (self.flag & 0x1) == 0x1 then
            self.level = stream:readuint()
        end
        if (self.flag & 0x2) == 0x2 then
            self.city_name = stream:read(0x18)
        end
        if (self.flag & 0x4) == 0x4 then
            self.building_index = stream:readuchar()
            self.building_id = stream:readushort()
            local unknow_2 = {}
            for i = 1, 0x83E do
                unknow_2[i] = stream:readuchar()
            end
            self.unknow_3 = stream:readuchar()
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.flag)
        if (self.flag & 0x1) == 0x1 then
            stream:writeuint(self.level)
        end
        if (self.flag & 0x2) == 0x2 then
            self.city_name = gbk.fromutf8(self.city_name)
            stream:write(self.city_name, 0x18)
        end
        if (self.flag & 0x4) == 0x4 then
            stream:writeuchar(self.building_index)
            stream:writeushort(self.building_id)
            stream:write("", 0x83E)
            stream:writeuchar(0)
        end
        return stream:get()
    end
}

packet.GCTeamLeaderAskInvite = {
    xy_id = packet.XYID_GC_TEAM_LEADER_ASK_INVITE,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCTeamLeaderAskInvite })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.source_guid = stream:readint()
        self.dest_guid = stream:readint()
        local source_name_size = stream:readuchar()
        local dest_name_size = stream:readuchar()
        if source_name_size <= 0x1E then
            self.source_name = stream:read(source_name_size)
        end
        if dest_name_size <= 0x1E then
            self.dest_name = stream:read(dest_name_size)
        end
        self.unknow_1 = stream:readint()
        self.unknow_2 = stream:readint()
        self.unknow_3 = stream:readshort()
        self.unknow_4 = stream:readshort()
    end,
    bos = function(self, buffer)
        local stream = bostream.new()
        stream:writeint(self.source_guid)
        stream:writeint(self.dest_guid)
        self.source_name = gbk.fromutf8(self.source_name)
        self.dest_name = gbk.fromutf8(self.dest_name)
        local source_name_size = string.len(self.source_name)
        local dest_name_size = string.len(self.dest_name)
        stream:writeuchar(source_name_size)
        stream:writeuchar(dest_name_size)
        if source_name_size <= 0x1E then
            stream:write(self.source_name, source_name_size)
        end
        if dest_name_size <= 0x1E then
            stream:write(self.dest_name, dest_name_size)
        end
        stream:writeint(self.unknow_1 or define.INVAILD_ID)
        stream:writeint(self.unknow_2 or define.INVAILD_ID)
        stream:writeshort(self.unknow_3 or define.INVAILD_ID)
        stream:writeshort(self.unknow_4 or define.INVAILD_ID)
        return stream:get()
    end
}

packet.GCNotifyGoodBad = {
    xy_id = packet.XYID_GC_NOTIFY_GOOD_BAD,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCNotifyGoodBad })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.mode)
        stream:writeint(self.bonus)
        return stream:get()
    end
}

packet.GCGuildError = {
    xy_id = packet.XYID_GC_GUILD_ERROR,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCGuildError })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writechar(self.error_code)
        return stream:get()
    end
}

packet.CGEXchangeYuanBaoPiao  = {
    xy_id = packet.XYID_CG_EXCHANGE_YUANBAO_PIAO,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGEXchangeYuanBaoPiao })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        stream:read(40)
        local b = stream:read(4)
        self.count = string.unpack(">I4", b)
    end
}

packet.CGSecKillRemoveItem = {
    xy_id = packet.XYID_CG_SEC_KILL_REMOVE_ITEM,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGSecKillRemoveItem })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.is_discard = stream:readuchar()
        self.is_all = stream:readuchar()
        self.index = stream:readuchar()
    end
}

packet.GCSecKillRemoveItem = {
    xy_id = packet.XYID_GC_SEC_KILL_REMOVE_ITEM,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCSecKillRemoveItem })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.is_discard = stream:readuchar()
        self.index = stream:readuchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.is_discard)
        stream:writeuchar(self.index)
        return stream:get()
    end
}

packet.GCMissionHaveDoneFlag = {
    xy_id = packet.XYID_GC_MISSION_HAVE_DONE_FLAG,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCMissionHaveDoneFlag })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.mission_id = stream:readint()
        self.flag = stream:readint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.mission_id)
        stream:writeint(self.flag)
        return stream:get()
    end
}

packet.GCJiYuanShopInfo = {
    xy_id = packet.XYID_GC_JIYUAN_SHOP_INFO,
    new = function()
        local o = o or {}
        setmetatable(o, { __index = packet.GCJiYuanShopInfo })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:read(0x640)
        self.m_objID = stream:readint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:write("", 400)
        stream:writeint(self.item_id or 0)
        stream:writeint(self.item_count or 0)
        stream:write("", 1192)
        stream:writeint(self.m_objID)
        return stream:get()
    end
}

packet.CGAskTargetESPlan = {
    xy_id = packet.XYID_CG_ASK_TARGET_ES_PLAN,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.CGAskTargetESPlan })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.m_objID = stream:readint()
    end
}

packet.GCTarExteriorSharePlan = {
    xy_id = packet.XYID_GC_TAR_EXTERIOR_SHARE_PLAN,
    new = function()
        local o = o or {}
        setmetatable(o, { __index = packet.GCTarExteriorSharePlan })
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow_1 = 16
        self.unknow_3 = 0
        self.unknow_4 = 10
        self.unknow_5 = 1
        self.unknow_6 = 1
        self.unknow_7 = 0
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readuchar()
        self.m_objID = stream:readint()
        self.unknow_3 = stream:readint()
        self.unknow_4 = stream:readshort()
        self.unknow_5 = stream:readshort()
        self.unknow_6 = stream:readshort()
        self.unknow_7 = stream:readint()
        self.list_1 = {}
        for i = 1, 6 do
            self.list_1[i] = stream:readint()
        end
        self.list_2 = {}
        for i = 1, 6 do
            local l = {}
            l.unknow_1 = stream:readint()
            l.unknow_2 = stream:readchar()
            l.unknow_3 = stream:readshort()
            l.unknow_4 = stream:readuint()
            l.unknow_5 = stream:readchar()
            l.unknow_6 = stream:read(0xC)
            self.list_2[i] = l
        end
        self.list_3 = {}
        for i = 1, 6 do
            local l = {}
            l.unknow_1 = stream:readshort()
            l.unknow_2 = stream:readchar()
            l.unknow_3 = stream:readint()
            self.list_3[i] = l
        end
        self.list_4 = {}
        for i = 1, 6 do
            local l = {}
            l.unknow_1 = stream:readshort()
            l.unknow_3 = stream:readint()
            self.list_4[i] = l
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.unknow_1)
        stream:writeint(self.m_objID)
        stream:writeint(self.unknow_3)
        stream:writeshort(self.unknow_4)
        stream:writeshort(self.unknow_5)
        stream:writeshort(self.unknow_6)
        stream:writeint(self.unknow_7)
        for i = 1, 6 do
            stream:writeint(define.INVAILD_ID)
        end
        for i = 1, 6 do
            stream:writeint(0)
            stream:writechar(0)
            stream:writeshort(0)
            stream:writeuint(0)
            stream:writechar(0)
            stream:write("", 0xC)
        end
        for i = 1, 6 do
            stream:writeshort(define.INVAILD_ID)
            stream:writechar(0)
            stream:writechar(0)
        end
        for i = 1, 6 do
            stream:writeshort(define.INVAILD_ID)
            stream:writeint(define.INVAILD_ID)
        end
        return stream:get()
    end
}

packet.CGSetMoodToHead = {
    xy_id = packet.XYID_CG_SET_MOOD_TO_HEAD,
    new = function()
        local o = o or {}
        setmetatable(o, { __index = packet.CGSetMoodToHead })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.show = stream:readuchar()
    end
}

packet.CGTeamChangeOption = {
    xy_id = packet.XYID_CG_TEAM_CHANGE_OPTION,
    new = function()
        local o = o or {}
        setmetatable(o, { __index = packet.CGTeamChangeOption })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readint()
        self.exp_mode = stream:readulong()
    end
}

packet.GCTeamOptionChanged = {
    xy_id = packet.XYID_TEAM_OPTION_CHANGED,
    new = function()
        local o = o or {}
        setmetatable(o, { __index = packet.GCTeamOptionChanged })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readint()
        self.exp_mode = stream:readulong()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.unknow_1 or 0)
        stream:writeulong(self.exp_mode)
        return stream:get()
    end
}

packet.GCPetSoulRanSe = {
    xy_id = packet.XYID_GC_PET_SOUL_RANSE,
    new = function()
        local o = {}
        setmetatable(o, { __index = packet.GCPetSoulRanSe })
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.type = stream:readint()  --3显示界面 2刷新
        self.select = stream:readint()
        self.list = {}
        for i = 1, 50 do
            local colors = {}
            colors[1] = stream:readchar()
            colors[2] = stream:readchar()
            colors[3] = stream:readchar()
            table.insert(self.list, colors)
        end
        self.target_id = stream:readint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.type)
        stream:writeint(self.select)
        for i = 1, 50 do
            local colors = self.list[i]
            stream:writeuchar(colors[1])
            stream:writeuchar(colors[2])
            stream:writeuchar(colors[3])
        end
        stream:writeint(self.target_id)
        return stream:get()
    end
}

packet.GCRMBChatActionInfo = {
    xy_id = packet.XYID_GC_RMB_CHAT_ACTION_INFO,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.GCRMBChatActionInfo})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readint()
        self.unknow_2 = stream:readint()
        self.list_1 = {}
        for i = 1, 4 do
            self.list_1[i] = stream:readint()
        end
        self.unknow_3 = stream:readint()
        self.list_2 = {}
        for i = 1, 4 do
            self.list_2[i] = stream:readint()
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.unknow_1)
        stream:writeint(self.unknow_2)
        for i = 1, 4 do
            stream:writeint(self.list_1[i])
        end
        stream:writeint(self.unknow_3)
        for i = 1, 4 do
            stream:writeint(self.list_2[i])
        end
        return stream:get()
    end
}

packet.CGAskCheDiFuLuData = {
    xy_id = packet.XYID_CG_ASK_CHEDIFULU_DATA,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.CGAskCheDiFuLuData})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readchar()
        self.unknow_2 = stream:readchar()
    end
}

packet.CGPetExteriorCollectionRequest = {
    xy_id = packet.XYID_CG_PET_EXTERIOR_COLLECTION_REQUEST,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.CGPetExteriorCollectionRequest})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.type = stream:readint()
        if self.type == 1 then
            self.pet_guid = packet.PetGUID.new()
            self.pet_guid:bis(stream)
        elseif self.type == 2 then
            self.m_objID = stream:readint()
        end
    end
}

packet.GCPetExteriorCollectionInfo = {
    xy_id = packet.XYID_GC_PET_EXTERIOR_COLLECTION_INFO,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.GCPetExteriorCollectionInfo})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.type = stream:readint()
        self.list = {}
        if self.type == 0 then
            for i = 1, 1700 do
                self.list[i] = stream:readchar()
            end
            self.unknow_2 = stream:readint()
        elseif self.type == 1 then
            for i = 1, 1700 do
                self.list[i] = stream:readchar()
            end
            self.unknow_2 = stream:readint()
            self.pet_guid = packet.PetGUID.new()
            self.pet_guid:bis(stream)
        elseif self.type == 2 then
            for i = 1, 1700 do
                self.list[i] = stream:readchar()
            end
            self.unknow_2 = stream:readint()
            self.pet_guid = packet.PetGUID.new()
            self.pet_guid:bis(stream)
        elseif self.type == 3 then
            for i = 1, 1700 do
                self.list[i] = stream:readchar()
            end
            self.unknow_2 = stream:readint()
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.type)
        if self.type == 0 then
            for i = 1, 1700 do
                stream:writechar(self.list[i])
            end
            stream:writeint(self.unknow_2)
        elseif self.type == 1 then
            for i = 1, 1700 do
                stream:writechar(self.list[i])
            end
            stream:writeint(self.unknow_2)
            packet.PetGUID.bos(self.pet_guid, stream)
        elseif self.type == 2 then
            for i = 1, 1700 do
                stream:writechar(self.list[i])
            end
            stream:writeint(self.unknow_2)
            packet.PetGUID.bos(self.pet_guid, stream)
        elseif self.type == 3 then
            for i = 1, 1700 do
                stream:writechar(self.list[i])
            end
            stream:writeint(self.unknow_2)
        end
        return stream:get()
    end
}

packet.GCTJCPVPCmnData = {
    xy_id = packet.XYID_GC_TJC_PVP_CMN_DATA,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.GCTJCPVPCmnData})
        o:ctor()
        return o
    end,
    ctor = function(self) self.buy_counts = { 0, 0, 0, 0, 0, 1} end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readint()
        self.buy_counts = {}
        for i = 1, 6 do
            self.buy_counts[i] = stream:readuint()
        end
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(1)
        for i = 1, 6 do
            stream:writeint(self.buy_counts[i])
        end
        return stream:get()
    end
}

packet.GCAbilityExp = {
    xy_id = packet.XYID_GC_ABILITY_EXP,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.GCAbilityExp})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeushort(self.ability)
        stream:writeuint(self.exp)
        stream:writeuint(self.exp_top)
        return stream:get()
    end
}

packet.CGReportWaigua = {
    xy_id = packet.XYID_CG_REPORT_WAIGUA,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.CGReportWaigua})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.type = stream:readuchar()
        self.name = stream:read(0x1E)
        if self.type == 1 then
            self.guid = stream:readint()
        end
    end
}

packet.WGCRetQueryQingRenJieTopList = {
    xy_id = packet.XYID_WGC_RET_QUERY_QINGRENJIE_TOP_LIST,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.WGCRetQueryQingRenJieTopList})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.rank_list_1 = {}
        self.rank_list_2 = {}
    end,
    bis = function(self, buffer)
        local stream = bistream.new()
        stream:attach(buffer)
        self.unknow_1 = stream:readint()
        self.unknow_2 = stream:readint()
        self.rank_list_1 = {}
        for i = 1, 20 do
            local r = {}
            r.guid = stream:readint()
            r.name = stream:read(0x1E)
            r.count = stream:readint()
            r.unknow_1 = stream:readint()
            r.unknow_2 = stream:readint()
            r.unknow_3 = stream:readint()
            r.guild_name = stream:read(64)
            table.insert(self.rank_list_1, r)
        end
        self.rank_list_2 = {}
        for i = 1, 20 do
            local r = {}
            r.guid = stream:readint()
            r.name = stream:read(0x1E)
            r.count = stream:readint()
            r.unknow_1 = stream:readint()
            r.unknow_2 = stream:readint()
            r.unknow_3 = stream:readint()
            r.guild_name = stream:read(64)
            table.insert(self.rank_list_2, r)
        end
        self.unknow_3 = stream:readchar()
        self.unknow_4 = stream:readint()
        self.unknow_5 = stream:readchar()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.unknow_1)
        stream:writeint(self.unknow_2)
        for i = 1, 20 do
            local r = self.rank_list_1[i]
            stream:writeint(r.guid)
            stream:write(gbk.fromutf8(r.name), 0x1E)
            stream:writeint(r.count)
            stream:writeint(r.unknow_1)
            stream:writeint(r.unknow_2)
            stream:writeint(r.unknow_3)
            stream:write(gbk.fromutf8(r.guild_name), 64)
        end
        for i = 1, 20 do
            local r = self.rank_list_2[i]
            stream:writeint(r.guid)
            stream:write(gbk.fromutf8(r.name), 0x1E)
            stream:writeint(r.count)
            stream:writeint(r.unknow_1)
            stream:writeint(r.unknow_2)
            stream:writeint(r.unknow_3)
            stream:write(gbk.fromutf8(r.guild_name), 64)
        end
        stream:writechar(self.unknow_3)
        stream:writeint(self.unknow_4)
        stream:writechar(self.unknow_5)
        return stream:get()
    end
}

packet.GCRefreshEquipAttr = {
    xy_id = packet.XYID_GC_REFRESH_EQUIP_ATTR,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.GCRefreshEquipAttr})
        o:ctor()
        return o
    end,
    ctor = function(self) end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuchar(self.type)
        stream:writeuint(self.item_index)
        stream:writeuint(self.attr_count)
        stream:writeulong(self.attr_type)
        for i = 1, 16 do
            stream:writeushort(self.attr_values[i] or 0)
        end
        return stream:get()
    end
}

return packet
