package com.study.tank.abst;

import com.study.tank.Constant;
import com.study.tank.Element;

import java.awt.Color;
import java.awt.Graphics;

public class Obstracle extends Element {
	private int size= Constant.SIZE_OBS/2;
	
	public Obstracle() {
		super();
	}
	public Obstracle(int x, int y) {
		super(x, y);
	}
	
	public int getSize() {
		return size;
	}
//	����ϰ���
	public void draw(Graphics g){
		int x=this.getX();
		int y=this.getY();
		g.fillRect(x, y, size, size);
		g.setColor(Color.gray);
		g.fillRect(x, y, size, 2);
		g.fillRect(x, y+size-2, size, 2);
		g.fillRect(x, y+size/2-2, size, 4);
		g.fillRect(x, y, 2, size/2);
		g.fillRect(x+size-2, y, 2, size/2);
		g.fillRect(x+size/2-2, y+size/2, 4, size/2);
	}
}
