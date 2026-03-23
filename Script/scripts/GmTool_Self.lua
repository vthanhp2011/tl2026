local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ScriptGlobal = require "scripts.ScriptGlobal"
local GmTool_Self = class("GmTool_Self", script_base)
local skynet = require "skynet"
local packet_def = require "game.packet"
local item_cls = require "item"
local gbk = require "gbk"
local configenginer = require "configenginer":getinstance()
local clusteragentproxy_core = require "clusteragentproxy_core"
local utils = require "utils"


GmTool_Self.script_id = 900066
--self:BroadMsgByChatPipe( selfId, "Tip:"..tostring(Tip), 0);111  
GmTool_Self.ZS_LevelMax = 3
GmTool_Self.CS_LevelMax = 98


-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--		GM工具配置区 【请及时更新GM配置信息】
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--【GM工具是否开启 false=关闭（所有角色都不可以用GM工具），true=开启（配置里的角色可使用GM工具）】
GmTool_Self.GmToolIsOpen = true;
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--【测试权限，正式的不要加入到这里面】 对应 WorldOperation、TargetOperation、SelfOperation    值1、2、3均可使用  最大权限 
GmTool_Self.GmCeshi = {
						{user = "ceshi01",guid = 200001,name = "qwer"},
					};


-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--【拥有所有权限的GM加到这里，所有GM请不要出现重复】 对应 WorldOperation、TargetOperation、SelfOperation    值1、2、3均可使用  最大权限 
GmTool_Self.GmRootLarge = {
"cs001",
"yaobai001",
					};
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--【拥有部分权限的GM加到这里，所有GM请不要出现重复】对应 WorldOperation、TargetOperation、SelfOperation    值1、2均可使用  中等权限 
GmTool_Self.GmRootIn = {
						
					};
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--【拥有最少权限的GM加到这里，所有GM请不要出现重复】对应 WorldOperation、TargetOperation、SelfOperation    仅值1可使用  最小权限 
GmTool_Self.GmRootSmall = {
						
					};
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--【root lv 1=最低权限 2=中等权限 3=最高权限】
--操作影响游戏数据的内容不要乱放权限  如MD,EX,FLAG,WORLD等变量设置   BUFF删给等   
--此类如果乱操作到相关功能的内容,能联想到>>那些角色出问题,无厘头的问题
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
GmTool_Self.GiveSelfGmBuff = 2;					--自身领取GMBUFF 权限
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--所有对象    	不开放的项目 权限设置为 >= 4 即可
GmTool_Self.WorldOperation_max = 17
GmTool_Self.WorldOperation = {
					[1]  = {rootlv = 99,selectname = "开新一期竞拍"},
					[2]  = {rootlv = 99,selectname = "关闭竞拍"},
					[3]  = {rootlv = 99,selectname = "更新本期竞拍物品配置"},
					[4]  = {rootlv = 99,selectname = "开启花榜"},
					[5]  = {rootlv = 99,selectname = "开启凤凰战"},
					[6]  = {rootlv = 99,selectname = "关闭凤凰战(不结算)"},
					[7]  = {rootlv = 99,selectname = "结束凤凰战(结算)"},
					[8]  = {rootlv = 3,selectname = "BOSS战场配置"},
					[9]  = {rootlv = 3,selectname = "新增CDK"},
					[14]  = {rootlv = 98,selectname = "创建怪物"},
					[15]  = {rootlv = 3,selectname = "删除创建怪物"},
					[16]  = {rootlv = 3,selectname = "创建BOSS"},
					[17]  = {rootlv = 3,selectname = "修正版本号"},
					

				};
--单个对象    	不开放的项目 权限设置为 >= 4 即可
GmTool_Self.TargetOperation_max = 0
GmTool_Self.TargetOperation = {
					
				};
--自身    		不开放的项目 权限设置为 >= 4 即可
GmTool_Self.SelfOperation_max = 36
GmTool_Self.SelfOperation = {
					[1]  = {rootlv = 2,selectname = "领取道具"},
					[2]  = {rootlv = 3,selectname = "查道具信息"},
					[3]  = {rootlv = 3,selectname = "清空背包"},
					[4]  = {rootlv = 2,selectname = "领取金币"},
					[5]  = {rootlv = 3,selectname = "扣除金币"},
					[6]  = {rootlv = 2,selectname = "领取交子"},
					[7]  = {rootlv = 3,selectname = "扣除交子"},
					[8]  = {rootlv = 2,selectname = "领取元宝"},
					[9]  = {rootlv = 3,selectname = "扣除元宝"},
					[10] = {rootlv = 2,selectname = "领取绑元"},
					[11] = {rootlv = 3,selectname = "扣除绑元"},
					[12] = {rootlv = 2,selectname = "领取经验"},
					[13] = {rootlv = 3,selectname = "扣除经验"},
					[14] = {rootlv = 1,selectname = "设置等级"},
					[15] = {rootlv = 1,selectname = "加入门派"},
					[16] = {rootlv = 2,selectname = "学习心法"},
					[17] = {rootlv = 2,selectname = "设置心法"},
					[18] = {rootlv = 1,selectname = "查询BUFF"},
					[19] = {rootlv = 3,selectname = "查询MD数据"},
					[20] = {rootlv = 3,selectname = "查询EX数据"},
					[21] = {rootlv = 3,selectname = "查询FLAG数据"},
					[22] = {rootlv = 3,selectname = "查询WORLD数据"},

					--root权限 不要乱开放给其它权限  限定为3   这个是避免不懂数据的乱设把角色数据给设置乱套了
					[23] = {rootlv = 3,selectname = "学习技能"},
					[24] = {rootlv = 3,selectname = "删除技能"},
					[25] = {rootlv = 3,selectname = "领取BUFF"},
					[26] = {rootlv = 3,selectname = "删除BUFF"},
					[27] = {rootlv = 3,selectname = "查场景数据"},
					[28] = {rootlv = 3,selectname = "切换场景"},
					[29] = {rootlv = 3,selectname = "设置MD数据"},
					[30] = {rootlv = 3,selectname = "设置EX数据"},
					[31] = {rootlv = 3,selectname = "设置FLAG数据"},
					[32] = {rootlv = 3,selectname = "设置WORLD数据"},
					
					[33] = {rootlv = 3,selectname = "xxx"},
					[34] = {rootlv = 3,selectname = "xxx"},
					[35] = {rootlv = 3,selectname = "xxx"},
					[36] = {rootlv = 3,selectname = "xxx"},
				};
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--		GM工具配置区 【请及时更新GM配置信息】
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--
--权限
function GmTool_Self:IsGM( selfId,selfIdEx )
	if self.GmToolIsOpen then
		local MaxGmCount = 10
		local human = self:get_scene():get_obj_by_id(selfId)
		local guid = human:get_guid()
		local _,accountname = skynet.call(".gamed", "lua", "query_roler_account", string.format("%x", guid))
		
		
		--开放并检测测试者的权限
		local env = skynet.getenv("env")
		-- skynet.logi("env = ",env)
		if env == "local" or env == "debug" then
			for i = 1,#self.GmCeshi do
				if MaxGmCount <= 10 then
					if self.GmCeshi[i].user == accountname
					and self.GmCeshi[i].guid == guid
					and self.GmCeshi[i].name == human:get_name() then
						return 98
					end
				else
					break
				end
			end
			return 98
		end
		
		for i = 1,#self.GmRootLarge do
			if MaxGmCount <= 10 then
				if self.GmRootLarge[i] == accountname then
					return 3
				end
			else
				break
			end
		end
		for i = 1,#self.GmRootIn do
			if MaxGmCount <= 10 then
				if self.GmRootIn[i] == accountname then
					return 2
				end
			else
				break
			end
		end
		for i = 1,#self.GmRootSmall do
			if MaxGmCount <= 10 then
				if self.GmRootSmall[i] == accountname then
					return 1
				end
			else
				break
			end
		end
	end
	return 0;
end
--打开GM工具
function GmTool_Self:OpenGmTool( selfId )
	local rootlv = self:IsGM( selfId );
	if rootlv == 0 then
		--普通角色不开启  这里可附加其它操作  联系客服
		
		return
	end
	local rootid
	local backinfo = {}
	for i = 1,self.WorldOperation_max do
		if self.WorldOperation[i] then
			rootid = self.WorldOperation[i].rootlv;
			if rootid then
				if rootlv >= rootid then
					table.insert(backinfo,"1")
				else
					table.insert(backinfo,"0")
				end
			else
				table.insert(backinfo,"0")
			end
		else
			table.insert(backinfo,"0")
		end
	end
	local worldinfo = table.concat(backinfo)
	backinfo = {}
	for i = 1,self.TargetOperation_max do
		if self.TargetOperation[i] then
			rootid = self.TargetOperation[i].rootlv;
			if rootid then
				if rootlv >= rootid then
					table.insert(backinfo,"1")
				else
					table.insert(backinfo,"0")
				end
			else
				table.insert(backinfo,"0")
			end
		else
			table.insert(backinfo,"0")
		end
	end
	local targetinfo = table.concat(backinfo)
	backinfo = {}
	for i = 1,self.SelfOperation_max do
		if self.SelfOperation[i] then
			rootid = self.SelfOperation[i].rootlv;
			if rootid then
				if rootlv >= rootid then
					table.insert(backinfo,"1")
				else
					table.insert(backinfo,"0")
				end
			else
				table.insert(backinfo,"0")
			end
		else
			table.insert(backinfo,"0")
		end
	end
	local selfinfo = table.concat(backinfo)
	self:BeginUICommand()
    self:UICommand_AddInt(316022021)
    self:UICommand_AddStr("..\\Patch\\GmTool.ini")
    self:UICommand_AddStr(selfinfo)
    self:UICommand_AddStr(targetinfo)
    self:UICommand_AddStr(worldinfo)
    self:EndUICommand()
    self:DispatchUICommand(selfId,316022021)
	self:notify_tips( selfId,"open gmtool!" )
