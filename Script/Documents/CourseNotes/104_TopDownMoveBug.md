
`UAIBlueprintHelperLibrary::SimpleMoveToLocation()` is an AI function. It's in the AIBlueprintHelperLibrary.
And AI MoveTo functions are not designed to be called from a client.
They're meant to be called on the server for AI Characters.

So if you have an AI character controlled by the server, you can use `SimpleMoveToLocation()` to move it to a location.
And if that AI character has its movement replicated, it'll replicate down to all clients, no problem.

But for a human controlled character, this is not going to work. It works locally, but there's no multiplayer replication built in.

It's not like calling `AddMovementInput` on a movement component. This has all sorts of lag compensation built in.
It has prediction, we can call it client side and we'll see our character move immediately and the server will receive that information through the movement component.

`SimpleMoveToLocation` have some interesting pathfinding capabilities. That's because there's a Nav Mesh bounds volume.
If we press P, we can see it that's required for any pathfinding to work.


# Lecture Presentation
## Click To Move
### Top Down Template
- Uses `SimpleMoveToLocation` if it was a short press
	- Does not work in multiplayer (Only works to AI controlled characters on server)
- Uses `AddMovementInput` if input is held down
	- Works in multiplayer
	- Requires constant input (movement direction)

### Our GAS Project
- We must use `AddMovementInput`
- Need a direction each frame
- Use Spline to smooth out the movement
