# UFUNCTION 的这些标记有什么区别：NetMulticast, Client, Server and/or BlueprintAuthorityOnly
在Unreal Engine（UE）中，`UFUNCTION`提供了一系列标记，用于定义如何在网络环境中调度和处理函数调用。这些标记常见的有`NetMulticast`、`Client`、`Server`和`BlueprintAuthorityOnly`。以下是这些标记的详细解释以及它们在不同场景中的使用方式：

### 1. NetMulticast

**描述**：
- 用于声明一个函数可以由服务器调用，并在所有客户端上执行。

**使用场景**：
- 当服务器需要通知所有客户端某个事件或状态变化，并且客户端都需要执行相同逻辑时使用。

**函数声明示例**：
```cpp
UFUNCTION(NetMulticast, Reliable)
void MyMulticastFunction();
```

**注意事项**：
- `NetMulticast`通常与`Reliable`或`Unreliable`关键字一起使用。`Reliable`确保调用最终会到达客户端，而`Unreliable`则不做这种保证以换取更好的性能。
- 只有在服务器端调用时，`NetMulticast`标记的函数才在所有客户端上执行。

### 2. Client

**描述**：
- 用于声明一个函数是由服务器端调用，并在特定的客户端上执行。

**使用场景**：
- 当服务器需要仅通知某一个特定客户端某个事件或状态变化时使用。

**函数声明示例**：
```cpp
UFUNCTION(Client, Reliable)
void MyClientFunction();
```

**注意事项**：
- 需要在服务器上调用，通常使用客户端的PlayerController或Client-specific对象。

### 3. Server

**描述**：
- 用于声明一个函数是由客户端调用，并在服务器上执行。

**使用场景**：
- 当客户端需要将某个事件或请求发送到服务器时使用。

**函数声明示例**：
```cpp
UFUNCTION(Server, Reliable, WithValidation)
void MyServerFunction();
```

**注意事项**：
- `WithValidation`是可选的，用于对服务器进行额外的安全性检查，确保调用是合法的。
- 客户端调用这些函数时，函数实际在服务器上执行。
- 需要在函数实现中添加验证代码，例如`bool MyServerFunction_Validate()`，用于验证该请求是否合法。

### 4. BlueprintAuthorityOnly

**描述**：
- 用于声明函数只能由具有授权的对象调用，通常是服务器或者拥有特定权限的客户端。

**使用场景**：
- 在Blueprint中，使某些函数只有在服务器或有权限的客户端上调用时有效。

**函数声明示例**：
```cpp
UFUNCTION(BlueprintAuthorityOnly, Category="MyCategory")
void MyAuthorityOnlyFunction();
```

**注意事项**：
- 主要用于在Blueprint中限制函数调用，确保只有服务器或具有特殊权限的客户端可以调用此函数。
- 可以避免无权限客户端做出不应有的操作。

### 示例总结

假设我们有一个游戏中所有客户端需要更新状态的场景，可以使用如下函数声明：

```cpp
UFUNCTION(NetMulticast, Reliable)
void UpdateAllClients();

UFUNCTION(Client, Reliable)
void NotifySpecificClient();

UFUNCTION(Server, Reliable, WithValidation)
void SendRequestToServer();

UFUNCTION(BlueprintAuthorityOnly)
void ExecuteAuthorityOnlyAction();
```

使用这些标记时，需要注意以下几点：

1. **性能与可靠性权衡**：
    - `Reliable` 函数确保到达，但会增加网络负载。
    - `Unreliable` 函数不保证到达，但可以在不需要严格同步的情况下提供更好的性能。

2. **权限与安全**：
    - 使用这些标记可以确保函数在适当的权限级别调用，避免潜在的安全威胁。
    - 特别注意`Server`标记的函数，需要实现验证以防止恶意客户端发送非法请求。

通过理解和正确使用这些标记，可以有效地管理网络调用，确保游戏逻辑在客户端和服务器之间正确同步。


> For more: https://dev.epicgames.com/documentation/en-us/unreal-engine/ufunctions-in-unreal-engine
