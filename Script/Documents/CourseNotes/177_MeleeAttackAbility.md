# Lecture content
1. Add a new GameplayTag: `Abilities.Attack`
2. Create a new GameplayAbility: `AGA_MeleeAttack` based on `AuraGameplayAbility`
3. Create a new GameplayAbility `GA_MeleeAttack` based on `AGA_MeleeAttack`
4. Assign the default Ability of each Class through SData_CharacterClass
5. Grant AGA_MeleeAttack to the Goblin_Spear
	- When Grant Ability, assign the character's current level to the Ability