end

function GmTool_Self:SetTip(selfId,msg)
	self:BeginEvent()
        self:AddText(msg)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
	self:BeginUICommand()
    self:UICommand_AddInt(426042021)
    self:UICommand_AddStr(msg)
    self:EndUICommand()
    self:DispatchUICommand(selfId,426042021)
end
function GmTool_Self:OverWarNotAward( selfId )
	if self.GmToolIsOpen then
		local rootlv = self:IsGM( selfId );
		--开放并检测测试者的权限
		local env = skynet.getenv("env")
		-- skynet.logi("env = ",env)
		if env == "local" or env == "debug" then
			if rootlv < self.CS_LevelMax then
				self:notify_tips( selfId,"您的GM权限不足以操作此项目。" )
				return
			end
		else
			if rootlv < self.ZS_LevelMax then
				self:notify_tips( selfId,"您的GM权限不足以操作此项目。" )
				return
			end
		end
		local sceneId = self:GetSceneID()
		local warflag = self:LuaFnGetCopySceneData_Param(0,69)
		if warflag == 1 then
			
			
			
			
			
			
		elseif warflag == 2 then
			local warscene = self:LuaFnGetCopySceneData_Param(0,66)
			if warscene > 0 then
				local warscenename = self:GetSceneName(warscene)
				if warscene ~= sceneId then
					self:notify_tips( selfId,"请到BOSS战场场景:["..warscenename.."]里面再进行操作。" )
					return
				end
				local isstart = self.scene:get_param(1)
				local isopen = self.scene:get_param(2)
				if isstart > 0 or isopen > 0 then
					self:StopOneActivity(394)
					self.scene:set_param(1,0)
					self.scene:set_param(2,0)
					self.scene:set_param(32,2147483647)
					local boxpos = 
					{ 
						--第一个水晶
						[1] = 
						{
							world_pos = {x = -1, y = -1}, --水晶位置
							league_id = -1, --占领水晶同盟id
							guild_id = -1, --占领水晶帮会id
							league_name = "", --占领水晶同盟名称
							hp = 0, -- 写死传0
						},
						--第二个水晶
						[2] = 
						{
							world_pos = {x = -1, y = -1}, --水晶位置
							league_id = -1, --占领水晶同盟id
							guild_id = -1, --占领水晶帮会id
							league_name = "", --占领水晶同盟名称
							hp = 0, -- 写死传0
						},
						--第三个水晶
						[3] = 
						{
							world_pos = {x = -1, y = -1}, --水晶位置
							league_id = -1, --占领水晶同盟id
							guild_id = -1, --占领水晶帮会id
							league_name = "", --占领水晶同盟名称
							hp = 0, -- 写死传0
						},
						--第四个水晶
						[4] = 
						{
							world_pos = {x = -1, y = -1}, --水晶位置
							league_id = -1, --占领水晶同盟id
							guild_id = -1, --占领水晶帮会id
							league_name = "", --占领水晶同盟名称
							hp = 0, -- 写死传0
						},
					}
					self:DispatchPhoenixPlainWarCrystalPos(boxpos)
					local msg = "#B"..warscenename.."#PBOSS战提前结束，不结算战场奖励！"
					self:SetTip( selfId,msg )
					if isopen > 0 then
						self:SceneBroadcastMsg(msg)
						local bossid = self.scene:get_param(28)
						local mostercount = self:GetMonsterCount()
						local objId,dataId,obj
						for i = 1,mostercount do
							objId = self:GetMonsterObjID(i)
							obj = self.scene:get_obj_by_id(objId)
							if obj then
								dataId = obj:get_model()
								if dataId == bossid
								or dataId == 99998
								or dataId == 99999
								or dataId == 52338 then
									self.scene:delete_temp_monster(obj)
								end
							end
						end
					end
					
				else
					self:notify_tips( selfId,"当前BOSS战场没有开启，无需关闭。" )
					return
				end
			else
				self:SetTip( selfId,"error warscene:"..tostring(warscene) )
			end
		end
	end
end
function GmTool_Self:OverWarOnAward( selfId )
	if self.GmToolIsOpen then
		local rootlv = self:IsGM( selfId );
		if env == "local" or env == "debug" then
			if rootlv < self.CS_LevelMax then
				self:notify_tips( selfId,"您的GM权限不足以操作此项目。" )
				return
			end
		else
			if rootlv < self.ZS_LevelMax then
				self:notify_tips( selfId,"您的GM权限不足以操作此项目。" )
				return
			end
		end
		local sceneId = self:GetSceneID()
		local warflag = self:LuaFnGetCopySceneData_Param(0,69)
		if warflag == 1 then
			
			
			
			
			
			
		elseif warflag == 2 then
			local warscene = self:LuaFnGetCopySceneData_Param(0,66)
			if warscene > 0 then
				local warscenename = self:GetSceneName(warscene)
				if warscene ~= sceneId then
					self:notify_tips( selfId,"请到BOSS战场场景:["..warscenename.."]里面再进行操作。" )
					return
				end
				local isstart = self.scene:get_param(1)
				local isopen = self.scene:get_param(2)
				if isstart > 0 or isopen > 0 then
					self.scene:set_param(4,0)
					local msg = "#B"..warscenename.."#PBOSS战提前结束，结算战场奖励！"
					self:SetTip( selfId,msg )
					if isopen > 0 then
						self:SceneBroadcastMsg(msg)
					end
					
				else
					self:notify_tips( selfId,"当前BOSS战场没有开启，无需关闭。" )
					return
				end
			else
				self:SetTip( selfId,"error warscene:"..tostring(warscene) )
			end
		end
	end
end

function GmTool_Self:SetBossWar( selfId, warflag, param1,param2,param3,param4 )
	if not warflag or warflag < 0 or warflag > 20 then
		return
	end
	if self.GmToolIsOpen then
		local rootlv = self:IsGM( selfId );
		if env == "local" or env == "debug" then
			if rootlv < self.CS_LevelMax then
				self:notify_tips( selfId,"您的GM权限不足以操作此项目。" )
				return
			end
		else
			if rootlv < self.ZS_LevelMax then
				self:notify_tips( selfId,"您的GM权限不足以操作此项目。" )
				return
			end
		end
		local sceneId = self.scene:get_id()
		local waring = false
		local warscene = self:LuaFnGetCopySceneData_Param(0,66)
		if warscene > 0 then
			if self:LuaFnGetCopySceneData_Param(warscene,2) > 0 then
				waring = true
			end
		end
		if waring then
			if warflag == 0 then
				self:notify_tips( selfId,"当前:"..tostring(warscene).."号场景正在进行战争，不可设置此项" )
				return
			end
		end
		local yexihu_boss = self:GetActivityWar("yexihu_boss",false,false,"findOne",{_id = 0})
		if not yexihu_boss then
			self:notify_tips( selfId,"数据获取异常。" )
			return
		end
		if warflag == 0 then
			if sceneId == 0
			or sceneId == 1
			or sceneId == 2 then
				self:notify_tips( selfId,"不可在主城开启战场。" )
				return
			end
			if not param1 or param1 < 0 or param1 > 11111111 then
				self:notify_tips( selfId,"week error。" )
				return
			elseif not param2 or param2 < 0 or param2 > 23 then
				self:notify_tips( selfId,"hour error。" )
				return
			elseif not param3 or param3 < 0 or param3 > 59 then
				self:notify_tips( selfId,"minue error。" )
				return
			elseif not param4 or param4 < 0 or param4 > 72000 then
				self:notify_tips( selfId,"longtime error。" )
				return
			end
			local timer = os.date("*t")
			local curminue = timer.hour * 60 + timer.min
			local needminue = param2 * 60 + param3
			if curminue + 2 >= needminue then
				local msg = string.format("请给战争开启多预留两分钟以上(好比欲%02d:%02d开启则设置成%d时%d分)。",
				param2,param3,param2,param3 + 3)
				self:SetTip( selfId,msg )
				return
			end
			
			local scenename = "战场所在:"..self:GetSceneName()
			local weekstr = string.format("%08d",param1)
			local  warini = yexihu_boss.warini
			warini.needscene = sceneId
			warini.startminue = needminue
			warini.longtime = param4
			for i = 1,7 do
				warini["week"..i] = tonumber(string.sub(weekstr,i + 1,i + 1))
			end
			local updatedata = {
				playername = scenename,
				warini = warini,
			}
			self:UpdateActivityWar("yexihu_boss",false,false,updatedata)
			local isok = self:get_scene():get_script_engienr():call(999998, "LoadActivity", "load",true)
			if isok == 1 then
				self:GetActivityWar_ini( selfId, 2 )
				self:StartOneActivity(394,2100000000)
				local msg = string.format("%sBOSS战场开启成功:%02d时%02d分正式开启。",scenename,param2,param3)
				self:SetTip( selfId,msg )
			else
				self:notify_tips( selfId,"设置失败，请重试。" )
				return
			end
		else
			local paramid = 
			{
			"bossid",
			"bossposx",
			"bossposz",
			"bossmaxhp",
			"needlevel",
			"needmaxhp",
			"paodiantime",
			"paodianluckhuman",
			"paodianlx",
			"paodiancount",
			"paodianlucklx",
			"paodianluckcount",
			"dieboxcount",
			"playerboxcount",
			"playerboxprotecttime",
			"dieboxdeltime",
			"backsceneid",
			"backposx",
			"backposz",
			}
			local idx = paramid[warflag]
			if not idx then
				self:notify_tips( selfId,"warflag error。。" )
				return
			end
			if not param1 or param1 < 0 or param1 > 2100000000 then
				self:notify_tips( selfId,"param1 error。。" )
				return
			end
			if waring then
				if idx == "bossid" then
					self:notify_tips( selfId,"BOSS战正在进行中，不可更改BOSSID" )
					return
				end
			end
			local warini = yexihu_boss.warini
			warini[idx] = param1
			local updatedata = {warini = warini}
			self:UpdateActivityWar("yexihu_boss",false,false,updatedata)
			paramid = {28,29,30, 6,8,9,10,11, 12,13,14,15, 33,35,36,34, 37,38,39}
			local parid = paramid[warflag]
			if warscene > 0 and parid then
				self:LuaFnSetCopySceneData_Param(warscene,parid,param1)
			end
			self:BeginUICommand()
			self:UICommand_AddInt(828042022)
			self:UICommand_AddInt(warflag)
			self:UICommand_AddInt(param1)
			self:EndUICommand()
			self:DispatchUICommand(selfId,828042022)
			self:notify_tips( selfId,"设置成功。" )
		end
	end
