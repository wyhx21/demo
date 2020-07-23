package com.study.tank.abst;

import com.study.tank.Constant;
import com.study.tank.Element;
import com.study.tank.inte.HaveBorder;

import java.awt.Color;
import java.awt.Graphics;
import java.util.concurrent.CopyOnWriteArrayList;

public class Water extends Obstracle implements HaveBorder {
	public Water() {
		super();
	}

	public Water(int x, int y) {
		super(x, y);
	}

	public void draw(Graphics g) {
		int x=this.getX();
		int y=this.getY();
		int size=this.getSize();
		g.setColor(Color.cyan);
		g.fillRect(x, y, size, size);
		g.setColor(Color.lightGray);
		g.setColor(Color.BLUE);
		for (int i = 0; i < 21; i+=20) {
			for (int j = 0; j < 21; j+=20) {
				g.drawLine(x+i, y+5+j, x+10+i, y+15+j);
				g.drawLine(x+10+i, y+15+j, x+20+i, y+5+j);
			}
		}
	}

	// ���ǽ��
	public void add(int x, int y, int num_width, int num_height,
			CopyOnWriteArrayList<Element> list) {
		int m, n;
		for (int i = 0; i < num_width * 2; i++) {
			for (int j = 0; j < num_height * 2; j++) {
				m = (x * 2 + i) * this.getSize();
				n = (y * 2 + j) * this.getSize();
				list.add(new Water(m, n));
			}
		}
	}
//	һ������ĸ�
	public void addFour(int x,int y,CopyOnWriteArrayList<Element>list){
		int a=this.getSize();
		list.add(new Water(x* Constant.SIZE_OBS,y*Constant.SIZE_OBS));
		list.add(new Water(x*Constant.SIZE_OBS+a,y*Constant.SIZE_OBS));
		list.add(new Water(x*Constant.SIZE_OBS,y*Constant.SIZE_OBS+a));
		list.add(new Water(x*Constant.SIZE_OBS+a,y*Constant.SIZE_OBS+a));
	}
}
