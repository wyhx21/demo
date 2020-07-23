package com.study.tank;


import com.study.tank.inte.Fadeable;

import java.util.Comparator;
import java.util.concurrent.CopyOnWriteArrayList;

public class Utils {
//	�ж��Ƿ���ײ
	public static boolean isCrash(int x1, int y1, int w1, int h1, int x2, int y2, int w2, int h2) {
		if (x1 >= x2 && x1 >= x2 + w2) {
			return false;
		} else if (x1 <= x2 && x1 + w1 <= x2) {
			return false;
		} else if (y1 >= y2 && y1 >= y2 + h2) {
			return false;
		} else if (y1 <= y2 && y1 + h1 <= y2) {
			return false;
		}
		return true;
	}
//	ȥ��Ԫ��
	public static void fade(CopyOnWriteArrayList<Element>list){
		for (Element e : list) {
			if(e instanceof Fadeable){
				if(((Fadeable)e).fade()<1)list.remove(e);
			}
		}
	}

	public static void sortList(CopyOnWriteArrayList<Element> list) {
		list.sort(new Comparator<Element>() {
			public int compare(Element e1, Element e2) {
				return e1.getPaint() - e2.getPaint();
			}
		});
	}
}
