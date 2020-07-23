package com.study.tank;

import com.study.tank.abst.*;
import com.study.tank.inte.BeattackAble;
import com.study.tank.inte.BeattackAble2;

import javax.swing.*;
import java.awt.*;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.util.HashSet;
import java.util.concurrent.CopyOnWriteArrayList;

public class Jpanel_1 extends JPanel implements Runnable,KeyListener{
	public static CopyOnWriteArrayList<Element> list=new CopyOnWriteArrayList<Element>();
	private TankMy t=null;
	private int s=Constant.SIZE_OBS;
	private static int numEnemy=0;
	
	private Tank t1,t2,t3,t4;
	Jpanel_1(){
		this.addRandomMap();
		
		t1=new Tank(80,Constant.HEIGHT_PANEL+40);
		t2=new Tank(Constant.WIDTH_PANEL+40,80,1);
		t3=new Tank(280,Constant.HEIGHT_PANEL+40,1);
	}
	
	public void paint(Graphics g) {
		this.addTank();
		this.addBullerEnemy();
		this.attack();
		Utils.fade(list);
		Utils.sortList(list);
		super.paint(g);
		this.drawObject(g);
		System.out.println(list.size());
		t1.draw(g);	t2.draw(g);
		t3.draw(g);
		Font font=new Font("����",Font.BOLD,50);
		g.setFont(font);
		g.setColor(Color.RED);
		g.drawString(Record.numTankMe+"",160,Constant.HEIGHT_PANEL+100);
		g.drawString(Record.numTankEnemy+"",360,Constant.HEIGHT_PANEL+100);
		g.drawString(Record.sumEnemy+"",Constant.WIDTH_PANEL+40,240);
	}
//	��������
	public void drawObject(Graphics g){
		g.fillRect(0, 0, Constant.WIDTH_PANEL, Constant.HEIGHT_PANEL);
		for (Element e : list) {
			e.draw(g);
		}
	}
//	���������ͼ
	public void addRandomMap(){
		HashSet<Element>hs=new HashSet<Element>();
		int width=Constant.WIDTH_PANEL/Constant.SIZE_OBS;
		int height=Constant.HEIGHT_PANEL/Constant.SIZE_OBS;
		int n=width*height/4;
		int r1=(int)(Math.random()*30);
		while(hs.size()<n+r1){
			hs.add(new Element((int)(Math.random()*width), (int)(Math.random()*height)));
		}
		for (Element e : hs) {
			switch ((int)(Math.random()*4)) {
			case 0:
				new Wall().addFour(e.getX(), e.getY(), list);
				break;
			case 1:
				new Water().addFour(e.getX(), e.getY(), list);
				break;
			case 2:
				new Grass().addFour(e.getX(), e.getY(), list);
				break;
			case 3:
				new Steel().addFour(e.getX(), e.getY(), list);
				break;
			}
		}
	}

	public void run() {
		while(true){
			try {
				Thread.sleep(20);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			this.repaint();
		}
	}
	public void keyPressed(KeyEvent e) {
		switch (e.getKeyCode()) {
		case KeyEvent.VK_UP:
			t.move(Constant.CODE_U);
			break;
		case KeyEvent.VK_DOWN:
			t.move(Constant.CODE_D);
			break;
		case KeyEvent.VK_LEFT:
			t.move(Constant.CODE_L);
			break;
		case KeyEvent.VK_RIGHT:
			t.move(Constant.CODE_R);
			break;
		case KeyEvent.VK_SPACE:
			BulletMy bm=t.shot();
			if(bm!=null) list.add(bm);
			break;
		default:
			break;
		}
	}
	
	public void keyReleased(KeyEvent e) {}

	public void keyTyped(KeyEvent e) {}
//	���̹��
	public void addTank(){
		int ie=0;
		int im=0;
		for (Element e : list) {
			if(e instanceof Tanke1) ie++;
			if(e instanceof TankMy) im++;
		}
		if(im<1 && Record.numTankMe>0){		
			t=new TankMy(Constant.WIDTH_PANEL/2-120,Constant.HEIGHT_PANEL-80);
			list.add(t);
			Record.lessMy();
		}
		if(ie<Constant.NUM_TE && numEnemy<Constant.SUM_TE){
			Tanke1 te=new Tanke1();
			switch (numEnemy%3) {
			case 0:
				te=new Tanke1();
				break;
			case 1:
				te=new Tanke1(Constant.WIDTH_PANEL/2-40,0);
				break;
			case 2:
				te=new Tanke1(Constant.WIDTH_PANEL-80,0);
				break;
			}
			Thread t=new Thread(te);
			t.start();
			list.add(te);
			Record.lessEnemy();
			numEnemy++;
		}
	}
//	�ҵ��ӵ�����(BeattackAble)
	public void attack(){
		boolean b;
		for (Element e1 : list) {
			for (Element e2 : list) {
				if(e1 instanceof BulletMy && e2 instanceof BeattackAble){
					if(e2 instanceof Obstracle){
						b=Utils.isCrash(e1.getX(), e1.getY(), 8, 8, e2.getX(), e2.getY(), s/2, s/2);
					}else if(e2 instanceof BulletEnemy){
						b=Utils.isCrash(e1.getX(), e1.getY(), 8, 8, e2.getX(), e2.getY(), 8, 8);
					}else{
						b=Utils.isCrash(e1.getX(), e1.getY(), 8, 8, e2.getX(), e2.getY(), s, s);
						if(b)Record.addEnemy();
					}
					if(b){
						((BulletMy) e1).injur(); 
						((BeattackAble) e2).injur();
					}
				}
				if(e1 instanceof BulletEnemy && e2 instanceof BeattackAble2){
					if(e2 instanceof Obstracle){
						b=Utils.isCrash(e1.getX(), e1.getY(), 8, 8, e2.getX(), e2.getY(), s/2, s/2);
					}else{
						b=Utils.isCrash(e1.getX(), e1.getY(), 8, 8, e2.getX(), e2.getY(), s, s);
					}
					if(b){
						((BulletEnemy) e1).injur(); 
						((BeattackAble2) e2).injur();
					}
				}
			}
		}
	}
//	����ӵ�
	public void addBullerEnemy(){
		for (Element e : list) {
			if(e instanceof Tanke1){
				for (Element e2 : ((Tanke1)e).list) {
					list.add(e2);
				}
			}
		}
	}
}