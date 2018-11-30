package manage;

import java.util.Scanner;
import java.util.Vector;

class Contacts implements Functions {
   String name;
   String phone_number;
   String email;
   Vector<Contacts> contacts;
   Scanner sc;
   
   public Contacts(String name,String phone_number,String email) {
      this.name=name;
      this.phone_number=phone_number;
      this.email=email;
   }
   
   public Contacts(Vector<Contacts> v_contacts) {
      int contacts_menu;
      sc=new Scanner(System.in);
      contacts=v_contacts;
      while(true) {
         System.out.println("<Contacts>");
         System.out.print("1.create\\ ");
         System.out.print("2.view\\ ");
         System.out.print("3.update\\ ");
         System.out.print("4.delete\\ ");
         System.out.println("5.exit");
         System.out.print("메뉴 입력>>");
         contacts_menu=sc.nextInt();
         if(contacts_menu==1)
            create();
         else if(contacts_menu==2)
            view();
         else if(contacts_menu==3) {
        	 int updateNum;
        	 if(contacts.size()<1) {
      		   System.out.println("update할 연락처가 없습니다.");
      		   continue;
        	 }
        	 else {
        		 view();
        		 while (true) {
        			   System.out.print("인덱스 입력>>");
        			   updateNum=sc.nextInt();
        			   
        			   if((updateNum-1)>=0 && (updateNum-1)<contacts.size()) {
        				   update(updateNum);
        				   break;
        			   }
        			   else
        				   System.out.println("해당 index를 가진 연락처가 존재하지 않습니다");
        		 }
        	 }
         }
         else if(contacts_menu==4) {
        	 int deleteNum;
        	 if(contacts.size()<1) {
      		   System.out.println("delete할 연락처가 없습니다.");
      		   continue;
      	   	 }
      	   
      	   	while (true) {
      		   System.out.print("인덱스 입력>>");
      		   deleteNum=sc.nextInt();
      			   
      		   if((deleteNum-1)>=0 && (deleteNum-1)<contacts.size()) {
      			   delete(deleteNum);
      			   break;
      		   }
      		   else
      			   System.out.println("해당 index를 가진 연락처가 존재하지 않습니다");
      	   }
         }
         else if(contacts_menu==5)
            break;
      }
   }
   
   @Override
   public void create() {
      sc=new Scanner(System.in);
      System.out.print("name: ");
      name=sc.nextLine();
      System.out.print("phone number: ");
      phone_number=sc.nextLine();
      System.out.print("e-mail: ");
      email=sc.nextLine();
      contacts.add(new Contacts(name,phone_number,email));
      System.out.println("연락처가 추가되었습니다.");
   }
   
   @Override
   public void view() {
	   System.out.println("--------------------저장된 연락처 목록--------------------");
	   for(int index = 1; index <= contacts.size(); index++) {
		   System.out.println("["+index+"]: name: "+contacts.get(index-1).name+" "
		   		+ "phone number: "+contacts.get(index-1).phone_number+" "
		   		+ "email: "+contacts.get(index-1).email);
	   }
	   System.out.println("----------------------------------------------------");
   }
   
   @Override
   public void update(int index) {
	   int answer;
	   String replaceContact;
	   sc=new Scanner(System.in);
	   
	   System.out.println("["+index+"]: name: "+contacts.get(index-1).name+" "
		   		+ "phone number: "+contacts.get(index-1).phone_number+" "
		   		+ "email: "+contacts.get(index-1).email);
	   System.out.println("연락처를 수정하시겠습니까? yes/no");
	   answer=sc.nextInt();
		   
	   if(answer==1) {
		   System.out.print("1.name / 2.phone number / 3.e-mail 중 어느 부분을 수정할 지 선택하세요>>");
		   answer=sc.nextInt();
		   System.out.print("수정한 내용을 입력>>");
		   replaceContact=sc.next();
		   
		   switch(answer) {
		   	   case 1 : {
				   name = replaceContact;
				   phone_number = contacts.get(index-1).phone_number;
				   email = contacts.get(index-1).email;
				   break;
			   }
			   case 2 : {
				   name = contacts.get(index-1).name;
				   phone_number = replaceContact;
				   email = contacts.get(index-1).email;
				   break;
			   }
			   case 3 : {
				   name = contacts.get(index-1).name;
				   phone_number = contacts.get(index-1).phone_number;
				   email = replaceContact;
				   break;
			   }
		   }
		   contacts.set(index-1, new Contacts(name, phone_number, email));  
		   System.out.println("연락처가 수정되었습니다.");
		   return;
	   }
		   
	   else {
		   return;
	   }
   }
   
   
   @Override
   public void delete(int index) {
	   int answer;
	   sc=new Scanner(System.in);
		   
	   System.out.println("["+index+"]: name: "+contacts.get(index-1).name+" "
		   		+ "phone number: "+contacts.get(index-1).phone_number+" "
		   		+ "email: "+contacts.get(index-1).email);
	   System.out.println("연락처를 삭제하시겠습니까? yes/no");
	   answer=sc.nextInt();
			   
	   if(answer==1) {
		   contacts.remove(index-1);
		   System.out.println("연락처가 삭제되었습니다.");
		   return;
	   }
			   
	   else {
		   return;
	   }
   }
}