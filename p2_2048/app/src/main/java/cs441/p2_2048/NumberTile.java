package cs441.p2_2048;


import android.content.Context;
import android.widget.FrameLayout;
import android.widget.TextView;

public class NumberTile extends FrameLayout {

    public NumberTile(Context context){
        super(context);
        label = new TextView(getContext());
        label.setTextSize(32);

        LayoutParams lp = new LayoutParams(-1,1);
        addView(label, lp);

        setNum(0);
    }


    private int num = 0;

    public int getNum(){
        return num;
    }

    public void setNum(int num){
        this.num = num;
        label.setText(num + "");
    }



    public boolean equals(NumberTile tile){
        return getNum() == tile.getNum();
    }

    private TextView label;

}
