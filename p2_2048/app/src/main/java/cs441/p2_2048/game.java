package cs441.p2_2048;


import android.content.Context;
import android.graphics.Point;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;
import android.widget.GridLayout;
import android.view.View.OnTouchListener;
import android.widget.LinearLayout;

import java.util.ArrayList;
import java.util.List;

public class game extends GridLayout {


    public game(Context context, AttributeSet attrs, int defStyle){
        super(context,attrs,defStyle);
        initGame();

    }

    public game(Context context){
        super(context);
        initGame();
    }

    public game(Context context, AttributeSet attrs){
        super(context, attrs);
        initGame();

    }

    private void initGame(){

        setColumnCount(4);
        setBackgroundColor(0xffbbada0);





        setOnTouchListener(new View.OnTouchListener() {
            private float xVal;
            private float yVal;
            private float offX;
            private float offY;

            @Override
            public boolean onTouch(View v, MotionEvent event){
               switch(event.getAction()){
                   case MotionEvent.ACTION_DOWN:
                       xVal = event.getX();
                       yVal = event.getY();
                       break;
                   case MotionEvent.ACTION_UP:
                       offX = event.getX() - xVal;
                       offY = event.getY() - yVal;

                       if(Math.abs(offX) > Math.abs(offY)){
                           if(offX < -5){

                               swipeLeft();
                           }
                           else if(offX > 5){
                               swipeRight();
                           }
                       }
                       else{
                           if(offY < -5){
                               swipeUp();
                           }
                           else if(offY > 5){
                               swipeDown();
                           }
                       }

                       break;
               }
                return true;
            }


        });

       onSizeChanged(2 ,2,2,2);

    }


    @Override
    protected void onSizeChanged(int w, int h, int oldw, int oldh){
        super.onSizeChanged(w,h,oldw,oldh);

        int tileWidth = (Math.min(w,h) - 10)/4;
        addTile(tileWidth, tileWidth);

        startGame();
    }

    private void addTile(int tileWidth, int tileHeight){
        NumberTile t;
        for(int y = 0; y < 4; y++){
            for(int x = 0; x < 4; x++){
                t = new NumberTile(getContext());
                t.setNum(0);
                addView(t, tileWidth, tileHeight);

                tileMap[x][y] = t;

            }
        }

    }

    private void startGame(){

        for(int i = 0; i < 4; i++){
            for(int j = 0; j < 4; j++){
                tileMap[j][i].setNum(0);
            }
        }

        addRandomNum();
        addRandomNum();
        addRandomNum();


    }


    private void addRandomNum(){

       

        for(int i = 0; i < 4; i++){
            for(int j = 0; j < 4; j++){
                if(tileMap[j][i].getNum() <= 0){
                    pointz.add(new Point(j,i));
                }

            }
        }
        Point p = pointz.remove((int)(Math.random() * pointz.size()));
        tileMap[p.x][p.y].setNum(Math.random() > 0.1 ? 2:4);

    }


    private void swipeLeft(){
        for(int y = 0; y < 4; y++){
            for(int x = 0; x < 4; x++){
                for(int x1 = x+1; x1< 4;x1++){
                    if(tileMap[x1][y].getNum() > 0){
                        if(tileMap[x][y].getNum() <=0){
                            tileMap[x][y].setNum(tileMap[x1][y].getNum());
                            tileMap[x1][y].setNum(0);

                            x--;
                            break;
                        }
                        else if(tileMap[x][y].equals(tileMap[x1][y])){
                            tileMap[x][y].setNum(tileMap[x][y].getNum()*2);
                            tileMap[x1][y].setNum(0);
                            break;
                        }
                    }
                }
            }
        }

    }

    private void swipeRight(){
        for(int y = 0; y < 4; y++){
            for(int x = 0; x < 4; x++){
                for(int x1 = x+1; x1< 4;x1++){
                    if(tileMap[x1][y].getNum() > 0){
                        if(tileMap[x][y].getNum() <=0){
                            tileMap[x][y].setNum(tileMap[x1][y].getNum());
                            tileMap[x1][y].setNum(0);

                            x--;
                            break;
                        }
                        else if(tileMap[x][y].equals(tileMap[x1][y])){
                            tileMap[x][y].setNum(tileMap[x][y].getNum()*2);
                            tileMap[x1][y].setNum(0);
                            break;
                        }
                    }
                }
            }
        }

    }

    private void swipeUp(){
        for(int y = 0; y < 4; y++){
            for(int x = 0; x < 4; x++){
                for(int x1 = x+1; x1< 4;x1++){
                    if(tileMap[x1][y].getNum() > 0){
                        if(tileMap[x][y].getNum() <=0){
                            tileMap[x][y].setNum(tileMap[x1][y].getNum());
                            tileMap[x1][y].setNum(0);

                            x--;
                            break;
                        }
                        else if(tileMap[x][y].equals(tileMap[x1][y])){
                            tileMap[x][y].setNum(tileMap[x][y].getNum()*2);
                            tileMap[x1][y].setNum(0);
                            break;
                        }
                    }
                }
            }
        }

    }

    private void swipeDown(){
        for(int y = 0; y < 4; y++){
            for(int x = 0; x < 4; x++){
                for(int x1 = x+1; x1< 4;x1++){
                    if(tileMap[x1][y].getNum() > 0){
                        if(tileMap[x][y].getNum() <=0){
                            tileMap[x][y].setNum(tileMap[x1][y].getNum());
                            tileMap[x1][y].setNum(0);

                            x--;
                            break;
                        }
                        else if(tileMap[x][y].equals(tileMap[x1][y])){
                            tileMap[x][y].setNum(tileMap[x][y].getNum()*2);
                            tileMap[x1][y].setNum(0);
                            break;
                        }
                    }
                }
            }
        }

    }


    private NumberTile[][] tileMap = new NumberTile[4][4];
    private List<Point> pointz = new ArrayList<Point>();
}




