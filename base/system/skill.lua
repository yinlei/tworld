-------------------------------------------------------------------------------
-- skill.lua
-------------------------------------------------------------------------------

local SkillData = require "data.skill"

--- 升级技能的错误号
local result = {
    SUCCESS = 0,
    NEXT_SKILL_NOT_EXIST = 1,
    NEXT_SKILL_ERROR = 2,
    NO_ENOUGH_MONEY = 3,
    CURRENT_SKILL_NOT_LEARNED = 4,
    NEXT_SKILL_HAS_LEARNED = 5,
    CURRENT_SKILL_NOT_EXIST = 6
}

local SkillSystem = {}

--- 配置数据
function SkillSystem.get_data(id)
    return SkillData[id]
end

--- 是否存在技能
function SkillSystem.has(avatar, id)
    return avatar.skills[id] == 1
end

--- 学习技能
function SkillSystem.learn(avatar, skills)
    for _, id in ipairs(skills) do
        avatar.cell.learn(id)
    end
end

--- 取消技能
function SkillSystem.unlearn(avatar, skills)
    for _, id in ipairs(skills) do
        avatar.cell.unlearn(id)
    end
end

--- 获取关联技能
function SkillSystem.get_related_skills(avatar, id)
    local skills = {}

    local skill_data = SkillSystem:get_data(id)
    for k, v in pairs(SkillData) do
        if v.pos and skill_data.pos and v.level and skill_data.level and v.id ~= skill_data.id and
        v.vocation == skill_data.vocation and v.pos == skill_data.pos and v.level == skill_data.level then
            table.insert(skills, k)
        end
    end

    return skills
end

local function _upgrade(avatar, id, current_skills, next_skills)
    local skill_data = SkillData[id]

    local need_money = skill_data.money or 0

    if avatar.gold < need_money then
        return result.NO_ENOUGH_MONEY
    end

    avatar:add_gold(-need_money, "skill up")

    SkillSystem.unlearn(current_skills)
    SkillSystem.learn(next_skills)
end

---
local function do_learn(avatar, next_id)
    local skill_data = SkillData[next_id]
    if not skill_data then
        return result.NEXT_SKILL_NOT_EXIST
    end

    if skill_data.level ~= 1 then
        return result.NEXT_SKILL_ERROR
    end

    local next_skills = SkillSystem.get_related_skills(avatar, next_id)

    for _, id in ipairs(next_skills) do
        if SkillSystem.has(id) then
            return result.NEXT_SKILL_HAS_LEARNED
        end
    end

    return _upgrade(avatar, id, {}, next_skills)
end


local function do_upgrade(avatar, id, next_id)
    if not SkillData[id] then
        return result.CURRENT_SKILL_NOT_EXIST
    end

    if not SkillData[next_id] then
        return result.NEXT_SKILL_NOT_EXIST
    end

    local current_skills = SkillSystem.get_related_skills(avatar, id)

    local next_skills = SkillSystem.get_related_skills(avatar, next_id)


    for _, id in ipairs(current_skills) do
        if not SkillSystem.has(id) then
            return result.CURRENT_SKILL_NOT_LEARNED
        end
    end

    for _, id in ipairs(next_skills) do
        if SkillSystem.has(id) then
            return result.NEXT_SKILL_HAS_LEARNED
        end
    end

    return _upgrade(avatar, next_id, current_skills, next_skills)
end

--- 技能升级
function SkillSystem.upgrade(avatar, id, next_id)
    local ret

    if id == 0 and next_id > 0  then
        ret = do_learn(avatar, next_id)
    else
        ret = do_upgrade(avatar, id, next_id)
    end

    return ret
end

