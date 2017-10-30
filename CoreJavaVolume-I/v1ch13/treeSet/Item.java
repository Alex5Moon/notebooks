package v1ch13.treeSet;

import java.util.Objects;

/**13-4
 * An item with a description and a part number.
 * @author Administrator
 *
 */
public class Item implements Comparable<Item> 
{
	private String description;
	private int partNumber;
	
	public Item(String aDescription, int aPartNumber)
	{
		this.description = aDescription;
		this.partNumber  = aPartNumber;
	}
	
	public String getDescription()
	{
		return this.description;
	}
	
	public String toString()
	{
		return "[description="+this.description+", partNumber="+this.partNumber+"]";
	}
	
	public boolean equals(Object otherObject)
	{
		if(this==otherObject) return true;
		if(otherObject==null) return false;
		if(this.getClass()!=otherObject.getClass()) return false;
		Item other = (Item)otherObject;
		return Objects.equals(this.description, other.description)&& this.partNumber==other.partNumber;
	}
	
	public int hashCode()
	{
		return Objects.hash(this.description,this.partNumber);
	}
	@Override
	public int compareTo(Item o) {
		// TODO Auto-generated method stub
		return Integer.compare(this.partNumber, o.partNumber);
	}

}
