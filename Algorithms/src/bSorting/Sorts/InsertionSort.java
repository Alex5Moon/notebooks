package bSorting.Sorts;

import java.util.Arrays;
/**
 * 插入排序（Insertion-Sort）的算法描述是一种简单直观的排序算法。
 * 工作原理是通过构建有序序列，对于未排序数据，在已排序序列中从后向前扫描，找到相应位置并插入。
 * @author Administrator
 * 
 * 时间复杂度(平均)：n^2
 * 时间复杂度(最坏):n^2
 * 时间复杂度(最好):n
 * 空间复杂度：             1
 */
public class InsertionSort {
	
	public static void main(String[] args) {
		int[] arr = {1,4,7,2,9,6,10,25,22,11};
		insertionSort(arr);
		System.out.println(Arrays.toString(arr));
	}
	
	/**
	 * 一般来说，插入排序都采用in-place在数组上实现。具体算法描述如下：
	 * 1 从第一个元素开始，该元素可以认为已经被排序；
	 * 2 取出下一个元素，在已经排序的元素序列中从后向前扫描；
	 * 3 如果该元素（已排序）大于新元素，将该元素移到下一位置；
	 * 4 重复步骤3，直到找到已排序的元素小于或者等于新元素的位置；
	 * 5 将新元素插入到该位置后；
	 * 6 重复步骤2~5。
	 * @param arr
	 */
	public static void insertionSort(int[] arr){
		int length = arr.length;
		int preIndex,current;
		for(int i = 1; i < length; i++){
			preIndex = i - 1;
			current  = arr[i];
			while (preIndex >= 0 && arr[preIndex] > current){
				arr[preIndex + 1] = arr[preIndex];
				preIndex --;
			}
			arr[preIndex+1] = current;
		}
	}
}
