# tqdm主要有三个地方被使用
## 1. 包装迭代器
1. **使用`tqdm(iterable)`**
```python
from tqdm import tqdm
from time import sleep

text = ""
for char in tqdm(["a", "b", "c", "d"]):
    sleep(0.25)
    text = text + char
```
2. **使用`trange(N)`进行可视化，`trange(N)`是`tqdm(range(N))`的简写**
```python
from tqdm import trange

for i in trange(100):
    sleep(0.01)
```
3. 实例化`tqdm()`
```python
pbar = tqdm(["a", "b", "c", "d"])
for char in pbar:
    sleep(0.25)
    pbar.set_description("Processing %s" % char)
```

## 2. 手动控制

