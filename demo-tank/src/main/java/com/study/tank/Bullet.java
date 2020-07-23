package com.study.tank;
import com.study.tank.inte.Fadeable;

import java.awt.Color;
import java.awt.Graphics;

public class Bullet extends Element implements Runnable, Fadeable {
	private int speed=15;
	private int code=Constant.CODE_U;
	int x=this.getX();
	int y=this.getY();
	public Bullet() {
		super();
	}

	public Bullet(int x, int y,int code) {
		super(x, y);
		this.code=code;
	}

	public int getSpeed() {
		return speed;
	}

	public void setSpeed(int speed) {
		this.speed = speed;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}
	
	public void draw(Graphics g) {
		this.overstep();
		g.setColor(Color.RED);
		g.fillRect(x, y, 8, 8);
	}
	public void run() {
		while(true){
			try {
				Thread.sleep(50);
			} catch (InterruptedException e) {}
			if(this.getBlood()<1)break;
			switch (code) {
			case Constant.CODE_U:
				y-=speed;
				break;
			case Constant.CODE_D:
				y+=speed;
				break;
			case Constant.CODE_L:
				x-=speed;
				break;
			case Constant.CODE_R:
				x+=speed;
				break;
			}
			this.setX(x);
			this.setY(y);
		}
	}

	public int fade() {
		return this.getBlood();
	}
	public void overstep(){
		if(this.getX()<0)this.setBlood(0);
		if(this.getY()<0)this.setBlood(0);
		if(this.getX()>Constant.WIDTH_PANEL)this.setBlood(0);
		if(this.getY()>Constant.HEIGHT_PANEL)this.setBlood(0);
	}
	public void injur() {
		int i=this.getBlood()-1;
		this.setBlood(i);
	}

}
