//package manage;

import java.util.Scanner;
import java.util.Vector;

class ToDoList{
	String date;
	String due;
	String contents;
	Vector<ToDoList> todoList;
	Scanner sc;
	public ToDoList(String date,String due,String contents) {
		this.date=date;
		this.due=due;
		this.contents=contents;
	}
	public ToDoList(Vector<ToDoList> v_todoList) {
		int todoList_menu;
		sc=new Scanner(System.in);
		todoList=v_todoList;
		while(true) {
			System.out.println("<To do List>");
			System.out.print("1.create\\ ");
			System.out.print("2.view\\ ");
			System.out.print("3.update\\ ");
			System.out.print("4.delete\\ ");
			System.out.println("5.exit");
			System.out.print("�޴� �Է�>>");
			todoList_menu=sc.nextInt();
			if(todoList_menu==1)
				create();
			else if(todoList_menu==2)
				view();
			else if(todoList_menu==3) {
				int updateNum;
				view();
				while(true) {
					System.out.print("update�� ��ȣ>>");
					updateNum=sc.nextInt();
					if(updateNum>=todoList.size()) {
						System.out.println("�Է��Ͻ� ��ȣ�� �������� �ʽ��ϴ�.");
						}
					else {
						update(updateNum);
						break;}
					}
				}
			else if(todoList_menu==4)
				delete(todoList_menu);
			else if(todoList_menu==5)
				break;
		}
	}
	public void create() {
		sc=new Scanner(System.in);
		System.out.print("date: ");
		date=sc.nextLine();
		System.out.print("due: ");
		due=sc.nextLine();
		System.out.print("contents: ");
		contents=sc.nextLine();
		todoList.add(new ToDoList(date,due,contents));
	}
	public void view() {
		System.out.println("------------------------------------------------------------------------------");
		for(int i=0;i<todoList.size();i++) {
			System.out.print("["+i+"]:");
			System.out.print(" date: "+todoList.elementAt(i).date);
			System.out.print(" due: "+todoList.elementAt(i).due);
			System.out.println(" contents: "+todoList.elementAt(i).contents);
		}
		System.out.println("------------------------------------------------------------------------------");
	}
	public void update(int index) {
		int updateNum=index;
		int updateMenu;
		int check;
		sc=new Scanner(System.in);

		System.out.print("["+updateNum+"]:");
		System.out.print(" date: "+todoList.elementAt(updateNum).date);
		System.out.print(" due: "+todoList.elementAt(updateNum).due);
		System.out.println(" description: "+todoList.elementAt(updateNum).contents);
		System.out.println("�� ���� �����Ͻðڽ��ϱ�?");
		System.out.print("1.yes\\2.no>>");
		check=sc.nextInt();
		if(check==2)
			return;					
				
		System.out.println("1.Date Update\\ 2.Due Update\\ 3.Description Update");
		System.out.print("update �ϰ���� menu�� �Է����ּ���>>");
		updateMenu=sc.nextInt();
		switch(updateMenu) {
			case 1:				
				System.out.print("update Date:");
				sc.nextLine();
				todoList.elementAt(updateNum).date=sc.nextLine(); break;
			case 2:				
				System.out.print("update Due:");
				sc.nextLine();
				todoList.elementAt(updateNum).due=sc.nextLine(); break;
			case 3:
				System.out.print("update Description:");
				sc.nextLine();
				todoList.elementAt(updateNum).contents=sc.nextLine(); break;						
				}
				System.out.println("�� ���� �����Ǿ����ϴ�.");
	}
	public void delete(int index) {
		int deleteNum;
		int deleteMenu;
		int check;
		sc=new Scanner(System.in);
		view();
		while(true) {
			System.out.print("delete�� ��ȣ>>");
			deleteNum=sc.nextInt();
			if(deleteNum>=todoList.size()) {
				System.out.println("�Է��Ͻ� ��ȣ�� �������� �ʽ��ϴ�.");
				}
			else {
				System.out.print("["+deleteNum+"]:");
				System.out.print(" date: "+todoList.elementAt(deleteNum).date);
				System.out.print(" due: "+todoList.elementAt(deleteNum).due);
				System.out.println(" description: "+todoList.elementAt(deleteNum).contents);
				System.out.println("�� ���� �����Ͻðڽ��ϱ�?");
				System.out.print("1.yes\\2.no>>");
				check=sc.nextInt();
				if(check==2)
					break;
				todoList.removeElementAt(deleteNum);
				System.out.println("�� ���� �����Ǿ����ϴ�.");
				break;
				}			
		}
	}

}