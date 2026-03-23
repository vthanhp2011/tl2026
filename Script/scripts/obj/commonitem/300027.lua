local gbk = require "gbk"
local class = require "class"
local define = require "define"
local script_base = require "script_base"
local common_item = class("common_item", script_base)

local g_petList = {}
g_petList[30309002] = {type=1, dataId=3009, level=1}	--珍兽蛋：兔子
g_petList[30309003] = {type=1, dataId=3019, level=1}	--珍兽蛋：燕子
g_petList[30309004] = {type=1, dataId=3029, level=1}	--珍兽蛋：乌龟
g_petList[30309005] = {type=1, dataId=3039, level=1}	--珍兽蛋：狗
g_petList[30309006] = {type=1, dataId=3049, level=1}	--珍兽蛋：刺猬
g_petList[30309007] = {type=1, dataId=3059, level=1}	--珍兽蛋：猴子
g_petList[30309008] = {type=1, dataId=3069, level=1}	--珍兽蛋：松鼠
g_petList[30309009] = {type=1, dataId=3079, level=1}	--珍兽蛋：浣熊
g_petList[30309010] = {type=1, dataId=3089, level=1}	--珍兽蛋：鹦鹉
g_petList[30309011] = {type=1, dataId=3099, level=1}	--珍兽蛋：蜥蜴
g_petList[30309012] = {type=1, dataId=3109, level=1}	--珍兽蛋：蝙蝠
g_petList[30309013] = {type=1, dataId=3119, level=1}	--珍兽蛋：大螳螂
g_petList[30309014] = {type=1, dataId=3129, level=1}	--珍兽蛋：鳄鱼
g_petList[30309015] = {type=1, dataId=3139, level=1}	--珍兽蛋：猫头鹰
g_petList[30309016] = {type=1, dataId=3149, level=1}	--珍兽蛋：獾
g_petList[30309017] = {type=1, dataId=3159, level=1}	--珍兽蛋：老虎
g_petList[30309018] = {type=1, dataId=3169, level=1}	--珍兽蛋：野猪
g_petList[30309019] = {type=1, dataId=3179, level=1}	--珍兽蛋：冰蚕
g_petList[30309020] = {type=1, dataId=3189, level=1}	--珍兽蛋：鹰
g_petList[30309021] = {type=1, dataId=3199, level=1}	--珍兽蛋：鸵鸟
g_petList[30309022] = {type=1, dataId=3209, level=1}	--珍兽蛋：豹子
g_petList[30309023] = {type=1, dataId=3219, level=1}	--珍兽蛋：北极熊
g_petList[30309024] = {type=1, dataId=3229, level=1}	--珍兽蛋：孔雀
g_petList[30309025] = {type=1, dataId=3239, level=1}	--珍兽蛋：剑齿虎
g_petList[30309026] = {type=1, dataId=3249, level=1}	--珍兽蛋：大猩猩
g_petList[30309027] = {type=1, dataId=3259, level=1}	--珍兽蛋：犀牛
g_petList[30309028] = {type=1, dataId=3269, level=1}	--珍兽蛋：雪貂
g_petList[30309029] = {type=1, dataId=3279, level=1}	--珍兽蛋：剑龙
g_petList[30309030] = {type=1, dataId=3289, level=1}	--珍兽蛋：駮马
g_petList[30309031] = {type=1, dataId=3299, level=1}	--珍兽蛋：黄鸟
g_petList[30309032] = {type=1, dataId=3309, level=1}	--珍兽蛋：年兽
g_petList[30309033] = {type=1, dataId=3319, level=1}	--珍兽蛋：龙龟
g_petList[30309034] = {type=1, dataId=3329, level=1}	--珍兽蛋：英招
g_petList[30309035] = {type=1, dataId=3339, level=1}	--珍兽蛋：麒麟
g_petList[30309036] = {type=1, dataId=3349, level=1}	--珍兽蛋：蛟龙
g_petList[30309037] = {type=1, dataId=3359, level=1}	--珍兽蛋：柴猫
g_petList[30309038] = {type=1, dataId=3369, level=1}	--珍兽蛋：鸡
g_petList[30309039] = {type=1, dataId=3379, level=1}	--珍兽蛋：鸭子
g_petList[30309040] = {type=1, dataId=3389, level=1}	--珍兽蛋：山羊
g_petList[30309041] = {type=1, dataId=3399, level=1}	--珍兽蛋：毛驴
g_petList[30309042] = {type=1, dataId=3409, level=1}	--珍兽蛋：鹅
g_petList[30309043] = {type=1, dataId=3419, level=1}	--珍兽蛋：霸王龙
g_petList[30309044] = {type=1, dataId=3429, level=1}	--珍兽蛋：企鹅
g_petList[30309045] = {type=1, dataId=3439, level=1}	--珍兽蛋：袋鼠
g_petList[30309046] = {type=1, dataId=3449, level=1}	--珍兽蛋：鸭嘴兽
g_petList[30309047] = {type=1, dataId=3459, level=1}	--珍兽蛋：猪
g_petList[30309048] = {type=1, dataId=3469, level=1}	--珍兽蛋：青蛙
g_petList[30309049] = {type=1, dataId=3479, level=1}	--珍兽蛋：小象
g_petList[30309050] = {type=1, dataId=3489, level=1}	--珍兽蛋：雪狐
g_petList[30309051] = {type=1, dataId=3499, level=1}	--珍兽蛋：狼
g_petList[30505108] = {type=0, dataId=3459, level=1}	--珍兽蛋：猪
g_petList[30505109] = {type=1, dataId=6069, level=1}	--珍兽蛋：墨镜猫
g_petList[30505110] = {type=1, dataId=6079, level=1}	--珍兽蛋：流行猫
g_petList[30505111] = {type=1, dataId=6089, level=1}	--珍兽蛋：时尚猫
g_petList[30505112] = {type=1, dataId=6099, level=1}	--珍兽蛋：偶像猫
g_petList[30505113] = {type=1, dataId=6109, level=1}	--珍兽蛋：冠军猫
g_petList[30505121] = {type=1, dataId=6569, level=1}	--企鹅蛋
g_petList[30505126] = {type=1, dataId=6649, level=1}	--玉兔铃铛
g_petList[30505127] = {type=1, dataId=6659, level=1}	--皓月玉兔铃铛
g_petList[30505128] = {type=1, dataId=6669, level=1}	--蟾宫玉兔铃铛
g_petList[30505129] = {type=1, dataId=6679, level=1}	--嫦娥玉兔铃铛
g_petList[30505237] = {type=1, dataId=6639, level=1}	--玄翼兽
g_petList[30505238] = {type=1, dataId=6619, level=1}	--火鬃鼠
g_petList[30309052] = {type=2, dataIds={}, level=1}	--神笛：珍奇鼠(按照玩家等级区间给不同的宠物)
g_petList[30309052].dataIds[1] = {dataId=8709,minHumanLevel=1,maxHumanLevel=44}
g_petList[30309052].dataIds[2] = {dataId=8719,minHumanLevel=45,maxHumanLevel=54}
g_petList[30309052].dataIds[3] = {dataId=8729,minHumanLevel=55,maxHumanLevel=64}
g_petList[30309052].dataIds[4] = {dataId=8679,minHumanLevel=65,maxHumanLevel=255}
g_petList[30309053] = {type=1, dataId=8689, level=1}	--麒麟蛋
g_petList[30505154] = {type=1, dataId=8699, level=1}	--珍兽蛋：吉祥猫
g_petList[30505164] = {type=2, dataIds={}, level=1}	--海盗鼠
g_petList[30505164].dataIds[1] = {dataId=8359,minHumanLevel=45,maxHumanLevel=54}
g_petList[30505164].dataIds[2] = {dataId=8369,minHumanLevel=55,maxHumanLevel=64}
g_petList[30505164].dataIds[3] = {dataId=8379,minHumanLevel=65,maxHumanLevel=255}
g_petList[30505179] = {type=1, dataId=7559, level=1}	--鸭嘴兽项圈
g_petList[30505180] = {type=1, dataId=3399, level=1}	--5级毛驴铃铛
g_petList[30505181] = {type=1, dataId=8969, level=1}	--45级毛驴铃铛
g_petList[30505182] = {type=1, dataId=8979, level=1}	--55级毛驴铃铛
g_petList[30505183] = {type=1, dataId=8989, level=1}	--65级毛驴铃铛
g_petList[30309600] = {type=1, dataId=7649, level=1} --珍兽蛋：龙猫 5
g_petList[30309601] = {type=1, dataId=7659, level=1} --珍兽蛋：龙猫 45
g_petList[30309602] = {type=1, dataId=7669, level=1} --珍兽蛋：龙猫 55
g_petList[30309603] = {type=1, dataId=7679, level=1} --珍兽蛋：龙猫 65
g_petList[30309604] = {type=1, dataId=7689, level=1} --珍兽蛋：龙猫 75
g_petList[30309605] = {type=1, dataId=7699, level=1} --珍兽蛋：龙猫 85
g_petList[30309606] = {type=1, dataId=7709, level=1} --珍兽蛋：龙猫 95
g_petList[30309607] = {type=1, dataId=7789, level=1} --珍兽蛋：熊猫 5
g_petList[30309608] = {type=1, dataId=7799, level=1} --珍兽蛋：熊猫 45
g_petList[30309609] = {type=1, dataId=7809, level=1} --珍兽蛋：熊猫 55
g_petList[30309610] = {type=1, dataId=7819, level=1} --珍兽蛋：熊猫 65
g_petList[30309611] = {type=1, dataId=7829, level=1} --珍兽蛋：熊猫 75
g_petList[30309612] = {type=1, dataId=7839, level=1} --珍兽蛋：熊猫 85
g_petList[30309613] = {type=1, dataId=7849, level=1} --珍兽蛋：熊猫 95
g_petList[30309614] = {type=1, dataId=7929, level=1} --珍兽蛋：蝴蝶 5
g_petList[30309615] = {type=1, dataId=7939, level=1} --珍兽蛋：蝴蝶 45
g_petList[30309616] = {type=1, dataId=7949, level=1} --珍兽蛋：蝴蝶 55
g_petList[30309617] = {type=1, dataId=7959, level=1} --珍兽蛋：蝴蝶 65
g_petList[30309618] = {type=1, dataId=7969, level=1} --珍兽蛋：蝴蝶 75
g_petList[30309619] = {type=1, dataId=7979, level=1} --珍兽蛋：蝴蝶 85
g_petList[30309620] = {type=1, dataId=7989, level=1} --珍兽蛋：蝴蝶 95
g_petList[30309621] = {type=1, dataId=7999, level=1} --珍兽蛋：蜗牛 5
g_petList[30309622] = {type=1, dataId=8009, level=1} --珍兽蛋：蜗牛 45
g_petList[30309623] = {type=1, dataId=8019, level=1} --珍兽蛋：蜗牛 55
g_petList[30309624] = {type=1, dataId=8029, level=1} --珍兽蛋：蜗牛 65
g_petList[30309625] = {type=1, dataId=8039, level=1} --珍兽蛋：蜗牛 75
g_petList[30309626] = {type=1, dataId=8049, level=1} --珍兽蛋：蜗牛 85
g_petList[30309627] = {type=1, dataId=8059, level=1} --珍兽蛋：蜗牛 95
g_petList[30309628] = {type=1, dataId=8069, level=1} --珍兽蛋：蝎子 5
g_petList[30309629] = {type=1, dataId=8079, level=1} --珍兽蛋：蝎子 45
g_petList[30309630] = {type=1, dataId=8089, level=1} --珍兽蛋：蝎子 55
g_petList[30309631] = {type=1, dataId=8099, level=1} --珍兽蛋：蝎子 65
g_petList[30309632] = {type=1, dataId=8109, level=1} --珍兽蛋：蝎子 75
g_petList[30309633] = {type=1, dataId=8119, level=1} --珍兽蛋：蝎子 85
g_petList[30309634] = {type=1, dataId=8129, level=1} --珍兽蛋：蝎子 95
g_petList[30309635] = {type=1, dataId=7859, level=1} --珍兽蛋：螃蟹 5
g_petList[30309636] = {type=1, dataId=7869, level=1} --珍兽蛋：螃蟹 45
g_petList[30309637] = {type=1, dataId=7879, level=1} --珍兽蛋：螃蟹 55
g_petList[30309638] = {type=1, dataId=7889, level=1} --珍兽蛋：螃蟹 65
g_petList[30309639] = {type=1, dataId=7899, level=1} --珍兽蛋：螃蟹 75
g_petList[30309640] = {type=1, dataId=7909, level=1} --珍兽蛋：螃蟹 85
g_petList[30309641] = {type=1, dataId=7919, level=1} --珍兽蛋：螃蟹 95
g_petList[30309642] = {type=1, dataId=7719, level=1} --珍兽蛋：犀鸟 5
g_petList[30309643] = {type=1, dataId=7729, level=1} --珍兽蛋：犀鸟 45
g_petList[30309644] = {type=1, dataId=7739, level=1} --珍兽蛋：犀鸟 55
g_petList[30309645] = {type=1, dataId=7749, level=1} --珍兽蛋：犀鸟 65
g_petList[30309646] = {type=1, dataId=7759, level=1} --珍兽蛋：犀鸟 75
g_petList[30309647] = {type=1, dataId=7769, level=1} --珍兽蛋：犀鸟 85
g_petList[30309648] = {type=1, dataId=7779, level=1} --珍兽蛋：犀鸟 95
g_petList[30309649] = {type=1, dataId=7509, level=1} --珍兽蛋：鸭嘴兽 5
g_petList[30309650] = {type=1, dataId=7519, level=1} --珍兽蛋：鸭嘴兽 45
g_petList[30309651] = {type=1, dataId=7529, level=1} --珍兽蛋：鸭嘴兽 55
g_petList[30309652] = {type=1, dataId=7539, level=1} --珍兽蛋：鸭嘴兽 65
g_petList[30309653] = {type=1, dataId=7549, level=1} --珍兽蛋：鸭嘴兽 75
g_petList[30309654] = {type=1, dataId=7559, level=1} --珍兽蛋：鸭嘴兽 85
g_petList[30309655] = {type=1, dataId=7569, level=1} --珍兽蛋：鸭嘴兽 95
g_petList[30309656] = {type=1, dataId=7579, level=1} --珍兽蛋：雪狐 5
g_petList[30309657] = {type=1, dataId=7589, level=1} --珍兽蛋：雪狐 45
g_petList[30309658] = {type=1, dataId=7599, level=1} --珍兽蛋：雪狐 55
g_petList[30309659] = {type=1, dataId=7609, level=1} --珍兽蛋：雪狐 65
g_petList[30309660] = {type=1, dataId=7619, level=1} --珍兽蛋：雪狐 75
g_petList[30309661] = {type=1, dataId=7629, level=1} --珍兽蛋：雪狐 85
g_petList[30309662] = {type=1, dataId=7639, level=1} --珍兽蛋：雪狐 95
g_petList[30309663] = {type=1, dataId=8139, level=1} --珍兽蛋：穿山甲 5
g_petList[30309664] = {type=1, dataId=8149, level=1} --珍兽蛋：穿山甲 45
g_petList[30309665] = {type=1, dataId=8159, level=1} --珍兽蛋：穿山甲 55
g_petList[30309666] = {type=1, dataId=8169, level=1} --珍兽蛋：穿山甲 65
g_petList[30309667] = {type=1, dataId=8179, level=1} --珍兽蛋：穿山甲 75
g_petList[30309668] = {type=1, dataId=8189, level=1} --珍兽蛋：穿山甲 85
g_petList[30309669] = {type=1, dataId=8199, level=1} --珍兽蛋：穿山甲 95
g_petList[30309670] = {type=1, dataId=8209, level=1} --珍兽蛋：大甲虫 5
g_petList[30309671] = {type=1, dataId=8219, level=1} --珍兽蛋：大甲虫 45
g_petList[30309672] = {type=1, dataId=8229, level=1} --珍兽蛋：大甲虫 55
g_petList[30309673] = {type=1, dataId=8239, level=1} --珍兽蛋：大甲虫 65
g_petList[30309674] = {type=1, dataId=8249, level=1} --珍兽蛋：大甲虫 75
g_petList[30309675] = {type=1, dataId=8259, level=1} --珍兽蛋：大甲虫 85
g_petList[30309676] = {type=1, dataId=8269, level=1} --珍兽蛋：大甲虫 95
g_petList[30309677] = {type=1, dataId=8279, level=1} --珍兽蛋：当扈 5
g_petList[30309678] = {type=1, dataId=8289, level=1} --珍兽蛋：当扈 45
g_petList[30309679] = {type=1, dataId=8299, level=1} --珍兽蛋：当扈 55
g_petList[30309680] = {type=1, dataId=8309, level=1} --珍兽蛋：当扈 65
g_petList[30309681] = {type=1, dataId=8319, level=1} --珍兽蛋：当扈 75
g_petList[30309682] = {type=1, dataId=8329, level=1} --珍兽蛋：当扈 85
g_petList[30309683] = {type=1, dataId=8339, level=1} --珍兽蛋：当扈 95
g_petList[30309684] = {type=1, dataId=8349, level=1} --珍兽蛋：海盗鼠 5
g_petList[30309685] = {type=1, dataId=8359, level=1} --珍兽蛋：海盗鼠 45
g_petList[30309686] = {type=1, dataId=8369, level=1} --珍兽蛋：海盗鼠 55
g_petList[30309687] = {type=1, dataId=8379, level=1} --珍兽蛋：海盗鼠 65
g_petList[30309688] = {type=1, dataId=8389, level=1} --珍兽蛋：海盗鼠 75
g_petList[30309689] = {type=1, dataId=8399, level=1} --珍兽蛋：海盗鼠 85
g_petList[30309690] = {type=1, dataId=8409, level=1} --珍兽蛋：海盗鼠 95
g_petList[30309691] = {type=1, dataId=8419, level=1} --珍兽蛋：宝箱童子 5
g_petList[30309692] = {type=1, dataId=8429, level=1} --珍兽蛋：宝箱童子 45
g_petList[30309693] = {type=1, dataId=8439, level=1} --珍兽蛋：宝箱童子 55
g_petList[30309694] = {type=1, dataId=8449, level=1} --珍兽蛋：宝箱童子 65
g_petList[30309695] = {type=1, dataId=8459, level=1} --珍兽蛋：宝箱童子 75
g_petList[30309696] = {type=1, dataId=8469, level=1} --珍兽蛋：宝箱童子 85
g_petList[30309697] = {type=1, dataId=8479, level=1} --珍兽蛋：宝箱童子 95
g_petList[30309698] = {type=1, dataId=8489, level=1} --珍兽蛋：树袋熊 5
g_petList[30309699] = {type=1, dataId=8499, level=1} --珍兽蛋：树袋熊 45
g_petList[30309700] = {type=1, dataId=8509, level=1} --珍兽蛋：树袋熊 55
g_petList[30309701] = {type=1, dataId=8519, level=1} --珍兽蛋：树袋熊 65
g_petList[30309702] = {type=1, dataId=8529, level=1} --珍兽蛋：树袋熊 75
g_petList[30309703] = {type=1, dataId=8539, level=1} --珍兽蛋：树袋熊 85
g_petList[30309704] = {type=1, dataId=8549, level=1} --珍兽蛋：树袋熊 95
g_petList[30309705] = {type=1, dataId=8569, level=1} --珍兽蛋：欢乐猪 5
g_petList[30309706] = {type=1, dataId=8579, level=1} --珍兽蛋：欢乐猪 45
g_petList[30309707] = {type=1, dataId=8589, level=1} --珍兽蛋：欢乐猪 55
g_petList[30309708] = {type=1, dataId=8599, level=1} --珍兽蛋：欢乐猪 65
g_petList[30309709] = {type=1, dataId=8609, level=1} --珍兽蛋：欢乐猪 75
g_petList[30309710] = {type=1, dataId=8619, level=1} --珍兽蛋：欢乐猪 85
g_petList[30309711] = {type=1, dataId=8629, level=1} --珍兽蛋：欢乐猪 95
g_petList[30309712] = {type=1, dataId=8749, level=1} --珍兽蛋：唐装鼠 5
g_petList[30309713] = {type=1, dataId=8759, level=1} --珍兽蛋：唐装鼠 45
g_petList[30309714] = {type=1, dataId=8769, level=1} --珍兽蛋：唐装鼠 55
g_petList[30309715] = {type=1, dataId=8779, level=1} --珍兽蛋：唐装鼠 65
g_petList[30309716] = {type=1, dataId=8789, level=1} --珍兽蛋：唐装鼠 75
g_petList[30309717] = {type=1, dataId=8799, level=1} --珍兽蛋：唐装鼠 85
g_petList[30309718] = {type=1, dataId=8809, level=1} --珍兽蛋：唐装鼠 95
g_petList[30309719] = {type=1, dataId=8819, level=1} --珍兽蛋：年兽 5
g_petList[30309720] = {type=1, dataId=8829, level=1} --珍兽蛋：年兽 45
g_petList[30309721] = {type=1, dataId=8839, level=1} --珍兽蛋：年兽 55
g_petList[30309722] = {type=1, dataId=8849, level=1} --珍兽蛋：年兽 65
g_petList[30309723] = {type=1, dataId=8859, level=1} --珍兽蛋：年兽 75
g_petList[30309724] = {type=1, dataId=8869, level=1} --珍兽蛋：年兽 85
g_petList[30309725] = {type=1, dataId=8879, level=1} --珍兽蛋：年兽 95
g_petList[30309726] = {type=1, dataId=8889, level=1} --珍兽蛋：鸳鸯 5
g_petList[30309727] = {type=1, dataId=8899, level=1} --珍兽蛋：鸳鸯 45
g_petList[30309728] = {type=1, dataId=8909, level=1} --珍兽蛋：鸳鸯 55
g_petList[30309729] = {type=1, dataId=8919, level=1} --珍兽蛋：鸳鸯 65
g_petList[30309730] = {type=1, dataId=8929, level=1} --珍兽蛋：鸳鸯 75
g_petList[30309731] = {type=1, dataId=8939, level=1} --珍兽蛋：鸳鸯 85
g_petList[30309732] = {type=1, dataId=8949, level=1} --珍兽蛋：鸳鸯 95
g_petList[30309733] = {type=1, dataId=22059, level=1} --珍兽蛋：穷奇 85
g_petList[30309734] = {type=1, dataId=22129, level=1} --珍兽蛋：小狐仙 85
g_petList[30309735] = {type=1, dataId=22140, level=1} --珍兽蛋：钢斧神猿 5
g_petList[30309736] = {type=1, dataId=22150, level=1} --珍兽蛋：丛林神猿 45
g_petList[30309737] = {type=1, dataId=22160, level=1} --珍兽蛋：地狱神猿 55
g_petList[30309738] = {type=1, dataId=22170, level=1} --珍兽蛋：魅灵神猿 65
g_petList[30309739] = {type=1, dataId=22180, level=1} --珍兽蛋：罗汉神猿 75
g_petList[30309740] = {type=1, dataId=22190, level=1} --珍兽蛋：上古神猿 85
g_petList[30309741] = {type=1, dataId=22219, level=1} --珍兽蛋：比翼鸟 5
g_petList[30309742] = {type=1, dataId=22229, level=1} --珍兽蛋：比翼鸟 45
g_petList[30309743] = {type=1, dataId=22239, level=1} --珍兽蛋：比翼鸟 55
g_petList[30309744] = {type=1, dataId=22249, level=1} --珍兽蛋：比翼鸟 65
g_petList[30309745] = {type=1, dataId=22259, level=1} --珍兽蛋：比翼鸟 75
g_petList[30309746] = {type=1, dataId=22269, level=1} --珍兽蛋：比翼鸟 85
g_petList[30309747] = {type=1, dataId=22279, level=1} --珍兽蛋：比翼鸟 95
g_petList[30309748] = {type=1, dataId=22289, level=1} --珍兽蛋：呆呆牛 5
g_petList[30309749] = {type=1, dataId=22299, level=1} --珍兽蛋：呆呆牛 45
g_petList[30309750] = {type=1, dataId=22309, level=1} --珍兽蛋：呆呆牛 55
g_petList[30309751] = {type=1, dataId=22319, level=1} --珍兽蛋：呆呆牛 65
g_petList[30309752] = {type=1, dataId=22329, level=1} --珍兽蛋：呆呆牛 75
g_petList[30309753] = {type=1, dataId=22339, level=1} --珍兽蛋：呆呆牛 85
g_petList[30309754] = {type=1, dataId=22349, level=1} --珍兽蛋：呆呆牛 95
g_petList[38000080] = {type=1, dataId=22293, level=1} --变异珍兽蛋：呆呆牛 45
g_petList[30309755] = {type=2, dataIds={}, level=1}	--珍奇牛(按照玩家等级区间给不同的宠物)
g_petList[30309755].dataIds[1] = {dataId=22359,minHumanLevel=1,maxHumanLevel=44}
g_petList[30309755].dataIds[2] = {dataId=22369,minHumanLevel=45,maxHumanLevel=54}
g_petList[30309755].dataIds[3] = {dataId=22379,minHumanLevel=55,maxHumanLevel=64}
g_petList[30309755].dataIds[4] = {dataId=22389,minHumanLevel=65,maxHumanLevel=74}
g_petList[30309755].dataIds[5] = {dataId=22399,minHumanLevel=75,maxHumanLevel=84}
g_petList[30309755].dataIds[6] = {dataId=22409,minHumanLevel=85,maxHumanLevel=255}
g_petList[30309054] = {type=1, dataId=8189, level=1} --珍兽蛋：雷麟 85     --新玄武岛会掉蛋
g_petList[30309055] = {type=1, dataId=3299, level=1} --珍兽蛋：雏凤 85
g_petList[30309756] = {type=1, dataId=22489, level=1} --珍兽蛋：麒麟 95
g_petList[30309056] = {type=1, dataId=3159, level=1} --珍兽蛋：老虎 45
g_petList[30504088] = {type=1, dataId=22499, level=1} --珍兽蛋：go仔 5
g_petList[30504089] = {type=1, dataId=22509, level=1} --珍兽蛋：go仔 45
g_petList[30504090] = {type=1, dataId=22519, level=1} --珍兽蛋：go仔 55
g_petList[30504091] = {type=1, dataId=22529, level=1} --珍兽蛋：go仔 65
g_petList[30504092] = {type=1, dataId=22539, level=1} --珍兽蛋：go仔 75
g_petList[30504093] = {type=1, dataId=22549, level=1} --珍兽蛋：go仔 85
g_petList[30504094] = {type=1, dataId=22559, level=1} --珍兽蛋：go仔 95
g_petList[30504125] = {type=1, dataId=23109, level=1} --珍兽蛋：花仙子 95
g_petList[30504126] = {type=1, dataId=23559, level=1} --珍兽蛋：章鱼 95
g_petList[30504127] = {type=1, dataId=23469, level=1} --珍兽蛋：熊猫双侠 95
g_petList[30504128] = {type=1, dataId=23009, level=1} --珍兽蛋：奶油火鸡 95
--***********************************************************
--极致新增修正
--***********************************************************
g_petList[30309057] = {type=1, dataId=22569, level=1} --珍兽蛋：神猿
g_petList[30309058] = {type=1, dataId=22579, level=1} --珍兽蛋：神猿
g_petList[30309059] = {type=1, dataId=22589, level=1} --岩魂
g_petList[30309060] = {type=1, dataId=22599, level=1} --岩魂
g_petList[30309061] = {type=1, dataId=22609, level=1} --岩魂
g_petList[30309062] = {type=1, dataId=22619, level=1} --岩魂
g_petList[30309063] = {type=1, dataId=22629, level=1} --岩魂
g_petList[30309064] = {type=1, dataId=22639, level=1} --岩魂
g_petList[30309065] = {type=1, dataId=22649, level=1} --岩魂
g_petList[30309077] = {type=1, dataId=23979, level=1} --七巧狸猫宝宝
g_petList[30309078] = {type=1, dataId=24609, level=1} --狭路逢
g_petList[30309079] = {type=1, dataId=24619, level=1} --狭路逢
g_petList[30309080] = {type=1, dataId=24629, level=1} --狭路逢
g_petList[30309081] = {type=1, dataId=24639, level=1} --狭路逢
g_petList[30309082] = {type=1, dataId=24649, level=1} --狭路逢
g_petList[30309083] = {type=1, dataId=24659, level=1} --狭路逢
g_petList[30309085] = {type=1, dataId=24599, level=1} --狭路逢
g_petList[30309084] = {type=1, dataId=6649, level=1} --玉兔宝宝
g_petList[30309765] = {type=1, dataId=22799, level=1} --玉兔宝宝
g_petList[30309766] = {type=1, dataId=22809, level=1} --玉兔宝宝
g_petList[30309767] = {type=1, dataId=22819, level=1} --玉兔宝宝
g_petList[30309768] = {type=1, dataId=22829, level=1} --玉兔宝宝
g_petList[30309769] = {type=1, dataId=22839, level=1} --玉兔宝宝
g_petList[30309770] = {type=1, dataId=22849, level=1} --玉兔宝宝
g_petList[30309771] = {type=1, dataId=22859, level=1}


