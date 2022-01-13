规律性时间间隔上记录的序列

read_csv(parse_dates)

基线水平+趋势+季节性+误差

加法时间序列 = 基线水平+趋势+季节性+误差
乘法时间序列 = 基线水平\*趋势\*季节性*误差

检验平稳性：单位根检验

去趋势化
去季节化
检验季节化
缺失值
自相关 偏相关
平滑处理

小波去噪：
对于非平稳信号，傅里叶变换会有问题，一段信号总体上包含哪些频率的成分，但是对各成分出现的时刻并无所知，可以使用短时傅里叶变换，给时域的信号加窗，但是加多大的窗是不好确定的，
海森堡不确定性-鱼和熊掌不可兼得

而小波直接把傅里叶变换的基给换了——将无限长的三角函数基换成了有限长的会衰减的小波基。这样不仅能够获取频率，还可以定位到时间了~
傅里叶变换的本质：不同频率的基函数与时域信号做相关性，相关性值高，那么信号就含有这个频率的成分高。（这句话怎么理解）
小波变换：同时有了 频域和时域 两项
小波变换为什么可行：正交小波分解具有时-频局部分解的能力，在进行信号处理时，小波分量表现的幅度较大，与噪声在高频部分的均匀变现正好形成明显的对比。经小波分解后，幅值比较大的小波系数绝大多数是有用信号，而幅值较小的系数一般都是噪声，即可以认为有用信号的小波变换系数要大于噪声的小波变换系数。阈值去噪法就是找到一个合适的阈值，保留大于阈值的小波系数，将小于阈值的小波系数做相应的处理，然后，根据处理后的小波系数还原出有用信号。


特征：
task
6：30
words []
reading
code
english
work

0401 
1031

11：30
7
morning
feeling
words 
leetcode
books 中午


特征工程
分类模板
特征工程（other）

牛逼代码 [agg(launch_date=('data', list))]
groupby('user_id').agg(launch_date=('date',list), launch_type=('launch_type', list)).reset_index()

concat()  上下
merge()  左右
append()

sorted(zip(l1, l2), lambda x: x[1])
dict.get(x, 0) # 给一个默认的值

.loc[mask]
df.notna()

df.explode(column_name)

playtime_list=("playtime", list) # 'count' / np.mean / lambda x: ";".join(map(str, x))

iterrows() : 将DataFrame迭代成（index ,series）
iteritems()： 将DataFrame迭代成（列名，series）
itertuples()： 将DataFrame迭代成元组 

dict.update() 如果有的话则被更新，没有的话被添加
空间压缩和类型变量的删除
list 的 target encode


dataframe.plot 更快些
fig, ax = subplots(nrows, ncols, figure)
pywt 这个包

np.transpose 转置

1. ------------------------------------------------------------ 2022 01 11 简单code
---------
拿到一个时间序列，首先对它进行平稳性和纯随机性的检验的预处理，
平稳性是某些时间序列具有的一种统计特征，我们可以用分布函数和密度函数来描述它。一个随机变量簇 $X$ 的联合概率分布是很难统计的。所以更简单，更实用的描述时间序列统计特征的方法是研究该序列的低阶矩。特别是均值，方差，自协方差和自相关系数。他们被成为特征统计量。

1. 均值

对于时间序列 $\lbrace X_t, t \in T \rbrace$ 来说,任意时刻的序列值 $X_t$ 都是一个随机变量，都有它自己的概率分布，记 $X_t$ 的分布函数 $F_t(x)$。只要满足$\int ^\infty_\infin x {\rm d}F_t(x) < \infin$

https://zhuanlan.zhihu.com/p/425664064
平稳性数据和非平稳性数据
平稳时间序列一般分为严平稳时间序列和宽
平稳时间序列。谓严平稳 (strictly stationary) 就是 种条件比较苛刻的平稳性定义 它认为只有序列所有的统计性质都不会随着时间的推移而发生变化时该序列才能被认为
平稳。宽平稳 (weak stationary) 是使用序列的特征统计量来定义的 种平稳性。它认
为序列的统计性质主要由它的低阶矩决定 所以只要保证序列低阶矩平稳( 阶) , 
就能保证序列的主要性质近似稳定。
宽平稳时间序列的统计性质。

补充：
平稳性数据的检验
1.时序图检验（图形分析方法）：所谓时序图就是平面二位坐标图，通常横轴表示时间，纵轴表示序列取值。根据平稳时间序列均值，方差为常数的性质，平稳序列的时序图应该显示出该序列始终在一个常数附件随机波动，而且波动的范围有界。如果一个时序图显示明显的趋势或周期性，那它通常不是平稳序列。
2. 可视化统计特征
绘制时间序列的自相关图和偏相关图。平稳序列会认为自相关性只与时间间隔有关，与时间无关。
现象：平稳序列通常具有短期相关性，平稳序列的自相关系数往往会迅速退化到0（滞后期越短/时间间隔 越短相关性越高，滞后性/时间间隔 为0时，相关性为1）；对于非平稳的序列，退化会发生的很慢，会存在先减后增或周期性波动给
2. 分段检验
划分时间窗口计算该窗口内序列均值方差差距。
3. 假设检验方法
1. 增广迪基·富勒检验（ADF Test）；
2. 科维亚特夫斯基-菲利普斯-施密特-辛-KPSS检验（趋势平稳性）；
3. 菲利普斯 佩龙检验（PP Test）。
非平稳性数据转换为平稳性数据

二、转为平稳性序列
1. 一阶差分


小波变换 是解决什么问题的，怎么解决的，不同的参数都有什么样子的影响

小波变换的代码

滑动平均的代码

去季节话，去趋势化，


Average smoothing is a relatively simple way to denoise time series data.

naive approach, 
这怎么部署
moving average, 
Holt linear,
二阶指数平滑 
exponential smoothing, 
1. 模型的前期准确
ARIMA, 
SARIMA
Auto Regressive Integrated Moving Average
and Prophet
DNN 
RF 
ES 
SARIMAX 
XGB 
LGBM 
ARIMA 
CNN 
NN 
CATboost 
RNN 
wavenet 
n-beats 
seq2seq 
fbprophet 
lstm