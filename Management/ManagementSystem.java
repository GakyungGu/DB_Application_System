package Management;
import java.util.Scanner;
import java.util.Vector;

interface Functions{
	abstract public void create();
	abstract public void view();
	abstract public void update(int index);
	abstract public void delete(int index);
}


public class ManagementSystem {
	static Vector<Contacts> contacts=new Vector<Contacts>();
	static Vector<ToDoLists> todoList=new Vector<ToDoLists>();
	static Vector<Appointments> appointment=new Vector<Appointments>();
	public static void main(String[] args) {
		Scanner scanner=new Scanner(System.in);
		int menu;
		while(true) {
			System.out.println("*****personal management system*****");
			System.out.print("1.Contacts\\ ");
			System.out.print("2.To Do List\\ ");
			System.out.print("3.Appointment\\ ");
			System.out.println("4.Exit");
			System.out.print("�޴� �Է�>>");
			menu=scanner.nextInt();
			
			if(isMenuAvailable(menu)) {
				if(menu==1)
					new Contacts(contacts);
				else if(menu==2)
					new ToDoLists(todoList);
				else if(menu==3)
					new Appointments(appointment);
				else if(menu==4)
					exitsystem();
			}
			else
				System.out.println("�ùٸ� ��ȣ�� �Է����ּ���.");
		}
	}
	
	public static boolean isMenuAvailable(int menu) {
		
		if(menu >= 1 && menu <5)
			return true;
		else
			return false;
	}
	
	public static void exitsystem() {
		System.out.println("���α׷��� ����˴ϴ�.");
		System.exit(0);
	}

}

