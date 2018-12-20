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
			System.out.print("메뉴 입력>>");
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
					System.out.print("update할 번호>>");
					updateNum=sc.nextInt();
					if(isUpdateAvailable(updateNum)) {
						update(updateNum);
						break;
						}
					else
						System.out.println("입력하신 번호는 존재하지 않습니다.");
				}
			}
			else if(todoList_menu==4) {
				int deleteNum;

				if(isEmptyToDoList(todoList,"delete"))
					continue;

				view();				
				while(true) {
					System.out.print("delete할 번호>>");
					deleteNum=sc.nextInt();
					if(deleteNum>todoList.size() || deleteNum<=0) {
						System.out.println("입력하신 번호는 존재하지 않습니다.");
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
		System.out.println("할 일을 수정하시겠습니까?");
		System.out.print("1.yes\\2.no>>");

		check=sc.nextInt();

		if(check==2)
			return;					
				
		System.out.println("1.Date Update\\ 2.Due Update\\ 3.Description Update");
		System.out.print("update 하고싶은 menu를 입력해주세요>>");

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
				System.out.println("할 일이 수정되었습니다.");
	}
	
	public void delete(int index) {
		int deleteNum=index-1;
		int check;
		
		printSelectedNumberInfo(deleteNum);
		System.out.println("할 일을 삭제하시겠습니까?");
		System.out.print("1.yes\\2.no>>");
		check=sc.nextInt();
		if(check==2)
			return;
		todoList.removeElementAt(deleteNum);
		System.out.println("할 일이 삭제되었습니다.");
				
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
			System.out.println(menu+"할 할 일이 없습니다.");
			return true;
		}
		else 
			return false;
	}
}