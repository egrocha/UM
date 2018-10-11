import java.util.ArrayList;

public class Stack {

    public ArrayList<String> stack;

    public Stack(){
        this.stack = new ArrayList<>();
        stack.add("boas");
        stack.add("pessoal");
    }

    public String top(){
        if(stack.size() > 0) {
            System.out.print(stack.get(stack.size() - 1));
            return stack.get(stack.size() - 1);
        }
        else return "";
    }

    public void push(String s){
        this.stack.add(s);
        top();
    }

    public void pop(){
        if(stack.size() > 0) this.stack.remove(this.stack.size()-1);
        top();
    }

    public boolean empty(){
        if(stack.size() < 1){
            System.out.print(true);
            return true;
        }
        else{
            System.out.print(false);
            return false;
        }
    }

    public int length(){
        System.out.print(stack.size());
        return stack.size();
    }

    public int length2(){
        int i = 0;
        for(String s : stack){
            i++;
        }
        System.out.print(i);
        return i;
    }

}
