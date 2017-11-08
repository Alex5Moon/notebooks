package v1ch14.synch;

/**14-8
 * A runnable that transfers money from an account to other accounts in a bank.
 * @author Administrator
 *
 */
public class TransferRunnable implements Runnable
{
	private Bank bank;
	private int fromAccount;
	private double maxAmount;
	private int DELAY = 10;
	
	public TransferRunnable(Bank b, int from, double max)
	{
		bank = b;
		fromAccount = from;
		maxAmount = max;
	}

	@Override
	public void run() 
	{
		try
		{
			while(true)
			{
				int toAccount = (int)(bank.size()*Math.random());
				double amount = maxAmount*Math.random();
				bank.transfer(fromAccount, toAccount, amount);
				Thread.sleep((int)(DELAY*Math.random()));
			}
		}
		catch(InterruptedException e)
		{
			
		}
		
	}
}