g_petList[30309772] = {type=1, dataId=22729, level=1}
g_petList[30309773] = {type=1, dataId=22739, level=1}
g_petList[30309774] = {type=1, dataId=22749, level=1}
g_petList[30309775] = {type=1, dataId=22759, level=1}
g_petList[30309776] = {type=1, dataId=22769, level=1}
g_petList[30309777] = {type=1, dataId=22779, level=1}
g_petList[30309778] = {type=1, dataId=22789, level=1}


g_petList[30309808] = {type=1, dataId=22949, level=1}
g_petList[30309809] = {type=1, dataId=22959, level=1}
g_petList[30309810] = {type=1, dataId=22969, level=1}
g_petList[30309811] = {type=1, dataId=22979, level=1}
g_petList[30309812] = {type=1, dataId=22989, level=1}
g_petList[30309813] = {type=1, dataId=22999, level=1}
g_petList[30309814] = {type=1, dataId=23009, level=1}

g_petList[30309816] = {type=1, dataId=23259, level=1}
g_petList[30309817] = {type=1, dataId=23269, level=1}
g_petList[30309818] = {type=1, dataId=23279, level=1}
g_petList[30309819] = {type=1, dataId=23289, level=1}
g_petList[30309820] = {type=1, dataId=23299, level=1}
g_petList[30309821] = {type=1, dataId=23309, level=1}
g_petList[30309822] = {type=1, dataId=23319, level=1}

