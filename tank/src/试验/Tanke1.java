package 试验;

import interfaces.BeattackAble;
import interfaces.Fadeable;

import java.util.concurrent.CopyOnWriteArrayList;

public class Tanke1 extends Tank implements Runnable,BeattackAble,Fadeable{
	public CopyOnWriteArrayList<Element>list =new CopyOnWriteArrayList<Element>();
	
	{
		this.setType(Constant.TYPE_EN1);
		this.setSpeed(Constant.SPEED_TE);
		this.setBlood(Constant.BLOOD_TE);
		this.setCode(Constant.CODE_D);
	}
	public Tanke1() {
		super();
	}

	public Tanke1(int x, int y) {
		super(x, y);
	}
	
	public void shot(){
		Utils.fade(list);
		if(list.size()>=Constant.NUM_BE) return;
		Bullet b=super.shot_1();
		BulletEnemy be=new BulletEnemy(b.getX(),b.getY(),b.getCode());
		Thread t=new Thread(be);
		t.start();
		list.add(be);
		return;
	}

	@Override
	public int fade() {
		return this.getBlood();
	}

	@Override
	public void injur() {
		int i=this.getBlood()-1;
		this.setBlood(i);
	}

	@Override
	public void run() {
		while(true){
			if(this.getBlood()<1)break;
			int j=(int)(Math.random()*50);
			for (int k = 0; k < 30+j; k++) {
				this.move(getCode());
				if(k%10==0)this.shot();
				try {
					Thread.sleep(50);
				} catch (InterruptedException e) {}
			}
			this.changeCode();
		}
	}
//	改变方向
	public void changeCode(){
		int i=(int)(Math.random()*4);
		switch (i) {
		case 0:
			this.setCode(Constant.CODE_U);
			break;
		case 1:
			this.setCode(Constant.CODE_D);
			break;
		case 2:
			this.setCode(Constant.CODE_L);
			break;
		case 3:
			this.setCode(Constant.CODE_R);
			break;
		}
	}
	public void move(int code){
		int speed=this.getSpeed();
		if(this.getCode()!=code){
			this.setCode(code);
			return;
		}
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
		this.amend();
		this.setX(x);
		this.setY(y);
	}
}
