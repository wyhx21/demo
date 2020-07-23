package 试验;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;

public class Test1 extends JFrame implements ActionListener{
	Jpanel_1 p1=null;
	Jpanel2 p2;
	
	JMenuBar cd;
	JMenu cdx1,cdx2,cdx3;
	JMenuItem zcd1,zcd2,zcd3,zcd4;
	
	public Test1(){
		zcd1=new JMenuItem("新  游  戏(N)");		zcd1.setMnemonic('n');
		zcd2=new JMenuItem("继续游戏(R)");		zcd2.setMnemonic('r');
		zcd3=new JMenuItem("存档退出(S)");		zcd3.setMnemonic('s');
		zcd4=new JMenuItem("退出游戏(Q)");		zcd4.setMnemonic('q');
		
		zcd1.setActionCommand("n");				zcd1.addActionListener(this);
		zcd2.setActionCommand("r");				zcd1.addActionListener(this);
		zcd3.setActionCommand("s");				zcd3.addActionListener(this);
		zcd4.setActionCommand("q");				zcd4.addActionListener(this);
		
		cdx1=new JMenu("游戏(F)");	cdx1.setMnemonic('f');
		cdx1.add(zcd1);		cdx1.add(zcd2);		cdx1.add(zcd3);		cdx1.add(zcd4);
		
		cdx2=new JMenu("编辑(E)");	cdx2.setMnemonic('e');
		cdx3=new JMenu("设置(D)");	cdx3.setMnemonic('d');
		
		cd=new JMenuBar();
		cd.add(cdx1);	cd.add(cdx2);	cd.add(cdx3);
		
		this.setJMenuBar(cd);
		
		p1=new Jpanel_1();
		this.add(p1);
		this.addKeyListener(p1);
		Thread t1=new Thread(p1);
		t1.start();
//		p2=new Jpanel2();
//		this.add(p2);
		
		this.setTitle("我的自定义窗口");
		this.setSize(Constant.WIDTH_PANEL+Constant.SIZE_OBS*2,Constant.HEIGHT_PANEL+Constant.SIZE_OBS*3);
		this.setLocation(200,50);
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setVisible(true);
	}

	public static void main(String[] args) {
		Test1 e=new Test1();
	}

	public void actionPerformed(ActionEvent e) {
		if(e.getActionCommand().equals("n")){
			this.remove(p1);
			p1=new Jpanel_1();
			this.add(p1);
			this.addKeyListener(p1);
			Thread t1=new Thread(p1);
			t1.start();
			this.setVisible(true);
		}
		if(e.getActionCommand().equals("r")){
			
		}
		if(e.getActionCommand().equals("s")){
			
		}
		if(e.getActionCommand().equals("q")){
			System.exit(-1);
		}
	}
}
