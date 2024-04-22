Ogolnie dzialanie tego co tutaj robie jest proste...

robiąc funkcje w tabeli, w sposob poniższy:
```lua
local tabela = {}

function tabela:function()
print(self)
end
```

i używając jej w sposob

```lua
tabela:function()
```

jesteśmy w stanie uzywac self, a self jest odwołaniem do obecnej tabeli, oczywiście mozemy wywolac funkcje w sposób:

```lua
tabela.funkcja()
```
ale musimy dac w parametrach wtedy nasza tabele.