g_petList[30309827] = {type=1, dataId=23119, level=1}
g_petList[30309828] = {type=1, dataId=23129, level=1}
g_petList[30309829] = {type=1, dataId=23139, level=1}
g_petList[30309830] = {type=1, dataId=23149, level=1}
g_petList[30309831] = {type=1, dataId=23159, level=1}
g_petList[30309832] = {type=1, dataId=23169, level=1}
g_petList[30309833] = {type=1, dataId=23179, level=1}

g_petList[30309837] = {type=1, dataId=23409, level=1}
g_petList[30309838] = {type=1, dataId=23419, level=1}
g_petList[30309839] = {type=1, dataId=23429, level=1}
g_petList[30309840] = {type=1, dataId=23439, level=1}
g_petList[30309841] = {type=1, dataId=23449, level=1}
g_petList[30309842] = {type=1, dataId=23459, level=1}
g_petList[30309843] = {type=1, dataId=23469, level=1}

g_petList[30309845] = {type=1, dataId=3069, level=1}
g_petList[30309983] = {type=1, dataId=30909, level=1}
g_petList[30309985] = {type=1, dataId=30919, level=1}
g_petList[30309986] = {type=1, dataId=30929, level=1}
g_petList[30309987] = {type=1, dataId=30939, level=1}
g_petList[30309990] = {type=1, dataId=31209, level=1}

