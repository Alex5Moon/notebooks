### HashMap
>
#### 底层
- 实现了Map.Entry\<K,V> 的一个 Node\<K,V\> 数组。 Node 结点的四种状态，null，next 为空，next 不为空，TreeNode。
```
   transient Node<K,V>[] table;
   
   // Basic hash bin node, used for most entries.
   static class Node<K,V> implements Map.Entry<K,V> {
        final int hash;
        final K key;
        V value;
        Node<K,V> next;

        Node(int hash, K key, V value, Node<K,V> next) {}

        public final K getKey()        { return key; }
        public final V getValue()      { return value; }
        public final String toString() { return key + "=" + value; }

        public final int hashCode() {return Objects.hashCode(key) ^ Objects.hashCode(value);}

        public final V setValue(V newValue) {
            V oldValue = value;
            value = newValue;
            return oldValue;
        }

        public final boolean equals(Object o) {
            if (o == this)
                return true;
            if (o instanceof Map.Entry) {
                Map.Entry<?,?> e = (Map.Entry<?,?>)o;
                if (Objects.equals(key, e.getKey()) &&
                    Objects.equals(value, e.getValue()))
                    return true;
            }
            return false;
        }
    }
```
>
#### 常量
>
```
static final int DEFAULT_INITIAL_CAPACITY = 1 << 4;  // 默认初始容量   16
static final int MAXIMUM_CAPACITY = 1 << 30;         // 最大容量      2的30次方
static final float DEFAULT_LOAD_FACTOR = 0.75f;      // 默认负载因子   0.75
static final int TREEIFY_THRESHOLD = 8;              // 一个桶中的元素个数超过 TREEIFY_THRESHOLD，就使用红黑树来替换链表
static final int UNTREEIFY_THRESHOLD = 6;            // 当扩容时，桶中元素个数小于这个值，就会把树形的桶元素 还原（切分）为链表结构
static final int MIN_TREEIFY_CAPACITY = 64;          // 如果当前哈希表为空，或者哈希表中元素的个数小于 进行树形化的阈值(默认为 64)，就去新建/扩容
```
>
#### 哈希再哈希
>
```
    static final int hash(Object key) {
        int h;
        return (key == null) ? 0 : (h = key.hashCode()) ^ (h >>> 16);
    }
```
- 为什么这里需要将高位数据移位到低位进行异或运算呢？
- 这是因为有些数据计算出的哈希值差异主要在高位，而 HashMap 里的哈希寻址是忽略容量以上的高位的，那么这种处理就可以有效避免类似情况下的哈希碰撞。
>
#### 构造器
>
```
  public HashMap(int initialCapacity, float loadFactor) {}        // 初始容量  initialCapacity 、负载因子  loadFactor
  public HashMap(int initialCapacity){}                           // 初始容量  initialCapacity 、负载因子  0.75f
  public HashMap(){}                                              // 初始容量  、负载因子 0.75f 
  public HashMap(Map<? extends K, ? extends V> m){}               // 初始容量、负载因子 0.75f
```
- 从非拷贝构造函数的实现来看，这个数组似乎并没有在最初就初始化好，仅仅设置了一些初始值
- HashMap 也许是按照 lazy-load 原则，在首次使用时被初始化（拷贝构造函数除外，这里仅介绍最通用的场景）
- 容量和负载系数决定了可用的桶的数量，空桶太多会浪费空间，如果使用的太满则会严重影响操作的性能。
- 极端情况下，假设只有一个桶，那么它就退化成了链表，完全不能提供所谓常数时间存的性能。
>
#### put方法
>
- key，value在内部是以node的形式存放的。
- 如果hash表是空的，先进行扩容。
- 将 tab[i = (n - 1) & hash] 赋值给结点 p ，如果 p 是空的，那么这个键对值放在这个地方，存入newNode 。i = (n - 1) & hash  这是具体键值对在哈希表中的位置。
- 否则，代表改位置已经存放结点。比较 p 结点的hash值，key值 是否与要存放的值相等，如果相等，将 结点p 赋值给结点 e，并将结点 e 的value 替换为要存储的value。
- 如果hash值相同，key不同，但是 p 的类型是树结点 TreeNode，则调用 TreeNode.putTreeVale插入。
- 其他，采用链表插入，尾插入，当前结点的next为空，直接插入。插入完成后，如果该链表的结点数超过8，则树化treebin();
- 最后判断，如果 负载因子 * 容量 > 元素数量，则进行扩容。resize操作。
>
```
    public V put(K key, V value) {
        return putVal(hash(key), key, value, false, true);
    }

    final V putVal(int hash, K key, V value, boolean onlyIfAbsent,
                   boolean evict) {
        Node<K,V>[] tab; Node<K,V> p; int n, i;
        if ((tab = table) == null || (n = tab.length) == 0)
            n = (tab = resize()).length;
        if ((p = tab[i = (n - 1) & hash]) == null)
            tab[i] = newNode(hash, key, value, null);
        else {
            Node<K,V> e; K k;
            if (p.hash == hash &&
                ((k = p.key) == key || (key != null && key.equals(k))))
                e = p;
            else if (p instanceof TreeNode)
                e = ((TreeNode<K,V>)p).putTreeVal(this, tab, hash, key, value);
            else {
                for (int binCount = 0; ; ++binCount) {
                    if ((e = p.next) == null) {
                        p.next = newNode(hash, key, value, null);
                        if (binCount >= TREEIFY_THRESHOLD - 1) // -1 for 1st
                            treeifyBin(tab, hash);
                        break;
                    }
                    if (e.hash == hash &&
                        ((k = e.key) == key || (key != null && key.equals(k))))
                        break;
                    p = e;
                }
            }
            if (e != null) { // existing mapping for key
                V oldValue = e.value;
                if (!onlyIfAbsent || oldValue == null)
                    e.value = value;
                afterNodeAccess(e);
                return oldValue;
            }
        }
        ++modCount;
        if (++size > threshold)
            resize();
        afterNodeInsertion(evict);
        return null;
    }
```
>
#### get方法
>
- 关键是找到 Node，返回node的value。
- 计算hash值，找到桶的位置；比较key，key不为null且equals相等，则返回这个node结点的值；否则，这个node结点递归调用 getNode
>
```
    public V get(Object key) {
        Node<K,V> e;
        return (e = getNode(hash(key), key)) == null ? null : e.value;
    }

    final Node<K,V> getNode(int hash, Object key) {
        Node<K,V>[] tab; Node<K,V> first, e; int n; K k;
        if ((tab = table) != null && (n = tab.length) > 0 &&
            (first = tab[(n - 1) & hash]) != null) {
            if (first.hash == hash && // always check first node
                ((k = first.key) == key || (key != null && key.equals(k))))
                return first;
            if ((e = first.next) != null) {
                if (first instanceof TreeNode)
                    return ((TreeNode<K,V>)first).getTreeNode(hash, key);
                do {
                    if (e.hash == hash &&
                        ((k = e.key) == key || (key != null && key.equals(k))))
                        return e;
                } while ((e = e.next) != null);
            }
        }
        return null;
    }
```
>
#### resize扩容方法
>
- 1 判断旧表的容量，如果大于0：如果大于最大容量，那么门阀值设置为 Integer.MAX_VALUE；并返回旧表。
-   如果容量增大两倍小于最大容量并且，旧的容量大于等于默认初始值，将 旧的容量扩大一倍，同时旧的门阀值也扩大一倍。
- 2 如果旧容量不大于0，且旧门阀值大于0，那么新的容量等于旧门阀值。
- 3 否则，新的容量等于默认容量，新的门阀值等于负载因子\*默认容量。
>
- 在往下，新容量与新门阀值产生后，开始将旧表中的数据放入新表中。
- 循环出去旧表中每个桶上的结点，将旧结点复制给临时的 node结点 ，如果不为空，则将旧的结点置为空。 
- 如果新结点的next为空，则直接将新结点放入新表中，放入的索引位置为 e.hash & (newCap - 1) ，将hash值与新结点的容量-1做与运算。
- 如果是树结点，则调用树结点的处理方法。
- 如果结点是链表，再采用一个循环，把链表上的所有结点重新hash
>
```
    final Node<K,V>[] resize() {
        Node<K,V>[] oldTab = table;
        int oldCap = (oldTab == null) ? 0 : oldTab.length;
        int oldThr = threshold;
        int newCap, newThr = 0;
        if (oldCap > 0) {
            if (oldCap >= MAXIMUM_CAPACITY) {
                threshold = Integer.MAX_VALUE;
                return oldTab;
            }
            else if ((newCap = oldCap << 1) < MAXIMUM_CAPACITY &&
                     oldCap >= DEFAULT_INITIAL_CAPACITY)
                newThr = oldThr << 1; // double threshold
        }
        else if (oldThr > 0) // initial capacity was placed in threshold
            newCap = oldThr;
        else {               // zero initial threshold signifies using defaults
            newCap = DEFAULT_INITIAL_CAPACITY;
            newThr = (int)(DEFAULT_LOAD_FACTOR * DEFAULT_INITIAL_CAPACITY);
        }
        if (newThr == 0) {
            float ft = (float)newCap * loadFactor;
            newThr = (newCap < MAXIMUM_CAPACITY && ft < (float)MAXIMUM_CAPACITY ?
                      (int)ft : Integer.MAX_VALUE);
        }
        threshold = newThr;
        @SuppressWarnings({"rawtypes","unchecked"})
            Node<K,V>[] newTab = (Node<K,V>[])new Node[newCap];
        table = newTab;
        if (oldTab != null) {
            for (int j = 0; j < oldCap; ++j) {
                Node<K,V> e;
                if ((e = oldTab[j]) != null) {
                    oldTab[j] = null;
                    if (e.next == null)
                        newTab[e.hash & (newCap - 1)] = e;
                    else if (e instanceof TreeNode)
                        ((TreeNode<K,V>)e).split(this, newTab, j, oldCap);
                    else { // preserve order
                        Node<K,V> loHead = null, loTail = null;
                        Node<K,V> hiHead = null, hiTail = null;
                        Node<K,V> next;
                        do {
                            next = e.next;
                            if ((e.hash & oldCap) == 0) {
                                if (loTail == null)
                                    loHead = e;
                                else
                                    loTail.next = e;
                                loTail = e;
                            }
                            else {
                                if (hiTail == null)
                                    hiHead = e;
                                else
                                    hiTail.next = e;
                                hiTail = e;
                            }
                        } while ((e = next) != null);
                        if (loTail != null) {
                            loTail.next = null;
                            newTab[j] = loHead;
                        }
                        if (hiTail != null) {
                            hiTail.next = null;
                            newTab[j + oldCap] = hiHead;
                        }
                    }
                }
            }
        }
        return newTab;
    }
```
>
#### 链表重新hash
>
- 新建两对头尾高低结点。
- 通过循环将所有的结点都取出来，放到临时变量 Node e，将此结点的 hash 与 旧表容量做与运算。
- 如果等于0，存入低位链表，第一次，将低位头尾都指向 e，从第二次开始，将头结点的next指向e，并将e赋给尾结点。
- 否则，存入高位链表。第一次，将高位头尾都指向e，从第二次开始，将头结点的next指向e，并将e赋值给尾结点。
- 循环结束，所有旧表上的结点被分配到高低两个链表中。开始向新表散列。散列时，
- 低尾结点不为空，说明低链表有数据，将低尾的next指向null，新表的索引指向低头结点，索引=旧表容量。
- 高尾结点不为空，说明高链表有数据，将高尾的next指向null，新表的索引指向高头结点，索引=旧索引+旧表容量。
>
- 经过rehash之后，元素的位置要么是在原位置，要么是在原位置再移动2次幂的位置。
>
- JDK1.7中rehash的时候，旧链表迁移新链表的时候，如果在新表的数组索引位置相同，则链表元素会倒置，JDK1.8不会倒置。
>
#### hashmap死循环
>
- 1、多线程put操作后，get操作导致死循环。
- 2、多线程put非null元素后，get操作得到null值。
- 3、多线程put操作，导致元素丢失。
>
- **并发情况下的扩容** 扩容源码
```
 1 void transfer(Entry[] newTable) {
 2         Entry[] src = table;
 3         int newCapacity = newTable.length;
 4         for (int j = 0; j < src.length; j++) {
 5             Entry<K,V> e = src[j];
 6             if (e != null) {
 7                 src[j] = null;
 8                 do {
 9                     Entry<K,V> next = e.next;
10                     int i = indexFor(e.hash, newCapacity);
11                     e.next = newTable[i];
12                     newTable[i] = e;
13                     e = next;
14                 } while (e != null);
15             }
16         }
17     }
```
>
- jdk 1.7 出现死循环的原因是 rehash 之后相同位置的链表元素会倒置，可能出现线程1是 a.next = b，线程2倒置之后是 b.next = a，
- 由于线程2扩容已经完成，线程1访问的就是新的位置数据，这样互相指向，出现环形链，倒置死循环。
>
- jdk 1.8 不会出现死循环，但是，多线程扩容的时候会有其他的问题。
>
- **多线程put操作，导致元素丢失**
- 1 线程1执行到第9行代码挂起，
```
null
7 ——> 5 ——> 3
```
- 2 线程2执行完成
```
null
5
null
3 ——> 7
```
- 3 接着执行线程1，首先放置 7 这个entry
```
null
null
null
7
```
- 4 再放置5这个entry
```
null
5
null
7
```
- 5 由于5的next为null，此时扩容动作结束，导致3这个Entry丢失。
>
- 因为同一个位置的链表扩容后会倒置
>
### ConcurrentHashMap
>



