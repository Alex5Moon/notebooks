### 索引
>
- IS NULL 与 IS NOT NULL，不能用null做索引
- 带通配符(%)的like语句，避免通配符(%)在搜寻词首出现
- Order by语句的非索引项降低语句
- WHERE子句中的连接顺序，最大数据的放在末尾
- SELECT子句中避免使用 ‘ * ‘
- 用TRUNCATE替代DELETE
- 用EXISTS替代IN、用NOT EXISTS替代NOT IN
- 避免在索引列上使用NOT 通常
- 避免在索引列上使用计算
- 用>=替代>
- 用UNION替换OR (适用于索引列)
- 避免改变索引列的类型
>
### sql的四种联接
>
- 内联接: A INNER JOIN B on A.key = B.key      交集
- 外联接：A OUTER JOIN B on A.key = B.key      并集
- 左联接：A LEFT  JOIN B on A.key = B.key      A全部，B中不存在的为null
- 右联接：A RIGHT JOIN B on A.key = B.key      B全部，A中不存在的为null
- 交叉联接：笛卡尔积
