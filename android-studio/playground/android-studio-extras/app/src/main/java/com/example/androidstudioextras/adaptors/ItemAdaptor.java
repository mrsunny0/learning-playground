package com.example.androidstudioextras.adaptors;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.example.androidstudioextras.R;
import com.example.androidstudioextras.model.Items;

import java.util.ArrayList;
import java.util.List;

public class ItemAdaptor extends ArrayAdapter<Items> {
    private Context mContext;
    private List<Items> itemList;

    public ItemAdaptor(@NonNull Context context, ArrayList<Items> list) {
        super(context, 0, list);
        mContext = context;
        itemList = list;
        Log.i("ADAPTOR", list.toString());
    }

    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
        // get current element
        Items currentItem = itemList.get(position);

        // expand View
        View listItem = convertView;
        if (listItem == null) {
            listItem = LayoutInflater.from(mContext).inflate(R.layout.item_list, parent, false);
        }

        // // update elements
        TextView textView = listItem.findViewById(R.id.buttonItem);
        Button button = listItem.findViewById(R.id.buttonItem);

        // update
        textView.setText(currentItem.text);
        button.setText(currentItem.button);

        return listItem;
    }
}