end
function GmTool_Self:GetActivityWar_ini( selfId, warflag )
	if self.GmToolIsOpen then
		local rootlv = self:IsGM( selfId );
		if env == "local" or env == "debug" then
			if rootlv < self.CS_LevelMax then
				self:notify_tips( selfId,"您的GM权限不足以操作此项目。" )
				return
			end
		else
			if rootlv < self.ZS_LevelMax then
				self:notify_tips( selfId,"您的GM权限不足以操作此项目。" )
				return
			end
		end
		local sceneId = self:GetSceneID()
		local backtab = {}
		for i = 1,200 do
			backtab[i] = {
				name = "",
				rank_value_1 = 0,
				level = 0,
				menpai = 0,
				total = 117,
				win = 0,
				rank_value_2 = 0,
				rank_value_3 = 0,
				server_id = 0,
			}
		end
		local sceneId = self.scene:get_id()
		-- if sceneId == 0
		-- or sceneId == 1
		-- or sceneId == 2 then
			-- self:notify_tips( selfId,"主城不可操作此项目。" )
			-- return
		-- end
		local warscene = self:LuaFnGetCopySceneData_Param(0,66)
		local uiid
		if warflag == 1 then
			-- 凤凰
		elseif warflag == 2 then
			local scenename = self:GetSceneName()
			backtab[103].name = scenename.."BOSS战"
			uiid = 828042021
			backtab[102].rank_value_1 = self.script_id
			backtab[102].name = "SetBossWar"
			local paramid = 
			{
			"bossid",
			"bossposx",
			"bossposz",
			"bossmaxhp",
			"needlevel",
			"needmaxhp",
			"paodiantime",
			"paodianluckhuman",
			"paodianlx",
			"paodiancount",
			"paodianlucklx",
			"paodianluckcount",
			"dieboxcount",
			"playerboxcount",
			"playerboxprotecttime",
			"dieboxdeltime",
			"backsceneid",
			"backposx",
			"backposz",
			}
			-- local paramid = {28,29,30, 6,8,9,10,11, 12,13,14,15, 33,35,36,34, 37,38,39}
			backtab[101].win = #paramid
			
			backtab[1 ].name = "BOSS怪物表ID"
			backtab[2 ].name = "BOSS创建位置X"
			backtab[3 ].name = "BOSS创建位置Z"
			backtab[4 ].name = "BOSS最大血量"
			backtab[5 ].name = "参与需求等级"
			backtab[6 ].name = "参与需求血量"
			backtab[7 ].name = "泡点间隙(不设写0)"
			backtab[8 ].name = "幸运泡点人数"
			backtab[9 ].name = "普通泡点得到类型"
			backtab[10].name = "普通泡点得到数量"
			backtab[11].name = "幸运泡点得到类型"
			backtab[12].name = "幸运泡点得到数量"
			backtab[13].name = "BOSS死亡掉落包数量"
			backtab[14].name = "最后一击BOSS专属包数量"
			backtab[15].name = "专属包保护时间(秒)"
			backtab[16].name = "所有掉落包存活时间(秒)"
			backtab[17].name = "请离战场回到场景号"
			backtab[18].name = "请离战场回到场景位置X"
			backtab[19].name = "请离战场回到场景位置Z"
			local yexihu_boss = self:GetActivityWar("yexihu_boss",false,false,"findOne",{_id = 0})
			if not yexihu_boss then
				local isok = self:get_scene():get_script_engienr():call(999998, "LoadActivity", "load")
				if isok ~= 2 then
					self:notify_tips( selfId,"加载数据异常。" )
					return
				end
				yexihu_boss = self:GetActivityWar("yexihu_boss",false,false,"findOne",{_id = 0})
				if not yexihu_boss then
					self:notify_tips( selfId,"加载数据异常。。" )
					return
				end
			end
			local warini = yexihu_boss.warini
			local startminue = warini.startminue
			local weekflag = "1"..tostring(warini.week7)
			for i = 1,6 do
				weekflag = weekflag..tostring(warini["week"..i])
			end
			backtab[101].name = weekflag
			backtab[101].rank_value_1 = startminue // 60
			backtab[101].rank_value_2 = startminue % 60
			backtab[101].rank_value_3 = warini.longtime
			for i,j in ipairs(paramid) do
				backtab[i].rank_value_1 = warini[j]
			end
		else
			return
		end
		local human = self:get_scene():get_obj_by_id(selfId)
		local guid = human:get_guid()
		local msg = packet_def.WGCRetQueryXBWRankCharts.new()
		msg.status = 2
		msg.type = 1
		msg.guid = guid
		msg.rank_count = 200
		msg.top_list = backtab
		self:get_scene():send2client(human, msg)
		self:BeginUICommand()
		self:EndUICommand()
		self:DispatchUICommand(selfId,uiid)
		-- self:DispatchUICommand(selfId,uiid)
		local msg = "泡点类型给予:\n0 = 不开泡点\n1 = 金币\n2 = 交子\n3 = 元宝\n4 = 绑元"
		self:BeginEvent(self.script_id)
		self:AddText(msg)
		self:EndEvent()
		self:DispatchEventList(selfId,selfId)
	end
end
		
function GmTool_Self:BackInfoToUI( selfId,backinfo )
	self:BeginUICommand()
    self:UICommand_AddInt(426042021)
    self:UICommand_AddStr(backinfo)
    self:EndUICommand()
    self:DispatchUICommand(selfId,426042021)
end

GmTool_Self.PhoenixPlainWarSceneId = 191					--凤凰战争场景
GmTool_Self.PhoenixPlainWarOverTime = 1200				--凤凰战争时长  单位:秒
GmTool_Self.PhoenixPlainWarStartTime = 10				--凤凰战争GM开启后延时10秒正式开始  单位:秒
GmTool_Self.PhoenixPlainWarAwardTime = 100				--凤凰战争参与时长达100秒以上方可领取奖励  单位:秒
GmTool_Self.PhoenixPlainWarNeedLevel = 10				--凤凰战争参与需求等级
GmTool_Self.PhoenixPlainWarNeedHp = 10000				--凤凰战争参与需求最低血量 
function GmTool_Self:DebugXX( selfId )
	skynet.logi(self:GetName(selfId))
end
--GM代码测试或执行区1
function GmTool_Self:DebugA( selfId )
	-- self:notify_tips( selfId,"DebugA。2" )

	if self.GmToolIsOpen then
		local rootlv = self:IsGM( selfId );
		if rootlv < self.CS_LevelMax then
			self:notify_tips( selfId,"您的GM权限不足以操作此项目。" )
			return
		end

			local isguild = 9			--要修改的帮会ID
			local newname = "此名称已重置2"			--新名字不要重复，用乱码不易重复
			local guild = skynet.call(".db", "lua", "findOne", {collection = "guild",query = {name = newname}})
			if guild then
				elf:notify_tips( selfId,"帮会重复。" )
				return
			end
			-- skynet.call(".db", "lua", "safe_insert", { collection = "guild", doc = guild})
			guild = skynet.call(".db", "lua", "findOne", {collection = "guild",query = {id = isguild}})
			if guild then
				-- self:notify_tips( selfId,guild.name )
				guild.name = newname
				guild.desc = newname
				local selector_x = {id = isguild}
				local update_x = {
					["$set"] = guild
				}
				skynet.send(".db", "lua", "update", { collection = "guild", selector = selector_x,update = update_x,upsert = false,multi = false})
				skynet.call(".Guildmanager", "lua", "load_guilds")
			else
				self:notify_tips( selfId,"不存在该帮会。" )
			end

		
		-- local backtab = {}
	  -- local human = self:get_scene():get_obj_by_id(selfId)
	  -- local guid = human:get_guid()
	  -- local dateinfo = os.date("%Y%m%d", 1723468148)
	  -- local human_item_logic = require "human_item_logic"
		-- local obj = self.scene:get_obj_by_id(selfId)
		-- local newid = obj:get_obj_id()
		-- self:notify_tips( selfId,"selfId:"..tostring(selfId) )
		-- self:notify_tips( selfId,"newid:"..tostring(newid) )
		-- self:SceneBroadcastMsgEx("isok:"..os.time())
		-- self:RestoreHp(selfId)
		
		
		-- local openflag = 11
		-- if openflag == 11 then
			-- self:SetPKValue(selfId, 0)
			-- return
		-- end
	end
