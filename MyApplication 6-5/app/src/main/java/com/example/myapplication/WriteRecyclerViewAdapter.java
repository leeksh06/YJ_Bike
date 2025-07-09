package com.example.myapplication;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.bumptech.glide.Glide;

import java.util.ArrayList;

public class WriteRecyclerViewAdapter extends RecyclerView.Adapter<WriteRecyclerViewAdapter.ImageViewHolder> {

    //리사이클러뷰에 넣을 데이터 리스트
    ArrayList<ImageData> arrayList;
    Context context;
    String activity = null;

    private OnItemClickListener mListener = null;
    public interface OnItemClickListener {
        void onItemClick(View v, int pos);
    }
    public void setOnItemClickListener(OnItemClickListener listener) {
        this.mListener = listener;
    }

    //생성자를 통하여 데이터 리스트 context를 받음
    public WriteRecyclerViewAdapter(Context context, ArrayList<ImageData> arrayList) {
        this.arrayList = arrayList;
        this.context = context;
    }

    public WriteRecyclerViewAdapter(Context context, ArrayList<ImageData> arrayList, String activity) {
        this.arrayList = arrayList;
        this.context = context;
        this.activity = activity;
    }

    @NonNull
    @Override
    public ImageViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.write_image_data_item, parent, false);

        return new ImageViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ImageViewHolder holder, int position) {
        String imageUri = arrayList.get(position).getImageUri();

        if (activity != null && activity.equals("detail")) {
            holder.write_btnRemoveImage.setVisibility(View.GONE);
        }

        if (!imageUri.equals("null")) {
            Glide.with(context).load(imageUri).into(holder.write_image);
        }
    }

    @Override
    public int getItemCount() {
        //데이터 리스트의 크기를 전달해주어야 함
        return arrayList.size();
    }

    public class ImageViewHolder extends RecyclerView.ViewHolder {
        ImageView write_image;
        ImageView write_btnRemoveImage;

        public ImageViewHolder(@NonNull View itemView) {
            super(itemView);
            write_image = (ImageView) itemView.findViewById(R.id.write_image);
            write_btnRemoveImage = (ImageView) itemView.findViewById(R.id.write_btnRemoveImage);

            write_btnRemoveImage.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    int pos = getAdapterPosition();
                    if (pos != RecyclerView.NO_POSITION) {
                        mListener.onItemClick(view, pos);
                    }
                }
            });
        }
    }
}

//class ImageViewHolder extends RecyclerView.ViewHolder {
//    ImageView write_image;
//    ImageView write_btnRemoveImage;
//
//    public ImageViewHolder(@NonNull View itemView) {
//        super(itemView);
//        write_image = (ImageView) itemView.findViewById(R.id.write_image);
//        write_btnRemoveImage = (ImageView) itemView.findViewById(R.id.write_btnRemoveImage);
//        write_btnRemoveImage.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                int pos = getAdapterPosition();
//                if (pos != RecyclerView.NO_POSITION) {
//                    mListener.onItemClick(view, pos);
//                }
//            }
//        });
//    }
//}

class ImageData {
    private String imageName;
    private String imageUri;

    public ImageData(String imageName, String imageUri) {
        this.imageName = imageName;
        this.imageUri = imageUri;
    }

    public String getImageUri() { return imageUri; }
    public void setImageUri(String imageUri) { this.imageUri = imageUri; }

    public String getImageName() { return imageName; }
    public void setImageName(String imageName) { this.imageName = imageName; }
}