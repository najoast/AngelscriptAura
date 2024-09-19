
### 三个职业
1. **战士 (Warrior)**
2. **弓箭手 (Archer)**
3. **法师 (Mage)**

### 属性分类
- **一级属性**（Primary Attributes）
  - 力量（Strength）
  - 敏捷（Dexterity）
  - 智力（Intelligence）
  - 体质（Vitality）

- **二级属性**（Secondary Attributes）
  - 生命值（HP）
  - 法力值（MP）
  - 生命回复（Health Regen）
  - 法力回复（Mana Regen）
  - 物理攻击力（Attack Power）
  - 魔法攻击力（Magic Power）
  - 防御力（Defense）
  - 命中率（Accuracy）
  - 闪避率（Evasion）
  - 暴击率（Critical Chance）
  - 暴击伤害（Critical Damage）
  - 抗魔力（Magic Resistance）

- **三级属性**（Tertiary Attributes）
  - 最小攻击力（Min Attack Power） = Attack Power * 0.9
  - 最大攻击力（Max Attack Power） = Attack Power * 1.1

### 二级属性计算公式

这里是各职业通过一级属性计算二级属性 Health Regen（生命回复）和 Mana Regen（法力回复）的公式。

#### 战士（Warrior）
- HP = Vitality * 20
- MP = Intelligence * 5
- Health Regen = Vitality * 0.5
- Mana Regen = Intelligence * 0.1
- Attack Power = Strength * 2 + Dexterity * 0.5
- Magic Power = Intelligence * 1.5
- Defense = Strength * 1.5 + Vitality * 0.5
- Accuracy = 0.5 + (Dexterity / 200)
- Evasion = 0.2 + (Dexterity / 200)
- Critical Chance = 0.05 + (Dexterity / 400) * 0.25
- Critical Damage = 120% + (Min(Dexterity,100) / 100) * 80%
- Magic Resistance = Intelligence * 0.5

#### 弓箭手（Archer）
- HP = Vitality * 15
- MP = Intelligence * 10
- Health Regen = Vitality * 0.3
- Mana Regen = Intelligence * 0.2
- Attack Power = Dexterity * 2 + Strength * 0.5
- Magic Power = Intelligence * 2
- Defense = Strength * 0.5 + Vitality * 1
- Accuracy = 0.6 + (Dexterity / 150)
- Evasion = 0.3 + (Dexterity / 150)
- Critical Chance = 0.05 + (Dexterity / 300) * 0.25
- Critical Damage = 120% + (Min(Dexterity,200) / 200) * 80%
- Magic Resistance = Intelligence * 1

#### 法师（Mage）
- HP = Vitality * 10
- MP = Intelligence * 20
- Health Regen = Vitality * 0.2
- Mana Regen = Intelligence * 0.5
- Attack Power = Intelligence * 2 + Dexterity * 0.5
- Magic Power = Intelligence * 3
- Defense = Strength * 0.5 + Vitality * 0.5
- Accuracy = 0.4 + (Dexterity / 250)
- Evasion = 0.1 + (Dexterity / 250)
- Critical Chance = 0.05 + (Dexterity / 500) * 0.25
- Critical Damage = 120% + (Min(Dexterity,100) / 100) * 80%
- Magic Resistance = Intelligence * 1.5

### 伤害计算公式
1. 计算攻击力
	- 如果是物理攻击，`Power = Random(Min Attack Power, Max Attack Power)`
	- 如果是魔法攻击，`Power = Random(Min Magic Power, Max Magic Power)`
2. 计算是否命中
	- `bIsHit = Random(0, 1) < Clamp((AttackerAccuracy - VictimEvasion), 0.05, 0.95)`
3. 计算是否暴击
	- `bIsCritical = Random(0, 1) < Critical Chance`
4. 计算伤害
	- 如果是物理攻击 `Damage = (Power - Defense) * (bIsCritial ? Critical Damage : 1)`
	- 如果是魔法攻击 `Damage = (Power - Magic Resistance) * (bIsCritial ? Critical Damage : 1)`

### 各职业初始一级属性

#### 战士（Warrior）
- 力量（Strength）：10
- 敏捷（Dexterity）：5
- 智力（Intelligence）：3
- 体质（Vitality）：7

#### 弓箭手（Archer）
- 力量（Strength）：5
- 敏捷（Dexterity）：10
- 智力（Intelligence）：4
- 体质（Vitality）：6

#### 法师（Mage）
- 力量（Strength）：3
- 敏捷（Dexterity）：4
- 智力（Intelligence）：10
- 体质（Vitality）：5

### 怪物设计及初始一级属性

1. **骷髅战士 (Skeleton Warrior)**
   - 力量（Strength）：5
   - 敏捷（Dexterity）：3
   - 智力（Intelligence）：1
   - 体质（Vitality）：4

2. **僵尸 (Zombie)**
   - 力量（Strength）：6
   - 敏捷（Dexterity）：2
   - 智力（Intelligence）：1
   - 体质（Vitality）：6

3. **兽人战士 (Orc Warrior)**
   - 力量（Strength）：8
   - 敏捷（Dexterity）：4
   - 智力（Intelligence）：2
   - 体质（Vitality）：7

4. **狼 (Wolf)**
   - 力量（Strength）：5
   - 敏捷（Dexterity）：7
   - 智力（Intelligence）：1
   - 体质（Vitality）：4

5. **哥布林 (Goblin)**
   - 力量（Strength）：3
   - 敏捷（Dexterity）：5
   - 智力（Intelligence）：2
   - 体质（Vitality）：3

6. **巨魔 (Troll)**
   - 力量（Strength）：10
   - 敏捷（Dexterity）：2
   - 智力（Intelligence）：1
   - 体质（Vitality）：10

7. **吸血蝙蝠 (Vampire Bat)**
   - 力量（Strength）：3
   - 敏捷（Dexterity）：8
   - 智力（Intelligence）：2
   - 体质（Vitality）：3

8. **火元素 (Fire Elemental)**
   - 力量（Strength）：2
   - 敏捷（Dexterity）：3
   - 智力（Intelligence）：8
   - 体质（Vitality）：4

9. **冰巨人 (Ice Giant)**
   - 力量（Strength）：9
   - 敏捷（Dexterity）：3
   - 智力（Intelligence）：2
   - 体质（Vitality）：8

10. **恶魔 (Demon)**
    - 力量（Strength）：10
    - 敏捷（Dexterity）：5
    - 智力（Intelligence）：5
    - 体质（Vitality）：10

