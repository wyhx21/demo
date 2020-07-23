package ÊÔÑé;

public class Record {
	public static int numTankMe=Constant.NUM_TM;
	public static int numTankEnemy=Constant.SUM_TE;
	public static int sumEnemy=0;
	public static void lessMy(){
		numTankMe--;
	}
	public static void lessEnemy(){
		numTankEnemy--;
	}
	public static void addEnemy(){
		sumEnemy++;
	}
}
