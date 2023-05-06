package pbe.cdr.stunet;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.R.color;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.Typeface;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class LoggedActivity extends AppCompatActivity {
    OkHttpClient client = new OkHttpClient();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.logged_window);

        Intent intent = getIntent();
        String user = intent.getStringExtra("user");
        String uid = intent.getStringExtra("uid");
        String url = intent.getStringExtra("url");

        Button logoutButton = (Button) findViewById(R.id.logout_button);
        Button sendQueryButton = (Button) findViewById(R.id.send_button);
        TextView nameText = (TextView) findViewById(R.id.name_label);
        EditText queryText = (EditText) findViewById(R.id.query_label);
        TableLayout table = (TableLayout) findViewById(R.id.table_query);

        nameText.setText(user);

        logoutButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(LoggedActivity.this, LoginActivity.class);
                startActivity(intent);
                finish();
            }
        });

        sendQueryButton.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View view) {
                String query = queryText.getText().toString().trim();
                String querySplit[] = query.split("\\?");
                Request request = null;
                String path = querySplit[0].trim();

                if (path.equals("timetables") || path.equals("marks") || path.equals("tasks")) {
                    if (querySplit.length > 1) {
                        request = new Request.Builder().url("http://" + url + "/" + querySplit[0] + "?uid=" + uid + "&" + querySplit[1]).build();
                    }
                    else {
                        request = new Request.Builder().url("http://" + url + "/" + querySplit[0] + "?uid=" + uid).build();
                    }

                    client.newCall(request).enqueue(new Callback() {
                        @Override
                        public void onFailure(@NonNull Call call, @NonNull IOException e) {
                            showError("Error: Connection failed!");
                        }

                        @Override
                        public void onResponse(@NonNull Call call, @NonNull Response response) throws IOException {
                            if (!response.isSuccessful()) {
                                throw new IOException("Error: Not found!");
                            } else {
                                runOnUiThread(new Runnable() {
                                    @Override
                                    public void run() {
                                        try {
                                            table.removeAllViews();
                                            JSONArray res = new JSONArray(response.body().string());
                                            printTable(table, res);
                                        } catch (JSONException | IOException e) {
                                            showError("Error: Not found!");
                                            e.printStackTrace();
                                        }
                                    }
                                });
                            }
                        }
                    });
                }
                else {
                    showError("Error: Not found!");
                }
            }
        });
    }

    public void printTable(TableLayout table, JSONArray res) throws JSONException {
        Iterator<String> it1 = res.getJSONObject(0).keys();
        TableRow titles =  new TableRow(LoggedActivity.this);
        titles.setLayoutParams(new TableRow.LayoutParams(TableRow.LayoutParams.MATCH_PARENT, TableRow.LayoutParams.MATCH_PARENT));

        while(it1.hasNext()){
            String title = it1.next();
            if(!title.equals("uid")) {
                TextView col = new TextView(LoggedActivity.this);
                col.setTypeface(null, Typeface.BOLD);
                col.setText(title);
                col.setTextColor(getResources().getColor(R.color.white));
                col.setTextSize(13);
                col.setBackgroundColor(getResources().getColor(R.color.seablue));
                col.setLayoutParams(new TableRow.LayoutParams(TableRow.LayoutParams.MATCH_PARENT, TableRow.LayoutParams.MATCH_PARENT,5f));
                titles.addView(col);
            }
        }
        titles.setGravity(Gravity.CENTER);
        table.addView(titles);

        for(int i = 0; i < res.length(); i++){
            TableRow row = new TableRow(LoggedActivity.this);
            row.setLayoutParams(new TableRow.LayoutParams(TableRow.LayoutParams.MATCH_PARENT, TableRow.LayoutParams.MATCH_PARENT));
            row.setBackgroundColor(getResources().getColor(R.color.clearblue));
            JSONObject content = res.getJSONObject(i);
            content.remove("uid");
            Iterator<String> it2 = content.keys();

            while(it2.hasNext()){
                String info = it2.next();
                String infoStr = content.get(info).toString();
                TextView col = new TextView(LoggedActivity.this);
                col.setText(infoStr);
                col.setTextColor(getResources().getColor(R.color.black));
                col.setTextSize(13);
                col.setBackgroundColor(getResources().getColor(R.color.clearblue));
                col.setPadding(5,5,5,5);
                col.setLayoutParams(new TableRow.LayoutParams(TableRow.LayoutParams.MATCH_PARENT, TableRow.LayoutParams.MATCH_PARENT,5f));
                row.addView(col);
            }
            row.setGravity(Gravity.CENTER);
            table.addView(row);
        }
    }

    public void showError(String text) {
        LoggedActivity.this.runOnUiThread(new Runnable() {
            public void run() {
                Toast toast = Toast.makeText(getApplicationContext(), text, Toast.LENGTH_SHORT);
                toast.show();
            }
        });
    }
}