--四时山君
g_petList[30309991] = {type=1, dataId=31239, level=1}
g_petList[30309992] = {type=1, dataId=31249, level=1}
g_petList[30309993] = {type=1, dataId=31259, level=1}
g_petList[30309994] = {type=1, dataId=31279, level=1}

--花仙子
g_petList[30309997] = {type=1, dataId=23049, level=1}
g_petList[30309998] = {type=1, dataId=23059, level=1}
g_petList[30309999] = {type=1, dataId=23069, level=1}
g_petList[30310000] = {type=1, dataId=23079, level=1}
g_petList[30310001] = {type=1, dataId=23089, level=1}
g_petList[30310002] = {type=1, dataId=23099, level=1}
g_petList[30310003] = {type=1, dataId=23109, level=1}

--巧巧
g_petList[30310012] = {type=1, dataId=24759, level=1}
g_petList[30310013] = {type=1, dataId=24769, level=1}
g_petList[30310014] = {type=1, dataId=24779, level=1}
g_petList[30310015] = {type=1, dataId=24789, level=1}
g_petList[30310016] = {type=1, dataId=24799, level=1}
g_petList[30310017] = {type=1, dataId=24809, level=1}
g_petList[30310018] = {type=1, dataId=24819, level=1}

--天命玄凤
g_petList[30310023] = {type=1, dataId=24839, level=1}
g_petList[30310024] = {type=1, dataId=24849, level=1}
g_petList[30310025] = {type=1, dataId=24859, level=1}
g_petList[30310026] = {type=1, dataId=24869, level=1}
g_petList[30310027] = {type=1, dataId=24879, level=1}
g_petList[30310028] = {type=1, dataId=24889, level=1}
g_petList[30310029] = {type=1, dataId=24899, level=1}

--小花妖
g_petList[30310039] = {type=1, dataId=23989, level=1}
g_petList[30310040] = {type=1, dataId=23999, level=1}
g_petList[30310041] = {type=1, dataId=24009, level=1}
g_petList[30310042] = {type=1, dataId=24019, level=1}
g_petList[30310043] = {type=1, dataId=24029, level=1}
g_petList[30310044] = {type=1, dataId=24039, level=1}
g_petList[30310045] = {type=1, dataId=24049, level=1}

--囚牛
g_petList[30310031] = {type=1, dataId=24919, level=1}
g_petList[30310032] = {type=1, dataId=24929, level=1}
g_petList[30310033] = {type=1, dataId=24939, level=1}
g_petList[30310034] = {type=1, dataId=24949, level=1}
g_petList[30310035] = {type=1, dataId=24959, level=1}
g_petList[30310036] = {type=1, dataId=24969, level=1}
g_petList[30310037] = {type=1, dataId=24979, level=1}

--烈兔甜心
g_petList[30310047] = {type=1, dataId=27429, level=1}
g_petList[30310048] = {type=1, dataId=27439, level=1}
g_petList[30310049] = {type=1, dataId=27449, level=1}
g_petList[30310050] = {type=1, dataId=27459, level=1}
g_petList[30310051] = {type=1, dataId=27469, level=1}
g_petList[30310052] = {type=1, dataId=27479, level=1}
g_petList[30310053] = {type=1, dataId=27489, level=1}

--七彩辉骏
g_petList[30310055] = {type=1, dataId=27499, level=1}
g_petList[30310056] = {type=1, dataId=27509, level=1}
g_petList[30310057] = {type=1, dataId=27519, level=1}
g_petList[30310058] = {type=1, dataId=27529, level=1}
g_petList[30310059] = {type=1, dataId=27539, level=1}
g_petList[30310060] = {type=1, dataId=27549, level=1}
g_petList[30310061] = {type=1, dataId=27559, level=1}

--安琪儿
g_petList[30309089] = {type=1, dataId=24679, level=1}
g_petList[30309090] = {type=1, dataId=24689, level=1}
g_petList[30309091] = {type=1, dataId=24699, level=1}
g_petList[30309092] = {type=1, dataId=24709, level=1}
g_petList[30309093] = {type=1, dataId=24719, level=1}
g_petList[30309094] = {type=1, dataId=24729, level=1}
g_petList[30309095] = {type=1, dataId=24739, level=1}

--镇岛神兽
g_petList[30310068] = {type=1, dataId=27579, level=1}
g_petList[30310069] = {type=1, dataId=27589, level=1}
g_petList[30310070] = {type=1, dataId=27599, level=1}
g_petList[30310071] = {type=1, dataId=27609, level=1}
g_petList[30310072] = {type=1, dataId=27619, level=1}
g_petList[30310073] = {type=1, dataId=27629, level=1}
g_petList[30310074] = {type=1, dataId=27639, level=1}

--鸾凤和鸣
g_petList[30310078] = {type=1, dataId=27649, level=1}
g_petList[30310079] = {type=1, dataId=27659, level=1}
g_petList[30310080] = {type=1, dataId=27669, level=1}
g_petList[30310081] = {type=1, dataId=27679, level=1}
g_petList[30310082] = {type=1, dataId=27689, level=1}
g_petList[30310083] = {type=1, dataId=27699, level=1}
g_petList[30310084] = {type=1, dataId=27709, level=1}
--平天大圣
g_petList[30310130] = {type=1, dataId=30189, level=1}
g_petList[30310131] = {type=1, dataId=30199, level=1}
g_petList[30310132] = {type=1, dataId=30209, level=1}
g_petList[30310133] = {type=1, dataId=30219, level=1}
g_petList[30310134] = {type=1, dataId=30229, level=1}
g_petList[30310135] = {type=1, dataId=30239, level=1}
g_petList[30310136] = {type=1, dataId=30249, level=1}
--百变圣僧
g_petList[30310141] = {type=1, dataId=6739, level=1}
g_petList[30310142] = {type=1, dataId=6749, level=1}
g_petList[30310143] = {type=1, dataId=6759, level=1}
g_petList[30310144] = {type=1, dataId=6769, level=1}
g_petList[30310145] = {type=1, dataId=6779, level=1}
g_petList[30310146] = {type=1, dataId=6789, level=1}
g_petList[30310147] = {type=1, dataId=6799, level=1}
--灵巫月神
g_petList[30310149] = {type=1, dataId=27939, level=1}
g_petList[30310150] = {type=1, dataId=27949, level=1}
g_petList[30310151] = {type=1, dataId=27959, level=1}
g_petList[30310152] = {type=1, dataId=27969, level=1}
g_petList[30310153] = {type=1, dataId=27979, level=1}
g_petList[30310154] = {type=1, dataId=27989, level=1}
g_petList[30310155] = {type=1, dataId=27999, level=1}
--黑山姥姥
g_petList[30310160] = {type=1, dataId=25929, level=1}
g_petList[30310161] = {type=1, dataId=25939, level=1}
g_petList[30310162] = {type=1, dataId=25949, level=1}
g_petList[30310163] = {type=1, dataId=25959, level=1}
g_petList[30310164] = {type=1, dataId=25969, level=1}
g_petList[30310165] = {type=1, dataId=25979, level=1}
g_petList[30310166] = {type=1, dataId=25989, level=1}
--蚀骨冥蛇
g_petList[38003424] = {type=1, dataId=6809, level=1}
g_petList[38003414] = {type=1, dataId=6819, level=1}
g_petList[38003415] = {type=1, dataId=6829, level=1}
g_petList[38003416] = {type=1, dataId=6839, level=1}
g_petList[38003417] = {type=1, dataId=6849, level=1}
g_petList[38003418] = {type=1, dataId=6859, level=1}
g_petList[38003419] = {type=1, dataId=6869, level=1}
--金童玉女
g_petList[38003490] = {type=1, dataId=25859, level=1}
g_petList[38003491] = {type=1, dataId=25869, level=1}
g_petList[38003492] = {type=1, dataId=25879, level=1}
g_petList[38003493] = {type=1, dataId=25889, level=1}
g_petList[38003494] = {type=1, dataId=25899, level=1}
g_petList[38003495] = {type=1, dataId=25909, level=1}
g_petList[38003496] = {type=1, dataId=25919, level=1}
--宝箱童子
g_petList[30310066] = {type=1, dataId=8419, level=1}

