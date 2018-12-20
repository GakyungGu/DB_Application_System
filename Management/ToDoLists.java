package Management;

import java.util.Scanner;
import java.util.Vector;

class ToDoLists{
	private String date;
	private String due;
	private String contents;
	protected Vector<ToDoLists> todoList;
	private Scanner sc;
	
	public ToDoLists(String date,String due,String contents) {
		this.date=date;
		this.due=due;
		this.contents=contents;
	}
	
	public ToDoLists(Vector<ToDoLists> v_todoList) {
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
				
				if(isEmptyToDoList(todoList,"update"))
					continue;
				view();
				while(true) {
					System.out.print("update�� ��ȣ>>");
					updateNum=sc.nextInt();
					if(isUpdateAvailable(updateNum)) {
						update(updateNum);
						break;
						}
					else
						System.out.println("�Է��Ͻ� ��ȣ�� �������� �ʽ��ϴ�.");
				}
			}
			else if(todoList_menu==4) {
				int deleteNum;

				if(isEmptyToDoList(todoList,"delete"))
					continue;

				view();				
				while(true) {
					System.out.print("delete�� ��ȣ>>");
					deleteNum=sc.nextInt();
					if(deleteNum>todoList.size() || deleteNum<=0) {
						System.out.println("�Է��Ͻ� ��ȣ�� �������� �ʽ��ϴ�.");
					}
					else {
						delete(deleteNum);
						break;
					}
				}
			}
			else if(todoList_menu==5)
				break;
		}
	}
	
	public void create() {
		sc=new Scanner(System.in);
		System.out.print("date:");
		date=sc.nextLine();
		System.out.print("due:");
		due=sc.nextLine();
		System.out.print("description:");
		contents=sc.nextLine();
		todoList.add(new ToDoLists(date,due,contents));
	}
	
	public void view() {
		System.out.println("------------------------------------------------------------------------------");
		for(int i=0;i<todoList.size();i++) {
			System.out.print("["+(i+1)+"]:");
			System.out.print(" date: "+todoList.elementAt(i).date);
			System.out.print(" due: "+todoList.elementAt(i).due);
			System.out.println(" description: "+todoList.elementAt(i).contents);
		}
		System.out.println("------------------------------------------------------------------------------");
	}
	
	public void update(int index) {
		int updateNum=index-1;
		int updateMenu;
		int check;
		
		printSelectedNumberInfo(updateNum);
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
		int deleteNum=index-1;
		int check;
		
		printSelectedNumberInfo(deleteNum);
		System.out.println("�� ���� �����Ͻðڽ��ϱ�?");
		System.out.print("1.yes\\2.no>>");
		check=sc.nextInt();
		if(check==2)
			return;
		todoList.removeElementAt(deleteNum);
		System.out.println("�� ���� �����Ǿ����ϴ�.");
				
	}
	
	public boolean isUpdateAvailable(int updateNumber) {

		if(updateNumber>todoList.size() || updateNumber<=0) 
			return false;
				
		else 
			return true;

	}

	public void printSelectedNumberInfo(int selectNum) {
		int index=selectNum+1;
		
		System.out.print("["+(index)+"]:");
		System.out.print(" date: "+todoList.elementAt(selectNum).date);
		System.out.print(" due: "+todoList.elementAt(selectNum).due);
		System.out.println(" description: "+todoList.elementAt(selectNum).contents);
		
	}
	
	public boolean isEmptyToDoList(Vector<ToDoLists> v, String menu) {
		if(v.isEmpty()) {
			System.out.println(menu+"�� �� ���� �����ϴ�.");
			return true;
		}
		else 
			return false;
	}
}