package cs441.p2_2048;


import android.content.Context;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;
import android.widget.GridLayout;
import android.view.View.OnTouchListener;

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

        setOnTouchListener(new View.OnTouchListener() {
            private float startX;
            private float startY;
            private float offsetX;
            private float offsetY;

            @Override
            public boolean onTouch(View v, MotionEvent event){
               switch(event.getAction()){
                   case MotionEvent.ACTION_DOWN:
                       startX = event.getX();
                       startY = event.getY();
                       break;
                   case MotionEvent.ACTION_UP:
                       offsetX = event.getX() - startX;
                       offsetY = event.getY() - startY;

                       if(Math.abs(offsetX) > Math.abs(offsetY)){
                           if(offsetX < -5){
                               swipeLeft();
                           }
                           else if(offsetX > 5){
                               swipeRight();
                           }
                       }
                       else{
                           if(offsetY < -5){
                               swipeUp();
                           }
                           else if(offsetY > 5){
                               swipeDown();
                           }
                       }

                       break;
               }
                return true;
            }


        });

    }


    private void swipeLeft(){

    }

    private void swipeRight(){

    }

    private void swipeUp(){

    }

    private void swipeDown(){

    }

}