end
--GM代码测试或执行区2
function GmTool_Self:DebugB( selfId )
	if self.GmToolIsOpen then
		local rootlv = self:IsGM( selfId );
		if rootlv < self.CS_LevelMax then
			self:notify_tips( selfId,"您的GM权限不足以操作此项目。" )
			return
		end
		local human = self.scene:get_obj_by_id(selfId)
		if not human then return end
		local agent = human:get_agent()
		local scene = self:get_scene()
		local sceneId = scene:get_id()
		self:RestoreHp(selfId)
		self:RestoreMp(selfId)
		self:RestoreRage(selfId)
		for i = 1,200 do
			human:set_cool_down(i, 0)
		end
		local ts_id = -99   
		if 27 == ts_id then
			--1297
			local ret = self:CallDestSceneFunction(1297,808002,"StartActivity_Ex",365)
			if ret then
				skynet.logi("365 活动开启中")
			else
				skynet.logi("365 没开启")
			end
			
			return
		end
		if 26 == ts_id then
			local hour = self:GetHour()
			local minute = self:GetMinute() + 3
			if minute == 60 then
				hour = hour + 1
				minute = 0
			elseif minute > 60 then
				hour = hour + 1
				minute = minute - 60
			end
			
			local overdate = tonumber(os.date("%Y%m%d"))
			local params = {
				startmoney = 1000,     -- 起拍价(默认取self.startmoney)
				addmoney = 50,         -- 每次加价幅度(默认取self.addmoney)
				dresscount = 3,        -- 参与竞拍的时装数量(默认取#self.dressid)
				ridecount = 3,         -- 参与竞拍的坐骑数量(默认取#self.rideid)
				overdate = overdate,   -- 结束日期(默认当天日期)
				uiflag = 1,            -- 界面标识(1普通/2特殊，默认1)
				-- is_new = 0             -- 是否新拍卖(0否/1是[新拍卖则清空所有期数从第一期开始]，默认0)
				end_hour = hour,
				end_minute = minute,
			}
			self:CallScriptFunction(700489, "OpenJingPai", selfId, params)
			return
		end
		
		if 25 == ts_id then
			local timex = os.date("*t")
			local todaytime = os.time({year = timex.year, month = timex.month, day = timex.day, hour = 0, min = 0, sec = 0})  
			local curtime = os.time()
			local subtime = 86400 - (curtime - todaytime)
			skynet.logi("subtime = ",subtime,"curtime = ",curtime,"todaytime = ",todaytime)
			
			
		
			return
		end
		if 24 == ts_id then
			local node_list = utils.get_cluster_specific_server_by_server_alias(".world")
			for n, node in pairs(node_list) do
				skynet.logi(n," = ",node)
				-- cluster.call(node, ".gamed", "ban_user", account)
			end

		
			return
		end
		if 23 == ts_id then
			skynet.send(".ranking", "lua", "init")
			local tab = skynet.call(".ranking", "lua", "get_guid_value")
			if tab then
				for i,j in pairs(tab) do
					skynet.logi("[",i,"] = ",j)
				end
			else
				skynet.logi("无数据")
			
			end
			
			
			return
		end
		if 22 == ts_id then
			local endtime = self:GetHour() * 60 + self:GetMinute() + 2
			local overdate = tonumber(os.date("%Y%m%d"))
			local uiflag = 2
			
			local is_new = 0             -- 是否新花榜(0否/1是[新拍卖则清空所有期数从第一期开始]，默认0)
			is_new = is_new == 1
			local migration = self:ResetHuaBang(selfId,overdate,endtime,uiflag,is_new)
			if migration >= 1 and migration <= 3 then
				local topname = define.FLOWER_TOP_NAME[uiflag][migration] or "花榜"
				local msg = "#B"..topname.."#P花榜即时开启。"
				self:AddGlobalCountNews_Fun(define.UPDATE_CLIENT_ICON_SRIPTID,"OnPlayerUpdateIconDisplay",msg)
				self:notify_tips( selfId,msg )
			else
				self:notify_tips( selfId,"花榜开启失败，请检查当时是否有花榜在进行中或者在跨服场景中。" )
			end
			
			
			
			return
		end
		if 21 == ts_id then
			skynet.logi("GmTool_Self:DebugB")
			skynet.call(".SCENE_123", "lua", "save_flower_top")
			return
		end
		if 20 == ts_id then
			skynet.logi("GmTool_Self:DebugB")
			local dmg_top_list = scene:get_dmg_top_list(100)
			for i,j in ipairs(dmg_top_list) do
				skynet.logi("dmg_top_list 第",i,"名:guid = ",j.guid,",damage = ",j.damage)
			end
			-- local menpai = self:GetMenPai(351)
			-- self:AddGlobalCountNews_Fun(self.script_id,"menpai",tostring(menpai))
			
			-- local ranking = self:GetRanking(1)
			-- skynet.logi(ranking)
			-- local ranking = skynet.call(".ranking", "lua", "get_dmg_top_list", 100)
			-- for i,j in ipairs(ranking) do
				-- skynet.logi("ranking 第",i,"名:guid = ",j.guid,",damage = ",j.damage)
			-- end
			return
		end
		if 19 == ts_id then
			human:send_operate_result_msg(-102)
			skynet.logi("selfId = ",selfId)
			-- self:LuaFnGmKillObj(selfId, selfId)
			return
		end
		if 18 == ts_id then
			self:LuaFnResetWeekActiveDay(selfId)
		
			return
		end
		if 17 == ts_id then
			local mingdong
			if sceneId == 0 then
				mingdong = scene:get_mingdong_data()
			else
				-- local my_scene = string.format(".SCENE_0",sceneId)
				mingdong = skynet.call(".SCENE_0", "lua", "get_mingdong_data")
			end
			if mingdong then
				for i,j in pairs(mingdong) do
					skynet.logi("[",i,"] = ",j)
				end
			end
			return
		end
		
		
		if 16 == ts_id then
			local obj = self.scene:get_obj_by_id(selfId)
					local ret = packet_def.GCCharEquipment.new()
					ret.m_objID = selfId
					ret.flag = 0
					local equip_container = obj:get_equip_container()
					local item_index = define.INVAILD_ID
					local gemid = define.INVAILD_ID
					local visual = 0
					local equip = equip_container:get_item(define.HUMAN_EQUIP.HEQUIP_WEAPON)
					if equip then
						local weap_exterior_visual,weapon_id = obj:get_exterior_weapon_visual()
						if weap_exterior_visual then
							item_index = weapon_id
							visual = weap_exterior_visual
						else
							item_index = equip:get_index()
							local equip_data = equip:get_equip_data()
							local gem1 = equip_data:get_slot_gem(1)
							if gem1 > 0 then
								gemid = gem1
							end
							visual = equip_data:get_visual()
						end
					end
					ret:set_weapon(item_index,gemid,visual)
					item_index = define.INVAILD_ID
					gemid = define.INVAILD_ID
					visual = 0
					equip = equip_container:get_item(define.HUMAN_EQUIP.HEQUIP_CAP)
					if equip then
						item_index = equip:get_index()
						local equip_data = equip:get_equip_data()
						local gem1 = equip_data:get_slot_gem(1)
						if gem1 > 0 then
							gemid = gem1
						end
						visual = equip_data:get_visual()
					end
					ret:set_cap(item_index,gemid,visual)
					item_index = define.INVAILD_ID
					gemid = define.INVAILD_ID
					visual = 0
					equip = equip_container:get_item(define.HUMAN_EQUIP.HEQUIP_ARMOR)
					if equip then
						item_index = equip:get_index()
						local equip_data = equip:get_equip_data()
						local gem1 = equip_data:get_slot_gem(1)
						if gem1 > 0 then
							gemid = gem1
						end
						visual = equip_data:get_visual()
					end
					ret:set_armour(item_index,gemid,visual)
					item_index = define.INVAILD_ID
					gemid = define.INVAILD_ID
					visual = 0
					equip = equip_container:get_item(define.HUMAN_EQUIP.HEQUIP_CUFF)
					if equip then
						item_index = equip:get_index()
						local equip_data = equip:get_equip_data()
						local gem1 = equip_data:get_slot_gem(1)
						if gem1 > 0 then
							gemid = gem1
						end
						visual = equip_data:get_visual()
					end
					ret:set_cuff(item_index,gemid,visual)
					ret:set_unknow_6(-1,-1,0)
					item_index = define.INVAILD_ID
					gemid = define.INVAILD_ID
					visual = define.INVAILD_ID
					local gem2id,gem3id = define.INVAILD_ID,define.INVAILD_ID
					equip = equip_container:get_item(define.HUMAN_EQUIP.HEQUIP_FASHION)
					if equip then
						item_index = equip:get_index()
						local equip_data = equip:get_equip_data()
						local gem = equip_data:get_slot_gem(1)
						if gem > 0 then
							gemid = gem
						end
						gem = equip_data:get_slot_gem(2)
						if gem > 0 then
							gem2id = gem
						end
						gem = equip_data:get_slot_gem(3)
						if gem > 0 then
							gem3id = gem
						end
						visual = equip_data:get_visual()
					end
					ret:set_fasion(item_index,gemid,gem2id,gem3id,visual)
					item_index = define.INVAILD_ID
					gemid = define.INVAILD_ID
					visual = 0
					equip = equip_container:get_item(define.HUMAN_EQUIP.HEQUIP_WUHUN)
					if equip then
						item_index = equip:get_index()
						visual = obj:get_wuhun_visual()
					end
					ret:set_wuhun(item_index,visual)
					ret.flag = ret.flag | 0x80000000
					scene:send2client(obj, ret)
					scene:broadcast(obj, ret, true)
			
		
		
		
			return
		end
		
		
		
		
		if 15 == ts_id then
			-- local msg = self:ScriptGlobal_Format("#{YXQ_221123_01}","#{_ITEM10141004}")
			-- local msg = self:ScriptGlobal_Format("你背包内#{DLZH_20220120_22}","#{_ITEM10141004}")
			-- DLZH_20220120_22	#H%s0已过期，系统已自动删除
			local msg = string.contact_args("#{YXQ_221123_01","#{_ITEM10141004}").."}"
			local mail = {}
			mail.guid = define.INVAILD_ID
			mail.source = ""
			mail.portrait_id = define.INVAILD_ID
			mail.dest = human:get_name()
			mail.flag = define.MAIL_TYPE.MAIL_TYPE_SYSTEM
			mail.create_time = os.time()
			mail.content = msg
			skynet.send(".world", "lua", "send_mail", mail)
			self:notify_tips( selfId,msg )
			return
		end
		local world_pos = human:get_world_pos()
		if 14 == ts_id then
			local ma_func = require "ma_func"
			local value = ma_func:get_my_guid()
			skynet.logi("value = ",value)
		
			return
		end
		if 13 == ts_id then
			local str = string.format("scenecore:leave 非角色触发数据存档%s_%d",human:get_name(),human:get_guid())
			assert(false,str)
			return
		end
		if 12 == ts_id then
			local source_container = human:get_fasion_bag_container()
			for i = 0,100 do
				local item = source_container:get_item(i)
				if item then
					skynet.logi("[",i,"] = ",self:GetItemName(item.item_index),"(",item.item_index,")")
				end
			end
			local equip_container = human:get_equip_container()
			local equip = equip_container:get_item(16)
			if equip then
				skynet.logi("[时装位] = ",self:GetItemName(equip.item_index),"(",equip.item_index,")")
			end
			local select_index = human:get_fashion_depot_index()
			skynet.logi("[select_index] = ",select_index)
		
		
			-- local source_container = human:get_fasion_bag_container()
			-- -- local item = source_container:get_item(0) or item_cls.new()
			-- local item = item_cls.new()
			-- local equip_container = human:get_equip_container()
			-- equip = equip_container:get_item(16) or item
			-- local notice = packet_def.GCFashionDepotOperation.new()
			-- notice.unknow_2 = 1
			-- notice.flag = 6
			-- notice.fashion = equip:copy_raw_data()
			-- self:get_scene():send2client(human, notice)
			-- -- self:get_scene():send_char_fashion_depot_data(human)
			return
		end
		
		
		
		if 11 == ts_id then
			human:send_refresh_attrib()
			return
		end
		if 10 == ts_id then
			-- self:get_scene():broad_char_equioment(human)
			
			local ret = packet_def.GCCharEquipment.new()
			ret.m_objID = selfId
			ret.flag = 0
			local item_index = define.INVAILD_ID
			local gemid = define.INVAILD_ID
			local visual = 0
			local gem2id,gem3id = define.INVAILD_ID,define.INVAILD_ID
			local equip_container = human:get_equip_container()
			local equip = equip_container:get_item(define.HUMAN_EQUIP.HEQUIP_FASHION)
			if equip then
				item_index = equip:get_index()
				local equip_data = equip:get_equip_data()
				local gem = equip_data:get_slot_gem(1)
				if gem > 0 then
					gemid = gem
				end
				gem = equip_data:get_slot_gem(2)
				if gem > 0 then
					gem2id = gem
				end
				gem = equip_data:get_slot_gem(3)
				if gem > 0 then
					gem3id = gem
				end
				visual = equip_data:get_visual()
			end
			ret:set_fasion(item_index,gemid,gem2id,gem3id,visual)
			self:get_scene():send2client(human, ret)
			self:get_scene():broadcast(human, ret, true)
			
			
			return
		end
		if 9 == ts_id then
			-- self:ActivateExteriorBackID(selfId,1,0)
				local posx,posz = self:GetWorldPos(selfId)
					local monsterid = self:LuaFnCreateMonster(50819,posx,posz,15,0,-1)
					if monsterid and monsterid ~= -1 then
						self:SetCharacterDieTime(monsterid, 3600000)
						  local human = self:get_scene():get_obj_by_id(selfId)
						  local name = human:get_name()
						self:SetCharacterName(monsterid, "木桩("..name..")")
					end
			return
		end
		if 8 == ts_id then
			local szItemTransfer = self:GetBagItemTransfer(selfId, 0)
			-- skynet.logi("szItemTransfer = ",szItemTransfer)
			
			local name = self:GetName(selfId)
			
		    -- local msg = string.contact_args("#{BGTS_220125_54","呵呵呵呵")
			-- msg = msg .. "}"
			
		    -- local msg = string.contact_args("#{BGTS_220125_61",name,"12345678")
			-- msg = msg .. "}"
			
			local msg = self:ScriptGlobal_Format("#{BGTS_220125_54}",name)
			
			
			self:BroadMsgByChatPipe(selfId, msg, 4)
			self:BeginEvent(self.script_id)
			self:AddText(msg)
			self:EndEvent()
			self:DispatchEventList(selfId,selfId)

			-- local fmt = gbk.fromutf8("#H侠士#{_INFOUSR%s}又添新物！背上的饰物#{_INFOMSG%s}巧夺天工，真是令人羡煞不已！")
			-- local message = string.format(fmt, gbk.fromutf8(name), szItemTransfer)
			-- self:BroadMsgByChatPipe(selfId, message, 4)
			return
		end
		if 7 == ts_id then
			local posx,posz = world_pos.x,world_pos.y
			local dir = self:GetMissionDataEx(selfId,800)
			skynet.logi("dir = ",dir,"dir / 100 = ",dir / 100)
			dir = dir / 100
			local monsterid = self:LuaFnCreateMonster(0,posx,posz,3,0,-1,dir)
			
			self:SetCharacterName(monsterid, tostring(dir))
			return
		end
		
		
		
		-- self:notify_tips( selfId,"DebugB。" )
		if 6 == ts_id then
			-- self:notify_tips( selfId,"XX0" )
			-- self:clientwrite( selfId,0,flag )
			human:send_operate_result_msg(-75)		
			return
		end
		if 5 == ts_id then
			local ret = packet_def.GCPackage_SwapItem.new()
			ret.result = 1
			ret.index_from = 1
			ret.index_to = 2
			ret.count = 0
			-- self:send2client(obj, ret)
			skynet.send(agent, "lua", "send2client", ret.xy_id, ret)
			return
		end
		if 4 == ts_id then
			local ret = packet_def.GCUseEquipResult.new()
			ret.bagIndex = 255
			ret.equipPoint = 16
			
			
            ret.equip_guid = {server = 0, world = 0, mask = 0, series = 0}
            ret.item_guid = {server = 0, world = 0, mask = 0, series = 0}
            ret.equipTableIndex = 0
            ret.item_index = -1
            ret.unknow = 1
            ret.result = 2
			
			local agent = human:get_agent()
			skynet.send(agent, "lua", "send2client", ret.xy_id, ret)
		
		
		
			-- human:send_exterior_info()
		
			return
		end
		if 3 == ts_id then
			local scriptid = 999361
			local objid = selfId
			local tipnum = 0
			local tips = {}
			local text
			for i = 1,10 do
			tipnum = tipnum + 1
			text = gbk.fromutf8("request = {\n")
			tips[tipnum] = {
				flag = 2,
				str = text,
				type = 0,
				index = 0,
				script_id = scriptid,
				len = string.len(text),
				split = -1
			}
			end
			local ret = packet_def.GCScriptCommand.new()
			ret.m_nCmdID = 0
			ret.event = tips
			ret.target_id = objid
			ret.size = tipnum
			
			local agent = human:get_agent()
			skynet.send(agent, "lua", "send2client", ret.xy_id, ret)
			
			-- self:send2client(obj_me, ret)
			return
		end
		
		if 2 == ts_id then
			self:BeginUICommand()
			-- self:UICommand_AddInt(index - 1)
			self:UICommand_AddInt(selfId)
			self:EndUICommand()
			self:DispatchUICommand(selfId,89334001)
			return
		end
		if 1 == ts_id then
			-- self:CallScriptFunction((400900), "TransferFunc", selfId, index1, index2, index3)
			
			local ret = packet_def.GCOrnamentsDataUpdate.new()
			--背
			ret.op_target = 0
			ret.op_code = 2
			--头
			-- ret.op_target = 1
			-- ret.op_code = 3
			
				ret.OrnamentsBackUnitNum = 3;
				ret.OrnamentsBackUnit = {
					{exteriorId = 1,x=128,y=128,z=128,state = 1,have_tip = 0},
					{exteriorId = 2,x=128,y=128,z=128,state = 2,have_tip = 0},
					{exteriorId = 3,x=128,y=128,z=128,state = 0,have_tip = 0},
				}
				ret.OrnamentsHeadUnitNum = 1
				ret.OrnamentsHeadUnit = {
					{exteriorId = 1,x=128,y=128,z=128,state = 4,have_tip = 0},
				
				}
			ret.CurOrnamentsBackId = 2
			ret.CurOrnamentsBackPos = 8421504
			ret.CurOrnamentsHeadId = 1
			ret.CurOrnamentsHeadPos = 8421504
			
			
			-- ret.OrnamentsBackUnit[1].exteriorId = 1
			-- ret.OrnamentsBackUnit[1].x = 1
			-- ret.OrnamentsBackUnit[1].y = 1
			-- ret.OrnamentsBackUnit[1].z = 1
			-- ret.OrnamentsBackUnit[1].z = 1
			
			
			-- ret.OrnamentsBackUnit[2].exteriorId = 2
			-- ret.OrnamentsBackUnit[2].x = 2
			-- ret.OrnamentsBackUnit[2].y = 2
			-- ret.OrnamentsBackUnit[2].z = 2
			-- ret.OrnamentsBackUnit[3].exteriorId = 3
			-- ret.OrnamentsBackUnit[3].x = 3
			-- ret.OrnamentsBackUnit[3].y = 3
			-- ret.OrnamentsBackUnit[3].z = 3
			-- ret.CurOrnamentsBackId = 1
			-- ret.nBackPosX = 128
			-- ret.nBackPosY = 128
			-- ret.nBackPosZ = 128
			-- self.CurOrnamentsBackPos = (self.nBackPosZ << 16) | (self.nBackPosY << 8) | self.nBackPosX
			local agent = human:get_agent()
			skynet.send(agent, "lua", "send2client", ret.xy_id, ret)
			-- self:send2client(human, ret)
			-- local scene = self:get_scene()
			-- scene:send2client(human, ret)
			return
		end
		
		
		
		-- local human = self.scene:get_obj_by_id(selfId)
		-- local openflag = 1
		-- if openflag == 1 then
			-- local container = human:get_prop_bag_container()
			-- for i, item in container:ipairs("prop") do
				-- if item then
					-- self:SceneBroadcastMsgEx("pos:"..tostring(i).." >> "..self:GetItemName(item:get_index()) .. " * "..item:get_lay_count())
				-- end
			-- end
			-- for i, item in container:ipairs("material") do
				-- if item then
					-- self:SceneBroadcastMsgEx("pos:"..tostring(i).." >> "..self:GetItemName(item:get_index()) .. " * "..item:get_lay_count())
				-- end
			-- end
			-- for i, item in container:ipairs("task") do
				-- if item then
					-- self:SceneBroadcastMsgEx("pos:"..tostring(i).." >> "..self:GetItemName(item:get_index()) .. " * "..item:get_lay_count())
				-- end
			-- end
			-- return
		-- end
	end
end
--自身领GMBUFF
function GmTool_Self:ReceiveGmBuff( selfId, index, param1,param2,param3 )
	if self.GmToolIsOpen then
		local rootlv = self:IsGM( selfId );
		if index == 1 then
			if rootlv >= self.GiveSelfGmBuff then
				local gm_buff = 2690
				self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, gm_buff, 0)
				local myname = self:GetName(selfId)
				local logx = "领取BUFF:"..tostring(gm_buff)
				self:SetGmToolLog(selfId,"领GM_BUFF",myname,logx)
				self:BeginUICommand()
				self:UICommand_AddInt(426042021)
				self:UICommand_AddStr("#G"..logx)
				self:EndUICommand()
				self:DispatchUICommand(selfId,426042021)
			end
		else
			if env == "local" or env == "debug" then
				if rootlv < self.CS_LevelMax then
					self:notify_tips( selfId,"您的GM权限不足以操作此项目。" )
					return
				end
			else
				if rootlv < self.ZS_LevelMax then
					self:notify_tips( selfId,"您的GM权限不足以操作此项目。" )
					return
				end
			end
			if index == 2 then
				local posx,posz = self:GetWorldPos(selfId)
				
				if 0 == 0 then
						local monsterid = self:LuaFnCreateMonster(50819,posx,posz,7,0,-1)
						-- local monsterid = self:LuaFnCreateMonster(50819,posx,posz,15,0,-1)
						-- local monsterid = self:LuaFnCreateMonster(50819,posx,posz,11,0,-1)
						if monsterid and monsterid ~= -1 then
							skynet.logi("monsterid = ",monsterid)
							self:get_scene():reset_dmg_top_monid(monsterid)
							self:SetCharacterDieTime(monsterid, 3600000)
							local monster = self:get_scene():get_obj_by_id(monsterid)
							monster:set_unconstrained_monster(true)
							  local human = self:get_scene():get_obj_by_id(selfId)
							  local name = human:get_name()
							monster:set_name("木桩("..tostring(monsterid)..")")
							monster:set_title(name.."创建:3600秒后消失")
							-- self:SetCharacterName(monsterid, "木桩("..tostring(monsterid)..")"..tostring(monsterid))
						end
					
					return
				end
				
				
				
					local  param2x = param2 or -1
					if param2x == -1 then
						param2x = 0
					end
					
					-- local deltime = param3 or 3600000
					local monsterid = self:LuaFnCreateMonster(param1,posx,posz,3,0,-1,param2x )
					if monsterid and monsterid ~= -1 then
						-- self:SetCharacterDieTime(monsterid, deltime)
						  -- local human = self:get_scene():get_obj_by_id(selfId)
						  -- local name = human:get_name()
						-- self:SetCharacterName(monsterid, "木桩("..name..")") 
					end
			
				-- local monsterid = self:LuaFnCreateMonster(0,posx + 2,posz + 2,3,0,809272)
				-- if monsterid and monsterid ~= -1 then
					-- self:SetCharacterName(monsterid, "张伏虎")
				-- end
				-- local monsterid = self:LuaFnCreateMonster(0,posx - 2,posz - 2,3,0,809272)
				-- if monsterid and monsterid ~= -1 then
					-- self:SetCharacterName(monsterid, "张笑师")
				-- end
				
				-- local posx,posz = self:GetWorldPos(selfId)
					-- local monsterid = self:LuaFnCreateMonster(50819,posx,posz,15,0,-1)
					-- if monsterid and monsterid ~= -1 then
						-- self:SetCharacterDieTime(monsterid, 3600000)
						  -- local human = self:get_scene():get_obj_by_id(selfId)
						  -- local name = human:get_name()
						-- self:SetCharacterName(monsterid, "木桩("..name..")")
					-- end
			
			
				-- 15,0,3
				-- local posx,posz = self:GetWorldPos(selfId)
				-- if not param1 or param1 == -1 then
					-- local monsterid = self:LuaFnCreateMonster(50819,posx,posz,15,0,-1)
					-- if monsterid and monsterid ~= -1 then
						-- self:SetCharacterDieTime(monsterid, 3600000)
						  -- local human = self:get_scene():get_obj_by_id(selfId)
						  -- local name = human:get_name()
						-- self:SetCharacterName(monsterid, "木桩("..name..")")
					-- end
				-- else
					-- local  param2x = param2 or -1
					-- local deltime = param3 or 3600000
					-- local monsterid = self:LuaFnCreateMonster(param1,posx,posz,3,0,param2x)
					-- if monsterid and monsterid ~= -1 then
						-- self:SetCharacterDieTime(monsterid, deltime)
						  -- -- local human = self:get_scene():get_obj_by_id(selfId)
						  -- -- local name = human:get_name()
						-- -- self:SetCharacterName(monsterid, "木桩("..name..")")
					-- end
				-- end
			elseif index == 3 then
			
			
			end
		end
	end
end
--对象自身操作
function GmTool_Self:SelfUse( selfId, selectindex, index1, index2, index3 )
	if not self.GmToolIsOpen then
		return
	elseif not selectindex or selectindex < 1 then
		return
	elseif not index1 or not index2 or not index3 then
		return
	end
	local need_rootlv = self.SelfOperation[selectindex].rootlv
	local selectname = self.SelfOperation[selectindex].selectname
	if not need_rootlv or need_rootlv < 1 then
		return
	elseif not selectname then
		return
	end
	local my_rootlv = self:IsGM(selfId)
	if my_rootlv < need_rootlv then
		self:notify_tips( selfId,"您的GM权限不足以操作此项目。" )
		return
	end
	local human = self:get_scene():get_obj_by_id(selfId)
	local loginfo,backinfo = "",""
	if selectindex == 1 then
		if index1 < 10000000 or index1 >= 60000000 then
			self:notify_tips( selfId,"请在P1输入正确的物品ID。" )
			return
		elseif index2 < 1 then
			self:notify_tips( selfId,"请在P2输入正确的数量。" )
			return
		end
		self:BeginAddItem()
		self:AddItem(index1,index2,false);
		if not self:EndAddItem(selfId) then
			self:notify_tips(selfId,"背包空间不足")
			return
		end
		self:AddItemListToHuman(selfId)
		loginfo = "已领取:"..self:GetItemName(index1)..tostring(index2).."个"
		backinfo = "#G"..loginfo
	elseif selectindex == 2 then
		if index1 < 0 or index1 > 118 then
			self:notify_tips( selfId,"请在P1输入正确的位置。" )
			return
		end
		local itemid = self:LuaFnGetItemTableIndexByIndex(selfId, index1 )
		if not itemid or itemid == -1 then
			self:notify_tips( selfId,"位置["..tostring(index1).."]上没有道具。" )
			return
		end
		local creatorName = self:LuaFnGetItemCreator(selfId, index1)
		if not creatorName then
			creatorName = "没有字符信息"
		end
		loginfo = "已查询位置["..tostring(index1).."]道具信息:"
		backinfo = loginfo.."\n#GID:"..tostring(itemid).."\nCreator:"..creatorName
	elseif selectindex == 3 then
		if index1 < 0 then
			self:notify_tips( selfId,"请在P1输入正确的位置。" )
			return
		elseif index2 < 0 then
			self:notify_tips( selfId,"请在P2输入正确的位置。" )
			return
		elseif index1 > index2 then
			self:notify_tips( selfId,"错误，P1不能大于P2。" )
			return
		end
		for i = index1,index2 do
			self:LuaFnEraseItem(selfId, i)
		end
		loginfo = "已清除位置["..tostring(index1).."]--["..tostring(index2).."]上的道具"
		backinfo = "#G"..loginfo
	elseif selectindex == 4 then
		if index1 < 1 then
			self:notify_tips( selfId,"请在P1输入正确的数值。" )
			return
		end
		local HumanMoney = self:LuaFnGetMoney(selfId)
		if HumanMoney + index1 > 144000000 then
			self:notify_tips( selfId,"金币过多，领取失败。" )
			return
		end
		self:AddMoney(selfId, index1)
		loginfo = "已领取金钱:"..tostring(index1)
		backinfo = "#G已领取金钱:#{_MONEY"..tostring(index1).."}"
	elseif selectindex == 5 then
		if index1 < 1 then
			self:notify_tips( selfId,"请在P1输入正确的数值。" )
			return
		end
		local delmoney = index1
		local HumanMoney = self:LuaFnGetMoney(selfId)
		if HumanMoney < 1 then
			self:notify_tips( selfId,"身上没有金钱。" )
			return
		elseif HumanMoney < delmoney then
			delmoney = HumanMoney
		end
		self:CostMoney(selfId, delmoney)
		loginfo = "已扣除金钱:"..tostring(delmoney)
		backinfo = "#G已扣除金钱:#{_MONEY"..tostring(delmoney).."}"
	elseif selectindex == 6 then
		if index1 < 1 then
			self:notify_tips( selfId,"请在P1输入正确的数值。" )
			return
		end
		local HumanMoney = self:GetMoneyJZ(selfId)
		if HumanMoney + index1 > 144000000 then
			self:notify_tips( selfId,"交子过多，领取失败。" )
			return
		end
		self:AddMoneyJZ(selfId, index1)
		loginfo = "已领取交子:"..tostring(index1)
		backinfo = "#G已领取交子:#{_EXCHG"..tostring(index1).."}"
	elseif selectindex == 7 then
		if index1 < 1 then
			self:notify_tips( selfId,"请在P1输入正确的数值。" )
			return
		end
		local delmoney = index1
		local HumanMoney = self:LuaFnGetMoney(selfId)
		if HumanMoney < 1 then
			self:notify_tips( selfId,"身上没有交子。" )
			return
		elseif HumanMoney < delmoney then
			delmoney = HumanMoney
		end
		local isok = self:LuaFnCostMoneyWithPriority(selfId, delmoney)
		if isok then
			loginfo = "已扣除交子:"..tostring(delmoney)
			backinfo = "#G已扣除交子:#{_EXCHG"..tostring(delmoney).."}"
		else
			loginfo = "扣除交子:"..tostring(delmoney).."失败"
			backinfo = "#cff0000扣除交子:#{_EXCHG"..tostring(delmoney).."}失败"
		end
	elseif selectindex == 8 then
		if index1 < 1 then
			self:notify_tips( selfId,"请在P1输入正确的数值。" )
			return
		end
		local yuanbao = self:GetYuanBao(selfId)
		if yuanbao + index1 > 2000000000 then
			self:notify_tips( selfId,"元宝过多。" )
			return
		end
		self:CSAddYuanbao(selfId, index1)
		-- human:add_yuanbao(index1)
		loginfo = "已领取元宝:"..tostring(index1)
		backinfo = "#G"..loginfo
	elseif selectindex == 9 then
		if index1 < 1 then
			self:notify_tips( selfId,"请在P1输入正确的数值。" )
			return
		end
		local yuanbao = self:GetYuanBao(selfId)
		local delyuanbao = index1
		if yuanbao < 1 then
			self:notify_tips( selfId,"身上没有元宝。" )
			return
		elseif yuanbao < delyuanbao then
			delyuanbao = yuanbao
		end
		self:LuaFnCostYuanBao(selfId, delyuanbao)
		loginfo = "已扣除元宝:"..tostring(delyuanbao)
		backinfo = "#G"..loginfo
	elseif selectindex == 10 then
		if index1 < 1 then
			self:notify_tips( selfId,"请在P1输入正确的数值。" )
			return
		end
		local yuanbao = self:GetBindYuanBao(selfId)
		if yuanbao + index1 > 2000000000 then
			self:notify_tips( selfId,"绑定元宝过多。" )
			return
		end
		self:AddBindYuanBao(selfId,index1)
		loginfo = "已领取绑定元宝:"..tostring(index1)
		backinfo = "#G"..loginfo
	elseif selectindex == 11 then
		if index1 < 1 then
			self:notify_tips( selfId,"请在P1输入正确的数值。" )
			return
		end
		local yuanbao = self:GetBindYuanBao(selfId)
		local delyuanbao = index1
		if yuanbao < 1 then
			self:notify_tips( selfId,"身上没有绑定元宝。" )
			return
		elseif yuanbao < delyuanbao then
			delyuanbao = yuanbao
		end
		self:LuaFnCostBindYuanBao(selfId, delyuanbao)
		loginfo = "已扣除绑定元宝:"..tostring(delyuanbao)
		backinfo = "#G"..loginfo
	elseif selectindex == 12 then
		if index1 < 1 then
			self:notify_tips( selfId,"请在P1输入正确的数值。" )
			return
		end
		self:AddExp(selfId, index1)
		loginfo = "已领取经验:"..tostring(index1)
		backinfo = "#G"..loginfo
	elseif selectindex == 13 then
		if index1 < 1 then
			self:notify_tips( selfId,"请在P1输入正确的数值。" )
			return
		end
		local myexp = self:GetExp(selfId)
		local delexp = 0 - index1
		if myexp < 1 then
			self:notify_tips( selfId,"当前没有经验。" )
			return
		elseif myexp < index1 then
			delexp = 0 - myexp
		end
		self:AddExp(selfId, delexp)
		loginfo = "已扣除经验:"..tostring(delexp)
		backinfo = "#G"..loginfo
	elseif selectindex == 14 then
		if index1 < 1 or index1 > 119 then
			self:notify_tips( selfId,"请在P1输入正确的数值。" )
			return
		end
		local curlv = self:GetLevel(selfId)
		if curlv == index1 then
			self:notify_tips( selfId,"当前等级相符，无需设置。" )
			return
		end
		-- self:SetLevel(selfId,index1)
		local obj = self:get_scene():get_obj_by_id(selfId)
		obj:set_level(index1)
		obj:wash_points()
		loginfo = "已设置角色等级:"..tostring(index1).."级"
		backinfo = "#G"..loginfo
	elseif selectindex == 15 then
		if index1 < 0 or index1 > 11 or index1 == 9 then
			self:notify_tips( selfId,"请在P1输入正确的数值。" )
			return
		end
		local curmp = self:GetMenPai(selfId)
		if curmp == index1 then
			self:notify_tips( selfId,"当前门派相符，无需更换。" )
			return
		elseif not curmp or curmp == -1 or curmp == 9 then
			self:LuaFnCancelImpactInSpecificImpact(selfId, 308)
			self:LuaFnJoinMenpai(selfId, index1)
		else
			self:LuaFnCancelImpactInSpecificImpact(selfId, 308)
			self:LuaFnChangeMenPai(selfId, index1)
			self:CallScriptFunction(888899, "UpdateRechargeMenPaiTitle", selfId, oldMenPai)
		end
		-- self:LuaFnJoinMenpai(selfId, index1)
		local mpname = {
		"少林",
		"明教",
		"丐帮",
		"武当",
		"峨嵋",
		"星宿",
		"天龙",
		"天山",
		"逍遥",
		"新手",
		"曼陀",
		"恶人谷",
		}
		local idx = index1 + 1
		loginfo = "已加入:["..tostring(mpname[idx]).."]门派"
		backinfo = "#G"..loginfo
	elseif selectindex == 16 then
		local xinfa_v1 = configenginer:get_config("xinfa_v1")
		local menpai = self:GetMenPai(selfId)
		for id, v1 in ipairs(xinfa_v1) do
			if v1.menpai == menpai then
				if self:HaveXinFa(selfId, id) == define.INVAILD_ID then
					self:AddXinFa(selfId, id)
				end
			end
		end
		loginfo = "领悟门派所有心法"
		backinfo = "#G"..loginfo
	elseif selectindex == 17 then
		if index1 < 1 then
			self:notify_tips( selfId,"请在P1输入正确的数值。" )
			return
		elseif index1 > self:GetLevel(selfId) then
			self:notify_tips( selfId,"心法等级不能超过人物等级。" )
			return
		end
		local xinfa_v1 = configenginer:get_config("xinfa_v1")
		local menpai = self:GetMenPai(selfId)
		for id, v1 in ipairs(xinfa_v1) do
			if v1.menpai == menpai then
				if self:HaveXinFa(selfId, id) ~= define.INVAILD_ID then
					self:LuaFnSetXinFaLevel(selfId, id, index1)
				end
			end
		end
		loginfo = "将已领悟的门派心法等级提升至"..tostring(index1).."级"
		backinfo = "#G"..loginfo
	elseif selectindex == 18 then
		local list = human:get_impact_list()
		local imptab = {"#G当前BUFF总数:"..tostring(#list)}
		local impid
		for _, imp in ipairs(list) do
			impid = imp:get_data_index()
			table.insert(imptab,tostring(impid))
		end
		loginfo = "已查询BUFF数及BUFFID"
		backinfo = table.concat(imptab,"\n")
	elseif selectindex == 19 then
		if index1 < 0 then
			self:notify_tips( selfId,"请在P1输入正确的数值。" )
			return
		end
		local mdvalue = self:GetMissionData(selfId, index1)
		loginfo = "已查询MD:["..tostring(index1).."] = "..tostring(mdvalue)
		backinfo = "#G"..loginfo
	elseif selectindex == 20 then
		if index1 < 0 then
			self:notify_tips( selfId,"请在P1输入正确的数值。" )
			return
		end
		local mdvalue = self:GetMissionDataEx(selfId, index1)
		loginfo = "已查询EX:["..tostring(index1).."] = "..tostring(mdvalue)
		backinfo = "#G"..loginfo
	elseif selectindex == 21 then
		if index1 < 0 then
			self:notify_tips( selfId,"请在P1输入正确的数值。" )
			return
		end
		local mdvalue = self:GetMissionFlag(selfId, index1)
		loginfo = "已查询FLAG:["..tostring(index1).."] = "..tostring(mdvalue)
		backinfo = "#G"..loginfo
	elseif selectindex == 22 then
		if index1 < 0 then
			self:notify_tips( selfId,"请在P1输入正确的数值。" )
			return
		end
		
		self:notify_tips( selfId,"未开放。" )
		return
	elseif selectindex == 23 then
		if index1 < 0 then
			self:notify_tips( selfId,"请在P1输入正确的数值。" )
			return
		end
		
		self:notify_tips( selfId,"未开放。学习技能" )
		return
	elseif selectindex == 24 then
		if index1 < 0 then
			self:notify_tips( selfId,"请在P1输入正确的数值。" )
			return
		end
		
		self:notify_tips( selfId,"未开放。删除技能" )
		return
	elseif selectindex == 25 then
		if index1 < 1  then
			self:notify_tips( selfId,"请在P1输入正确的数值。" )
			return
		end
		self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, index1, 100)
		loginfo = "已领取BUFF:"..tostring(index1)
		backinfo = "#G"..loginfo
	elseif selectindex == 26 then
		if index1 < 1 or index1 > 32767 then
			self:notify_tips( selfId,"请在P1输入正确的数值。" )
			return
		end
		self:LuaFnCancelSpecificImpact(selfId, index1)
		loginfo = "已清除BUFF:"..tostring(index1)
		backinfo = "#G"..loginfo
	elseif selectindex == 27 then
		if index1 >= 0 then
			loginfo = "已查询场景:["..tostring(index1).."]号参数信息"
			local backtab = {loginfo.."#G"}
			local value
			backinfo = loginfo.."\n#G"
			for i = 0,31 do
				value = self:LuaFnGetCopySceneData_Param(index1,i)
				backinfo = "Param["..tostring(i).."] = "..tostring(value)
				table.insert(backtab,backinfo)
			end
			backinfo = table.concat(backtab,"\n")
		else
			local sceneId = self:GetSceneID()
			loginfo = "已查询场景:["..tostring(sceneId).."]号参数信息"
			local backtab = {loginfo.."#G"}
			local value
			backinfo = loginfo.."\n#G"
			for i = 0,31 do
				value = self:LuaFnGetCopySceneData_Param(i)
				backinfo = "Param["..tostring(i).."] = "..tostring(value)
				table.insert(backtab,backinfo)
			end
			backinfo = table.concat(backtab,"\n")
		end
	elseif selectindex == 28 then
		if index1 < 0 then
			x900066_Back( sceneId,selfId,"请在P1输入正确的数值" )
			return
		elseif index2 < 1 or index2 > 999 then
			x900066_Back( sceneId,selfId,"请在P2输入正确的数值" )
			return
		elseif index3 < 1 or index3 > 999 then
			x900066_Back( sceneId,selfId,"请在P3输入正确的数值" )
			return
		end
		self:CallScriptFunction((400900), "TransferFunc", selfId, index1, index2, index3)
		loginfo = "已传送至:"..tostring(index1).."号场景("..tostring(index2)..","..tostring(index3)..")"
		backinfo = "#G"..loginfo
	elseif selectindex == 29 then
		if index1 < 0 then
			self:notify_tips( selfId,"请在P1输入正确的数值。" )
			return
		end
		self:SetMissionData(selfId, index1, index2)
		local curvalue = self:GetMissionData(selfId, index1)
		loginfo = "已设置MD:"..tostring(index1).." = "..tostring(curvalue)
		backinfo = "#G"..loginfo
	elseif selectindex == 30 then
		if index1 < 0 then
			self:notify_tips( selfId,"请在P1输入正确的数值。" )
			return
		end
		self:SetMissionDataEx(selfId, index1, index2)
		local curvalue = self:GetMissionDataEx(selfId, index1)
		loginfo = "已设置EX:"..tostring(index1).." = "..tostring(curvalue)
		backinfo = "#G"..loginfo
	elseif selectindex == 31 then
		if index1 < 0 then
			self:notify_tips( selfId,"请在P1输入正确的数值。" )
			return
		elseif index2 < 0 then
			self:notify_tips( selfId,"请在P2输入正确的数值。" )
			return
		end
		self:SetMissionFlag(selfId, index1, index2)
		local curvalue = self:GetMissionFlag(selfId, index1)
		loginfo = "已设置FLAG:"..tostring(index1).." = "..tostring(curvalue)
		backinfo = "#G"..loginfo
	else
		self:notify_tips( selfId,"未开放内容。" )
		return
	end
	local myname = self:GetName(selfId)
	self:SetGmToolLog(selfId,selectname,myname,loginfo)
	self:notify_tips(selfId,backinfo)
	--回传UI
	self:BeginUICommand()
    self:UICommand_AddInt(426042021)
    self:UICommand_AddStr(backinfo)
    self:EndUICommand()
    self:DispatchUICommand(selfId,426042021)
end
--对象操作目标
function GmTool_Self:TargetUse( selfId, selectindex, index1, index2, index3 )
end


--对象操作在线角色
function GmTool_Self:WorldUse( selfId, selectindex, index1, index2, index3 )
	if not self.GmToolIsOpen then
		return
	elseif not selectindex or selectindex < 1 then
		return
	elseif not index1 or not index2 or not index3 then
		return
	end
	local need_rootlv = self.WorldOperation[selectindex].rootlv
	local selectname = self.WorldOperation[selectindex].selectname
	if not need_rootlv or need_rootlv < 1 then
		return
	elseif not selectname then
		return
	end
	local my_rootlv = self:IsGM(selfId)
	if env == "local" or env == "debug" then
		if my_rootlv < self.CS_LevelMax then
			self:notify_tips( selfId,"您的GM权限不足以操作此项目。" )
			return
		end
	else
		if my_rootlv < need_rootlv then
			self:notify_tips( selfId,"您的GM权限不足以操作此项目。" )
			return
		end
	end
	local human = self:get_scene():get_obj_by_id(selfId)
	local loginfo,backinfo = "",""
	if selectindex >= 1 and selectindex <= 7 then
		if selectindex ~= 5 then
			self:CallScriptFunction(700489,"Gm_to_Operate",selectindex,selectname)
		else
			self:CallScriptFunction(888819,"StartHuaBangTop",selfId,selectname)
		end
	elseif selectindex == 8 then
		self:GetActivityWar_ini( selfId, 2 )
	elseif selectindex == 9 then
		-- if not index1 or index1 < 1 then
			-- self:notify_tips( selfId,"index1 error。" )
			-- return
		-- end
		local isok,doccd = self:CallScriptFunction(900067,"AddMoneyCardCount",selfId,index1)
		if isok == -1 then
			return
		elseif isok == 0 then
			self:notify_tips( selfId,"生成失败。" )
			return
		end
		local msg = string.format("欲新增CDK数:%d,实际生成数:%d。\n请查看%s。",index1,isok,doccd)
		local myname = self:GetName(selfId)
		self:SetGmToolLog(selfId,selectname,myname,"生成CDK:"..tostring(isok))
		self:notify_tips(selfId,backinfo)
		--回传UI
		self:BeginUICommand()
		self:UICommand_AddInt(426042021)
		self:UICommand_AddStr(msg)
		self:EndUICommand()
		self:DispatchUICommand(selfId,426042021)
		return
	elseif selectindex == 14 then
		
		if index1 < 0 then
			self:notify_tips( selfId,"参数1异常。" )
			return
		end
		local scriptid = index2 > 0 and index2 or -1
		local dir = index3 > 0 and index3 or nil
		local posx,posz = self:GetWorldPos(selfId)
		local monsterid = self:LuaFnCreateMonster(index1,posx,posz,3,0,scriptid,dir)
		if monsterid and monsterid ~= -1 then
			self:SetCharacterDieTime(monsterid,3600000)
			local monster = self:get_scene():get_obj_by_id(monsterid)
			local name = monster:get_name().."_id:"..monsterid
			-- self:SetCharacterName(monsterid,name)
			monster:set_name(name)
			monster:set_title("3600秒后消失")
			monster:set_unconstrained_monster(true)
			backinfo = "生成怪物:"..monsterid
			loginfo = backinfo
		end
	elseif selectindex == 15 then
		local del_num = 0
		local monster_num = self:GetMonsterCount()
		for i = 1,monster_num do
			local objId = self:GetMonsterObjID(i)
			local obj = self:get_scene():get_obj_by_id(objId)
			local name = obj:get_name()
			if string.find(name,"_id:") then
				self:LuaFnDeleteMonster(objId)
				del_num = del_num + 1
			end
		end
		backinfo = "删除怪物:"..del_num
		loginfo = backinfo
	elseif selectindex == 16 then
		if index1 < 0 then
			self:notify_tips( selfId,"参数1异常。" )
			return
		end
		local posx,posz = self:GetWorldPos(selfId)
		local monsterid = self:LuaFnCreateMonster(index1,posx,posz,4,0,-1)
		if monsterid and monsterid ~= -1 then
			if index2 and index2 > 0 then
				self:LuaFnSetLifeTimeAttrRefix_MaxHP(monsterid,index2)
				self:RestoreHp(monsterid)
			end
			if index3 and index3 > 0 then
				self:SetCharacterDieTime(monsterid,index3 * 1000)
			end
			self:SetUnitReputationID(monsterid,monsterid,29)
		end
		backinfo = "创建BOSS:"..index1
		loginfo = backinfo
	elseif selectindex == 17 then
		local guids = {}
		if index1 > 0 then
			table.insert(guids,index1)
		elseif index2 > 0 then
			table.insert(guids,index2)
		elseif index3 > 0 then
			table.insert(guids,index3)
		end
		if #guids > 0 then
			for _,ids in ipairs(guids) do
				local save_lv = skynet.call(".gamed", "lua", "reset_save_lv", ids)
				local msg = string.format("修正guid:%d的数据版本号为%s",ids,tostring(save_lv))
				self:notify_tips(selfId,msg)
			end
			backinfo = "修正角色版本号:"..#guids.."个"
			loginfo = backinfo
		end
	end
	local myname = self:GetName(selfId)
	self:SetGmToolLog(selfId,selectname,myname,loginfo)
	if backinfo ~= "" then
		self:SetTip(selfId,backinfo)
	end
end

return GmTool_Self