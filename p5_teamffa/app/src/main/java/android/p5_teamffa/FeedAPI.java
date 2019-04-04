package android.p5_teamffa;

import android.p5_teamffa.model.Feed;

import retrofit2.Call;
import retrofit2.http.GET;

public interface FeedAPI {

    String BASE_URL = "https://www.reddit.com/r/";

    @GET("funny/.rss")
    Call<Feed> getFeed();

}
