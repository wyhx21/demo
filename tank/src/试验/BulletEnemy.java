package สิั้;

import interfaces.BeattackAble;

public class BulletEnemy extends Bullet implements BeattackAble{
	{
		this.setBlood(Constant.BLOOD_BE);
		this.setSpeed(Constant.SPEED_BE);
	}

	public BulletEnemy() {
		super();
	}

	public BulletEnemy(int x, int y, int code) {
		super(x, y, code);
	}
}
