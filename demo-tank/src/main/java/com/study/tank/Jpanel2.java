package com.study.tank;


import javax.swing.*;
import java.awt.*;

public class Jpanel2 extends JPanel{

	@Override
	protected void paintBorder(Graphics g) {
		// TODO Auto-generated method stub
		super.paintBorder(g);
//		g.fillRect(0,0,Constant.WIDTH_PANEL+Constant.SIZE_OBS*2,Constant.HEIGHT_PANEL+Constant.SIZE_OBS*2);
		Font font=new Font("�����п�",Font.BOLD,100);
		g.setFont(font);
		g.drawString("��ӭ�����ҵ�̹��С��Ϸ", 200, 300);
		g.drawString("������κ����", 400, 450);
	}
	
}