--欢乐猪
g_petList[30310067] = {type=1, dataId=8569, level=1}

--特殊珍兽狭路逢·九幽体力资质在#G2500#W以上
g_petList[30309086] = {type=1, dataId=24661, level=1} 
--特殊珍兽狭路逢·九幽体力资质在#G2350#W以上
g_petList[30309087] = {type=1, dataId=24661, level=1} 
--特殊珍兽狭路逢·九幽体力资质在#G2200#W以上
g_petList[30309088] = {type=1, dataId=24661, level=1} 
--/////////////////////////////////////////////////////////
g_petList[30309531] = {type=1, dataId=30039, level=1} 
--珍兽蛋：昭瑞麒麟
g_petList[30310089] = {type=1, dataId=30049, level=1} 
g_petList[30310090] = {type=1, dataId=30059, level=1} 
g_petList[30310091] = {type=1, dataId=30069, level=1} 
g_petList[30310092] = {type=1, dataId=30079, level=1} 
g_petList[30310093] = {type=1, dataId=30089, level=1} 
g_petList[30310094] = {type=1, dataId=30099, level=1} 
g_petList[30310095] = {type=1, dataId=30109, level=1} 

--珍兽蛋：覆海龙君
g_petList[30310097] = {type=1, dataId=30119, level=1} 
g_petList[30310098] = {type=1, dataId=30129, level=1} 
g_petList[30310099] = {type=1, dataId=30139, level=1} 
g_petList[30310100] = {type=1, dataId=30149, level=1} 
g_petList[30310101] = {type=1, dataId=30159, level=1} 
g_petList[30310102] = {type=1, dataId=30169, level=1} 
g_petList[30310103] = {type=1, dataId=30179, level=1} 

--珍兽蛋：飓风圣兽
g_petList[30310105] = {type=1, dataId=27829, level=1}
g_petList[30310106] = {type=1, dataId=27839, level=1}
g_petList[30310107] = {type=1, dataId=27849, level=1}
g_petList[30310108] = {type=1, dataId=27859, level=1}
g_petList[30310109] = {type=1, dataId=27869, level=1}
g_petList[30310110] = {type=1, dataId=27879, level=1}
g_petList[30310111] = {type=1, dataId=27889, level=1}

--珍兽蛋：千锋战蝎
g_petList[30310118] = {type=1, dataId=30949, level=1}
g_petList[30310119] = {type=1, dataId=30959, level=1}
g_petList[30310120] = {type=1, dataId=30969, level=1}
g_petList[30310121] = {type=1, dataId=30979, level=1}
g_petList[30310122] = {type=1, dataId=30989, level=1}
g_petList[30310123] = {type=1, dataId=30999, level=1}
g_petList[30310124] = {type=1, dataId=31009, level=1}

g_petList[30309066] = {type=1, dataIds={}, level=1}	--欢乐猪
g_petList[30309066].dataIds[1] = {dataId=8569,minHumanLevel=5,maxHumanLevel=44}
g_petList[30309066].dataIds[2] = {dataId=8579,minHumanLevel=45,maxHumanLevel=54}
g_petList[30309066].dataIds[3] = {dataId=8589,minHumanLevel=55,maxHumanLevel=64}
g_petList[30309066].dataIds[4] = {dataId=8599,minHumanLevel=65,maxHumanLevel=74}
g_petList[30309066].dataIds[5] = {dataId=8609,minHumanLevel=75,maxHumanLevel=84}
g_petList[30309066].dataIds[6] = {dataId=8619,minHumanLevel=85,maxHumanLevel=94}
g_petList[30309066].dataIds[7] = {dataId=8629,minHumanLevel=95,maxHumanLevel=119}

g_petList[30309067] = {type=1, dataIds={}, level=1}	--灵兔兽
g_petList[30309067].dataIds[1] = {dataId=22799,minHumanLevel=5,maxHumanLevel=44}
g_petList[30309067].dataIds[2] = {dataId=22809,minHumanLevel=45,maxHumanLevel=54}
g_petList[30309067].dataIds[3] = {dataId=22819,minHumanLevel=55,maxHumanLevel=64}
g_petList[30309067].dataIds[4] = {dataId=22829,minHumanLevel=65,maxHumanLevel=74}
g_petList[30309067].dataIds[5] = {dataId=22839,minHumanLevel=75,maxHumanLevel=84}
g_petList[30309067].dataIds[6] = {dataId=22849,minHumanLevel=85,maxHumanLevel=94}
g_petList[30309067].dataIds[7] = {dataId=22859,minHumanLevel=95,maxHumanLevel=119}

g_petList[30309068] = {type=1, dataId=23339, level=1} --幼齿龙
g_petList[30309069] = {type=1, dataId=23349, level=1} --幼齿龙
g_petList[30309070] = {type=1, dataId=23359, level=1} --幼齿龙
g_petList[30309071] = {type=1, dataId=23369, level=1} --幼齿龙
g_petList[30309072] = {type=1, dataId=23379, level=1} --幼齿龙
g_petList[30309073] = {type=1, dataId=23389, level=1} --幼齿龙
g_petList[30309074] = {type=1, dataId=23399, level=1} --幼齿龙

g_petList[30309075] = {type=1, dataIds={}, level=1}	--幼齿龙
g_petList[30309075].dataIds[1] = {dataId=23339,minHumanLevel=5,maxHumanLevel=44}
g_petList[30309075].dataIds[2] = {dataId=23349,minHumanLevel=45,maxHumanLevel=54}
g_petList[30309075].dataIds[3] = {dataId=23359,minHumanLevel=55,maxHumanLevel=64}
g_petList[30309075].dataIds[4] = {dataId=23369,minHumanLevel=65,maxHumanLevel=74}
g_petList[30309075].dataIds[5] = {dataId=23379,minHumanLevel=75,maxHumanLevel=84}
g_petList[30309075].dataIds[6] = {dataId=23389,minHumanLevel=85,maxHumanLevel=94}
g_petList[30309075].dataIds[7] = {dataId=23399,minHumanLevel=95,maxHumanLevel=119}

g_petList[30309757] = {type=2, dataIds={}, level=1}	--呆呆牛
g_petList[30309757].dataIds[1] = {dataId=22289,minHumanLevel=5,maxHumanLevel=44}
g_petList[30309757].dataIds[2] = {dataId=22299,minHumanLevel=45,maxHumanLevel=54}
g_petList[30309757].dataIds[3] = {dataId=22309,minHumanLevel=55,maxHumanLevel=64}
g_petList[30309757].dataIds[4] = {dataId=22319,minHumanLevel=65,maxHumanLevel=74}
g_petList[30309757].dataIds[5] = {dataId=22329,minHumanLevel=75,maxHumanLevel=84}
g_petList[30309757].dataIds[6] = {dataId=22339,minHumanLevel=85,maxHumanLevel=94}
g_petList[30309757].dataIds[7] = {dataId=22349,minHumanLevel=95,maxHumanLevel=119}


g_petList[30309815] = {type=2, dataIds={}, level=1}	--呆呆牛
g_petList[30309815].dataIds[1] = {dataId=23189,minHumanLevel=5,maxHumanLevel=44}
g_petList[30309815].dataIds[2] = {dataId=23199,minHumanLevel=45,maxHumanLevel=54}
g_petList[30309815].dataIds[3] = {dataId=23209,minHumanLevel=55,maxHumanLevel=64}
g_petList[30309815].dataIds[4] = {dataId=23219,minHumanLevel=65,maxHumanLevel=74}
g_petList[30309815].dataIds[5] = {dataId=23229,minHumanLevel=75,maxHumanLevel=84}
g_petList[30309815].dataIds[6] = {dataId=23239,minHumanLevel=85,maxHumanLevel=94}
g_petList[30309815].dataIds[7] = {dataId=23249,minHumanLevel=95,maxHumanLevel=119}

g_petList[30309078] = {type=2, dataIds={}, level=1}	--珍兽蛋：狭路逢
g_petList[30309078].dataIds[1] = {dataId=24599,minHumanLevel=45,maxHumanLevel=54}
g_petList[30309078].dataIds[2] = {dataId=24609,minHumanLevel=55,maxHumanLevel=64}
g_petList[30309078].dataIds[3] = {dataId=24619,minHumanLevel=65,maxHumanLevel=74}
g_petList[30309078].dataIds[4] = {dataId=24629,minHumanLevel=75,maxHumanLevel=84}
g_petList[30309078].dataIds[5] = {dataId=24639,minHumanLevel=85,maxHumanLevel=94}
g_petList[30309078].dataIds[6] = {dataId=24649,minHumanLevel=95,maxHumanLevel=119}

g_petList[30309846] = {type=2, dataIds={}, level=1}	--高级珍兽笼：小狐仙
g_petList[30309846].dataIds[1] = {dataId=22099,minHumanLevel=55,maxHumanLevel=64}
g_petList[30309846].dataIds[2] = {dataId=22109,minHumanLevel=65,maxHumanLevel=74}
g_petList[30309846].dataIds[3] = {dataId=22119,minHumanLevel=75,maxHumanLevel=84}
g_petList[30309846].dataIds[4] = {dataId=22129,minHumanLevel=85,maxHumanLevel=94}
g_petList[30309846].dataIds[5] = {dataId=22139,minHumanLevel=95,maxHumanLevel=119}

g_petList[30309982] = {type=2, dataIds={}, level=1}	--超级珍兽笼：九黎妖虎
g_petList[30309982].dataIds[1] = {dataId=27389,minHumanLevel=65,maxHumanLevel=74}
g_petList[30309982].dataIds[2] = {dataId=27399,minHumanLevel=75,maxHumanLevel=84}
g_petList[30309982].dataIds[3] = {dataId=27409,minHumanLevel=85,maxHumanLevel=94}
g_petList[30309982].dataIds[4] = {dataId=27419,minHumanLevel=95,maxHumanLevel=119}

