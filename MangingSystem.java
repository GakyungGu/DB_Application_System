//package manage;
import java.util.Scanner;
import java.util.Vector;

interface Functions{
	abstract public void create();
	abstract public void view();
	abstract public void update(int index);
	abstract public void delete(int index);
}
public class MangingSystem {
	static Vector<Contacts> contacts=new Vector<Contacts>();
	static Vector<ToDoList> todoList=new Vector<ToDoList>();
	static Vector<Appointment> appointment=new Vector<Appointment>();
	public static void main(String[] args) {
		Scanner scanner=new Scanner(System.in);
		int menu;
		while(true) {
			System.out.println("*****personal management system*****");
			System.out.print("1.Contacts\\ ");
			System.out.print("2.To Do List\\ ");
			System.out.print("3.Appointment\\ ");
			System.out.println("4.Exit");
			System.out.print("메뉴 입력>>");
			menu=scanner.nextInt();
			
			if(menu==1)
				new Contacts(contacts);
			else if(menu==2)
				new ToDoList(todoList);
			else if(menu==3)
				new Appointment(appointment);
			else if(menu==4)
				break;
		}
	}

}
