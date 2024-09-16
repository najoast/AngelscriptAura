My definition of Module:
- Small classes split according to the principle of high cohesion and low coupling
- Each class is responsible for doing one thing and doing it well
- Stateful
- Although there is state, the state should be as uncoupled as possible
- If it is a module for Character, try not to have specific restrictions on players or monsters, and make it universal

Most of the game logic should still be completed in their respective main classes, such as the blueprint base class. Here are some functions that need to be shared across classes and have high cohesion.

***

我对 Module 的定义：
- 按高内聚、低耦合原则拆分的小类
- 每个类负责做一件事，并把它做好
- 有状态
- 虽然有状态，但状态要尽可能没有耦合
- 如果是针对 Character 的 Module，尽可能不要有特定是玩家还是怪的限制，做到通用

大部分的游戏逻辑，应该还是在它们各自的主类里完成的，比如和种蓝图基类。这里放的是一些需要跨类共享，且高内聚的功能。
