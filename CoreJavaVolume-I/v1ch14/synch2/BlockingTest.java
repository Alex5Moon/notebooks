package v1ch14.synch2;

/**
 * JConsole 是一个内置 Java 性能分析器，可以从命令行（直接输入jconsole）或在 GUI shell （jdk\bin下打开）中运行。
 * 它用于对JVM中内存，线程和类等的监控
 * @author Administrator
 *
 */

public class BlockingTest 
{
	public static final int NACCOUNTS = 10;
	public static final double INITIAL_BALANCE = 1000;
	
	public static void main(String[] args) 
	{
		Bank b = new Bank(NACCOUNTS,INITIAL_BALANCE);
		int i;
		for(i=0; i<NACCOUNTS; i++)
		{
			TransferRunnable r = new TransferRunnable(b, i, 2*INITIAL_BALANCE);
			Thread t = new Thread(r);
			t.start();
		}
	}
}
