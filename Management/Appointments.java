package Management;

import java.util.*;

class Appointments implements Functions{
    private String date;
    private String persons;
    private String location;
    protected Vector<Appointments> v_appointments;

    public Appointments(String date, String persons, String location){
        this.date = date;
        this.persons = persons;
        this.location = location;
    }

    public String getDate(){ return date; }
    public String getPersons(){ return persons; }
    public String getLocation(){ return location; }

    public Appointments(Vector<Appointments> v_appointments) {
        this.v_appointments = v_appointments;
        Scanner s = new Scanner(System.in);
        int submenu;
        int updateindex, deleteindex;

        while (true) {
            System.out.println();
            System.out.println("Menu>> 1. create  2. view  3. update  4. delete  5. exit");
            System.out.print("���ϴ� �޴��� �������ּ���. >> ");
            submenu = s.nextInt();

            switch (submenu) {
                case 1:
                    create();
                    System.out.println();
                    break;

                case 2:
                    view();
                    System.out.println();
                    break;

                case 3:
                    view();
                    if(v_appointments.size() == 0){
                        System.out.println("update �� ����� �����ϴ�.");
                        break;
                    }
                    while(true){
                        System.out.print("�ε��� �Է� >>");
                        updateindex = s.nextInt();
                        if(updateindex-1 > (v_appointments.size())){
                            System.out.println("�ش� index�� ���� ����� �������� �ʽ��ϴ�. ");
                        }
                        else {
                            update(updateindex);
                            break;
                        }

                    }
                    System.out.println();
                    break;

                case 4:
                    view();
                    if(v_appointments.size() == 0){
                        System.out.println("delete �� ����� �����ϴ�.");
                        break;
                    }
                    while(true) {
                        System.out.print("�ε��� �Է� >>");
                        deleteindex = s.nextInt();
                        if (deleteindex - 1 > (v_appointments.size())) {
                            System.out.println("�ش� index�� ���� ����� �������� �ʽ��ϴ�. ");
                        }
                        else {
                            delete(deleteindex);
                            break;
                        }
                    }
                    System.out.println();
                    break;

                case 5:
                    System.out.println("����� �����մϴ�.");
                    System.out.println();
                    return;

                default:
                    System.out.println("�߸������Ͽ����ϴ�. �ٽ� �������ּ���.");

            }

        }
    }

    public boolean checkUpdateIndex(int updateindex) {
        if(updateindex>3 || updateindex<=0)
            return false;

        else
            return true;
    }


    public boolean printChoosingNumberInfo(int selectNum) {
        int index = selectNum+1;
        System.out.print("[" + index + "/ ");
        System.out.print("date : "+ v_appointments.elementAt(selectNum).getDate() + " " + "/ ");
        System.out.print("person : "+ v_appointments.elementAt(selectNum).getPersons() + " " + "/ ");
        System.out.print("location : "+ v_appointments.elementAt(selectNum).getLocation() + " " + "]");
        System.out.println();

        return true;
    }

    public void create(){
        Scanner s = new Scanner(System.in);
        String date, persons, location;


        System.out.print("date>> ");
        date = s.nextLine();
        System.out.print("persons>> ");
        persons = s.nextLine();
        System.out.print("location>> ");
        location = s.nextLine();

        addRecord(date, persons, location);


    }

    public boolean addRecord(String date, String persons, String location){
        Appointments appointments;
        appointments = new Appointments(date, persons, location);
        v_appointments.add(appointments);
        if(v_appointments.isEmpty()){
            return false;
        }
        else {

            System.out.println("����� �߰��Ǿ����ϴ�. ");
            return true;
        }


    }


    public void view(){
        System.out.println("------------------------------------------------------------------------------");

        for(int i=0; i<v_appointments.size(); i++){
            System.out.print("[" + (i+1) + " / ");
            System.out.print("date : " +v_appointments.elementAt(i).date + " / ");
            System.out.print("person : " + v_appointments.elementAt(i).persons + "  / ");
            System.out.print("location : " + v_appointments.elementAt(i).location + "]");
            System.out.println();
        }
        System.out.println();
        System.out.println("------------------------------------------------------------------------------");
    }

    public void update(int updateindex){
        Scanner s = new Scanner(System.in);
        int updateNum = updateindex - 1;
        int updateMenu;
        int check;

        printChoosingNumberInfo(updateNum);
        System.out.println("����� �����Ͻðڽ��ϱ�? ");
        System.out.print("yes / no>> ");

        check=s.nextInt();

        if(check==2)
            return;

        System.out.println("1.Date / 2.Persons / 3.Locations �� ��� �κ��� ������ �� �����ϼ��� >> ");

        updateMenu=s.nextInt();
        switch(updateMenu) {
            case 1:
                System.out.println("������ ������ �Է� >> ");
                System.out.print("update Date: ");
                s.nextLine();
                v_appointments.elementAt(updateNum).date = s.nextLine();
                break;

            case 2:
                System.out.println("������ ������ �Է� >> ");
                System.out.print("update Person: ");
                s.nextLine();
                v_appointments.elementAt(updateNum).persons = s.nextLine();
                break;

            case 3:
                System.out.println("������ ������ �Է� >> ");
                System.out.print("update Location: ");
                s.nextLine();
                v_appointments.elementAt(updateNum).location = s.nextLine();
                break;
        }

        System.out.println("����� �����Ǿ����ϴ�.");

    }

    public void delete(int deleteindex){
        Scanner s = new Scanner(System.in);
        int deleteNum = deleteindex-1;
        int check;

        printChoosingNumberInfo(deleteNum);

        System.out.println("����� �����Ͻðڽ��ϱ�?");
        System.out.print("yes / no>>");
        check=s.nextInt();

        if(check==2)
            return;
        v_appointments.removeElementAt(deleteNum);
        System.out.println("����� �����Ǿ����ϴ�.");

    }
}

