package Management;

import static org.junit.jupiter.api.Assertions.*;

import java.util.Vector;

import org.junit.jupiter.api.*;
import org.junit.Test;

public class ToDoListsTest {
	static ToDoLists test=null;
		
	@Test
	public void indexTest() {
		Vector<ToDoLists> todoList=new Vector<ToDoLists>();
		test=new ToDoLists("1","2","3");
		todoList.add(test);
		test.todoList=todoList;
		assertTrue(test.isUpdateAvailable(1));
	}
		
	@Test
	public void emptyTodoListTest() {
		Vector<ToDoLists> todoList=new Vector<ToDoLists>();
		test.todoList=todoList;
		assertTrue(test.isEmptyToDoList(todoList,"update"));		
	}

}