g_petList[30309984] = {type=2, dataIds={}, level=1}	--超级珍兽笼：万世魂
g_petList[30309984].dataIds[1] = {dataId=31109,minHumanLevel=65,maxHumanLevel=74}
g_petList[30309984].dataIds[2] = {dataId=31119,minHumanLevel=75,maxHumanLevel=84}
g_petList[30309984].dataIds[3] = {dataId=31129,minHumanLevel=85,maxHumanLevel=94}
g_petList[30309984].dataIds[4] = {dataId=31139,minHumanLevel=95,maxHumanLevel=119}

g_petList[30309988] = {type=2, dataIds={}, level=1}	--超级珍兽笼：狭路逢
g_petList[30309988].dataIds[1] = {dataId=24629,minHumanLevel=65,maxHumanLevel=74}
g_petList[30309988].dataIds[2] = {dataId=24639,minHumanLevel=75,maxHumanLevel=84}
g_petList[30309988].dataIds[3] = {dataId=24649,minHumanLevel=85,maxHumanLevel=94}
g_petList[30309988].dataIds[4] = {dataId=24659,minHumanLevel=95,maxHumanLevel=119}

g_petList[30309989] = {type=2, dataIds={}, level=1}	--超级珍兽笼：秦小偶
g_petList[30309989].dataIds[1] = {dataId=30909,minHumanLevel=65,maxHumanLevel=74}
g_petList[30309989].dataIds[2] = {dataId=30919,minHumanLevel=75,maxHumanLevel=84}
g_petList[30309989].dataIds[3] = {dataId=30929,minHumanLevel=85,maxHumanLevel=94}
g_petList[30309989].dataIds[4] = {dataId=30939,minHumanLevel=95,maxHumanLevel=119}

g_petList[30309995] = {type=2, dataIds={}, level=1}	--超级珍兽笼：四时山君
g_petList[30309995].dataIds[1] = {dataId=31249,minHumanLevel=65,maxHumanLevel=74}
g_petList[30309995].dataIds[2] = {dataId=31259,minHumanLevel=75,maxHumanLevel=84}
g_petList[30309995].dataIds[3] = {dataId=31269,minHumanLevel=85,maxHumanLevel=94}
g_petList[30309995].dataIds[4] = {dataId=31279,minHumanLevel=95,maxHumanLevel=119}

g_petList[30309996] = {type=2, dataIds={}, level=1}	--超级珍兽笼：安琪儿
g_petList[30309996].dataIds[1] = {dataId=24709,minHumanLevel=65,maxHumanLevel=74}
g_petList[30309996].dataIds[2] = {dataId=24719,minHumanLevel=75,maxHumanLevel=84}
g_petList[30309996].dataIds[3] = {dataId=24729,minHumanLevel=85,maxHumanLevel=94}
g_petList[30309996].dataIds[4] = {dataId=24739,minHumanLevel=95,maxHumanLevel=119}

g_petList[30310011] = {type=2, dataIds={}, level=1}	--超级珍兽笼：霓凰
g_petList[30310011].dataIds[1] = {dataId=31319,minHumanLevel=65,maxHumanLevel=74}
g_petList[30310011].dataIds[2] = {dataId=31329,minHumanLevel=75,maxHumanLevel=84}
g_petList[30310011].dataIds[3] = {dataId=31339,minHumanLevel=85,maxHumanLevel=94}
g_petList[30310011].dataIds[4] = {dataId=31349,minHumanLevel=95,maxHumanLevel=119}

g_petList[30310022] = {type=2, dataIds={}, level=1}	--超级珍兽笼：巧巧
g_petList[30310022].dataIds[1] = {dataId=24789,minHumanLevel=65,maxHumanLevel=74}
g_petList[30310022].dataIds[2] = {dataId=24799,minHumanLevel=75,maxHumanLevel=84}
g_petList[30310022].dataIds[3] = {dataId=24809,minHumanLevel=85,maxHumanLevel=94}
g_petList[30310022].dataIds[4] = {dataId=24819,minHumanLevel=95,maxHumanLevel=119}

g_petList[30310030] = {type=2, dataIds={}, level=1}	--超级珍兽笼：天命玄凤
g_petList[30310030].dataIds[1] = {dataId=24869,minHumanLevel=65,maxHumanLevel=74}
g_petList[30310030].dataIds[2] = {dataId=24879,minHumanLevel=75,maxHumanLevel=84}
g_petList[30310030].dataIds[3] = {dataId=24889,minHumanLevel=85,maxHumanLevel=94}
g_petList[30310030].dataIds[4] = {dataId=24899,minHumanLevel=95,maxHumanLevel=119}

g_petList[30310038] = {type=2, dataIds={}, level=1}	--超级珍兽笼：囚牛
g_petList[30310038].dataIds[1] = {dataId=24949,minHumanLevel=65,maxHumanLevel=74}
g_petList[30310038].dataIds[2] = {dataId=24959,minHumanLevel=75,maxHumanLevel=84}
g_petList[30310038].dataIds[3] = {dataId=24969,minHumanLevel=85,maxHumanLevel=94}
g_petList[30310038].dataIds[4] = {dataId=24979,minHumanLevel=95,maxHumanLevel=119}

g_petList[30310046] = {type=2, dataIds={}, level=1}	--超级珍兽笼：小花妖
g_petList[30310046].dataIds[1] = {dataId=24019,minHumanLevel=65,maxHumanLevel=74}
g_petList[30310046].dataIds[2] = {dataId=24029,minHumanLevel=75,maxHumanLevel=84}
g_petList[30310046].dataIds[3] = {dataId=24039,minHumanLevel=85,maxHumanLevel=94}
g_petList[30310046].dataIds[4] = {dataId=24049,minHumanLevel=95,maxHumanLevel=119}

g_petList[30310054] = {type=2, dataIds={}, level=1}	--超级珍兽笼：烈兔甜心
g_petList[30310054].dataIds[1] = {dataId=27459,minHumanLevel=65,maxHumanLevel=74}
g_petList[30310054].dataIds[2] = {dataId=27469,minHumanLevel=75,maxHumanLevel=84}
g_petList[30310054].dataIds[3] = {dataId=27479,minHumanLevel=85,maxHumanLevel=94}
g_petList[30310054].dataIds[4] = {dataId=27489,minHumanLevel=95,maxHumanLevel=119}

g_petList[30310062] = {type=2, dataIds={}, level=1}	--超级珍兽笼：七彩辉骏
g_petList[30310062].dataIds[1] = {dataId=27529,minHumanLevel=65,maxHumanLevel=74}
g_petList[30310062].dataIds[2] = {dataId=27539,minHumanLevel=75,maxHumanLevel=84}
g_petList[30310062].dataIds[3] = {dataId=27549,minHumanLevel=85,maxHumanLevel=94}
g_petList[30310062].dataIds[4] = {dataId=27559,minHumanLevel=95,maxHumanLevel=119}

g_petList[30310075] = {type=2, dataIds={}, level=1}	--超级珍兽笼：镇岛神兽
g_petList[30310075].dataIds[1] = {dataId=27609,minHumanLevel=65,maxHumanLevel=74}
g_petList[30310075].dataIds[2] = {dataId=27619,minHumanLevel=75,maxHumanLevel=84}
g_petList[30310075].dataIds[3] = {dataId=27629,minHumanLevel=85,maxHumanLevel=94}
g_petList[30310075].dataIds[4] = {dataId=27639,minHumanLevel=95,maxHumanLevel=119}

g_petList[30310076] = {type=2, dataIds={}, level=1}	--超级珍兽笼：镇岛神兽
g_petList[30310076].dataIds[1] = {dataId=27609,minHumanLevel=65,maxHumanLevel=74}
g_petList[30310076].dataIds[2] = {dataId=27619,minHumanLevel=75,maxHumanLevel=84}
g_petList[30310076].dataIds[3] = {dataId=27629,minHumanLevel=85,maxHumanLevel=94}
g_petList[30310076].dataIds[4] = {dataId=27639,minHumanLevel=95,maxHumanLevel=119}

g_petList[30310085] = {type=2, dataIds={}, level=1}	--超级珍兽笼：鸾凤和鸣
g_petList[30310085].dataIds[1] = {dataId=27679,minHumanLevel=65,maxHumanLevel=74}
g_petList[30310085].dataIds[2] = {dataId=27689,minHumanLevel=75,maxHumanLevel=84}
g_petList[30310085].dataIds[3] = {dataId=27699,minHumanLevel=85,maxHumanLevel=94}
g_petList[30310085].dataIds[4] = {dataId=27709,minHumanLevel=95,maxHumanLevel=119}

g_petList[38000204] = {type=2, dataIds={}, level=1}	--超级珍兽笼：五色神牛
g_petList[38000204].dataIds[1] = {dataId=23749,minHumanLevel=65,maxHumanLevel=74}
g_petList[38000204].dataIds[2] = {dataId=23759,minHumanLevel=75,maxHumanLevel=84}
g_petList[38000204].dataIds[3] = {dataId=23769,minHumanLevel=85,maxHumanLevel=94}
g_petList[38000204].dataIds[4] = {dataId=23779,minHumanLevel=95,maxHumanLevel=119}

g_petList[38002172] = {type=2, dataIds={}, level=1}	--超级珍兽笼：七巧狸猫
g_petList[38002172].dataIds[1] = {dataId=23949,minHumanLevel=65,maxHumanLevel=74}
g_petList[38002172].dataIds[2] = {dataId=23959,minHumanLevel=75,maxHumanLevel=84}
g_petList[38002172].dataIds[3] = {dataId=23969,minHumanLevel=85,maxHumanLevel=94}
g_petList[38002172].dataIds[4] = {dataId=23979,minHumanLevel=95,maxHumanLevel=119}

