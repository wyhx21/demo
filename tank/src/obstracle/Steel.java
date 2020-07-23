package obstracle;

import interfaces.BeattackAble;
import interfaces.BeattackAble2;
import interfaces.Fadeable;
import interfaces.HaveBorder;

import java.awt.Color;
import java.awt.Graphics;
import java.util.concurrent.CopyOnWriteArrayList;

import 试验.Constant;
import 试验.Element;

public class Steel extends Obstracle implements HaveBorder,Fadeable,BeattackAble,BeattackAble2{
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
//	添加钢墙
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
//	一次添加四个
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
