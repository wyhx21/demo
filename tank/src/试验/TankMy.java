package  ‘—È;

import interfaces.BeattackAble2;
import interfaces.Fadeable;

import java.util.concurrent.CopyOnWriteArrayList;

public class TankMy extends Tank implements BeattackAble2,Fadeable{
	private CopyOnWriteArrayList<Element>list =new CopyOnWriteArrayList<Element>();
	
	{
		this.setType(Constant.TYPE_MY);
		this.setSpeed(Constant.SPEED_MY);
		this.setBlood(Constant.BLOOD_MY);
		this.setCode(Constant.CODE_U);
	}
	public TankMy() {
		super();
	}

	public TankMy(int x, int y) {
		super(x, y);
	}
	
	public BulletMy shot(){
		Utils.fade(list);
		if(this.getBlood()<1)return null;
		if(list.size()>=Constant.NUM_BM) return null;
		Bullet b=super.shot_1();
		BulletMy bm=new BulletMy(b.getX(),b.getY(),b.getCode());
		Thread t=new Thread(bm);
		t.start();
		list.add(bm);
		return bm;
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

	@Override
	public int fade() {
		// TODO Auto-generated method stub
		return this.getBlood();
	}

	@Override
	public void injur() {
		// TODO Auto-generated method stub
		int i=this.getBlood()-1;
		this.setBlood(i);
	}
}
