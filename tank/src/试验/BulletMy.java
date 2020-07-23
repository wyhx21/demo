package สิั้;

public class BulletMy extends Bullet{
	{
		this.setBlood(Constant.BLOOD_BM);
		this.setSpeed(Constant.SPEED_BM);
	}

	public BulletMy() {
		super();
	}

	public BulletMy(int x, int y, int code) {
		super(x, y, code);
	}
}
