### Unreal Engine Motion Warping

**Motion Warping** is a powerful feature in Unreal Engine that allows for dynamic adjustments to character animations (such as blending, stretching, and aligning) in response to gameplay conditions. This is particularly useful for improving the realism of character movements in various scenarios, such as navigating uneven terrain or interacting with objects.

#### Key Concepts

1. **Animation Adjustments**:
   - Motion Warping modifies existing animations to better fit the character's context.
   - This can involve altering the timing and position of animations based on gameplay needs.

2. **Warp Targets**:
   - Warp Targets are specific points that can be defined to guide the motion of the character.
   - These targets help align the character’s movements with the environment or other actors.

3. **Warping Methods**:
   - **Translation Warping**: Adjusts the position of the character's root bone.
   - **Rotation Warping**: Modifies the orientation of the character’s root bone to align with different orientations.

4. **Animation Montages**:
   - This feature can be combined with Animation Montages to create rich, interactive animations that respond to player actions.

5. **Gameplay Integration**:
   - Motion Warping can be triggered by specific gameplay events, allowing for responsive character animations in real-time.

#### Implementation Steps

1. **Setup Animation Blueprint**:
   - Create or open an Animation Blueprint for your character.
   - Add Motion Warping nodes to control the warping behavior.

2. **Define Warp Targets**:
   - Create and position Warp Targets in your level or character blueprint.
   - Reference these targets in your Animation Blueprint to guide the warping.

3. **Adjust Animation Logic**:
   - Utilize state machines or blend spaces to define when and how to apply Motion Warping.
   - Integrate Motion Warping into the character’s movement logic to ensure smooth transitions.

4. **Testing and Tweaking**:
   - Playtest the character movements to ensure that the warping feels natural.
   - Adjust the parameters of the Motion Warping nodes as needed to refine the animation quality.

#### Use Cases

- **Navigating Obstacles**: Characters can adjust their movements when encountering barriers or uneven surfaces.
- **Interacting with Objects**: Improve the animation of characters when picking up or interacting with objects.
- **Combat Animations**: Enhance attack or dodge movements to better align with enemy positions.

### Conclusion

Motion Warping in Unreal Engine provides developers with the tools to create more immersive and responsive character animations. By adjusting movements dynamically based on gameplay conditions, it enhances the overall experience for players.

***

Lecture steps:
1. Enable the `Motion Warping` Plugin.
2. Open the Animation Sequence which you want to use for Motion Warping.
	- In the Asset Details Panel, check the `EnableRootMotion` option.
	- If this is checked, then this is a root motion animation and can be used with motion warping.
3. Add a `UMotionWarpingComponent` to the Actor you want to use for Motion Warping.
4. Open the Animation Montage you want to use for Motion Warping.
5. Add a new Notify Track called `Motion Warping` (or any other name you prefer).
6. Right click on the `Motion Warping` track and select `Add Notify State`, then select `Motion Warping`.
7. Drag and change the timeline to match your preferred warping window.
8. Clieck the `MotionWarping` notify state, then change the settings in the Details Panel.
	- Expand `Root Motion Modifier` (Keep it's default `Skew Warp` option).
	- Set `Warp Target Name` to `FacingTarget`.
	- Uncheck `Warp Translation` (Because we don't want to warp our position, we only want to warp our rotation).
	- Keep the `Warp Rotation` option checked.
	- Change the `Rotation Type` to `Facing`. (This will make our animation rotate our root bone to face our target, which we've called `FacingTarget`)
9. Set the `FacingTarget` to the location of the target you want to warp to in the runtime.
	- This may happen in the `GameplayAbility`'s `ActivateAbility` function.
	- In Angelscript, you can use `MotionWarping.AddOrUpdateWarpTargetFromLocation(n"FacingTarget", TargetLocation);` to set the target location.