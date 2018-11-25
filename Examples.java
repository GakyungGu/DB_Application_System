import java.util.*;

class Appointments implements Function{
    private String date;
    private String persons;
    private String location;
    Vector<Appointments> v_appointments;

    public Appointments(String date, String persons, String location){
        this.date = date;
        this.date = persons;
        this.date = location;
    }

    public String getDate(){ return date; }
    public String getPersons(){ return persons; }
    public String getLocation(){ return location; }

    public Appointments(Vector<Appointments> v_appointments){
        Scanner s= new Scanner;
        int submenu;
        int updateindex, deleteindex;

        System.out.print("원하는 메뉴를 선택해주세요. >> ");
        submenu = s.nextInt();

        switch(submenu){
            case 1:
                create();
                break;
            case 2:
                view();
                break;
            case 3:
                view();
                System.out.print("업데이트를 원하는 번호를 선택해주세요. >>");
                updateindex = s.nextInt();
                update(updateindex);
                break;
            case 4:
                view();
                System.out.print("삭제를 원하는 번호를 선택해주세요. >>");
                deleteindex = s.nextInt();
                delete(deleteindex);
                break;
            default:
                System.out.println("잘못선택하였습니다. 다시 선택해주세요.");
        }
    }

    public void create(){
        Scanner s = new Scanner(System.in);
        String date, persons, location;
        Appointments appointments;

        System.out.print("date>> ");
        date = s.next();
        System.out.print("persons>> ");
        persons = s.next();
        System.out.print("location>> ");
        location = s.next();

        appointments = new Appointments(date, persons, location);
        v_appointments.add(appointments);
    }

    public void view(){
        for(int i=0; i<v_appointments.size(); i++){
            System.out.println(i+1 + " " + v_appointments.get(i).getDate()
                    " " + v_appointments.get(i).getPersons() + " " + v_appointments.get(i).getLocation());
        }
    }

    public void update(int updateindex){
        System.out.print("update 원하는 요소를 선택해주세요. >> ");
    }

    public void delete(int deleteindex){
        v_appointments.remove(deleteindex-1);
    }
}
public class Examples {
    public static void main(String[] args){


    }
}
