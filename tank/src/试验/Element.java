package  ‘—È;

import java.awt.Graphics;

public class Element {
	private int x;
	private int y;
	private int blood=1;
	private int paint=1;
	public Element() {
		super();
	}
	public Element(int x, int y) {
		super();
		this.x = x;
		this.y = y;
	}
	public int getPaint() {
		return paint;
	}
	public void setPaint(int paint) {
		this.paint = paint;
	}
	public int getBlood() {
		return blood;
	}
	public void setBlood(int blood) {
		this.blood = blood;
	}
	public int getX() {
		return x;
	}
	public void setX(int x) {
		this.x = x;
	}
	public int getY() {
		return y;
	}
	public void setY(int y) {
		this.y = y;
	}
	public void draw(Graphics g){
		
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + x;
		result = prime * result + y;
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Element other = (Element) obj;
		if (x != other.x)
			return false;
		if (y != other.y)
			return false;
		return true;
	}
}
