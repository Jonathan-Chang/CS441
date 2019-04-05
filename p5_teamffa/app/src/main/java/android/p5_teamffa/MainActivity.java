package android.p5_teamffa;

import android.p5_teamffa.model.Feed;
import android.p5_teamffa.model.entry.Entry;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;

import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.simplexml.SimpleXmlConverterFactory;

public class MainActivity extends AppCompatActivity {


    private static final String TAG = "MainActivity";
    private static final String BASE_URL = "https://www.reddit.com/r/";





    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);


        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl(BASE_URL)
                .addConverterFactory(SimpleXmlConverterFactory.create())
                .build();

        FeedAPI feedAPI = retrofit.create(FeedAPI.class);

        Call<Feed> call = feedAPI.getFeed();


        call.enqueue(new Callback<Feed>() {
            @Override
            public void onResponse(Call<Feed> call, Response<Feed> response) {
             //   Log.d(TAG, "onResponse: feed: " + response.body().toString());
                Log.d(TAG, "onResponse: Server Response: " + response.toString());
                List<Entry> entrys = response.body().getEntries();
//                Log.d(TAG, "onResponse: entrys: " + response.body().getEntries());
//                Log.d(TAG, "onResponse: author: " + entrys.get(0).getAuthor());
//                Log.d(TAG, "onResponse: updated: " + entrys.get(0).getUpdate());
//                Log.d(TAG, "onResponse: title: " + entrys.get(0).getTitle());
                for(int i = 0; i < entrys.size(); i++) {
                    ExtractXML extractXML1 = new ExtractXML(entrys.get(0).getContent(), "<a href=");
                    List<String> postContent = extractXML1.start();

                    ExtractXML extractXML2 = new ExtractXML(entrys.get(0).getContent(), "<img src=");
                    try {
                        postContent.add(extractXML2.start().get(0));
                    }catch (NullPointerException e){
                        postContent.add(null);
                    }
                    catch (IndexOutOfBoundsException e){
                        postContent.add(null);
                    }
                    extractXML2.start();
                }
            }

            @Override
            public void onFailure(Call<Feed> call, Throwable t) {
                Toast.makeText(MainActivity.this, "An Error Occured", Toast.LENGTH_SHORT).show();

            }
        });



    }
}