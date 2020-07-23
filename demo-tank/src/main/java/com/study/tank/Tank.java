package com.study.tank;

import com.study.tank.abst.Obstracle;
import com.study.tank.inte.HaveBorder;

import java.awt.*;
import java.util.concurrent.CopyOnWriteArraySet;

public class Tank extends Element{
	int x=this.getX();
	int y=this.getY();
	private int code=Constant.CODE_U;
	private int speed=10;
	private int blood=1;
	private int type=Constant.TYPE_MY;
	public CopyOnWriteArraySet<Element> list=new CopyOnWriteArraySet<Element>();
	public Tank() {
		super();
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public Tank(int x, int y) {
		super(x, y);
	}
	
	public Tank(int x, int y,int n) {
		super(x, y);
		if(n==0) this.setType(Constant.TYPE_MY);
		if(n==1) this.setType(Constant.TYPE_EN1);
	}
	
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public int getSpeed() {
		return speed;
	}
	public void setSpeed(int speed) {
		this.speed = speed;
	}
	public int getBlood() {
		return blood;
	}
	public void setBlood(int blood) {
		this.blood = blood;
	}
	public void addList(){
		list.clear();
		for (Element e : Jpanel_1.list) {
			if(e instanceof HaveBorder) list.add(e);
		}
	}
	public void move(int code){	}
	
	protected Bullet shot_1(){
		int x_bullet=x-4;
		int y_bullet=y-4;
		switch (code) {
		case Constant.CODE_U:
			x_bullet+=Constant.SIZE_OBS/2;			
			break;
		case Constant.CODE_D:
			x_bullet+=Constant.SIZE_OBS/2;
			y_bullet+=Constant.SIZE_OBS;
			break;
		case Constant.CODE_L:
			y_bullet+=Constant.SIZE_OBS/2;
			break;
		case Constant.CODE_R:
			x_bullet+=Constant.SIZE_OBS;
			y_bullet+=Constant.SIZE_OBS/2;
			break;
		}
		return new Bullet(x_bullet,y_bullet,code);
	}
	
	public void draw(Graphics g){//̹�˳ߴ�Ϊ80*80
		switch (type) {
		case Constant.TYPE_MY:
			g.setColor(Color.YELLOW);
			break;
		case Constant.TYPE_EN1:
			g.setColor(Color.green);
			break;
		}
		switch (code) {
		case Constant.CODE_U:
			g.fill3DRect(x+10, y+10, 15, 70, false);
			g.fill3DRect(x+55, y+10, 15, 70, false);
			g.fill3DRect(x+25, y+20, 30, 50, false);
			g.fill3DRect(x+38, y, 4, 45, true);
			g.fillOval(x+28, y+33, 24, 24);
			break;
		case Constant.CODE_D:
			g.fill3DRect(x+10, y, 15, 70, false);
			g.fill3DRect(x+55, y, 15, 70, false);
			g.fill3DRect(x+25, y+10, 30, 50, false);
			g.fill3DRect(x+38, y+35, 4, 45, true);
			g.fillOval(x+28, y+23, 24, 24);
			break;
		case Constant.CODE_L:
			g.fill3DRect(x+10, y+10, 70, 15, false);
			g.fill3DRect(x+10, y+55, 70, 15, false);
			g.fill3DRect(x+20, y+25, 50, 30, false);
			g.fill3DRect(x, y+38, 45, 4, true);
			g.fillOval(x+33, y+28, 24, 24);
			break;
		case Constant.CODE_R:
			g.fill3DRect(x, y+10, 70, 15, false);
			g.fill3DRect(x, y+55, 70, 15, false);
			g.fill3DRect(x+10, y+25, 50, 30, false);
			g.fill3DRect(x+35, y+38, 45, 4, true);
			g.fillOval(x+23, y+28, 24, 24);
			break;
		}
	}
	public boolean OverStep(){
		boolean b=false;
		if(x<0) {
			x=0;
			b=true;
		}
		if(y<0) {
			y=0;
			b=true;
		}
		if(x>Constant.WIDTH_PANEL-Constant.SIZE_OBS){
			x=Constant.WIDTH_PANEL-Constant.SIZE_OBS;
			b=true;
		}
		if(y>Constant.HEIGHT_PANEL-Constant.SIZE_OBS){
			y=Constant.HEIGHT_PANEL-Constant.SIZE_OBS;
			b=true;
		}
		return b;
	}
//	��ײ����
	public boolean amend(){
		this.addList();
		boolean b=false;
		for (Element e : list) {
			if(e instanceof Obstracle){
				b=Utils.isCrash(x, y, Constant.SIZE_OBS, Constant.SIZE_OBS, 
						e.getX(), e.getY(), Constant.SIZE_OBS/2, Constant.SIZE_OBS/2);
				if(b){
					switch (code) {
					case Constant.CODE_U:
						y=e.getY()+Constant.SIZE_OBS/2;
						break;
					case Constant.CODE_D:
						y=e.getY()-Constant.SIZE_OBS;
						break;
					case Constant.CODE_L:
						x=e.getX()+Constant.SIZE_OBS/2;
						break;
					case Constant.CODE_R:
						x=e.getX()-Constant.SIZE_OBS;
						break;
					}
				}
			}
		}
		this.OverStep();
		return b || this.OverStep();
	}
	
}
