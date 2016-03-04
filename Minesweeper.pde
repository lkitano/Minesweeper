import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private static int NUM_COLS = 25;
private static int NUM_ROWS = 25; 
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(600, 600);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    frameRate(60);
    
    //your code to declare and initialize buttons goes here

    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    bombs = new ArrayList <MSButton>();

    for(int x = 0; x < NUM_ROWS; x ++){
        for(int y = 0; y < NUM_COLS; y++){
            buttons[x][y] = new MSButton(x,y);
        
    
    
    }
    }
    setBombs();
}
public void setBombs()
{
    //your code
    int b=0;
    while(b<(NUM_ROWS*NUM_COLS)/6){
        int row = (int)(Math.random()*NUM_ROWS);
        int col = (int)(Math.random()*NUM_COLS);


        if(bombs.contains(buttons[row][col]) == false){
            bombs.add(buttons[row][col]);
            b++;


        }
    }
}

public void draw ()
{
    background( 0 );
    if(isWon()){
        displayWinningMessage();
    }

   

}
public boolean isWon()
{
    //your code here
     // for(int i = 0; i < bombs.length, i++){
     //    if(bombs.contains(i))
     // }
        for(int i = 0;i < NUM_ROWS; i++){
        for(int j = 0; j < NUM_ROWS; j++){
            if(!bombs.contains(buttons[i][j]) && !buttons[i][j].isClicked()){
                return false;
            }
        }
    }
    return true;
}
public void displayLosingMessage()
{
    //your code here
    for(int i = 0 ;i < NUM_ROWS; i++){
        for(int j = 0; j < NUM_ROWS; j++){
            buttons[i][j].clicked = true;
            buttons[i][j].setLabel("L");
        }
    }
   

}
public void displayWinningMessage()
{
    //your code here
    for(int i = 0 ;i < NUM_ROWS; i++){
        for(int j = 0; j < NUM_ROWS; j++){
            if(!buttons[i][j].getLabel().equals("L"))
            buttons[i][j].setLabel("W");
        }
    }
   

}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;

    
    public MSButton ( int rr, int cc )
    {
        width = 600/NUM_COLS;
        height = 600/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed){
            marked = !marked;
        } else 
        if (bombs.contains(this)){
            {
                displayLosingMessage();
            }
        } else if (this.countBombs(r,c)> 0){
        
            setLabel(Integer.toString(this.countBombs(r,c)));
        } else if(this.countBombs(r,c)==0){
             for (int i =-1; i <2;i++){
                for(int j = -1; j < 2; j++){
            if(isValid(r+i,c+j) && buttons[r+i][c+j].isClicked()==false){
                 buttons[r+i][c+j].mousePressed();
           
                }

             }
             


              
      }
            
            
            
          } 

       
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }

    public String getLabel(){
        return label;
    }
    public boolean isValid(int r, int c)
    {
        return (r <NUM_ROWS && c<NUM_COLS && r >= 0 && c>=0);

        
       
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        for(int i = -1; i<2; i++) {
            for(int j = -1; j < 2; j++){
                if(isValid(row+i,col+j) && bombs.contains(buttons[row+i][col+j])){
                    numBombs++;
                }
            }
        }
        return numBombs;
        
    }
}