g_petList[38001080] = {type=2, dataIds={}, level=1}	--超级珍兽笼：唐装鼠
g_petList[38001080].dataIds[1] = {dataId=8779,minHumanLevel=65,maxHumanLevel=74}
g_petList[38001080].dataIds[2] = {dataId=8789,minHumanLevel=75,maxHumanLevel=84}
g_petList[38001080].dataIds[3] = {dataId=8799,minHumanLevel=85,maxHumanLevel=94}
g_petList[38001080].dataIds[4] = {dataId=8809,minHumanLevel=95,maxHumanLevel=119}

g_petList[38001798] = {type=2, dataIds={}, level=1}	--超级珍兽笼：萌宝猪
g_petList[38001798].dataIds[1] = {dataId=30609,minHumanLevel=65,maxHumanLevel=74}
g_petList[38001798].dataIds[2] = {dataId=30619,minHumanLevel=75,maxHumanLevel=84}
g_petList[38001798].dataIds[3] = {dataId=30629,minHumanLevel=85,maxHumanLevel=94}
g_petList[38001798].dataIds[4] = {dataId=30639,minHumanLevel=95,maxHumanLevel=119}

g_petList[30309802] = {type=2, dataIds={}, level=1}	--低级珍兽笼：熊猫
g_petList[30309802].dataIds[1] = {dataId=7789,minHumanLevel=5,maxHumanLevel=44}
g_petList[30309802].dataIds[2] = {dataId=7799,minHumanLevel=45,maxHumanLevel=119}

g_petList[30309803] = {type=2, dataIds={}, level=1}	--高级珍兽笼：熊猫
g_petList[30309803].dataIds[1] = {dataId=7809,minHumanLevel=5,maxHumanLevel=64}
g_petList[30309803].dataIds[2] = {dataId=7819,minHumanLevel=65,maxHumanLevel=74}
g_petList[30309803].dataIds[3] = {dataId=7829,minHumanLevel=75,maxHumanLevel=84}
g_petList[30309803].dataIds[4] = {dataId=7839,minHumanLevel=85,maxHumanLevel=119}

g_petList[30309804] = {type=2, dataIds={}, level=1}	--超级珍兽笼：熊猫
g_petList[30309804].dataIds[1] = {dataId=7849,minHumanLevel=5,maxHumanLevel=119}

g_petList[30309791] = {type=2, dataIds={}, level=1}	--低级珍兽笼：呆呆牛
g_petList[30309791].dataIds[1] = {dataId=22289,minHumanLevel=5,maxHumanLevel=44}
g_petList[30309791].dataIds[2] = {dataId=22299,minHumanLevel=45,maxHumanLevel=119}

g_petList[30309792] = {type=2, dataIds={}, level=1}	--高级珍兽笼：呆呆牛
g_petList[30309792].dataIds[1] = {dataId=22309,minHumanLevel=5,maxHumanLevel=64}
g_petList[30309792].dataIds[2] = {dataId=22319,minHumanLevel=65,maxHumanLevel=74}
g_petList[30309792].dataIds[3] = {dataId=22329,minHumanLevel=75,maxHumanLevel=84}
g_petList[30309792].dataIds[4] = {dataId=22339,minHumanLevel=85,maxHumanLevel=119}

g_petList[30309793] = {type=2, dataIds={}, level=1}	--超级珍兽笼：呆呆牛
g_petList[30309793].dataIds[1] = {dataId=22349,minHumanLevel=5,maxHumanLevel=119}

g_petList[30310010] = {type=1, dataId=31349, level=1,minHumanLevel=95,maxHumanLevel=119} --霓凰
g_petList[30310116] = {type=1, dataId=27819, level=1,minHumanLevel=95,maxHumanLevel=119} --珍兽蛋：小鹿呦呦

g_petList[30310096] = {type=2, dataIds={}, level=1}	--超级珍兽笼：昭瑞麒麟
g_petList[30310096].dataIds[1] = {dataId=30079,minHumanLevel=65,maxHumanLevel=74}
g_petList[30310096].dataIds[2] = {dataId=30089,minHumanLevel=75,maxHumanLevel=84}
g_petList[30310096].dataIds[3] = {dataId=30099,minHumanLevel=85,maxHumanLevel=94}
g_petList[30310096].dataIds[4] = {dataId=30109,minHumanLevel=95,maxHumanLevel=119}

g_petList[30310104] = {type=2, dataIds={}, level=1}	--超级珍兽笼：覆海龙君
g_petList[30310104].dataIds[1] = {dataId=30149,minHumanLevel=65,maxHumanLevel=74}
g_petList[30310104].dataIds[2] = {dataId=30159,minHumanLevel=75,maxHumanLevel=84}
g_petList[30310104].dataIds[3] = {dataId=30169,minHumanLevel=85,maxHumanLevel=94}
g_petList[30310104].dataIds[4] = {dataId=30179,minHumanLevel=95,maxHumanLevel=119}

g_petList[30310117] = {type=2, dataIds={}, level=1}	--超级珍兽笼：小鹿呦呦
g_petList[30310117].dataIds[1] = {dataId=27789,minHumanLevel=65,maxHumanLevel=74}
g_petList[30310117].dataIds[2] = {dataId=27799,minHumanLevel=75,maxHumanLevel=84}
g_petList[30310117].dataIds[3] = {dataId=27809,minHumanLevel=85,maxHumanLevel=94}
g_petList[30310117].dataIds[4] = {dataId=27819,minHumanLevel=95,maxHumanLevel=119}

g_petList[30310112] = {type=2, dataIds={}, level=1}	--超级珍兽笼：飓风圣兽
g_petList[30310112].dataIds[1] = {dataId=27859,minHumanLevel=65,maxHumanLevel=74}
g_petList[30310112].dataIds[2] = {dataId=27869,minHumanLevel=75,maxHumanLevel=84}
g_petList[30310112].dataIds[3] = {dataId=27879,minHumanLevel=85,maxHumanLevel=94}
g_petList[30310112].dataIds[4] = {dataId=27889,minHumanLevel=95,maxHumanLevel=119}

g_petList[30310125] = {type=2, dataIds={}, level=1}	--超级珍兽笼：千峰战蝎
g_petList[30310125].dataIds[1] = {dataId=30979,minHumanLevel=65,maxHumanLevel=74}
g_petList[30310125].dataIds[2] = {dataId=30989,minHumanLevel=75,maxHumanLevel=84}
g_petList[30310125].dataIds[3] = {dataId=30999,minHumanLevel=85,maxHumanLevel=94}
g_petList[30310125].dataIds[4] = {dataId=31009,minHumanLevel=95,maxHumanLevel=119}

g_petList[30310126] = {type=2, dataIds={}, level=1}	--超级珍兽笼：火焰妖魔
g_petList[30310126].dataIds[1] = {dataId=31179,minHumanLevel=65,maxHumanLevel=74}
g_petList[30310126].dataIds[2] = {dataId=31189,minHumanLevel=75,maxHumanLevel=84}
g_petList[30310126].dataIds[3] = {dataId=31199,minHumanLevel=85,maxHumanLevel=94}
g_petList[30310126].dataIds[4] = {dataId=31209,minHumanLevel=95,maxHumanLevel=119}

g_petList[30310140] = {type=2, dataIds={}, level=1}	--超级珍兽笼：平天大圣
g_petList[30310140].dataIds[1] = {dataId=30219,minHumanLevel=65,maxHumanLevel=74}
g_petList[30310140].dataIds[2] = {dataId=30229,minHumanLevel=75,maxHumanLevel=84}
g_petList[30310140].dataIds[3] = {dataId=30239,minHumanLevel=85,maxHumanLevel=94}
g_petList[30310140].dataIds[4] = {dataId=30249,minHumanLevel=95,maxHumanLevel=119}

g_petList[30310148] = {type=2, dataIds={}, level=1}	--超级珍兽笼：百变圣僧
g_petList[30310148].dataIds[1] = {dataId=6769,minHumanLevel=65,maxHumanLevel=74}
g_petList[30310148].dataIds[2] = {dataId=6779,minHumanLevel=75,maxHumanLevel=84}
g_petList[30310148].dataIds[3] = {dataId=6789,minHumanLevel=85,maxHumanLevel=94}
g_petList[30310148].dataIds[4] = {dataId=6799,minHumanLevel=95,maxHumanLevel=119}

g_petList[30310156] = {type=2, dataIds={}, level=1}	--超级珍兽笼：灵巫月神
g_petList[30310156].dataIds[1] = {dataId=27969,minHumanLevel=65,maxHumanLevel=74}
g_petList[30310156].dataIds[2] = {dataId=27979,minHumanLevel=75,maxHumanLevel=84}
g_petList[30310156].dataIds[3] = {dataId=27989,minHumanLevel=85,maxHumanLevel=94}
g_petList[30310156].dataIds[4] = {dataId=27999,minHumanLevel=95,maxHumanLevel=119}

g_petList[38003420] = {type=2, dataIds={}, level=1}	--超级珍兽笼：蚀骨冥蛇
g_petList[38003420].dataIds[1] = {dataId=6839,minHumanLevel=65,maxHumanLevel=74}
g_petList[38003420].dataIds[2] = {dataId=6849,minHumanLevel=75,maxHumanLevel=84}
g_petList[38003420].dataIds[3] = {dataId=6859,minHumanLevel=85,maxHumanLevel=94}
g_petList[38003420].dataIds[4] = {dataId=6869,minHumanLevel=95,maxHumanLevel=119}

g_petList[38003497] = {type=2, dataIds={}, level=1}	--超级珍兽笼：金童玉女
g_petList[38003497].dataIds[1] = {dataId=25889,minHumanLevel=65,maxHumanLevel=74}
g_petList[38003497].dataIds[2] = {dataId=25899,minHumanLevel=75,maxHumanLevel=84}
g_petList[38003497].dataIds[3] = {dataId=25909,minHumanLevel=85,maxHumanLevel=94}
g_petList[38003497].dataIds[4] = {dataId=25919,minHumanLevel=95,maxHumanLevel=119}

