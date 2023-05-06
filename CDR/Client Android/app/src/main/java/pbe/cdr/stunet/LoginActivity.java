package pbe.cdr.stunet;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.widget.ContentLoadingProgressBar;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.EditText;
import android.widget.Button;
import android.widget.ProgressBar;
import android.widget.Toast;


import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class LoginActivity extends AppCompatActivity {
    OkHttpClient client = new OkHttpClient();
    private Boolean passView = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.login_window);
        final ImageView logo = (ImageView) findViewById(R.id.logo_image);
        final EditText urlText = (EditText) findViewById(R.id.url_label);
        final EditText userText = (EditText) findViewById(R.id.user_label);
        final EditText passwordText = (EditText) findViewById(R.id.password_label);
        final Button loginButton = (Button) findViewById(R.id.login_button);

        loginButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                String url = urlText.getText().toString().trim();
                String uid = passwordText.getText().toString().trim();
                String user = userText.getText().toString().trim();
                Request request = new Request.Builder().url("http://"+url+"/students?uid="+uid).build();

                client.newCall(request).enqueue(new Callback() {
                    @Override
                    public void onFailure(@NonNull Call call, @NonNull IOException ex) {
                        showError("Connection Error!");
                        ex.printStackTrace();
                    }

                    @Override
                    public void onResponse(@NonNull Call call, @NonNull Response response) throws IOException {
                        if (!response.isSuccessful()) {
                            throw new IOException("Error!\nResponse: " + response);
                        }
                        else {
                            try {
                                JSONArray res = new JSONArray(response.body().string());
                                if(res.getJSONObject(0).has("uid")) {
                                    if(user.equals(res.getJSONObject(0).get("Name").toString())) {
                                        System.out.println("user: " + res.getJSONObject(0).get("uid"));
                                        Intent intent = new Intent(LoginActivity.this, LoggedActivity.class);
                                        intent.putExtra("uid", res.getJSONObject(0).get("uid").toString());
                                        intent.putExtra("user", res.getJSONObject(0).get("Name").toString());
                                        intent.putExtra("url", urlText.getText().toString().trim());
                                        startActivity(intent);
                                    }
                                    else {
                                        showError("Error: This user does not exist!");
                                    }
                                }
                                else {
                                    showError("Error: Cannot login!");
                                }
                            } catch (JSONException ex) {
                                showError("Error: Cannot login!");
                                ex.printStackTrace();
                            }
                        }
                    }
                });
            }
        });
    }

    public void showError(String text) {
        LoginActivity.this.runOnUiThread(new Runnable() {
            public void run() {
                Toast toast = Toast.makeText(getApplicationContext(), text, Toast.LENGTH_SHORT);
                toast.show();
            }
        });
    }
}