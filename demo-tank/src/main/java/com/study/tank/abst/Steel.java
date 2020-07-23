package com.study.tank.abst;

import com.study.tank.Constant;
import com.study.tank.Element;
import com.study.tank.inte.BeattackAble;
import com.study.tank.inte.BeattackAble2;
import com.study.tank.inte.Fadeable;
import com.study.tank.inte.HaveBorder;

import java.awt.*;
import java.util.concurrent.CopyOnWriteArrayList;

public class Steel extends Obstracle implements HaveBorder, Fadeable, BeattackAble, BeattackAble2 {
	{
		this.setBlood(Constant.BLOOD_STEEL);
	}
	public Steel() {
		super();
	}
	public Steel(int x, int y) {
		super(x, y);
	}
	public void draw(Graphics g) {
		g.setColor(Color.WHITE);
		super.draw(g);
	}
//	��Ӹ�ǽ
	public void add(int x,int y,int num_width,int num_height,CopyOnWriteArrayList<Element>list){
		int m,n;
		for (int i = 0; i < num_width*2; i++) {
			for (int j = 0; j < num_height*2; j++) {
				m=(x*2+i)*this.getSize();
				n=(y*2+j)*this.getSize();
				list.add(new Steel(m, n));
			}
		}
	}
//	һ������ĸ�
	public void addFour(int x,int y,CopyOnWriteArrayList<Element>list){
		int a=this.getSize();
		list.add(new Steel(x*Constant.SIZE_OBS,y*Constant.SIZE_OBS));
		list.add(new Steel(x*Constant.SIZE_OBS+a,y*Constant.SIZE_OBS));
		list.add(new Steel(x*Constant.SIZE_OBS,y*Constant.SIZE_OBS+a));
		list.add(new Steel(x*Constant.SIZE_OBS+a,y*Constant.SIZE_OBS+a));
	}

	public void injur() {
		int i=this.getBlood()-1;
		this.setBlood(i);
	}

	public int fade() {
		return this.getBlood();
	}
}
