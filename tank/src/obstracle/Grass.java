package obstracle;

import java.awt.Color;
import java.awt.Graphics;
import java.util.concurrent.CopyOnWriteArrayList;

import 试验.Constant;
import 试验.Element;

public class Grass extends Obstracle{
	{
		this.setPaint(2);
	}
	public Grass() {
		super();
	}
	public Grass(int x, int y) {
		super(x, y);
	}
//	绘出障碍物
	public void draw(Graphics g){
		int size=this.getSize();
		int x=this.getX();
		int y=this.getY();
		g.setColor(Color.DARK_GRAY);
		g.fillRect(x, y, size, size);
		g.setColor(Color.GREEN);
		for (int i = 0; i < 21; i+=20) {
			for (int j = 0; j < 21; j+=20) {
				g.drawLine(x+10+i, y+15+j, x+10+i, y+5+j);
				g.drawLine(x+10+i, y+15+j, x+5+i, y+10+j);
				g.drawLine(x+10+i, y+15+j, x+15+i, y+10+j);
			}
		}
	}
//	添加草
	public void add(int x,int y,int num_width,int num_height,CopyOnWriteArrayList<Element>list){
		int m,n;
		for (int i = 0; i < num_width*2; i++) {
			for (int j = 0; j < num_height*2; j++) {
				m=(x*2+i)*this.getSize();
				n=(y*2+j)*this.getSize();
				list.add(new Grass(m, n));
			}
		}
	}
//	一次添加四个
	public void addFour(int x,int y,CopyOnWriteArrayList<Element>list){
		int a=this.getSize();
		list.add(new Grass(x*Constant.SIZE_OBS,y*Constant.SIZE_OBS));
		list.add(new Grass(x*Constant.SIZE_OBS+a,y*Constant.SIZE_OBS));
		list.add(new Grass(x*Constant.SIZE_OBS,y*Constant.SIZE_OBS+a));
		list.add(new Grass(x*Constant.SIZE_OBS+a,y*Constant.SIZE_OBS+a));
	}
}
