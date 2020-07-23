package 试验;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;

import javax.swing.JPanel;

public class Jpanel2 extends JPanel{

	@Override
	protected void paintBorder(Graphics g) {
		// TODO Auto-generated method stub
		super.paintBorder(g);
//		g.fillRect(0,0,Constant.WIDTH_PANEL+Constant.SIZE_OBS*2,Constant.HEIGHT_PANEL+Constant.SIZE_OBS*2);
		Font font=new Font("华文行楷",Font.BOLD,100);
		g.setFont(font);
		g.drawString("欢迎来到我的坦克小游戏", 200, 300);
		g.drawString("制作：魏怡红", 400, 450);
	}
	
}