g_petList[30310167] = {type=2, dataIds={}, level=1}	--超级珍兽笼：黑山姥姥
g_petList[30310167].dataIds[1] = {dataId=25989,minHumanLevel=95,maxHumanLevel=119}
function common_item:IsSkillLikeScript()
    return 1
end

function common_item:CancelImpacts()
    return 0
end

function common_item:OnConditionCheck(selfId)
	-- 校验使用的物品
	if not self:LuaFnVerifyUsedItem(selfId )then
		self:notify_tips( selfId, "未开放道具，无法使用。")
		return 0
	end
	local checkCreatePet = self:TryCreatePet(selfId, 1)
	if not checkCreatePet then
		self:notify_tips( selfId, "您不能携带更多的珍兽。")
		return 0
	end
	local itemTblIndex = self:LuaFnGetItemIndexOfUsedItem(selfId)
	local petItem = g_petList[itemTblIndex]
	if not petItem then
		self:notify_tips( selfId, "未开放道具，无法使用。")
		return 0
	end
	--[[if petItem.type ~= 2 then
	    local takeLevel = self:GetPetTakeLevel(petItem.dataId)
	    local humanLevel = self:GetLevel(selfId)
	    if not takeLevel or not humanLevel or takeLevel > humanLevel then
		    self:notify_tips( selfId, "你的等级不能比珍兽的携带等级低。")
		    return 0
	    end
	end]]
	return 1
end

function common_item:OnDeplete(selfId)
    return 1
end

function common_item:OnActivateOnce(selfId)
	--删除前保存Trans....
	local BagIndex = self:LuaFnGetBagIndexOfUsedItem(selfId)
	local itemTblIndex = self:LuaFnGetItemIndexOfUsedItem(selfId )
	if self:LuaFnGetItemTableIndexByIndex(selfId,BagIndex) ~= itemTblIndex then
		self:notify_tips(selfId, "使用道具异常，无法使用。")
		return 0
	end
	local petItem = g_petList[itemTblIndex];
	if not petItem then
		self:notify_tips(selfId, "未开放道具，无法使用。")
		return 0
	end
	local params
	local pet_space
	local fun_name
	local pet_type = petItem.type
	if pet_type == 1 then
		fun_name = "CreateRMBPetToHuman34534"
		pet_space = 1
		if petItem.dataIds then
			params = petItem.dataIds
		else
			params = petItem.dataId
		end
	elseif pet_type == 2 then
		fun_name = "Create2RMBPetToHuman34534"
		pet_space = 2
		params = petItem.dataIds
	else
		pet_space = 1
		params = petItem.dataId
	end
	if pet_space and params then
		local ItemInfo = self:GetBagItemTransfer(selfId, BagIndex )
		local checkCreatePet = self:TryCreatePet(selfId,pet_space)
		if not checkCreatePet then
			self:notify_tips(selfId, "您不能携带更多的珍兽。")
			return 0
		end
		if fun_name then
			if type(params) == "number" then
				if not params or not self:GetIsPetID(params) then
					self:notify_tips(selfId, "珍兽ID不存在。")
					return 0
				end
				self:EraseItem(selfId, BagIndex)
				local ret, petGUID_H, petGUID_L = self:CallScriptFunction(800105, fun_name, selfId, params, petItem.level)
				if ret then
					self:OnGivePlayerPet(selfId, params, petGUID_H, petGUID_L, ItemInfo)
				end
				return 1
			elseif type(params) == "table" then
				local level = self:GetLevel(selfId)
				for _, pet in pairs(params) do
					if level >= pet.minHumanLevel and level <= pet.maxHumanLevel  then
						if not self:GetIsPetID(pet.dataId) then
							self:notify_tips(selfId, "珍兽ID不存在。")
							return 0
						end
						self:EraseItem(selfId, BagIndex)
						local ret, petGUID_H, petGUID_L = self:CallScriptFunction(800105, fun_name, selfId, pet.dataId, petItem.level)
						if ret then
							if pet_space == 1 then
								self:OnGivePlayerPet(selfId, pet.dataId, petGUID_H, petGUID_L, ItemInfo)
							else
								for i = 1,pet_space do
									self:OnGivePlayerPet(selfId, pet.dataId, petGUID_H[i], petGUID_L[i], ItemInfo )
								end
							end
						end
						return 1
					end
				end
			end
		else
			if not self:GetIsPetID(params) then
				self:notify_tips(selfId, "珍兽ID不存在。")
				return 0
			end
			self:EraseItem(selfId, BagIndex)
			local ret, petGUID_H, petGUID_L = self:LuaFnCreatePetToHuman(selfId, params, true)
			if ret then
				self:OnGivePlayerPet(selfId, params, petGUID_H, petGUID_L, ItemInfo )
			end
			return 1
		end
	end
	self:notify_tips(selfId, "未知错误。")
	return 0
end

function common_item:OnGivePlayerPet(selfId, petId, petGUID_H, petGUID_L, ItemInfo )
	local petName = self:GetPetName(petId)
	if petName then
		self:notify_tips(selfId, "恭喜您成功的获得了"..petName.."！")
	end
	self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 18, 0)
	local player_name = self:GetName(selfId)
	player_name = gbk.fromutf8(player_name)
	--毛驴公告....
	if petId == 3399 or petId == 8969 or petId == 8979 or petId == 8989 then
		local szPetTrans = self:GetPetTransString(selfId, petGUID_H, petGUID_L )
		local Msg = "#{_INFOUSR%s}#R使用了#{_INFOMSG%s}#R得到了一只#{_INFOMSG%s}#R。"
		local str = string.format(Msg, player_name, ItemInfo, szPetTrans )
		self:BroadMsgByChatPipe(selfId, str, 4)
		return
	end
	--唐装鼠公告....
	if petId == 8759 or petId == 8789 or petId == 8799  then
		local szPetTrans = self:GetPetTransString(selfId, petGUID_H, petGUID_L )
		local Msg = "#{_INFOUSR%s}#{TZS_16}#{_INFOMSG%s}#{TZS_17}#{_INFOUSR%s}#{TZS_18}"
		local str = string.format( Msg, player_name, szPetTrans, player_name )
		self:BroadMsgByChatPipe(selfId, str, 4)
		return
	end
	--穷奇公告....
	if petId == 22059 then
		local szPetTrans = self:GetPetTransString(selfId, petGUID_H, petGUID_L )
		local Msg = "#{_INFOUSR%s}#{XZS_01}#{_INFOMSG%s}#{XZS_02}#{_INFOMSG%s}#{XZS_03}"
		local str = string.format( Msg, player_name, ItemInfo, szPetTrans )
		self:BroadMsgByChatPipe(selfId, str, 4)
		return
	end
	--小狐仙公告....
	if petId == 22129 then
		local szPetTrans = self:GetPetTransString(selfId, petGUID_H, petGUID_L )
		local Msg = "#{_INFOUSR%s}#{XZS_04}#{_INFOMSG%s}#{XZS_05}#{_INFOMSG%s}#{XZS_06}"
		local str = string.format( Msg, player_name, ItemInfo, szPetTrans )
		self:BroadMsgByChatPipe(selfId, str, 4)
		return
	end
	--鸳鸯公告... zchw
	if (petId == 8889) or (petId == 8899) or (petId == 8909) or (petId == 8919) or (petId == 8929) or(petId == 8939) or (petId == 8949) then
		local szPetTrans = self:GetPetTransString(selfId, petGUID_H, petGUID_L )
		local Msg = "#{_INFOUSR%s}#{XZS_07}#{_INFOMSG%s}#{XZS_08}#{_INFOMSG%s}#{XZS_09}"
		local str = string.format(Msg, player_name, ItemInfo, szPetTrans )
		self:BroadMsgByChatPipe(selfId, str, 4)
		return
	end
	--呆呆牛公告... hzp
	if (petId == 22289) or (petId == 22299) or (petId == 22309) or (petId == 22319) or (petId == 22329) or(petId == 22339) or (petId == 22349) then
		local szPetTrans = self:GetPetTransString(selfId, petGUID_H, petGUID_L )
		local Msg = "#{_INFOUSR%s}#{XZS_04}#{_INFOMSG%s}#{XZS_10}#{_INFOMSG%s}#{XZS_11}"
		local str = string.format( Msg, player_name, ItemInfo, szPetTrans )
		self:BroadMsgByChatPipe(selfId, str, 4)
		return
	end
	--欢乐猪公告... hzp
	if (petId == 8569) or (petId == 8579) or (petId == 8589) or (petId == 8599) or (petId == 8609) or(petId == 8619) or (petId == 8629) then
		local szPetTrans =self: GetPetTransString(selfId, petGUID_H, petGUID_L )
		local Msg = "#{_INFOUSR%s}#{XZS_12}#{_INFOMSG%s}#{XZS_13}#{_INFOMSG%s}#{XZS_14}"
		local str = string.format(Msg, player_name, ItemInfo, szPetTrans )
		self:BroadMsgByChatPipe(selfId, str, 4)
		return
	end
	--比翼鸟公告... hzp
	if (petId == 22219) or (petId == 22229) or (petId == 22239) or (petId == 22249) or (petId == 22259) or(petId == 22269) or (petId == 22279) then
		local szPetTrans = self:GetPetTransString(selfId, petGUID_H, petGUID_L )
		local Msg = "#{_INFOUSR%s}#{XZS_15}#{_INFOMSG%s}#{XZS_16}#{_INFOMSG%s}#{DSSJ_4}"
		local str = string.format(Msg, player_name, ItemInfo, szPetTrans )
		self:BroadMsgByChatPipe(selfId, str, 4)
		return
	end
	local szPetTrans = self:GetPetTransString(selfId, petGUID_H, petGUID_L )
	local Msg = "#{_INFOUSR%s}#{XZS_12}#{_INFOMSG%s}#{XZS_13}#{_INFOMSG%s}#{XZS_14}"
	local str = string.format(Msg, player_name, ItemInfo, szPetTrans )
	self:BroadMsgByChatPipe(selfId, str, 4)
end

return common_item