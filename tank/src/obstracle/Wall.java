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

public class Wall extends Obstracle implements HaveBorder,BeattackAble,Fadeable,BeattackAble2{
	{
		this.setBlood(Constant.BLOOD_WALL);
	}
	public Wall() {
		super();
	}
	public Wall(int x, int y) {
		super(x, y);
	}
	public void draw(Graphics g) {
		g.setColor(Color.RED);
		super.draw(g);
	}
//	添加墙体
	public void add(int x,int y,int num_width,int num_height,CopyOnWriteArrayList<Element>list){
		int m,n;
		for (int i = 0; i < num_width*2; i++) {
			for (int j = 0; j < num_height*2; j++) {
				m=(x*2+i)*this.getSize();
				n=(y*2+j)*this.getSize();
				list.add(new Wall(m, n));
			}
		}
	}
//	一次添加四个
	public void addFour(int x,int y,CopyOnWriteArrayList<Element>list){
		int a=this.getSize();
		list.add(new Wall(x*Constant.SIZE_OBS,y*Constant.SIZE_OBS));
		list.add(new Wall(x*Constant.SIZE_OBS+a,y*Constant.SIZE_OBS));
		list.add(new Wall(x*Constant.SIZE_OBS,y*Constant.SIZE_OBS+a));
		list.add(new Wall(x*Constant.SIZE_OBS+a,y*Constant.SIZE_OBS+a));
	}

	@Override
	public int fade() {
		// TODO Auto-generated method stub
		return this.getBlood();
	}

	@Override
	public void injur() {
		// TODO Auto-generated method stub
		int b=this.getBlood()-1;
		this.setBlood(b);
	}
}
