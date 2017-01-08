-------------------------------------------------------------------------------
-- calculate.lua
-------------------------------------------------------------------------------

local SkillCalculate = {}

--- 获取的指定属性
function SkillCalculate.get_property(o, name)
    return o.battle_props[name]
end

--- 获取命中率
function SkillCalculate.get_hit_rate(attacker, defender)
    local hit_rate = SkillCalculate.get_property(attacker, 'hit_rate')
    local miss_rate = SkillCalculate.get_property(defender, 'miss_rate')

    return hit_rate - miss_rate
end

--- 获取暴击率
function SkillCalculate.get_crit_rate(attacker, defender)
    local crit_rate = SkillCalculate.get_property(attacker, 'crit_rate')
    local anti_crit_rate = SkillCalculate.get_property(defender, 'anti_crit_rate')

    return crit_rate - anti_crit_rate
end

--- 获取攻击
function SkillCalculate:get_attack(o)
    return SkillCalculate.get_property(o, 'attack')
end

--- 获取防御
function SkillCalculate:get_defense(o)
    return SkillCalculate.get_property(o, 'defense')
end


--- 获取伤害
function SkillCalculate.get_damage()
end



